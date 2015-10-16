var AFP_TLN_DRAG_DROP = function()
{
	var mouseOffset = null;
	var iMouseDown  = false;
	var lMouseState = false;
	var dragObject  = null;

	// Demo 0 variables
	var DragDrops = [];
	var Markers = [];
	var curTarget = null;
	var lastTarget = null;
	var dragHelper = null;
	var rootParent = null;
	var rootSibling = null;
	var curMarker = null; 
	var dropBeforeNode = null; 
	var allowDrag = false;
	var dragTimeOut = null;
	
	var setDragHelper = function(el, cls)
	{
		dragHelper = JSUtils.$("dragHelper_div");
		if(JSUtils.BrowserDetection.applewebkit) // Safari
		{
			dragHelper.style.position="absolute"; 
		}
	};
	
	var getDragHelper = function()
	{
		return dragHelper;
	};

	var CreateDragContainer = function()
	{
		//Create a new Container Instance so that items from one Set can not
		//be dragged into items from another Set
		
		var cDrag = DragDrops.length;
		DragDrops[cDrag] = [];
		Markers[cDrag] = [];

		//Each item passed to this function should be a - container.  Store each
		//of these items in our current container

		for(var i=0; i < arguments.length; i++)
		{
			var cObj = arguments[i];
			DragDrops[cDrag].push(cObj);
			cObj.setAttribute('DropObj', cDrag);
			
			
			//Every top level item in these containers should be draggable.  Do this
			//by setting the DragObj attribute on each item and then later checking
			//this attribute in the mouseMove function
			
			for(var j=0; j < cObj.childNodes.length; j++)
			{
				if (cObj.childNodes[j].getAttribute('isDrag')=="1")
				{
					cObj.childNodes[j].setAttribute('DragObj', cDrag);
					cObj.childNodes[j].setAttribute('CurCont', i);
				}
				else if (cObj.childNodes[j].getAttribute('name')=="tabDragMarker")
				{
					Markers[cDrag].push(cObj.childNodes[j]);
				}
			}
		}
	};

	var getMouseOffset = function(target, ev, overflown)
	{
		ev = ev || window.event;
		
		var docPos    = getPosition(target, overflown);
		var mousePos  = JSUtils.mouseCoords(ev);
		return {x:mousePos.x - docPos.x, y:mousePos.y - docPos.y};
	};

	var getPosition = function(el, overflown)
	{
		if (el.getBoundingClientRect)
		{
			var bounding = el.getBoundingClientRect();
			return {x:bounding.left+document.body.scrollLeft, y:bounding.top+document.body.scrollTop};
		}
		
		overflown = overflown || [];
		var left = 0, top = 0;
		do
		{
			left += el.offsetLeft || 0;
			top += el.offsetTop || 0;
			el = el.offsetParent;
		} while (el);
		for (var i = 0; i < overflown.length; i++)
		{
			var element = document.getElementById(overflown[i]);
			left -= element.scrollLeft || 0;
			top -= element.scrollTop || 0;
		}
		left -= document.body.scrollLeft;
		top -= document.body.scrollTop;
		return {x: left, y: top};
	};

	// iMouseDown represents the current mouse button state: up or down
	/*
	lMouseState represents the previous mouse button state so that we can
	check for button clicks and button releases:

	if(iMouseDown && !lMouseState) // button just clicked!
	if(!iMouseDown && lMouseState) // button just released!
	*/

	var mouseMove = function(ev)
	{
		ev         = ev || window.event;
		
		/*
		We are setting target to whatever item the mouse is currently on
		
		Firefox uses event.target here, MSIE uses event.srcElement
		*/
		var target   = JSUtils.getElementFromEvent(ev);
		var mousePos = JSUtils.mouseCoords(ev);
		// todo generic
		if (target.className == "TransparentCover")
		{
			target = target.parentNode;
		}
		
		/*
		dragObj is the grouping our item is in (set from the createDragContainer function).
		if the item is not in a grouping we ignore it since it can't be dragged with this
		script.
		*/
		
		var dragObj = target.getAttribute ? target.getAttribute('DragObj'): null;
		
		 // if the mouse was moved over an element that is draggable
		if(dragObj!=null)
		{
			// if the user is just starting to drag the element
			if(iMouseDown && allowDrag && !lMouseState)
			{
			
				// mouseDown target
				curTarget     = target;
			
				// Record the mouse x and y offset for the element
				rootParent    = curTarget.parentNode;
				rootSibling   = curTarget.nextSibling;
				// todo generic
				if (rootSibling.getAttribute("name")=="tabDragMarker") rootSibling = rootSibling.nextSibling;
				

				// We remove anything that is in our dragHelper DIV so we can put a new item in it.
				for(var i=0; i < dragHelper.childNodes.length; i++)
				{
					dragHelper.removeChild(dragHelper.childNodes[i]);
				}
				curTarget.style.cursor = "move"; //new
				// Make a copy of the current item and put it in our drag helper.
				dragHelper.appendChild(curTarget.cloneNode(true));
				dragHelper.style.display = 'block';
				
				// disable dragging from our helper DIV (it's already being dragged)
				// disable other functionality
				var dragedTab = dragHelper.firstChild;
				while (dragedTab && dragedTab.getAttribute("isDrag")!=1)
				{
					dragedTab = dragedTab.nextSibling;
				}
				JSUtils.clearAllEventsFromElement(dragedTab);
				dragedTab.removeAttribute('DragObj');
				dragedTab.id = "dragChild";
				dragHelper.style.width = parseInt(curTarget.getAttribute("savedClientWidth"))+"px";
				dragHelper.style.height = parseInt(curTarget.clientHeight)+"px";
				
				/*
				Record the current position of all drag/drop targets related
				to the element.  We do this here so that we do not have to do
				it on the general mouse move event which fires when the mouse
				moves even 1 pixel.  If we don't do this here the script
				would run much slower.
				*/
				var dragConts = DragDrops[dragObj];
				var overflown = dragConts[parseInt(target.getAttribute("CurCont"))].getAttribute("overflown").split(",");
				
				mouseOffset   = getMouseOffset(target, ev, overflown);
				
				/*
				first record the width/height of our drag item.  Then hide it since
				it is going to (potentially) be moved out of its parent.
				*/
				curTarget.setAttribute('startWidth',  parseInt(curTarget.offsetWidth));
				curTarget.setAttribute('startHeight', parseInt(curTarget.offsetHeight));
				curTarget.style.display  = 'none';
				
				// loop through each possible drop container
				for(var i=0; i < dragConts.length; i++)
				{
					var pos = getPosition(dragConts[i]);
					
					/*
					save the width, height and position of each container.
					
					Even though we are saving the width and height of each
					container back to the container this is much faster because
					we are saving the number and do not have to run through
					any calculations again.  Also, offsetHeight and offsetWidth
					are both fairly slow.  You would never normally notice any
					performance hit from these two functions but our code is
					going to be running hundreds of times each second so every
					little bit helps!
					
					Note that the biggest performance gain here, by far, comes
					from not having to run through the getPosition function
					hundreds of times.
					*/
					if(JSUtils.BrowserDetection.applewebkit) // Safari
					{
						dragConts[i].setAttribute('startHeight', parseInt(dragConts[i].scrollHeight));
					}
					else
					{
						dragConts[i].setAttribute('startHeight', parseInt(dragConts[i].offsetHeight));
					}
					dragConts[i].setAttribute('startWidth',  parseInt(dragConts[i].offsetWidth));
					dragConts[i].setAttribute('startLeft',   parseInt(pos.x));
					dragConts[i].setAttribute('startTop',    parseInt(pos.y));
					
					// loop through each child element of each container
					for(var j=0; j < dragConts[i].childNodes.length; j++)
					{
						if((dragConts[i].childNodes[j].nodeName=='#text') || (dragConts[i].childNodes[j]==curTarget)) continue;
						var overflown = dragConts[i].getAttribute("overflown").split(",");
						var pos = getPosition(dragConts[i].childNodes[j], overflown);
						
						// save the width, height and position of each element
						if(JSUtils.BrowserDetection.applewebkit) // Safari
						{
							dragConts[i].childNodes[j].setAttribute('startHeight', parseInt(dragConts[i].childNodes[j].scrollHeight));
						}
						else
						{
							dragConts[i].childNodes[j].setAttribute('startHeight', parseInt(dragConts[i].childNodes[j].offsetHeight));
						}
						dragConts[i].childNodes[j].setAttribute('startWidth',  parseInt(dragConts[i].childNodes[j].offsetWidth));
						dragConts[i].childNodes[j].setAttribute('startLeft',   parseInt(pos.x));
						dragConts[i].childNodes[j].setAttribute('startTop',    parseInt(pos.y));
					}
				}
			}
		}
		
		// If we get in here we are dragging something
		if(curTarget && curTarget.getAttribute("isDrag")=="1")
		{	
			// move our helper div to wherever the mouse is (adjusted by mouseOffset)
			var topP = mousePos.y - mouseOffset.y;
			var leftP = mousePos.x - mouseOffset.x;
			
			var widthP = parseInt(curTarget.getAttribute('startWidth'));
			var heightP = parseInt(curTarget.getAttribute('startHeight'));
			if (topP > 0 && (topP+heightP) < LayoutService.getBodyHeight()) {
				dragHelper.style.top  = mousePos.y - mouseOffset.y;
			}
			
			if ( !LSAPI.AFPPlugin.configuration.isRTL() )
			{
				if ( leftP > 0 && (leftP+widthP) < LayoutService.getBodyWidth() )
				{
					dragHelper.style.left = mousePos.x - mouseOffset.x;
				} 
				
			} 
			else 
			{
				var RTLMouseOffset = 5;
				var dragLeft = mousePos.x - widthP - document.body.scrollLeft + RTLMouseOffset;
				if (dragLeft >= 0 && ( mousePos.x - document.body.scrollLeft + RTLMouseOffset ) < LayoutService.getBodyWidth() ) 
				{
					dragHelper.style.left = dragLeft + "px";
				}
			}	
					
			var dragConts  = DragDrops[curTarget.getAttribute('DragObj')];
			var dragMarkers = Markers[curTarget.getAttribute('DragObj')];
			var activeCont = null;

			var xPos = mousePos.x - mouseOffset.x;// + (parseInt(curTarget.getAttribute('startWidth')) /2);
			var yPos = mousePos.y - mouseOffset.y;// + (parseInt(curTarget.getAttribute('startHeight'))/2);
			
			// check each drop container to see if our target object is "inside" the container
			for(var i=0; i < dragConts.length; i++)
			{
				if( (parseInt(dragConts[i].getAttribute('startLeft')) < xPos) &&
					(parseInt(dragConts[i].getAttribute('startTop')) < yPos) &&
					((parseInt(dragConts[i].getAttribute('startLeft')) + parseInt(dragConts[i].getAttribute('startWidth')))  > xPos) &&
					((parseInt(dragConts[i].getAttribute('startTop'))  + parseInt(dragConts[i].getAttribute('startHeight'))) > yPos))
				{
					/*
					our target is inside of our container so save the container into
					the activeCont variable and then exit the loop since we no longer
					need to check the rest of the containers
					*/
					activeCont = dragConts[i];
					if (curMarker && curMarker!=dragMarkers[i] && curMarker.style)
						curMarker.style.display = "none";
					curMarker = dragMarkers[i];

					// exit the for loop
					break;
				}
			}
			
			// Our target object is in one of our containers.  Check to see where our div belongs
			if(activeCont)
			{
				// beforeNode will hold the first node AFTER where our div belongs
				var beforeNode = null;
				
				var loopStart, loopEnd, loopSkip;
				if (LSAPI.AFPPlugin.configuration.isRTL()) 
				{
					loopStart = 0;
					loopEnd = activeCont.childNodes.length;
					loopSkip = 1;
				} 
				else 
				{
					loopStart = activeCont.childNodes.length - 1;
					loopEnd = -1;
					loopSkip = -1;
				}
				
				// loop through each child node (skipping text nodes).
				for(var i=loopStart; i!=loopEnd; i+=loopSkip)
				{
					var currTab = activeCont.childNodes[i];
					
					if(currTab.nodeName == '#text') continue;
					if(currTab == curMarker) continue;
					
					var currTabTop 	= parseInt( currTab.getAttribute('startTop') );
					var currTabHeight = parseInt( currTab.getAttribute('startHeight') );
					var currTabLeft 	= parseInt( currTab.getAttribute('startLeft') );
					var currTabWidth 	= parseInt( currTab.getAttribute('startWidth') );
					
					// if the current item is "After" the item being dragged
					if( curTarget != currTab						&&
						( ( currTabTop + currTabHeight ) > yPos )	&&
							( ( !LSAPI.AFPPlugin.configuration.isRTL() &&
							( ( currTabLeft + currTabWidth )  > xPos ) ) ) ||
							( LSAPI.AFPPlugin.configuration.isRTL() &&
							( ( currTabLeft + currTabWidth )  > mousePos.x ) ) )
					{
						beforeNode = currTab;
					}
				}
				
				// the item being dragged belongs before another item
				if (beforeNode)
				{
					if (dropBeforeNode == null) {
						dropBeforeNode = beforeNode;
					}
				
					if (activeCont.getAttribute("overflown") == TLN_AFP_IVIEW.getFirstLevelScrollableElm().id)
					{
						var autoScroll 					= null;
						var beforeNodeLeft 				= parseInt(beforeNode.getAttribute('startLeft'));
						var beforeNodeWidth 			= parseInt(beforeNode.getAttribute('startWidth'));
						var firstLevelContainerLeft 	= parseInt(TLN_AFP_IVIEW.getFirstLevelPosition().x);
						var firstLevelContainerWidth 	= parseInt(TLN_AFP_IVIEW.getFirstLevelScrollableElm().style.width);
						
						if( LSAPI.AFPPlugin.configuration.isRTL() ) // RTL
						{
							if( beforeNodeLeft + beforeNodeWidth > firstLevelContainerLeft - 10 )
							{
								autoScroll = "ff";
							}
							else if( beforeNodeLeft < 0 )
							{
								autoScroll = "rw";
							}
						}
						else //LTR
						{
							if ( beforeNodeLeft < firstLevelContainerLeft - 10 )
							{
								autoScroll = "rw";
							}
							else if ( beforeNodeLeft + beforeNodeWidth > firstLevelContainerLeft + firstLevelContainerWidth)
							{
								autoScroll = "ff";
							}
						}
						
						if( autoScroll )
						{
							TLN_AFP_IVIEW.first_level_scroll( autoScroll ); // scroll Forward or Rewind.
							
							calculateContChildren(activeCont);
							activeCont.insertBefore(curMarker, curTarget);
						}
						
					}
					
					if (beforeNode != curTarget.nextSibling)
					{
						dropBeforeNode = beforeNode;
						
						activeCont.insertBefore(curTarget, beforeNode);
						activeCont.insertBefore(curMarker, curTarget);
						
						
						//debug.write("activeCont.insertBefore("+curTarget.id+","+ beforeNode.id+");");
					}
					
				// the item being dragged belongs at the end of the current container
				}	
				else
				{
					if((curTarget.nextSibling) || (curTarget.parentNode!=activeCont))
					{
						dropBeforeNode = "end";
						activeCont.appendChild(curTarget);
						activeCont.insertBefore(curMarker, curTarget);
					}
				}
				
				// make our drag item visible
				/*if(curTarget.style.display!=''){
					curTarget.style.display  = '';
				}*/
				if(curTarget.style.display!='none')
				{
					curTarget.style.display  = 'none';
				}
				if(curMarker.style.display!='')
				{
					curMarker.style.display  = '';
				}
			}
			else
			{
				
				dropBeforeNode = null;
				// our drag item is not in a container, so hide it.
				if(curTarget.style.display!='none')
				{
					curTarget.style.display  = 'none';
				}
				if(curMarker && curMarker.style.display!='none')
				{
					curMarker.style.display  = 'none';
				}
			}
		}
		else if (iMouseDown && !lMouseState && target.getAttribute("isDrag")=="0")
		{
			target.style.cursor = "no-drop"; // only in iE
			curTarget = target;
		} 
		
		// track the current mouse state so we can compare against it next time
		lMouseState = iMouseDown;

		// mouseMove target
		lastTarget  = target;

		// track the current mouse state so we can compare against it next time
		lMouseState = iMouseDown;

		// this helps prevent items on the page from being highlighted while dragging
		return false;
	}

	var mouseUp = function(ev)
	{
		if(!curMarker)
		{
			curMarker = JSUtils.$('tabDragMarker');
		} 
		if(curTarget){
			curTarget.style.cursor = "pointer";
			if (curTarget.getAttribute("isDrag")=="1"){
				// hide our helper object - it is no longer needed
				dragHelper.style.display = 'none';
				// if the drag item is invisible put it back where it was before moving it
				if(curMarker.style.display == 'none'){
					if(rootSibling){
						rootParent.insertBefore(curTarget, rootSibling);
					} else {
						rootParent.appendChild(curTarget);
					}
				}
				else{
					curMarker.style.display = 'none';
						TLN_AFP_IVIEW.rearrangeTlnNodes(curTarget, dropBeforeNode);
				}
		
				// make sure the drag item is visible
				curTarget.style.display = '';
				// update the scroll buttons state.
				TLN_AFP_IVIEW.updateFirstLevelScrollBtnsState("both");
			}
		}
		curTarget  = null;
		iMouseDown = false;
		lMouseState = iMouseDown;
		if (dragTimeOut){
			clearTimeout(dragTimeOut);
			delete dragTimeOut;
		}
		
		if (document.addEventListener)
		{
			document.removeEventListener("mousemove", mouseMove, false);
			document.removeEventListener("mouseup", mouseUp, false);
		}
		else if (document.attachEvent)
		{
			document.detachEvent("onmousemove", mouseMove);
			document.detachEvent("onmouseup", mouseUp);
			document.body.detachEvent("onmouseleave", mouseUp); // IE fix - When the cursor goes out os screen, drop the dragged element.
		}
		
		hideContentCover();
	};

	var mouseDown = function(e)
	{
		iMouseDown = true;
		// historically the reamrked lines used to delay the move action, after grasp image was implemented- no need to delay
		//allowDrag=false;
		/*if(dragTimeOut)
			clearTimeout(dragTimeOut);*/
		//dragTimeOut=setTimeout("allowDrag=true;clearTimeout(dragTimeOut);delete dragTimeOut;",200);
		allowDrag=true;
		
		showContentCover();
		
		if (document.addEventListener)
		{
			document.addEventListener("mousemove", mouseMove, false);
			document.addEventListener("mouseup", mouseUp, false);
		}
		else if (document.attachEvent)
		{
			document.attachEvent("onmousemove", mouseMove);
			document.attachEvent("onmouseup", mouseUp);
			document.body.attachEvent("onmouseleave", mouseUp);
		}
		
		if(lastTarget || JSUtils.BrowserDetection.applewebkit){
			return false;
		}
	};
	
	var showContentCover = function()
	{
		// get content area div
		var divContentArea = JSUtils.$("divContentArea");
		if (divContentArea)
		{
			// getting iframe size and position
			var contentPosition = JSUtils.findAbsolutePosition(divContentArea);
			
			// display the cover area div
			coverAreaElement.setSizeAndLocation( contentPosition.x, contentPosition.y, divContentArea.offsetWidth, divContentArea.offsetHeight );
			coverAreaElement.display("dragHelper_div");
		}
	};
	
	var hideContentCover = function()
	{
		// hide the cover area div
		coverAreaElement.hide("dragHelper_div");
	};

	var calculateContChildren = function (activeCont)
	{
		for(var j=0; j < activeCont.childNodes.length; j++)
		{
			if((activeCont.childNodes[j].nodeName=='#text') || (activeCont.childNodes[j]==curTarget)) continue;
			var overflown = activeCont.getAttribute("overflown").split(",");
			var pos = getPosition(activeCont.childNodes[j], overflown);
			
			// save the width, height and position of each element
			activeCont.childNodes[j].setAttribute('startWidth',  parseInt(activeCont.childNodes[j].offsetWidth));
			activeCont.childNodes[j].setAttribute('startHeight', parseInt(activeCont.childNodes[j].offsetHeight));
			activeCont.childNodes[j].setAttribute('startLeft',   parseInt(pos.x));
			activeCont.childNodes[j].setAttribute('startTop',    parseInt(pos.y));
		}
	};
	
	return {
		"CreateDragContainer":CreateDragContainer,
		"setDragHelper":setDragHelper,
		"getDragHelper":getDragHelper,
		"mouseDown":mouseDown
	};

}();
