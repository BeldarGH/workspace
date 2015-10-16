var AFP_TLN_DRAG_DROP=function(){
var mouseOffset=null;
var iMouseDown=false;
var lMouseState=false;
var dragObject=null;
var DragDrops=[];
var Markers=[];
var curTarget=null;
var lastTarget=null;
var dragHelper=null;
var rootParent=null;
var rootSibling=null;
var curMarker=null;
var dropBeforeNode=null;
var allowDrag=false;
var dragTimeOut=null;
var setDragHelper=function(el, cls){
dragHelper=JSUtils.$("dragHelper_div");
if(JSUtils.BrowserDetection.applewebkit)
{
dragHelper.style.position="absolute";}
};
var getDragHelper=function(){
return dragHelper;
};
var CreateDragContainer=function(){

var cDrag=DragDrops.length;
DragDrops[cDrag]=[];
Markers[cDrag]=[];
for(var i=0; i < arguments.length; i++){
var cObj=arguments[i];
DragDrops[cDrag].push(cObj);
cObj.setAttribute('DropObj', cDrag);
for(var j=0; j < cObj.childNodes.length; j++){
if (cObj.childNodes[j].getAttribute('isDrag')=="1"){
cObj.childNodes[j].setAttribute('DragObj', cDrag);
cObj.childNodes[j].setAttribute('CurCont', i);}
else if (cObj.childNodes[j].getAttribute('name')=="tabDragMarker"){
Markers[cDrag].push(cObj.childNodes[j]);}
}}
};
var getMouseOffset=function(target, ev, overflown){
ev=ev || window.event;
var docPos=getPosition(target, overflown);
var mousePos=JSUtils.mouseCoords(ev);
return {x:mousePos.x - docPos.x, y:mousePos.y - docPos.y};
};
var getPosition=function(el, overflown){
if (el.getBoundingClientRect){
var bounding=el.getBoundingClientRect();
return {x:bounding.left+document.body.scrollLeft, y:bounding.top+document.body.scrollTop};}
overflown=overflown || [];
var left=0, top=0;
do{
left += el.offsetLeft || 0;
top += el.offsetTop || 0;
el=el.offsetParent;}
while (el);
for (var i=0; i < overflown.length; i++){
var element=document.getElementById(overflown[i]);
left -= element.scrollLeft || 0;
top -= element.scrollTop || 0;}
left -= document.body.scrollLeft;
top -= document.body.scrollTop;
return {x: left, y: top};
};
/*
lMouseState represents the previous mouse button state so that we can
check for button clicks and button releases:
if(iMouseDown && !lMouseState)
if(!iMouseDown && lMouseState)
*/
var mouseMove=function(ev){
ev=ev || window.event;
var target=JSUtils.getElementFromEvent(ev);
var mousePos=JSUtils.mouseCoords(ev);
if (target.className == "TransparentCover"){
target=target.parentNode;}
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
var dragedTab=dragHelper.firstChild;
while (dragedTab && dragedTab.getAttribute("isDrag")!=1){
dragedTab=dragedTab.nextSibling;}
JSUtils.clearAllEventsFromElement(dragedTab);
dragedTab.removeAttribute('DragObj');
dragedTab.id="dragChild";
dragHelper.style.width=parseInt(curTarget.getAttribute("savedClientWidth"))+"px";
dragHelper.style.height=parseInt(curTarget.clientHeight)+"px";
var dragConts=DragDrops[dragObj];
var overflown=dragConts[parseInt(target.getAttribute("CurCont"))].getAttribute("overflown").split(",");
mouseOffset=getMouseOffset(target, ev, overflown);
/*
first record the width/height of our drag item. Then hide it since
it is going to (potentially) be moved out of its parent.
*/
curTarget.setAttribute('startWidth', parseInt(curTarget.offsetWidth));
curTarget.setAttribute('startHeight', parseInt(curTarget.offsetHeight));
curTarget.style.display='none';
for(var i=0; i < dragConts.length; i++){
var pos=getPosition(dragConts[i]);
if(JSUtils.BrowserDetection.applewebkit)
{
dragConts[i].setAttribute('startHeight', parseInt(dragConts[i].scrollHeight));}
else{
dragConts[i].setAttribute('startHeight', parseInt(dragConts[i].offsetHeight));}
dragConts[i].setAttribute('startWidth', parseInt(dragConts[i].offsetWidth));
dragConts[i].setAttribute('startLeft', parseInt(pos.x));
dragConts[i].setAttribute('startTop', parseInt(pos.y));
for(var j=0; j < dragConts[i].childNodes.length; j++){
if((dragConts[i].childNodes[j].nodeName=='#text') || (dragConts[i].childNodes[j]==curTarget)) continue;
var overflown=dragConts[i].getAttribute("overflown").split(",");
var pos=getPosition(dragConts[i].childNodes[j], overflown);
if(JSUtils.BrowserDetection.applewebkit)
{
dragConts[i].childNodes[j].setAttribute('startHeight', parseInt(dragConts[i].childNodes[j].scrollHeight));}
else{
dragConts[i].childNodes[j].setAttribute('startHeight', parseInt(dragConts[i].childNodes[j].offsetHeight));}
dragConts[i].childNodes[j].setAttribute('startWidth', parseInt(dragConts[i].childNodes[j].offsetWidth));
dragConts[i].childNodes[j].setAttribute('startLeft', parseInt(pos.x));
dragConts[i].childNodes[j].setAttribute('startTop', parseInt(pos.y));}
}}
}
if(curTarget && curTarget.getAttribute("isDrag")=="1"){

var topP=mousePos.y - mouseOffset.y;
var leftP=mousePos.x - mouseOffset.x;
var widthP=parseInt(curTarget.getAttribute('startWidth'));
var heightP=parseInt(curTarget.getAttribute('startHeight'));
if (topP > 0 && (topP+heightP) < LayoutService.getBodyHeight()){
dragHelper.style.top=mousePos.y - mouseOffset.y;}
if(!LSAPI.AFPPlugin.configuration.isRTL()){
if(leftP > 0 && (leftP+widthP) < LayoutService.getBodyWidth()){
dragHelper.style.left=mousePos.x - mouseOffset.x;}
}
else{
var RTLMouseOffset=5;
var dragLeft=mousePos.x - widthP - document.body.scrollLeft + RTLMouseOffset;
if (dragLeft >= 0 &&(mousePos.x - document.body.scrollLeft + RTLMouseOffset)< LayoutService.getBodyWidth()){
dragHelper.style.left=dragLeft + "px";}
}
var dragConts=DragDrops[curTarget.getAttribute('DragObj')];
var dragMarkers=Markers[curTarget.getAttribute('DragObj')];
var activeCont=null;
var xPos=mousePos.x - mouseOffset.x;
var yPos=mousePos.y - mouseOffset.y;
for(var i=0; i < dragConts.length; i++){
if( (parseInt(dragConts[i].getAttribute('startLeft')) < xPos) &&
(parseInt(dragConts[i].getAttribute('startTop')) < yPos) &&
((parseInt(dragConts[i].getAttribute('startLeft')) + parseInt(dragConts[i].getAttribute('startWidth'))) > xPos) &&
((parseInt(dragConts[i].getAttribute('startTop')) + parseInt(dragConts[i].getAttribute('startHeight'))) > yPos)){

activeCont=dragConts[i];
if (curMarker && curMarker!=dragMarkers[i] && curMarker.style)
curMarker.style.display="none";
curMarker=dragMarkers[i];
break;}
}
if(activeCont){

var beforeNode=null;
var loopStart, loopEnd, loopSkip;
if (LSAPI.AFPPlugin.configuration.isRTL()){
loopStart=0;
loopEnd=activeCont.childNodes.length;
loopSkip=1;}
else{
loopStart=activeCont.childNodes.length - 1;
loopEnd=-1;
loopSkip=-1;}

for(var i=loopStart; i!=loopEnd; i+=loopSkip){
var currTab=activeCont.childNodes[i];
if(currTab.nodeName == '#text') continue;
if(currTab == curMarker) continue;
var currTabTop=parseInt( currTab.getAttribute('startTop') );
var currTabHeight=parseInt( currTab.getAttribute('startHeight') );
var currTabLeft=parseInt( currTab.getAttribute('startLeft') );
var currTabWidth=parseInt( currTab.getAttribute('startWidth') );
if( curTarget != currTab &&(( currTabTop + currTabHeight)> yPos)&&(( !LSAPI.AFPPlugin.configuration.isRTL() &&(( currTabLeft + currTabWidth)> xPos)))||(LSAPI.AFPPlugin.configuration.isRTL() &&(( currTabLeft + currTabWidth)> mousePos.x))){
beforeNode=currTab;}
}
if (beforeNode){
if (dropBeforeNode == null){
dropBeforeNode=beforeNode;}
if (activeCont.getAttribute("overflown") == TLN_AFP_IVIEW.getFirstLevelScrollableElm().id){
var autoScroll=null;
var beforeNodeLeft=parseInt(beforeNode.getAttribute('startLeft'));
var beforeNodeWidth=parseInt(beforeNode.getAttribute('startWidth'));
var firstLevelContainerLeft=parseInt(TLN_AFP_IVIEW.getFirstLevelPosition().x);
var firstLevelContainerWidth=parseInt(TLN_AFP_IVIEW.getFirstLevelScrollableElm().style.width);
if( LSAPI.AFPPlugin.configuration.isRTL())
{
if( beforeNodeLeft + beforeNodeWidth > firstLevelContainerLeft - 10){
autoScroll="ff";}
else if( beforeNodeLeft < 0){
autoScroll="rw";}
}
else
{
if(beforeNodeLeft < firstLevelContainerLeft - 10){
autoScroll="rw";}
else if(beforeNodeLeft + beforeNodeWidth > firstLevelContainerLeft + firstLevelContainerWidth){
autoScroll="ff";}
}
if( autoScroll){
TLN_AFP_IVIEW.first_level_scroll( autoScroll );
calculateContChildren(activeCont);
activeCont.insertBefore(curMarker, curTarget);}
}
if (beforeNode != curTarget.nextSibling){
dropBeforeNode=beforeNode;
activeCont.insertBefore(curTarget, beforeNode);
activeCont.insertBefore(curMarker, curTarget);
}
}
else{
if((curTarget.nextSibling) || (curTarget.parentNode!=activeCont)){
dropBeforeNode="end";
activeCont.appendChild(curTarget);
activeCont.insertBefore(curMarker, curTarget);}
}
/*if(curTarget.style.display!=''){
curTarget.style.display='';
}*/
if(curTarget.style.display!='none'){
curTarget.style.display='none';}
if(curMarker.style.display!=''){
curMarker.style.display='';}
}
else{
dropBeforeNode=null;
if(curTarget.style.display!='none'){
curTarget.style.display='none';}
if(curMarker && curMarker.style.display!='none'){
curMarker.style.display='none';}
}}
else if (iMouseDown && !lMouseState && target.getAttribute("isDrag")=="0"){
target.style.cursor="no-drop";
curTarget=target;}

lMouseState=iMouseDown;
lastTarget=target;
lMouseState=iMouseDown;
return false;}
var mouseUp=function(ev){
if(!curMarker){
curMarker=JSUtils.$('tabDragMarker');}
if(curTarget){
curTarget.style.cursor="pointer";
if (curTarget.getAttribute("isDrag")=="1"){
dragHelper.style.display='none';
if(curMarker.style.display == 'none'){
if(rootSibling){
rootParent.insertBefore(curTarget, rootSibling);}
else{
rootParent.appendChild(curTarget);}
}
else{
curMarker.style.display='none';
TLN_AFP_IVIEW.rearrangeTlnNodes(curTarget, dropBeforeNode);}

curTarget.style.display='';
TLN_AFP_IVIEW.updateFirstLevelScrollBtnsState("both");}
}
curTarget=null;
iMouseDown=false;
lMouseState=iMouseDown;
if (dragTimeOut){
clearTimeout(dragTimeOut);
delete dragTimeOut;}
if (document.addEventListener){
document.removeEventListener("mousemove", mouseMove, false);
document.removeEventListener("mouseup", mouseUp, false);}
else if (document.attachEvent){
document.detachEvent("onmousemove", mouseMove);
document.detachEvent("onmouseup", mouseUp);
document.body.detachEvent("onmouseleave", mouseUp);
}
hideContentCover();
};
var mouseDown=function(e){
iMouseDown=true;
/*if(dragTimeOut)
clearTimeout(dragTimeOut);*/
allowDrag=true;
showContentCover();
if (document.addEventListener){
document.addEventListener("mousemove", mouseMove, false);
document.addEventListener("mouseup", mouseUp, false);}
else if (document.attachEvent){
document.attachEvent("onmousemove", mouseMove);
document.attachEvent("onmouseup", mouseUp);
document.body.attachEvent("onmouseleave", mouseUp);}
if(lastTarget || JSUtils.BrowserDetection.applewebkit){
return false;}
};
var showContentCover=function(){

var divContentArea=JSUtils.$("divContentArea");
if (divContentArea){

var contentPosition=JSUtils.findAbsolutePosition(divContentArea);
coverAreaElement.setSizeAndLocation( contentPosition.x, contentPosition.y, divContentArea.offsetWidth, divContentArea.offsetHeight );
coverAreaElement.display("dragHelper_div");}
};
var hideContentCover=function(){

coverAreaElement.hide("dragHelper_div");
};
var calculateContChildren=function (activeCont){
for(var j=0; j < activeCont.childNodes.length; j++){
if((activeCont.childNodes[j].nodeName=='#text') || (activeCont.childNodes[j]==curTarget)) continue;
var overflown=activeCont.getAttribute("overflown").split(",");
var pos=getPosition(activeCont.childNodes[j], overflown);
activeCont.childNodes[j].setAttribute('startWidth', parseInt(activeCont.childNodes[j].offsetWidth));
activeCont.childNodes[j].setAttribute('startHeight', parseInt(activeCont.childNodes[j].offsetHeight));
activeCont.childNodes[j].setAttribute('startLeft', parseInt(pos.x));
activeCont.childNodes[j].setAttribute('startTop', parseInt(pos.y));}
};
return{
"CreateDragContainer":CreateDragContainer,
"setDragHelper":setDragHelper,
"getDragHelper":getDragHelper,
"mouseDown":mouseDown
};
}();
var personalizationChange=null;
var TLN_AFP_IVIEW=function(){

/***************************************/
/*************** constants ***********************************************/
/***************************************/
var FIRST_LEVEL_SCROLL_STEPS=30;
var FIRST_LEVEL_SCROLL_SPEED=50;
var NAVIGATION_DOCKED_ATTR="com.sap.portal.navigation.isDocked";
var TOOL_TIP_ATTR="com.sap.portal.navigation.Tooltip";
var NAVIGATION_LEVELS="com.sap.portal.navigation.levels";
var PROP_DRAGABLEETABS="com.sap.portal.navigation.afp.dragableTabs";
var AFP_PERS_MENU_ID="afp_personalize_menu_id";
var MI_CLEAR_PERSONALIZE="com.sap.portal.navigation.afp.menu.item.ClearPersonalization";
var DISPLAY_NAME_ATTR="displayName";
var FIXED_TITLE_ATTR="fixedTitle";
var IS_SELECTED_ATTR="isSelected";
var SAVED_CLIENT_HEIGHT_ATTR="savedClientHeight";
var SAVED_CLIENT_WIDTH_ATTR="savedClientWidth";
var TAB_INDEX_ATTR="tabIndex";
var TOP_TAB_INDEX_ATTR="topTabIndex";
var SUB_TAB_INDEX_ATTR="subTabIndex";
var DISABLE_CLASS_ATTR="disableClass";
var HOVER_CLASS_ATTR="hoverClass";
var STANDARD_CLASS_ATTR="standardClass";
var ENABLED_BUTTON_ATTR="enabled";
var DOWN_BUTTON_ATTR="downClass";
var IS_OVERFLOW_ATTR="isOverflow";
var LENGTH_ATTR="length";
var TLN_BIDI_SIZE_FIX=4;
/***************************************/
/***************************************/
/************** global variables *************************/
/***************************************/
var TLN_NUMBER_OF_FIXED_TABS=0;
var TLN_COMPONENT_KEY="TopLevel";
var NAVIGATION_LEVELS="com.sap.portal.navigation.levels";
var NUMBER_OF_LEVELS;
var TLN_SECOND_LEVEL;
var REMOVABLE_TABS;
var DRAGABLE_TABS;
var DISPLAY_MODE;
var displayModePrefix="";
var DRILL_DOWN_LEVEL;
var tabsContainerInitialWidth=10000;
var timeInterval, timeOut;
var isLastClickFromTln=false;
var isLoadedFirstTime=true;
var isSecondLevelFinishedDrawFirstTime=false;
var isFinishedLoadedFirstTime=false;
var selected_tab, selected_subTab;
var firstLevelScrollLimit;
var firstLevelScrollLimitR;
var firstLevelTabIdsArr=[];
var unDockedTabIdsArr=[];
var secondLevelStartOverflowTabIndex;
var secondLevelNodesArr;
var popupMenuContainer;
var tln_currentMenu;
var lastBodyWidth=null;
var ResourceBundleStrings={};
var firstLevelPosition;
var rebuildTLN=false;
var forceSetTLNSize=false;
var currentlySelectedScrollBtn=null;
var lastNavNodeName=null;
var firstLevelScrollableTD, staticMenuTDElm;
var firstLevelOverflowTD=null, secondLevelOverflowTD;
var updateFirstLevelScrollBtnsState=null;
var isPersonalized=false;
var smallTabsMode=null;
var TabWorkCenterCSSClass="TabWorkCenter";
var TabHomeCSSClass="TabHome";
var DarkSeparator01CSSClass="DarkSeparator01";
var FirstLevelSeperatorCSSClass="Separator";
var WorkcenterStandardCSSClass="WorkcenterStandard";
var WorkcenterDownCSSClass="WorkcenterDown";
var WorkcenterHoverCSSClass="WorkcenterHover";
var HouseStandardCSSClass="HouseStandard";
var HouseDownCSSClass="HouseDown";
var HouseHoverCSSClass="HouseHover";
var TabHoverCSSClass="TabHover";
var TabDown00CSSClass="TabDown00";
var TabDown10CSSClass="TabDown10";
var TabDown20CSSClass="TabDown20";
var TabDownForSub00CSSClass="TabDownForSub00";
var TabDownForSub10CSSClass="TabDownForSub10";
var TabDownForSub20CSSClass="TabDownForSub20";
var TabDownForSub01CSSClass="TabDownForSub01";
var TabDownForSub11CSSClass="TabDownForSub11";
var TabDownForSub21CSSClass="TabDownForSub21";
var OverflowTabCSSClass="OverflowTab";
var DragMarker1CSSClass="DragMarker1";
var FirstLevelTabTextCSSClass="TabText";
var BottomBorderCSSClass="TabBottomBorder";
var FirstLevelTabDownClass="TabDown";
/*****************************************************************************/
/***************************************/
/************************* General button states - HTML Elements ****************************/
/***************************************/
var pixelImage="<img src=\"/com.sap.portal.navigation.afp.tln/images/blank.gif\" alt=\"\" style=\"width:1px;\" \/>";
var darkSeperatorHTML=function darkSeperatorHTML(){
return ["<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" height=\"100%\" width=\"2\">",
"<tr>",
"<td height=\"100%\" class=\"DarkSeparator00\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"</tr>",
"<tr>",
"<td class=\"",DarkSeparator01CSSClass,"\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"</tr>",
"</table>"
].join("");
};
var downDivHTML=function downDivHTML(){
return ["<table dir=\"ltr\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">",
"<tr>",
"<td class=\"" + TabDown00CSSClass + "\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"<td width=\"100%\" class=\"" + TabDown10CSSClass + "\" nowrap=\"nowrap\">"+ pixelImage +"</td>",
"<td class=\"" + TabDown20CSSClass + "\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"</tr>",
"</table>" ].join("");
};
var downDivWithSubTabsHTML=function downDivWithSubTabsHTML(){
var backgroundPositionRTLFix="";
if( LSAPI.AFPPlugin.configuration.isRTL() && !smallTabsMode)backgroundPositionRTLFix=" style=\"background-position: left top;\"";
return ["<table dir=\"ltr\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">",
"<tr>",
"<td class=\"" + TabDownForSub00CSSClass + "\"" + backgroundPositionRTLFix + " nowrap=\"nowrap\">" + pixelImage + "</td>",
"<td class=\"" + TabDownForSub10CSSClass + "\" width=\"100%\" nowrap=\"nowrap\">" + pixelImage + "</td>" +
"<td class=\"" + TabDownForSub20CSSClass + "\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"</tr>",
"<tr>",
"<td class=\"" + TabDownForSub01CSSClass + "\"" + backgroundPositionRTLFix + " height=\"100%\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"<td class=\"" + TabDownForSub11CSSClass + "\" height=\"3px\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"<td class=\"" + TabDownForSub21CSSClass + "\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"</tr>" +
"</table>"].join("");
};
var smallTabsHomeDownDivHTML=function smallTabsHomeDownDivHTML(){
var additionalStyle="";
if(JSUtils.BrowserDetection.applewebkit)
{
additionalStyle=" style=\"height: 45px;\"";}
return ["<table dir=\"ltr\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"" + additionalStyle + ">",
"<tr>",
"<td class=\"HomeDownForSub00_SmallTabs\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"<td class=\"HomeDownForSub10_SmallTabs\" width=\"100%\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"<td class=\"HomeDownForSub20_SmallTabs\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"</tr>",
"<tr>",
"<td class=\"HomeDownForSub01_SmallTabs\" height=\"100%\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"<td class=\"HomeDownForSub11_SmallTabs\" width=\"100%\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"<td class=\"HomeDownForSub21_SmallTabs\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"</tr>",
"<tr>",
"<td class=\"HomeDownForSub02_SmallTabs\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"<td class=\"HomeDownForSub12_SmallTabs\" width=\"100%\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"<td class=\"HomeDownForSub22_SmallTabs\" nowrap=\"nowrap\">" + pixelImage + "</td>",
"</tr>",
"</table>"].join("");
};
var dragDrop1stLevelDevider=function dragDrop1stLevelDevider(){
return ["<div id=\"tabDragMarker\" name=\"tabDragMarker\" class=\"DragMarker\" style=\"display:none;\">",
"<div class=\"DragMarker0\"></div>",
"<div class=" + DragMarker1CSSClass + "></div>",
"<div class=\"DragMarker2\"></div>",
"</div>"].join("");
};
var initTLN=function initTLN(){
registerTLNEvents();
var node=LSAPI.AFPPlugin.model.getCurrentLaunchNode();
setInitialParams(node);
smallTabsMode=(DISPLAY_MODE == "No Images");
setInitialMarkup();
setOverflowTooltips();
};
var registerTLNEvents=function registerTLNEvents(){
EPCM.subscribeEvent('urn:com.sapportals:navigation','ClearPersonalization', TLN_AFP_IVIEW.clearPersonalization);
personalizationChange=top.LSAPI.AFPPlugin.service.getPersonalizationChangesMethod(TLN_AFP_IVIEW.savePersonalization);
top.LSAPI.AFPPlugin.controller.registerOnNavigate(TLN_AFP_IVIEW.updateTLN);
top.LSAPI.getVisualPlugin().registerScreenModeChangeNotification(TLN_AFP_IVIEW.screenModeChange);
top.LSAPI.getTabsetPlugin().registerOnTabsetSwitch(TLN_AFP_IVIEW.applyTabsetFilter);
top.LSAPI.getTabsetPlugin().registerOnBeforeTabsetSwitch(TLN_AFP_IVIEW.beforeTabsetSwitched);
};
var setInitialParams=function setInitialParams(node){

TLN_AFP_IVIEW.updateNavLevels(node);
REMOVABLE_TABS=top.LSAPI.AFPPlugin.configuration.getClientSideAttributeValue(TLN_COMPONENT_KEY,"com.sap.portal.navigation.afp.removableTabs");
if (JSUtils.isEmpty(REMOVABLE_TABS) || "null" == REMOVABLE_TABS){
REMOVABLE_TABS="false";}
REMOVABLE_TABS=(REMOVABLE_TABS=="true");
DRAGABLE_TABS=top.LSAPI.AFPPlugin.configuration.getClientSideAttributeValue(TLN_COMPONENT_KEY,"com.sap.portal.navigation.afp.dragableTabs");
if (JSUtils.isEmpty(DRAGABLE_TABS) || "null" == DRAGABLE_TABS){
DRAGABLE_TABS="true";}
DRAGABLE_TABS=(DRAGABLE_TABS=="true");
setNumberOfFixedTabs();
DRILL_DOWN_LEVEL=LSAPI.AFPPlugin.configuration.getClientSideAttributeValue(TLN_COMPONENT_KEY,"com.sap.portal.navigation.afp.drillDownLevel");
if (JSUtils.isEmpty(DRILL_DOWN_LEVEL) || "null" == DRILL_DOWN_LEVEL){
DRILL_DOWN_LEVEL="2";}
DISPLAY_MODE=LSAPI.AFPPlugin.configuration.getClientSideAttributeValue(TLN_COMPONENT_KEY,"com.sap.portal.navigation.afp.displayMode");
if (JSUtils.isEmpty(DISPLAY_MODE) || "null" == DISPLAY_MODE){
DISPLAY_MODE="Default";}
displayModePrefix=(DISPLAY_MODE == "No Images")?"_SmallTabs":"";
TLN_AFP_IVIEW.initCssPrefixes();
};
var setNumberOfFixedTabs=function setNumberOfFixedTabs(){
TLN_NUMBER_OF_FIXED_TABS=top.LSAPI.AFPPlugin.configuration.getClientSideAttributeValue( TLN_COMPONENT_KEY, "com.sap.portal.navigation.afp.numberOfFixedTabs" );
if(JSUtils.isEmpty(TLN_NUMBER_OF_FIXED_TABS) || "null" == TLN_NUMBER_OF_FIXED_TABS){
TLN_NUMBER_OF_FIXED_TABS="1";}
TLN_NUMBER_OF_FIXED_TABS=parseInt(TLN_NUMBER_OF_FIXED_TABS);
};
var setInitialMarkup=function setInitialMarkup(){
var firstLevelTR=JSUtils.$('firstLevelTR');
if( !firstLevelTR)return;
if(TLN_NUMBER_OF_FIXED_TABS > 0){
var fixedTabCell=firstLevelTR.insertCell(-1);
fixedTabCell.id="staticMenuTD";
fixedTabCell.className="Menu Static";
fixedTabCell.style.verticalAlign="top";
fixedTabCell.nowrap="nowrap";
fixedTabCell.innerHTML="<div id=\"staticMenuDiv\"></div>";
var fixedTabSeparatorCell=firstLevelTR.insertCell(-1);
fixedTabSeparatorCell.style.verticalAlign="top";
fixedTabSeparatorCell.style.width="2px";
fixedTabSeparatorCell.style.paddingTop="1px";
fixedTabSeparatorCell.innerHTML=darkSeperatorHTML();
}
var markup=new JSUtils.StringBuilder();
var firstLevelCell=firstLevelTR.insertCell(-1);
firstLevelCell.id="firstLevelScrollable_td";
firstLevelCell.className="Menu Scrollable";
if( smallTabsMode){
firstLevelCell.style.width="100%";}
firstLevelCell.style.display="block";
firstLevelCell.style.verticalAlign="top";
firstLevelCell.nowrap="nowrap";
markup.Append( "<div id=\"firstLevelScrollable\" class=\"firstLevelScrollableClass\">" );
markup.Append( "<div id=\"allFirstLevelTabs\" style=\"height:100%;\" overflown=\"firstLevelScrollable\">" );
markup.Append( "</div>" );
markup.Append( "</div>" );
firstLevelCell.innerHTML=markup.ToString();
if( smallTabsMode){
var endAreaSTSeparatorCell=firstLevelTR.insertCell(-1);
endAreaSTSeparatorCell.innerHTML="<div class=\"OverflowDividerLeft_SmallTabs\"></div>";}
else{
var endAreaSeparatorCell=firstLevelTR.insertCell(-1);
endAreaSeparatorCell.style.verticalAlign="top";
endAreaSeparatorCell.style.width="2px";
endAreaSeparatorCell.style.paddingTop="1px";
if (LSAPI.AFPPlugin.configuration.isRTL()){
endAreaSeparatorCell.style.paddingLeft="24px";}
endAreaSeparatorCell.innerHTML=darkSeperatorHTML();}
var endAreaSTCell=firstLevelTR.insertCell(-1);
endAreaSTCell.id="endStretchedArea";
endAreaSTCell.className="EndArea" + displayModePrefix;
endAreaSTCell.nowrap="nowrap";
markup=new JSUtils.StringBuilder();
if( smallTabsMode){
markup.Append( "<table id=\"OverflowAreaOpen\" class=\"ScrollingArea Open_SmallTabs\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"display: none;\">" );
markup.Append( "<tr>" );
markup.Append( "<td><div id=\"tlnBackwardBtn\" class=\"BackwardBtn_SmallTabs bDisabled_SmallTabs\" enabled=\"0\" standardClass=\"BackwardBtn_SmallTabs bStandard_SmallTabs\" hoverClass=\"BackwardBtn_SmallTabs bHover_SmallTabs\" downClass=\"BackwardBtn_SmallTabs bDown_SmallTabs\" disableClass=\"BackwardBtn_SmallTabs bDisabled_SmallTabs\" onmousedown=\"TLN_AFP_IVIEW.scrollBtnDown(this);event.cancelBubble=true;\" onmouseup=\"TLN_AFP_IVIEW.scrollBtnUp(this);event.cancelBubble=true;\" onmouseover=\"TLN_AFP_IVIEW.scrollBtnHover(this);event.cancelBubble=true;\" onmouseout=\"TLN_AFP_IVIEW.scrollBtnOut(this);event.cancelBubble=true;\"></div></td>" );
markup.Append( "<td><div class=\"OverflowDivider_SmallTabs\"></div></td>" );
markup.Append( "<td><div id=\"tlnForwardBtn\" class=\"ForwardBtn_SmallTabs fStandard_SmallTabs\" enabled=\"1\" standardClass=\"ForwardBtn_SmallTabs fStandard_SmallTabs\" hoverClass=\"ForwardBtn_SmallTabs fHover_SmallTabs\" downClass=\"ForwardBtn_SmallTabs fDown_SmallTabs\" disableClass=\"ForwardBtn_SmallTabs fDisabled_SmallTabs\" onmousedown=\"TLN_AFP_IVIEW.scrollBtnDown(this);event.cancelBubble=true;\" onmouseup=\"TLN_AFP_IVIEW.scrollBtnUp(this);event.cancelBubble=true;\" onmouseover=\"TLN_AFP_IVIEW.scrollBtnHover(this);event.cancelBubble=true;\" onmouseout=\"TLN_AFP_IVIEW.scrollBtnOut(this);event.cancelBubble=true;\"></div></td>" );
markup.Append( "<td><div class=\"OverflowDivider_SmallTabs\"></div></td>" );
markup.Append( "<td><div id=\"tlnOverflowBtn\" class=\"OverflowBtn_SmallTabs oStandard_SmallTabs\" enabled=\"1\" standardClass=\"OverflowBtn_SmallTabs oStandard_SmallTabs\" hoverClass=\"OverflowBtn_SmallTabs oHover_SmallTabs\" downClass=\"OverflowBtn_SmallTabs oDown_SmallTabs\" disableClass=\"OverflowBtn_SmallTabs oDisabled_SmallTabs\" onclick=\"if (JSUtils.$('OverflowAreaOpen').style.display != 'none'){TLN_AFP_IVIEW.draw1stLevelOverflowMenu(this);}\" onmouseover=\"TLN_AFP_IVIEW.scrollBtnHover(this);event.cancelBubble=true;\" onmouseout=\"TLN_AFP_IVIEW.scrollBtnOut(this);event.cancelBubble=true;\"></div></td>" );
markup.Append( "</tr>" );
markup.Append( "</table>" );
}
else{
markup.Append( "<div id=\"OverflowAreaOpen\" class=\"ScrollingArea Open\" style=\"display:none;\">" );
markup.Append( "<div id=\"tlnForwardBtn\" class=\"ForwardBtn fStandard\" enabled=\"1\" standardClass=\"ForwardBtn fStandard\" hoverClass=\"ForwardBtn fHover\" downClass=\"ForwardBtn fDown\" disableClass=\"ForwardBtn fDisabled\" onmousedown=\"TLN_AFP_IVIEW.scrollBtnDown(this);event.cancelBubble=true;\" onmouseup=\"TLN_AFP_IVIEW.scrollBtnUp(this);event.cancelBubble=true;\" onmouseover=\"TLN_AFP_IVIEW.scrollBtnHover(this);event.cancelBubble=true;\" onmouseout=\"TLN_AFP_IVIEW.scrollBtnOut(this);event.cancelBubble=true;\"></div>" );
markup.Append( "<div id=\"tlnBackwardBtn\" class=\"BackwardBtn bDisabled\" enabled=\"0\" standardClass=\"BackwardBtn bStandard\" hoverClass=\"BackwardBtn bHover\" downClass=\"BackwardBtn bDown\" disableClass=\"BackwardBtn bDisabled\" onmousedown=\"TLN_AFP_IVIEW.scrollBtnDown(this);event.cancelBubble=true;\" onmouseup=\"TLN_AFP_IVIEW.scrollBtnUp(this);event.cancelBubble=true;\" onmouseover=\"TLN_AFP_IVIEW.scrollBtnHover(this);event.cancelBubble=true;\" onmouseout=\"TLN_AFP_IVIEW.scrollBtnOut(this);event.cancelBubble=true;\"></div>" );
markup.Append( "<div id=\"tlnOverflowBtn\" class=\"OverflowBtn oStandard\" enabled=\"1\" standardClass=\"OverflowBtn oStandard\" hoverClass=\"OverflowBtn oHover\" downClass=\"OverflowBtn oDown\" disableClass=\"OverflowBtn oDisabled\" onclick=\"if (JSUtils.$('OverflowAreaOpen').style.display != 'none'){TLN_AFP_IVIEW.draw1stLevelOverflowMenu(this);}\" onmouseover=\"TLN_AFP_IVIEW.scrollBtnHover(this);event.cancelBubble=true;\" onmouseout=\"TLN_AFP_IVIEW.scrollBtnOut(this);event.cancelBubble=true;\"></div>" );
markup.Append( "</div>" );
}
markup.Append( "<div id=\"dragHelper_div\" class=\"FirstLevelDragHelper\" style=\"z-index:300;\"></div>" );
markup.Append( "<div id=\"OverflowAreaClose\" class=\"ScrollingArea Close" + displayModePrefix + "\" style=\"display:block;\"></div>" );
endAreaSTCell.innerHTML=markup.ToString();
};
var setOverflowTooltips=function setOverflowTooltips(){
var forwardBtnTooltip=top.LSAPI.AFPPlugin.configuration.getResourceBundleValue("TopLevel", "TLN_FRWRD_BTN");
var backwardBtnTooltip=top.LSAPI.AFPPlugin.configuration.getResourceBundleValue("TopLevel", "TLN_BCWRD_BTN");
var overflowBtnTooltip=top.LSAPI.AFPPlugin.configuration.getResourceBundleValue("TopLevel", "TLN_OVERFLOW_BTN");
var tlnForwardBtnElm=JSUtils.$("tlnForwardBtn");
if (tlnForwardBtnElm) tlnForwardBtnElm.title=forwardBtnTooltip;
var tlnBackwardBtnElm=JSUtils.$("tlnBackwardBtn");
if (tlnBackwardBtnElm) tlnBackwardBtnElm.title=backwardBtnTooltip;
var tlnOverflowBtnElm=JSUtils.$("tlnOverflowBtn");
if (tlnOverflowBtnElm) tlnOverflowBtnElm.title=overflowBtnTooltip;
var secondLevelOverflowBtnElm=JSUtils.$("secondLevelOverflowButton_div");
if(secondLevelOverflowBtnElm) secondLevelOverflowBtnElm.title=overflowBtnTooltip;
};
function outerHTML(node){
return node.outerHTML || new XMLSerializer().serializeToString(node);
};
/***************************************************************/
/***************************************************************/
var updateTLN=function(currentNode){
var visualPlugin=LSAPI.getVisualPlugin();
if (isLastClickFromTln){
isLastClickFromTln=false;
return;}
smallTabsMode=(DISPLAY_MODE == "No Images");
updateNavLevels(currentNode);
if (isLoadedFirstTime){
accessibilityInitialization();
if(LSAPI.AFPPlugin.configuration.isRTL() && !smallTabsMode){
initRTL();}
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
if( smallTabsMode && JSUtils.BrowserDetection.is_firefox)
{
firstLevelScrollable.style.height="44px";}
visualPlugin.registerScreenModeChangeNotification(TLN_AFP_IVIEW.setFullScreenAttributes);
setFullScreenAttributes(0);
createTLNCollections();
createTLN(currentNode);
AFPLayoutAPI.notifyOnFinishLoading('TopLevel');
isLoadedFirstTime=false;}
else if( currentNode && rebuildTLN ){
rebuildTLN=false;
createTLN(currentNode);}
else if (currentNode != null && currentNode.getName()!=lastNavNodeName){
updateSelectedNodes(currentNode);}
};
/**
* How does number of levels in the TLN is determined (in order of their importance)?
* 1. Node - if configured on the node ignore the following configurations:
* 2. Page (AFP) - if configured on the Page ignore ignore the following configurations:
* 3. TLN iview - if configured on the iview ignore ignore the following configurations:
* 4. Default - If none of the above was configured - num of levels=2.
**/
var updateNavLevels =function(currentNode){
var navLevels;
if(currentNode)
{
var firstLevelNode=currentNode.getFirstLevel();
navLevels=firstLevelNode.getAttributeValue(NAVIGATION_LEVELS);
}
if (JSUtils.isEmpty(navLevels) || "null" == navLevels)
{
navLevels=LSAPI.AFPPlugin.configuration.getAttributeValue("navLevels");
if ((JSUtils.isEmpty(navLevels) || "null" == navLevels))
{
navLevels=top.LSAPI.AFPPlugin.configuration.getClientSideAttributeValue(TLN_COMPONENT_KEY,"com.sap.portal.navigation.afp.numberOfLevels");
if (JSUtils.isEmpty(navLevels) || "null" == navLevels)
{
navLevels="2";
}}
}
if( (!JSUtils.isEmpty(NUMBER_OF_LEVELS)) && (navLevels != NUMBER_OF_LEVELS)){
rebuildTLN=true;
forceSetTLNSize=true;}
NUMBER_OF_LEVELS=navLevels;
TLN_SECOND_LEVEL=(parseInt(NUMBER_OF_LEVELS)==2);
};
var initRTL=function(){
var tlnOverflowAreaOpenElm=JSUtils.$("OverflowAreaOpen");
if (tlnOverflowAreaOpenElm) tlnOverflowAreaOpenElm.style.right="5px";
var tlnOverflowAreaColseElm=JSUtils.$("OverflowAreaClose");
if (tlnOverflowAreaColseElm) tlnOverflowAreaColseElm.style.right="5px";
var tlnForwardBtnElm=JSUtils.$("tlnForwardBtn");
if (tlnForwardBtnElm) tlnForwardBtnElm.style.right="10px";
var tlnBackwardBtnElm=JSUtils.$("tlnBackwardBtn");
if (tlnBackwardBtnElm) tlnBackwardBtnElm.style.right="10px";
var tlnOverflowBtnElm=JSUtils.$("tlnOverflowBtn");
if (tlnOverflowBtnElm) tlnOverflowBtnElm.style.right="10px";
};
/***************************************************************/
/***************************************************************/
var applyTabsetFilter=function(){

TLN_AFP_IVIEW.selected_tab=null;
selected_tab=null;
rebuildTLN=true;
forceSetTLNSize=true;
isSecondLevelFinishedDrawFirstTime=false;
firstLevelTabIdsArr=[];
unDockedTabIdsArr=[];
var staticMenuDiv=JSUtils.$("staticMenuDiv");
if (staticMenuDiv){
staticMenuDiv.innerHTML="";}

};
/***************************************************************
Function: accessibilityInitialization
Description: gets all accessibility strings from the resource bundle
and sets the DTN skeleton as accessible.
****************************************************************/
var accessibilityInitialization=function(){
var isAccMode=AccessibilityManager.isAccessibilityModeOn();
var tlnTableElmId="TlnMainTable";
var tlnTableElm=JSUtils.$(tlnTableElmId);
AccessibilityManager.setElementAccessKey(tlnTableElm, "T");
tlnTableElm.tabIndex=0;
AccessibilityManager.setSkipableElement(AccessibilityManager.TLN_ENTRY, tlnTableElm);
AccessibilityManager.setEntryId(AccessibilityManager.TLN_ENTRY, tlnTableElmId);
if(isAccMode){

ResourceBundleStrings.tlnEntry=top.LSAPI.AFPPlugin.configuration.getResourceBundleValue("TopLevel", "ACC_TLN");
ResourceBundleStrings.entryLevel=top.LSAPI.AFPPlugin.configuration.getResourceBundleValue("TopLevel", "ACC_TLN_LEVEL");
ResourceBundleStrings.selectedEntry=top.LSAPI.AFPPlugin.configuration.getResourceBundleValue("TopLevel", "ACC_TLN_SELECTED");
ResourceBundleStrings.unselectedEntry=top.LSAPI.AFPPlugin.configuration.getResourceBundleValue("TopLevel", "ACC_TLN_UNSELECTED");
AccessibilityManager.setElementAccessibilityTooltip(tlnTableElm, ResourceBundleStrings.tlnEntry);}
};
var updateSelectedNodes=function(currentNode){

if (currentNode == null){
return;}
lastNavNodeName=currentNode.getName();
var node=currentNode;
var el=JSUtils.$(node.getName());
while(!el && node.getParent()){
node=node.getParent();
el=JSUtils.$(node.getName());}

if (el){
var level=parseInt(el.getAttribute("level"));
if (level == 1){
if (TLN_AFP_IVIEW.selected_tab != el.parentNode){
selectFirstLevelTab(el.parentNode);
if (TLN_SECOND_LEVEL)
node.getChildren(draw2ndLevelNodes, [currentNode]);}
} else if (level == 2){

if (node.getParent()){
var firstLevelTab=JSUtils.$(node.getParent().getName());
if (firstLevelTab){
firstLevelTab=firstLevelTab.parentNode;
if (TLN_AFP_IVIEW.selected_tab != firstLevelTab)
selectFirstLevelTab(firstLevelTab);}
}
if (TLN_AFP_IVIEW.selected_subTab != el.parentNode)
selectSecondLevelTab(el.parentNode);}
}
};
var createTLN=function(currentNode){
LSAPI.AFPPlugin.model.getNavigationSubTree(null, drawInitialNodes, [currentNode]);
};
/***************************************************************/
/***************************************************************/
var compareCurrentNodeId=function(currentNode, nodeName, recursive){
if (!nodeName || !currentNode) return false;
if (currentNode.getName() == nodeName){
return true;}
else{
if (recursive){
return compareCurrentNodeId(currentNode.getParent(), nodeName, recursive);}
else{
return false;}
}
};
/********************************************************************/
/********************************************************************/
var checkShorter3dotsText=function(str, numOfChr){
if (str.length > numOfChr){
return (str.substr(0, numOfChr) + "...");}
else{
return str;}
};
/********************************************************************/
/********************************************************************/
var setTlnSizeTimeout;
var delayedSetTlnSize=function(){
setTlnSizeTimeout=window.setTimeout("window.clearTimeout(TLN_AFP_IVIEW.setTlnSizeTimeout);TLN_AFP_IVIEW.setTlnSize();",20);
};
var firstSizeCalculation=function(){
setTlnSizeTimeout=window.setTimeout("window.clearTimeout(TLN_AFP_IVIEW.setTlnSizeTimeout);TLN_AFP_IVIEW.setTlnSize();",20);
};
var setFullScreenAttributes=function(mode){
if (mode != 0)return;
if (!JSUtils.BrowserDetection.is_ie && !JSUtils.BrowserDetection.applewebkit){
var secondLevelScrollableParent=JSUtils.$("BgSubTabArea1");
var curCollSpan=parseInt(secondLevelScrollableParent.getAttribute("colspan"));
var newCollSpan;
if (curCollSpan == 5 || curCollSpan == 3){
newCollSpan=curCollSpan - 1;
secondLevelScrollableParent.setAttribute("colspan", newCollSpan);}
}
};
var setTlnSize=function(){

var sndLevelDivElm;
if (!forceSetTLNSize){
if(parseInt(lastBodyWidth) == parseInt(LayoutService.getBodyWidth()) ||
parseInt(LayoutService.getBodyWidth()) == 0)return;}
else{
forceSetTLNSize=false;}

lastBodyWidth=parseInt(LayoutService.getBodyWidth());
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
if (!firstLevelScrollableTD) firstLevelScrollableTD=JSUtils.$("firstLevelScrollable_td");
if (!firstLevelPosition) firstLevelPosition=JSUtils.findAbsolutePosition(firstLevelScrollable);
setTLNWidthAndOverflow1stLevel();
setTLNWidthAndOverflow2ndLevel();
if (!JSUtils.BrowserDetection.is_ie){
firstLevelScrollable.style.display="block";
var staticMenuDiv=JSUtils.$("staticMenuDiv");
firstLevelScrollableTD.style.display="";
if (staticMenuDiv){
if (smallTabsMode){
staticMenuDiv.style.height="44px";}
else{
staticMenuDiv.style.height="67px";}
}}

window.setTimeout( TLN_AFP_IVIEW.fixTLNWidth, (JSUtils.BrowserDetection.applewebkit)? 100: 0);
if (TLN_AFP_IVIEW.selected_tab)
scrollTabToVisibleScope(TLN_AFP_IVIEW.selected_tab);
};
var fixTLNWidth=function(){
if( !JSUtils.BrowserDetection.is_ie)return;
var firstLevelScrollableTDWidth=parseInt(JSUtils.$('firstLevelScrollable_td').clientWidth);
var firstLevelScrollableWidth=parseInt(JSUtils.$('firstLevelScrollable').clientWidth);
if (firstLevelScrollableTDWidth > firstLevelScrollableWidth){
JSUtils.$('firstLevelScrollable').style.width=firstLevelScrollableTDWidth + 'px';}

var secondLevelScrollableTDWidth=parseInt( JSUtils.$('BgSubTabArea1').clientWidth );
var secondLevelScrollableWidth=parseInt( JSUtils.$('secondLevelScrollable').clientWidth );
if(JSUtils.BrowserDetection.is_ie &&
LSAPI.AFPPlugin.configuration.isRTL() &&
secondLevelScrollableTDWidth > secondLevelScrollableWidth){
JSUtils.$('secondLevelScrollable').style.width=secondLevelScrollableTDWidth + 'px';}
};
var set1stLevelWidth=function set1stLevelWidth(){
var screenWidth;
if (LayoutService.getLayoutMinWidth() > lastBodyWidth)
screenWidth=LayoutService.getLayoutMinWidth();
else
screenWidth=lastBodyWidth;
if (!firstLevelScrollableTD) firstLevelScrollableTD=JSUtils.$("firstLevelScrollable_td");
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
var outerTableFramesWidth=getOuterframeWidth();
open_close_scroll("open");
var firstLevelRow=firstLevelScrollableTD.parentNode;
var allTDWidthsWithoutScrollabale=0;
for( var i=0;i < firstLevelRow.children.length;i++){
var curChild=firstLevelRow.children[i];
if( curChild.tagName == "TD" && curChild != firstLevelScrollableTD){
allTDWidthsWithoutScrollabale += curChild.scrollWidth;}
}
firstLevelScrollable.style.width=(screenWidth - allTDWidthsWithoutScrollabale - outerTableFramesWidth)+ "px";
};
var set2ndLevelWidth=function set2ndLevelWidth(){
var screenWidth;
if (LayoutService.getLayoutMinWidth() > lastBodyWidth)
screenWidth=LayoutService.getLayoutMinWidth();
else
screenWidth=lastBodyWidth;
var overflow_button=JSUtils.$("secondLevelOverflowButton_div");
var sndLevelDivElm=JSUtils.$("secondLevelScrollable");
overflow_button.style.display="block";
var overflowBtnWidth=overflow_button.clientWidth;
var outerTableFramesWidth=getOuterframeWidth();
var RTLOffset=LSAPI.AFPPlugin.configuration.isRTL()?4:0;
if (TLN_SECOND_LEVEL){
sndLevelDivElm.style.width=(screenWidth - overflowBtnWidth - outerTableFramesWidth - RTLOffset) + "px";}
};
/********************************************************************/
/********************************************************************/
var setTLNWidthAndOverflow1stLevel=function(){
set1stLevelWidth();
if (LSAPI.AFPPlugin.configuration.isRTL())
setTLNWidthAndOverflow1stLevelRTL();
else
setTLNWidthAndOverflow1stLevelLTR();
};
var setTLNWidthAndOverflow1stLevelLTR=function(){

var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
var allFirstLevelTabs=JSUtils.$("allFirstLevelTabs");
var endArea_td=JSUtils.$("endStretchedArea");
var firstLevel_row=endArea_td.parentNode;
var isOverflow=false;
if (firstLevelTabIdsArr.length > TLN_NUMBER_OF_FIXED_TABS+1){
var lastChild=allFirstLevelTabs.lastChild;
while (lastChild && lastChild.id.indexOf(TAB_INDEX_ATTR)!=0)
lastChild=lastChild.previousSibling;
var lastChildPosX=JSUtils.findAbsolutePosition(lastChild).x;
var allTabsTablePosX=JSUtils.findAbsolutePosition(allFirstLevelTabs).x;
isOverflow=lastChild &&(lastChildPosX + parseInt( lastChild.getAttribute(SAVED_CLIENT_WIDTH_ATTR))> allTabsTablePosX + parseInt(firstLevelScrollable.style.width) );}

var cell=endArea_td.previousSibling;
for (var i=0; i < 1; i++){
while (cell.tagName != "TD"){
cell=cell.previousSibling;}
for (var j=0; j < cell.childNodes.length; j++){
if (cell.childNodes[j].nodeName=='#text') continue;
cell.childNodes[j].style.visibility=(isOverflow)? "visible": "hidden";}
cell=cell.previousSibling;}
if (isOverflow){
open_close_scroll("open");
firstLevelScrollLimit=lastChildPosX -
allTabsTablePosX +
parseInt(lastChild.getAttribute(SAVED_CLIENT_WIDTH_ATTR)) -
parseInt(firstLevelScrollable.style.width) - 1;
updateFirstLevelScrollBtnsState("both");
if(JSUtils.BrowserDetection.applewebkit && !smallTabsMode)
{
firstLevelScrollable.style.width=( parseInt(firstLevelScrollable.style.width) + 9)+ "px";}
}
else{
firstLevelScrollLimit=undefined;
open_close_scroll("close");
firstLevelScrollable.scrollLeft=0;
var firstLevelWidth=parseInt(firstLevelScrollable.style.width);
if(JSUtils.BrowserDetection.is_ie)
{
firstLevelScrollable.style.width=( firstLevelWidth + 13)+ "px";}
else if(JSUtils.BrowserDetection.applewebkit)
{
var safariWidthOffset=smallTabsMode?48:26;
firstLevelScrollable.style.width=( firstLevelWidth + safariWidthOffset)+ "px";}
else
{
var firefoxWidthOffset=smallTabsMode?49:17;
firstLevelScrollable.style.width=( firstLevelWidth + firefoxWidthOffset)+ "px";}
}
firstLevelScrollable.setAttribute(IS_OVERFLOW_ATTR,isOverflow? "true": "false");
if (TLN_SECOND_LEVEL){
if (endArea_td.previousSibling.className != BottomBorderCSSClass){
for(var i=0; i < firstLevel_row.cells.length; i++){
if(i==0 ||(i==2 && TLN_NUMBER_OF_FIXED_TABS>0)) continue;
var cell=firstLevel_row.cells[i];
if(cell.className == "" || cell.className.length == 0){
cell.className=BottomBorderCSSClass;}
else if(cell.className.indexOf(BottomBorderCSSClass) == -1){
cell.className=cell.className + " " + BottomBorderCSSClass;}
}}
}
else{

for(var i=0; i < firstLevel_row.cells.length;i++){
if(i==0 ||(i==2 && TLN_NUMBER_OF_FIXED_TABS>0)) continue;
var cell=firstLevel_row.cells[i];
if(cell.className.indexOf(BottomBorderCSSClass) > -1){
var arr=cell.className.split(" ");
var classStr="";
for( var j=0;j < arr.length;j++){
if( arr[j] != BottomBorderCSSClass){
classStr +=((classStr=="")?(arr[j]):(" " + arr[j]) );}
}
cell.className=classStr;}
}}
};
var setTLNWidthAndOverflow1stLevelRTL=function(){

var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
var allFirstLevelTabs=JSUtils.$("allFirstLevelTabs");
var endArea_td=JSUtils.$("endStretchedArea");
var firstLevel_row=endArea_td.parentNode;
var isOverflow=false;
if(firstLevelTabIdsArr.length > TLN_NUMBER_OF_FIXED_TABS + 1){
var lastChild=allFirstLevelTabs.lastChild;
while(lastChild && lastChild.id.indexOf(TAB_INDEX_ATTR) != 0)lastChild=lastChild.previousSibling;
var lastChildPosX=JSUtils.findAbsolutePosition(lastChild).x;
var allTabsTablePosX=JSUtils.findAbsolutePosition(allFirstLevelTabs).r;
var allTabsTablePosL=JSUtils.findAbsolutePosition(allFirstLevelTabs).x;
isOverflow=lastChild && (lastChildPosX - document.body.scrollLeft) < allTabsTablePosX - parseInt(firstLevelScrollable.style.width);}

var cell=endArea_td.previousSibling;
for (var i=0; i < 1; i++){
while (cell.tagName != "TD"){
cell=cell.previousSibling;}
for (var j=0; j < cell.childNodes.length; j++){
if (cell.childNodes[j].nodeName=='#text') continue;
cell.childNodes[j].style.visibility=(isOverflow)? "visible": "hidden";}
cell=cell.previousSibling;}
if (isOverflow){
open_close_scroll("open");
firstLevelScrollLimit=lastChildPosX - allTabsTablePosL;
firstLevelScrollLimitR=allFirstLevelTabs.clientWidth - parseInt(firstLevelScrollable.style.width);
updateFirstLevelScrollBtnsStateRTL("both");
if(JSUtils.BrowserDetection.applewebkit && !smallTabsMode)
{
firstLevelScrollable.style.width=( parseInt(firstLevelScrollable.style.width) + 9)+ "px";}
}
else{
firstLevelScrollLimit=undefined;
firstLevelScrollLimitR=undefined;
open_close_scroll("close");
firstLevelScrollable.scrollLeft=allFirstLevelTabs.clientWidth - parseInt(firstLevelScrollable.style.width);
if (!JSUtils.BrowserDetection.is_ie){
firstLevelScrollable.style.width=(parseInt(firstLevelScrollable.style.width)+7)+"px";}
else{
firstLevelScrollable.style.width=(parseInt(firstLevelScrollable.style.width)+13)+"px";}
}
firstLevelScrollable.setAttribute(IS_OVERFLOW_ATTR,isOverflow? "true": "false");
if (TLN_SECOND_LEVEL){
if (endArea_td.previousSibling.className != BottomBorderCSSClass){
var mainTable=firstLevel_row.parentNode;
while (mainTable.tagName!="TABLE"){
mainTable=mainTable.parentNode;}
for (var i=0; i < firstLevel_row.cells.length; i++){
if (i==0 || (i==2 && TLN_NUMBER_OF_FIXED_TABS>0)) continue;
var cell=firstLevel_row.cells[i];
if (cell.className == "" || cell.className.length == 0){
cell.className=BottomBorderCSSClass;}
else{
if (cell.className.indexOf(BottomBorderCSSClass) == -1){
cell.className=cell.className + " " + BottomBorderCSSClass;}
}}
}}
};
var setTLNWidthAndOverflow2ndLevel=function(){
if (!TLN_SECOND_LEVEL) return;
set2ndLevelWidth();
if (LSAPI.AFPPlugin.configuration.isRTL())
setTLNWidthAndOverflow2ndLevelRTL();
else
setTLNWidthAndOverflow2ndLevelLTR();
};
var setTLNWidthAndOverflow2ndLevelLTR=function(){

var scrolling_div=JSUtils.$("secondLevelScrollable");
var overflow_button=JSUtils.$("secondLevelOverflowButton_div");
var index=0;
var tab_div=null;
var tab_end_position=0;
while(true){
var tab_div=JSUtils.$(SUB_TAB_INDEX_ATTR+index);
if( !tab_div)break;
tab_end_position += tab_div.clientWidth;
if( tab_end_position >= scrolling_div.clientWidth)break;
index++;}
if (tab_div){
overflow_button.style.display="block";
secondLevelStartOverflowTabIndex=index;}
else{
overflow_button.style.display="none";}
};
var setTLNWidthAndOverflow2ndLevelRTL=function(){
var overflow_button=JSUtils.$("secondLevelOverflowButton_div");
var index=0;
var tab_div=null;
var overflowBtnWidth=overflow_button.clientWidth;
while(true){
var tab_div=JSUtils.$(SUB_TAB_INDEX_ATTR+index);
if( !tab_div || JSUtils.findAbsolutePosition(tab_div).x <= overflowBtnWidth)break;
index++;}
if (tab_div){
overflow_button.style.display="block";
secondLevelStartOverflowTabIndex=index;}
else{
overflow_button.style.display="none";}
};
var getFirstLevelPosition=function(){
return firstLevelPosition;
};
var getFirstLevelScrollableElm=function(){
return JSUtils.$("firstLevelScrollable");
};
/********************************************************************/
/********************************************************************/
var drawInitialNodes=function(nodes, args){
if (!nodes)
return;
var MOUSE_OUT_EVENT="onmouseout";
var MOUSE_OVER_EVENT="onmouseover";
if(JSUtils.BrowserDetection.is_ie)
{
MOUSE_OUT_EVENT="onmouseleave";
MOUSE_OVER_EVENT="onmouseenter";}

var isEnabled=LSAPI.getTabsetPlugin().isEnabled();
var currentTabset=LSAPI.getTabsetPlugin().getCurrentTabset();
if (isEnabled && (currentTabset != "ALL")){
TLN_NUMBER_OF_FIXED_TABS=0;}
else{

setNumberOfFixedTabs();}

var markup=[];
firstLevelTabIdsArr=[];
for (var i=0; i < nodes.length; i++){
var node, title, tooltip, nodeUri, isDrag, isDocked;
node=nodes[i];
title=JSUtils.ESCAPE_TO_HTML(node.getTitle());
tooltip=(node.getAttributeValue(TOOL_TIP_ATTR))?node.getAttributeValue(TOOL_TIP_ATTR):title;
nodeUri=node.getNodeURI();
isDrag=(isFixedTab(i))?0:1;
if (node.getAttributeValue(NAVIGATION_DOCKED_ATTR)==null)
isDocked=true;
else
isDocked=(node.getAttributeValue(NAVIGATION_DOCKED_ATTR)=="true");
if (!isDocked){

unDockedTabIdsArr.push(node.getName());}
else{
firstLevelTabIdsArr.push(node.getName());
markup.push( "<div id=\"", TAB_INDEX_ATTR,i, "\" ");
markup.push( DISPLAY_NAME_ATTR, "=\"", title, "\" ");
markup.push("title=\"",tooltip,"\" ");
markup.push("topTabIndex=\"",i,"\" ");
markup.push("isDrag=\"",isDrag,"\" ");
if (!JSUtils.BrowserDetection.is_ie)
markup.push("style=\"-moz-user-select:none;\" ");
markup.push( MOUSE_OUT_EVENT + "=\"if(TLN_AFP_IVIEW.selected_tab!=this){TLN_AFP_IVIEW.tabStandard(this.id);}");
if(!isFixedTab(i)){
if (REMOVABLE_TABS)
markup.push("TLN_AFP_IVIEW.hideFirstLevelTabCloseButton(this);")
if (DRAGABLE_TABS)
markup.push("TLN_AFP_IVIEW.hideFirstLevelTabGrasp(this);")}
markup.push("\" ");
markup.push( MOUSE_OVER_EVENT + "=\"TLN_AFP_IVIEW.tabHover(this.id);\" ");
markup.push("class=\"",( (isFixedTab(i))? TabHomeCSSClass: TabWorkCenterCSSClass) + (TLN_SECOND_LEVEL? (" " + BottomBorderCSSClass): "")," TabStandard\">");
var downTabStyle=(TLN_SECOND_LEVEL)? "TabDownForSubContainer": "TabDownContainer";
var additionalStyle=(JSUtils.BrowserDetection.is_ie)?"":" style=\"margin-top:-1px;\"";
markup.push("<div id=\"tabDown",i,"\" class=\""+downTabStyle+"\"" + additionalStyle + ">");
if( smallTabsMode && isFixedTab(i))
{
markup.push(smallTabsHomeDownDivHTML());}
else{
markup.push((TLN_SECOND_LEVEL)? downDivWithSubTabsHTML(): downDivHTML());}
markup.push("</div>");
markup.push("<div class=\"Icon_TitleContainer\">");
markup.push("<div id=\"tabIcon",i,"\" class=\"",( (i==0 && TLN_NUMBER_OF_FIXED_TABS>0 )?HouseStandardCSSClass:WorkcenterStandardCSSClass),"\"></div>");
if( !smallTabsMode || !isFixedTab(i)){
markup.push( "<div class=\"" + FirstLevelTabTextCSSClass + "\" nowrap=\"nowrap\" style=\"white-space:nowrap\">",title,"</div>" );}

markup.push("</div>");
if(!isFixedTab(i)){
markup.push("<div id=\"tabSeperator",i,"\" class=\"",FirstLevelSeperatorCSSClass, (TLN_SECOND_LEVEL?(" " + BottomBorderCSSClass):""),"\"></div>");
if (REMOVABLE_TABS){

markup.push("<div id=\"CloseButtonContainer",i,"\" class=\"CloseButtonContainer\">");
markup.push("<div class=\"CloseButtonImageStandard\"");
markup.push(" onmouseover=\"this.className = 'CloseButtonImageHover';\"");
markup.push(" onmouseout=\"this.className = 'CloseButtonImageStandard';\"");
markup.push(" onmousedown=\"this.className = 'CloseButtonImageDown';\"");
markup.push(" onmouseup=\"this.className = 'CloseButtonImageHover';TLN_AFP_IVIEW.removeFirstLevelTab(this.parentNode.parentNode);\">");
markup.push("</div>");
markup.push("</div>");}
if (DRAGABLE_TABS){

markup.push("<div id=\"TabGraspImage",i,"\" class=\"TransparentCover\" style=\"display:none;\" onmousedown=\"AFP_TLN_DRAG_DROP.mouseDown(); return false;\"></div>");}
}
markup.push("<div style=\"display:none;\" id=\"",node.getName(),"\" level=\"1\"></div>");
markup.push("</div>");
if(isFixedTab(i)){
JSUtils.$("staticMenuDiv").innerHTML=markup.join("");
if (!JSUtils.BrowserDetection.is_ie && !JSUtils.BrowserDetection.is_firefox){

JSUtils.$("staticMenuDiv").style.paddingTop="1px";}
markup=[];}
}}
var additionalStyle="";
if( smallTabsMode && JSUtils.BrowserDetection.applewebkit)additionalStyle=" style=\"height:44px;\" ";
if (TLN_SECOND_LEVEL)
markup.push("<div class=\"TabBottomBorder\" id=\"firstLevelStrechedTab\"" + additionalStyle + ">" + pixelImage + "</div>");
else
markup.push("<div id=\"firstLevelStrechedTab\"" + additionalStyle + ">" + pixelImage + "</div>");
markup.push(dragDrop1stLevelDevider());
drawInitialLayout(markup);
drawInitialListeners(nodes,args);
};
var isFixedTab=function isFixedTab(tabIndex){
return (tabIndex < TLN_NUMBER_OF_FIXED_TABS);
};
var drawInitialLayout=function(markup){
/***************************************************************************/
/**********************Layout ordering*************************/
var nodes_container=JSUtils.$("allFirstLevelTabs");
if (!firstLevelScrollableTD) firstLevelScrollableTD=JSUtils.$("firstLevelScrollable_td");
if (JSUtils.BrowserDetection.is_ie){
if( smallTabsMode){
firstLevelScrollableTD.style.width=firstLevelScrollableTD.clientWidth + "px";}
else{
firstLevelScrollableTD.style.width="auto";}
}
nodes_container.innerHTML=markup.join("");
nodes_container.className=nodes_container.className;
if (!JSUtils.BrowserDetection.applewebkit)
nodes_container.style.width=tabsContainerInitialWidth + "px";
firstLevelScrollableTD.style.width="100%";
firstLevelScrollableTD.style.display="block";
if (!JSUtils.BrowserDetection.is_ie){

firstLevelScrollableTD.style.paddingTop="1px";}
};
/***************************************************************************/
var drawInitialListeners=function(nodes,args){

var firstTab=JSUtils.$(TAB_INDEX_ATTR + "0");
if (firstTab){
var firstTabWidth=parseInt(firstTab.clientWidth);
if (firstTabWidth == 0){
window.setTimeout(function() {drawInitialListeners(nodes,args);},20);
return;}
}
var currentNode;
if (args.length){
currentNode=args[0];}

if ((!currentNode) || "?NavigationTarget=Roles://ErrorNode" == currentNode.originalObject.nodeURI){
currentNode=nodes[0];}

var scrollableTabsSizeAggregation=0;
for (var i=0; i < nodes.length; i++){
var el=JSUtils.$(TAB_INDEX_ATTR+i);
if (!el) continue;
el.tabIndex=0;
el.setAttribute(LENGTH_ATTR, nodes.length);
setFirstLevelTabWidth(el, i);
if (i == 0)
el.setAttribute(SAVED_CLIENT_HEIGHT_ATTR, parseInt(el.clientHeight));
el.setAttribute( DISPLAY_NAME_ATTR, JSUtils.ESCAPE_TO_HTML( el.getAttribute(DISPLAY_NAME_ATTR)));
el.setAttribute( FIXED_TITLE_ATTR, JSUtils.ESCAPE_TO_HTML(el.title) );
el.setAttribute( IS_SELECTED_ATTR, "false" );
el.onclick=function(){
var node=nodes[parseInt(this.getAttribute(TOP_TAB_INDEX_ATTR))];
var hasChildren=node.hasChildren();
var nodeUri=node.getNodeURI();
top.LSAPI.AFPPlugin.service.navigate(node,node.getShowType(),'ExecuteLocally=true&DrillDownLevel='+DRILL_DOWN_LEVEL);
};
el.onfocus=function(){
checkFirstLevelScrollLimits();
scrollTabToVisibleScope(this);
var isSelected=this.getAttribute(IS_SELECTED_ATTR) == "true";
if(!isSelected)tabHover(this);
};
el.onblur=function(){
var isSelected=this.getAttribute(IS_SELECTED_ATTR) == "true";
if(!isSelected)tabStandard(this);
};
el.onkeydown=function(e){
var evt=e || window.event;
var keyCode=evt.keyCode;
if(LSAPI.AFPPlugin.configuration.isRTL()){
keyCode=AccessibilityManager.getSwitchKeyboardArrowsDirection(keyCode);}
switch(keyCode){

case AccessibilityManager.KEY_ENTER:
case AccessibilityManager.KEY_SPACE:{
this.onclick();
break;}

case AccessibilityManager.KEY_DOWN:{
if (TLN_AFP_IVIEW.selected_subTab){
try{
TLN_AFP_IVIEW.selected_subTab.focus();}
catch(e){
var firstSubTabElm=JSUtils.$("secondLevelTabs").firstChild;
if(firstSubTabElm) firstSubTabElm.focus();}
}
break;}

case AccessibilityManager.KEY_LEFT:{
focusFirstLevelPrevTab(this.id);
break;}

case AccessibilityManager.KEY_RIGHT:{
focusFirstLevelNextTab(this.id);
break;}

case AccessibilityManager.KEY_TAB:{
var focusedNextTab=false;
if(evt.shiftKey)focusedNextTab=focusFirstLevelPrevTab(this.id);
else
focusedNextTab=focusFirstLevelNextTab(this.id);
if( focusedNextTab)
AccessibilityManager.cancelDefaultKeyEvent(evt);
break;}
}
};
updateTlnAccTooltip(el, 1);
var node=nodes[i];
if (compareCurrentNodeId(currentNode, node.getName(), true)){
selectFirstLevelTab(el);
JSUtils.clearAllEventsFromElement(JSUtils.$("secondLevelTabs"));
JSUtils.$("secondLevelTabs").innerHTML="";
if (TLN_SECOND_LEVEL){

if (node.hasChildren()){
node.getChildren(draw2ndLevelNodes, [currentNode]);}
JSUtils.$("SecondLevelTR").style.display="";}
else{
JSUtils.$("SecondLevelTR").style.display="none";}
}
scrollableTabsSizeAggregation += parseInt(el.style.width);}
if (!JSUtils.BrowserDetection.applewebkit && scrollableTabsSizeAggregation > tabsContainerInitialWidth){

nodes_container.style.width=(150 + scrollableTabsSizeAggregation) + "px";}

if (!TLN_SECOND_LEVEL || (currentNode && !currentNode.hasChildren())){
firstSizeCalculation();}
drawInitialDragDrop();
drawInitialTlnSize();
};
var focusFirstLevelNextTab=function focusFirstLevelNextTab( tabId){
var currTab=JSUtils.$( tabId );
if( !currTab)return;
var currTabIndex=parseInt( currTab.getAttribute(TOP_TAB_INDEX_ATTR) );
var nextTab=currTab.nextSibling;
if( isFixedTab(currTabIndex) && !nextTab){
var allFirstLevelTabs=JSUtils.$("allFirstLevelTabs");
if( allFirstLevelTabs)nextTab=allFirstLevelTabs.firstChild;
}
while( nextTab && nextTab.id.indexOf(TAB_INDEX_ATTR) != 0)
{
nextTab=nextTab.nextSibling;}
if( nextTab)
{
nextTab.focus();
return true;}
return false;
};
var focusFirstLevelPrevTab=function focusFirstLevelPrevTab( tabId){
var currTab=JSUtils.$( tabId );
if( !currTab)return;
var currTabIndex=parseInt( currTab.getAttribute(TOP_TAB_INDEX_ATTR) );
var prevTab=currTab.previousSibling;
if( !isFixedTab(currTabIndex) &&(!prevTab ||(prevTab.id.indexOf(TAB_INDEX_ATTR) != 0 && !prevTab.previousSibling)))
{
prevTab=JSUtils.$(TAB_INDEX_ATTR + (TLN_NUMBER_OF_FIXED_TABS-1) );
}
while( prevTab && prevTab.id.indexOf(TAB_INDEX_ATTR) != 0)
{
prevTab=prevTab.previousSibling;}
if( prevTab)
{
prevTab.focus();
return true;}
return false;
};
var checkFirstLevelScrollLimits=function checkFirstLevelScrollLimits(){
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
if( !LSAPI.AFPPlugin.configuration.isRTL())
{
if( firstLevelScrollable.scrollLeft > firstLevelScrollLimit)
firstLevelScrollable.scrollLeft=firstLevelScrollLimit;}

updateFirstLevelScrollBtnsState("both");
};
var drawInitialDragDrop=function(){

AFP_TLN_DRAG_DROP.setDragHelper(JSUtils.$("dragHelper_div"));
AFP_TLN_DRAG_DROP.getDragHelper().className='FirstLevelDragHelper';
AFP_TLN_DRAG_DROP.CreateDragContainer(JSUtils.$('allFirstLevelTabs'));
};
var drawInitialTlnSize=function(){
EPCM.subscribeEvent("urn:com.sapportals.portal:browser","resize",delayedSetTlnSize);
};
/************************************************************************
Function: updateTlnAccTooltip
Parameters: nodeElm - a TLN first element to be set with accessibility tooltip
level - the TLN level that nodeElm belongs to
Decription: Sets the correct tooltip for each element, based on it status (selected, title etc.)
*************************************************************************/
var updateTlnAccTooltip=function(nodeElm, level){
if(!AccessibilityManager.isAccessibilityModeOn()) return;
var title=nodeElm.getAttribute(FIXED_TITLE_ATTR);
var isSelected=nodeElm.getAttribute(IS_SELECTED_ATTR) == "true";
var levelParam=new Array();
levelParam[0]=level;
var tooltip=title + " - " + (isSelected? ResourceBundleStrings.selectedEntry: ResourceBundleStrings.unselectedEntry) + " - " + JSUtils.messageFormat(ResourceBundleStrings.entryLevel, levelParam);
AccessibilityManager.setElementAccessibilityTooltip(nodeElm, tooltip);
};
/********************************************************************/
/********************************************************************/
var draw2ndLevelNodes=function(nodes, args){

var nodes_container=JSUtils.$("secondLevelTabs");
JSUtils.clearAllEventsFromElement(nodes_container);
nodes_container.innerHTML="";
if (!nodes){
return;}
secondLevelNodesArr=nodes;
var currentNode=(args && args.length)? args[0]: undefined;
var max_width=parseInt(nodes_container.parentNode.parentNode.clientWidth);
var agg_width=0;
var lastVisibleNodeIndex;
var markup=[];
JSUtils.$("secondLevelOverflowButton_div").style.display="none";
for (var i=0; i < nodes.length; i++){
var node=nodes[i];
var title=JSUtils.ESCAPE_TO_HTML(node.getTitle());
var tooltip=(node.getAttributeValue(TOOL_TIP_ATTR))?node.getAttributeValue(TOOL_TIP_ATTR):title;
var nodeUri=node.getNodeURI();
var nodeName=node.getName();
markup.push("<div class=\"Tab SubTabStandard\"");
markup.push(" title=\""+tooltip+"\"");
markup.push(" " + SUB_TAB_INDEX_ATTR + "=\"" + i + "\"");
markup.push(" id=\"" + SUB_TAB_INDEX_ATTR + i + "\"");
markup.push(" onmouseover=\"TLN_AFP_IVIEW.subTabHover(this);\"");
markup.push(" onmouseout=\"if(TLN_AFP_IVIEW.selected_subTab!=this){TLN_AFP_IVIEW.subTabStandard(this);}\">");
if (LSAPI.AFPPlugin.configuration.isRTL()){
markup.push("<div class=\"Separator\" style=\"float:left\"></div>");
markup.push("<div class=\"TabText\" style=\"float:left\">" + title + "</div>");}
else{
markup.push("<div class=\"TabText\">" + title + "</div>");
markup.push("<div class=\"Separator\"></div>");}
markup.push("<div style=\"display:none;\" id=\"" + nodeName + "\" level=\"2\"></div>");
markup.push("</div>");}
nodes_container.innerHTML=markup.join("");
if (lastVisibleNodeIndex){
JSUtils.$("secondLevelOverflowButton_div").style.display="block";}
var scrollableTabsSizeAggregation=0;
for (i=0; i < nodes_container.childNodes.length; i++ ){
if (nodes_container.childNodes[i].tagName != "DIV") continue;
el=nodes_container.childNodes[i];
el.tabIndex=0;
el.setAttribute(FIXED_TITLE_ATTR, JSUtils.ESCAPE_TO_HTML(el.title));
el.setAttribute(IS_SELECTED_ATTR, "false");
el.onclick=function(){
var node=nodes[parseInt(this.getAttribute(SUB_TAB_INDEX_ATTR))];
LSAPI.AFPPlugin.service.navigate(node,node.getShowType(),'ExecuteLocally=true&DrillDownLevel='+(DRILL_DOWN_LEVEL-1));
};
el.onkeydown=function(e){
var evt=e || window.event;
var keyCode=evt.keyCode;
if(LSAPI.AFPPlugin.configuration.isRTL()){
keyCode=AccessibilityManager.getSwitchKeyboardArrowsDirection(keyCode);}
if(keyCode == AccessibilityManager.KEY_ENTER || keyCode == AccessibilityManager.KEY_SPACE){
this.onclick();}
if(keyCode == AccessibilityManager.KEY_RIGHT){
var nextElm=this.nextSibling;
while(nextElm && nextElm.tagName != 'DIV'){
nextElm=nextElm.nextSibling}
if(nextElm){
nextElm.focus();}
}
if(keyCode == AccessibilityManager.KEY_LEFT){
var prevElm=this.previousSibling;
while(prevElm && prevElm.tagName != 'DIV'){
prevElm=prevElm.previousSibling}
if(prevElm){
prevElm.focus();}
}
if(keyCode == AccessibilityManager.KEY_UP){
if(TLN_AFP_IVIEW.selected_tab)TLN_AFP_IVIEW.selected_tab.focus();}
}
el.onfocus=function(){
var isSelected=this.getAttribute(IS_SELECTED_ATTR) == "true";
if(!isSelected)subTabHover(this);
if( LSAPI.AFPPlugin.configuration.isRTL() && JSUtils.BrowserDetection.is_ie){
var scrollContainer=JSUtils.$('secondLevelScrollable');
var secondLevelTabs=JSUtils.$('secondLevelTabs');
var secondLevelTR=JSUtils.$('SecondLevelTR');
var outerFrameWidth=getOuterframeWidth();
var scrollLeft=secondLevelTabs.offsetWidth - scrollContainer.offsetWidth;
var pos=JSUtils.findAbsolutePosition(this);
var currentTabPosition=pos.x -(secondLevelTR.offsetWidth - scrollContainer.offsetWidth)- outerFrameWidth;
if( currentTabPosition == 0 && currentTabPosition < scrollLeft)
{
scrollLeft=currentTabPosition;}
scrollContainer.scrollLeft=scrollLeft;}
};
el.onblur=function(){
var isSelected=this.getAttribute(IS_SELECTED_ATTR) == "true";
if(!isSelected)subTabStandard(this);
};
updateTlnAccTooltip(el, 2);
var node=nodes[parseInt(el.getAttribute(SUB_TAB_INDEX_ATTR))];
if (compareCurrentNodeId(currentNode, node.getName(), true)){
selectSecondLevelTab(el);}
scrollableTabsSizeAggregation += el.clientWidth;}
if (!JSUtils.BrowserDetection.applewebkit && scrollableTabsSizeAggregation > tabsContainerInitialWidth){

nodes_container.style.width=(150 + scrollableTabsSizeAggregation) + "px";}
if (!isSecondLevelFinishedDrawFirstTime || forceSetTLNSize){
isSecondLevelFinishedDrawFirstTime=true;
firstSizeCalculation();}
else
setTLNWidthAndOverflow2ndLevel();
};
var getOuterframeWidth=function getOuterframeWidth(){
var width=0;
var leftBorder=JSUtils.$('frame01TD');
if( leftBorder){
width += leftBorder.offsetWidth;}
var rightBorder=JSUtils.$('frame21TD');
if( rightBorder){
width += rightBorder.offsetWidth;}
return width;
};
/********************************************************************/
/********************************************************************/
var open_close_scroll=function(state){
var clsElm=JSUtils.$("OverflowAreaClose");
var opnElm=JSUtils.$("OverflowAreaOpen");
if (state == "close"){
opnElm.style.display="none";
clsElm.style.display="block";}
else if (state == "open"){
opnElm.style.display="block";
clsElm.style.display="none";}

};
/********************************************************************/
/********************************************************************/
var first_level_scroll=function(direction){
if (LSAPI.AFPPlugin.configuration.isRTL())
first_level_scroll_rtl(direction);
else
first_level_scroll_ltr(direction);
};
var first_level_scroll_ltr=function(direction){
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
if (direction == "ff"){
if (firstLevelScrollable.scrollLeft < firstLevelScrollLimit)
firstLevelScrollable.scrollLeft += FIRST_LEVEL_SCROLL_STEPS;}
else if (direction == "rw"){
if (firstLevelScrollable.scrollLeft > 0)
firstLevelScrollable.scrollLeft -= FIRST_LEVEL_SCROLL_STEPS;}
updateFirstLevelScrollBtnsState(direction);
};
var first_level_scroll_rtl=function(direction){
if (!firstLevelScrollable) firstLevelScrollable=$("firstLevelScrollable");
if (direction == "ff"){
if (!JSUtils.BrowserDetection.is_firefox){
if (firstLevelScrollable.scrollLeft < firstLevelScrollLimitR)
firstLevelScrollable.scrollLeft += FIRST_LEVEL_SCROLL_STEPS;}
else
firstLevelScrollable.scrollLeft += FIRST_LEVEL_SCROLL_STEPS;}
else if (direction == "rw"){
if (!JSUtils.BrowserDetection.is_firefox){
if (firstLevelScrollable.scrollLeft > firstLevelScrollLimit)
firstLevelScrollable.scrollLeft -= FIRST_LEVEL_SCROLL_STEPS;}
else
firstLevelScrollable.scrollLeft -= FIRST_LEVEL_SCROLL_STEPS;}
updateFirstLevelScrollBtnsState(direction);
};
/********************************************************************/
/********************************************************************/
var updateFirstLevelScrollBtnsState=function(direction){
if (LSAPI.AFPPlugin.configuration.isRTL())
updateFirstLevelScrollBtnsStateRTL(direction);
else
updateFirstLevelScrollBtnsStateLTR(direction);
};
var updateFirstLevelScrollBtnsStateLTR=function(direction){
var tlnForwardBtn=JSUtils.$("tlnForwardBtn");
var tlnBackwardBtn=JSUtils.$("tlnBackwardBtn");
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
if (direction == "ff" || direction == "both"){
if (firstLevelScrollable.scrollLeft >= firstLevelScrollLimit){
firstLevelScrollable.scrollLeft=firstLevelScrollLimit;
tlnForwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"0");
tlnForwardBtn.style.cursor="default";
tlnForwardBtn.className=tlnForwardBtn.getAttribute(DISABLE_CLASS_ATTR);
cancelMouseDownTimeOut();
tlnBackwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"1");
tlnBackwardBtn.style.cursor="pointer";
tlnBackwardBtn.className=tlnBackwardBtn.getAttribute(STANDARD_CLASS_ATTR);}
else if (tlnForwardBtn.getAttribute(ENABLED_BUTTON_ATTR)=="0"){
tlnForwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"1");
tlnForwardBtn.style.cursor="pointer";
tlnForwardBtn.className=tlnForwardBtn.getAttribute(STANDARD_CLASS_ATTR);}
}
if (direction == "rw" || direction == "both"){
if (firstLevelScrollable.scrollLeft <= 0){
firstLevelScrollable.scrollLeft=0;
tlnBackwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"0");
tlnBackwardBtn.style.cursor="default";
tlnBackwardBtn.className=tlnBackwardBtn.getAttribute(DISABLE_CLASS_ATTR);
cancelMouseDownTimeOut();
tlnForwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"1");
tlnForwardBtn.style.cursor="pointer";
tlnForwardBtn.className=tlnForwardBtn.getAttribute(STANDARD_CLASS_ATTR);}
else if (tlnBackwardBtn.getAttribute(ENABLED_BUTTON_ATTR)=="0"){
tlnBackwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"1");
tlnBackwardBtn.style.cursor="pointer";
tlnBackwardBtn.className=tlnBackwardBtn.getAttribute(STANDARD_CLASS_ATTR);}
}
};
var updateFirstLevelScrollBtnsStateRTL=function(direction){
if (!tlnForwardBtn) tlnForwardBtn=$("tlnForwardBtn");
if (!tlnBackwardBtn) tlnBackwardBtn=$("tlnBackwardBtn");
if (!JSUtils.BrowserDetection.is_firefox){
if (direction == "ff" || direction == "both"){
firstLevelScrollLimitR=allFirstLevelTabs.clientWidth - parseInt(firstLevelScrollable.style.width);
if (firstLevelScrollable.scrollLeft >= firstLevelScrollLimitR){
firstLevelScrollable.scrollLeft=firstLevelScrollLimitR;
tlnBackwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"0");
tlnBackwardBtn.style.cursor="default";
tlnBackwardBtn.className=tlnBackwardBtn.getAttribute(DISABLE_CLASS_ATTR);
cancelMouseDownTimeOut();
tlnForwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"1");
tlnForwardBtn.style.cursor="pointer";
tlnForwardBtn.className=tlnForwardBtn.getAttribute("standardClass");}
else if (tlnBackwardBtn.getAttribute(ENABLED_BUTTON_ATTR)=="0"){
tlnBackwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"1");
tlnBackwardBtn.style.cursor="pointer";
tlnBackwardBtn.className=tlnBackwardBtn.getAttribute("standardClass");}
}
if (direction == "rw" || direction == "both"){
if (firstLevelScrollable.scrollLeft <= firstLevelScrollLimit){
firstLevelScrollable.scrollLeft=firstLevelScrollLimit;
tlnForwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"0");
tlnForwardBtn.style.cursor="default";
tlnForwardBtn.className=tlnForwardBtn.getAttribute(DISABLE_CLASS_ATTR);
cancelMouseDownTimeOut();
tlnBackwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"1");
tlnBackwardBtn.style.cursor="pointer";
tlnBackwardBtn.className=tlnBackwardBtn.getAttribute("standardClass");}
else if (tlnForwardBtn.getAttribute(ENABLED_BUTTON_ATTR)=="0"){
tlnForwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"1");
tlnForwardBtn.style.cursor="pointer";
tlnForwardBtn.className=tlnForwardBtn.getAttribute("standardClass");}
}}
else{
tlnForwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"1");
tlnForwardBtn.style.cursor="pointer";
tlnForwardBtn.className=tlnForwardBtn.getAttribute("standardClass");
tlnBackwardBtn.setAttribute(ENABLED_BUTTON_ATTR,"1");
tlnBackwardBtn.style.cursor="pointer";
tlnBackwardBtn.className=tlnBackwardBtn.getAttribute("standardClass");}
};
var tabHover=function(tabObj){
if( typeof(tabObj) == "string")
tabObj=JSUtils.$(tabObj);
if(!tabObj || tabObj.id == "dragChild")return;
var iconDivObj, iconClassName;
var topTabIndex=parseInt(tabObj.getAttribute(TOP_TAB_INDEX_ATTR));
if(!isFixedTab(topTabIndex)){
if (REMOVABLE_TABS)
JSUtils.$("CloseButtonContainer" + topTabIndex).style.display="block";
if (DRAGABLE_TABS)
JSUtils.$("TabGraspImage" + topTabIndex).style.display="block";}
if (TLN_AFP_IVIEW.selected_tab==tabObj)
return;
iconDivObj=JSUtils.$("tabIcon"+topTabIndex);
if (TLN_NUMBER_OF_FIXED_TABS>0 && tabObj.id == "tabIndex0"){
iconClassName=HouseHoverCSSClass;
tabObj.className=TabHomeCSSClass + " " + TabHoverCSSClass + (TLN_SECOND_LEVEL? (" " + BottomBorderCSSClass): "");}
else{
iconClassName=WorkcenterHoverCSSClass;
tabObj.className=TabWorkCenterCSSClass + " " + TabHoverCSSClass + (TLN_SECOND_LEVEL? (" " + BottomBorderCSSClass): "");}
iconDivObj.className=iconClassName;
};
var selectFirstLevelTab=function(tabObj){

scrollTabToVisibleScope(tabObj);
var downDivObj, iconDivObj;
var topTabIndex=parseInt(tabObj.getAttribute(TOP_TAB_INDEX_ATTR));
if (TLN_AFP_IVIEW.selected_tab){
tabStandard(TLN_AFP_IVIEW.selected_tab);
TLN_AFP_IVIEW.selected_tab.setAttribute(IS_SELECTED_ATTR, "false");
updateTlnAccTooltip(TLN_AFP_IVIEW.selected_tab, 1);}
var tabOldWidth=tabObj.scrollWidth;
tabObj.style.width=null;
if(!isFixedTab(topTabIndex)){
if (REMOVABLE_TABS)
JSUtils.$("CloseButtonContainer"+topTabIndex).style.display="block";
}
downDivObj=JSUtils.$("tabDown"+topTabIndex);
iconDivObj=JSUtils.$("tabIcon"+topTabIndex);
if(isFixedTab(topTabIndex)){
iconDivObj.className=HouseDownCSSClass;
tabObj.className=TabHomeCSSClass + " " + FirstLevelTabDownClass;}
else{
iconDivObj.className=WorkcenterDownCSSClass;
tabObj.className=TabWorkCenterCSSClass + " " + FirstLevelTabDownClass;
if(TLN_SECOND_LEVEL && !isFixedTab(topTabIndex))JSUtils.$("tabSeperator" + topTabIndex).className=FirstLevelSeperatorCSSClass + " " + BottomBorderCSSClass;}
TLN_AFP_IVIEW.selected_tab=tabObj;
TLN_AFP_IVIEW.selected_tab.setAttribute(IS_SELECTED_ATTR, "true");
updateTlnAccTooltip(TLN_AFP_IVIEW.selected_tab, 1);
downDivObj.style.display="block";
if (TLN_NUMBER_OF_FIXED_TABS == 0 && tabObj.id=="tabIndex0" && LSAPI.AFPPlugin.configuration.isRTL()){
var actualWidth=tabObj.childNodes[1].offsetWidth + 4;
tabObj.style.width=actualWidth;
tabObj.setAttribute(SAVED_CLIENT_WIDTH_ATTR, actualWidth);
downDivObj.style.width="auto";}
if (JSUtils.BrowserDetection.is_ie)
downDivObj.style.height=(TLN_NUMBER_OF_FIXED_TABS==0 || tabObj.id!="tabIndex0")? "100%": (tabObj.getAttribute(SAVED_CLIENT_HEIGHT_ATTR)+"px");
else{
if( smallTabsMode)downDivObj.style.height="45px";
else
downDivObj.style.height="100%";}
var tabNewWidth=setFirstLevelTabWidth(tabObj, topTabIndex);
downDivObj.style.width=parseInt(tabNewWidth) -(( !isFixedTab(topTabIndex) )? 1 : 0)+ "px";
if(LSAPI.AFPPlugin.configuration.isRTL() && (!isFixedTab(topTabIndex))){
if(smallTabsMode)updateScrollLimits( tabNewWidth - tabOldWidth - TLN_BIDI_SIZE_FIX );
else
updateScrollLimits( -TLN_BIDI_SIZE_FIX );}
else
updateScrollLimits( tabNewWidth - tabOldWidth );
};
var setFirstLevelTabWidth=function setFirstLevelTabWidth(tabElement, tabIndex){
var tabNewWidth=tabElement.scrollWidth;
if( LSAPI.AFPPlugin.configuration.isRTL() && !isFixedTab(tabIndex)){
tabNewWidth += TLN_BIDI_SIZE_FIX;}
tabElement.style.width=tabNewWidth;
tabElement.setAttribute(SAVED_CLIENT_WIDTH_ATTR, tabNewWidth);
return tabNewWidth;
};
var tabStandard=function(tabObj){
if( typeof(tabObj) == "string")
tabObj=JSUtils.$(tabObj);
if(!tabObj || tabObj.id == "dragChild")return;
var topTabIndex=parseInt(tabObj.getAttribute(TOP_TAB_INDEX_ATTR));
JSUtils.$("tabDown"+topTabIndex).style.display="none";
var tabOldWidth=tabObj.scrollWidth;
if( tabObj.style.display != "none")
tabObj.style.width=null;
if (TLN_NUMBER_OF_FIXED_TABS>0 && tabObj.id=="tabIndex0"){
JSUtils.$("tabIcon0").className=HouseStandardCSSClass;
tabObj.className=TabHomeCSSClass + (TLN_SECOND_LEVEL? (" " + BottomBorderCSSClass): "") + " TabStandard";}
else{
JSUtils.$("tabIcon"+tabObj.getAttribute(TOP_TAB_INDEX_ATTR)).className=WorkcenterStandardCSSClass;
if(!isFixedTab(topTabIndex)){
if (REMOVABLE_TABS)
JSUtils.$("CloseButtonContainer"+topTabIndex).style.display="none";
if (DRAGABLE_TABS)
JSUtils.$("TabGraspImage"+topTabIndex).style.display="none";}
tabObj.className=TabWorkCenterCSSClass + (TLN_SECOND_LEVEL? (" " + BottomBorderCSSClass): "") + " TabStandard";
if (TLN_SECOND_LEVEL)
JSUtils.$("tabSeperator" + topTabIndex).className=FirstLevelSeperatorCSSClass + " " + BottomBorderCSSClass;}

if( tabObj.style.display != "none"){
var tabNewWidth=setFirstLevelTabWidth(tabObj, topTabIndex);
if(LSAPI.AFPPlugin.configuration.isRTL() && smallTabsMode && (!isFixedTab(topTabIndex)))updateScrollLimits( tabNewWidth - tabOldWidth - TLN_BIDI_SIZE_FIX );
else
updateScrollLimits( tabNewWidth - tabOldWidth );}
};
var updateScrollLimits=function updateScrollLimits(deltaWidth){
if( firstLevelScrollLimit && firstLevelScrollLimit != undefined && !isNaN(firstLevelScrollLimit) && (deltaWidth != 0)){
if(!LSAPI.AFPPlugin.configuration.isRTL()){
firstLevelScrollLimit += deltaWidth;
if(smallTabsMode)updateFirstLevelScrollBtnsStateLTR("both");}
else{
firstLevelScrollLimit -= deltaWidth;
if(smallTabsMode)updateFirstLevelScrollBtnsStateRTL("both");}
}
if( firstLevelScrollLimitR && !isNaN(firstLevelScrollLimitR)){
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
firstLevelScrollLimitR=JSUtils.$('allFirstLevelTabs').clientWidth - parseInt(firstLevelScrollable.style.width);}
};
var overflowHover=function(elm){
if (JSUtils.$("OverflowAreaOpen").style.display == "none")
return;
elm.className="Menu " + OverflowTabCSSClass + " " + TabHoverCSSClass + (TLN_SECOND_LEVEL?(" " + BottomBorderCSSClass):"");
};
var overflowStandard=function(elm){
if (JSUtils.$("OverflowAreaOpen").style.display == "none")
return;
elm.className="Menu " + OverflowTabCSSClass + " TabStandard"+(TLN_SECOND_LEVEL?(" " + BottomBorderCSSClass):"");
};
var showFirstLevelTabCloseButton=function(tabObj){
JSUtils.$("CloseButtonContainer"+tabObj.getAttribute(TOP_TAB_INDEX_ATTR)).style.display="block";
};
var hideFirstLevelTabCloseButton=function (tabObj){
JSUtils.$("CloseButtonContainer"+tabObj.getAttribute(TOP_TAB_INDEX_ATTR)).style.display="none";
};
var showFirstLevelTabGrasp=function(tabObj){
JSUtils.$("TabGraspImage"+tabObj.getAttribute(TOP_TAB_INDEX_ATTR)).style.display="block";
};
var hideFirstLevelTabGrasp=function(tabObj){
JSUtils.$("TabGraspImage"+tabObj.getAttribute(TOP_TAB_INDEX_ATTR)).style.display="none";
};
var removeFirstLevelTab=function(tabObj){
if (tabObj == selected_tab){
if (tabObj.nextSibling)
selectFirstLevelTab(tabObj.nextSibling);
else
if (tabObj.previousSibling)
selectFirstLevelTab(tabObj.previousSibling);}
tabObj.parentNode.removeChild(tabObj);
var targetIdentifierDiv=tabObj.lastChild;
while(targetIdentifierDiv.tagName!="DIV")
targetIdentifierDiv=targetIdentifierDiv.previousSibling;
var targetId=targetIdentifierDiv.id;
undockTlnNode(targetId)
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
var allFirstLevelTabs=JSUtils.$("allFirstLevelTabs");
firstLevelScrollLimit=parseInt(allFirstLevelTabs.lastChild.offsetLeft) +
parseInt(allFirstLevelTabs.lastChild.clientWidth) -
parseInt(firstLevelScrollable.clientWidth) - 1;
};
var scrollAreaHover=function scrollAreaHover(event){
if (event.toElement.getAttribute(HOVER_CLASS_ATTR) && event.toElement.getAttribute(HOVER_CLASS_ATTR) !== ""){
if (currentlySelectedScrollBtn && currentlySelectedScrollBtn !== event.toElement){
scrollBtnOut(currentlySelectedScrollBtn);}
currentlySelectedScrollBtn=event.toElement;
scrollBtnHover(event.toElement);}
};
var scrollAreaOut=function scrollAreaOut(event){
if (event.toElement && event.toElement.id == "endStretchedArea"){
return;}
if (currentlySelectedScrollBtn){
scrollBtnOut(currentlySelectedScrollBtn);
currentlySelectedScrollBtn=null;}
};
var scrollAreaDown=function scrollAreaDown(event){
scrollBtnDown( getElementFromEvent(event) );
};
var scrollAreaUp=function scrollAreaUp(event){
scrollBtnUp( getElementFromEvent(event) );
};
var scrollBtnHover=function(el){
if (el.getAttribute(ENABLED_BUTTON_ATTR) == "1"){
el.className=el.getAttribute(HOVER_CLASS_ATTR);}
};
var scrollBtnOut=function(el){
cancelMouseDownTimeOut();
if (el.getAttribute(ENABLED_BUTTON_ATTR) == "1"){
el.className=el.getAttribute(STANDARD_CLASS_ATTR);}
};
var scrollBtnDown=function(el){
if (el.getAttribute(ENABLED_BUTTON_ATTR) == "1"){
var scrlParam;
if (LSAPI.AFPPlugin.configuration.isRTL()){
scrlParam=(el.id == "tlnForwardBtn")?"rw":"ff";}
else{
scrlParam=(el.id == "tlnForwardBtn")?"ff":"rw";}
var oppositeElement=(el.id == "tlnForwardBtn")?JSUtils.$("tlnBackwardBtn"):JSUtils.$("tlnForwardBtn");
setMouseDownTimeOut(scrlParam);
el.className=el.getAttribute(DOWN_BUTTON_ATTR);
first_level_scroll(scrlParam);
oppositeElement.setAttribute(ENABLED_BUTTON_ATTR,"1");
oppositeElement.style.cursor="pointer";
oppositeElement.className=oppositeElement.getAttribute(STANDARD_CLASS_ATTR);}
};
var scrollBtnUp=function(el){
cancelMouseDownTimeOut();
if (el.getAttribute(ENABLED_BUTTON_ATTR) == "1"){
el.className=el.getAttribute(HOVER_CLASS_ATTR);}
};
var setMouseDownTimeOut=function(btnElm){
if (timeInterval)
return;
timeInterval=setInterval("TLN_AFP_IVIEW.first_level_scroll('"+btnElm+"')", FIRST_LEVEL_SCROLL_SPEED);
};
var cancelMouseDownTimeOut=function(){
clearInterval(timeInterval);
timeInterval=null;
};
var scrollTabToVisibleScope=function(tabObj){
if (!LSAPI.AFPPlugin.configuration.isRTL()){
scrollTabToVisibleScopeLTR(tabObj);}
else{
scrollTabToVisibleScopeRTL(tabObj);}
};
var scrollTabToVisibleScopeLTR=function(tabObj){
var scrolling_div, nodeElAbsolutePosition, tab_end_position, tab_start_position
var topTabIndex=tabObj.getAttribute(TOP_TAB_INDEX_ATTR);
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
if(!isFixedTab( parseInt(topTabIndex))&& firstLevelScrollable.getAttribute(IS_OVERFLOW_ATTR) == "true"){
if (!firstLevelPosition)
firstLevelPosition=JSUtils.findAbsolutePosition(firstLevelScrollable);
nodeElAbsolutePosition=JSUtils.findAbsolutePosition(tabObj);
tab_end_position=nodeElAbsolutePosition.x - firstLevelPosition.x + parseInt(tabObj.getAttribute(SAVED_CLIENT_WIDTH_ATTR));
tab_start_position=nodeElAbsolutePosition.x;
if (tab_end_position > parseInt(firstLevelScrollable.style.width,0)){
firstLevelScrollable.scrollLeft=firstLevelScrollable.scrollLeft + (tab_end_position - parseInt(firstLevelScrollable.style.width,0));
updateFirstLevelScrollBtnsState("both");}
else if (tab_start_position < firstLevelPosition.x){
firstLevelScrollable.scrollLeft=firstLevelScrollable.scrollLeft - (firstLevelPosition.x - tab_start_position);
updateFirstLevelScrollBtnsState("both");}
}
else{
firstLevelScrollable.scrollLeft=0;}
};
var scrollTabToVisibleScopeRTL=function(tabObj){
var scrolling_div, nodeElAbsolutePosition, tab_end_position, tab_start_position
var topTabIndex=tabObj.getAttribute(TOP_TAB_INDEX_ATTR);
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
if(!isFixedTab( parseInt(topTabIndex))&& firstLevelScrollable.getAttribute(IS_OVERFLOW_ATTR) == "true"){
if (!firstLevelPosition)
firstLevelPosition=JSUtils.findAbsolutePosition(firstLevelScrollable);
nodeElAbsolutePosition=JSUtils.findAbsolutePosition(tabObj);
tab_end_position=nodeElAbsolutePosition.x + parseInt(tabObj.getAttribute(SAVED_CLIENT_WIDTH_ATTR),0);
tab_start_position=nodeElAbsolutePosition.x;
if (tab_end_position > parseInt(firstLevelScrollable.style.width)){
firstLevelScrollable.scrollLeft += (tab_end_position - parseInt(firstLevelScrollable.style.width,0));
updateFirstLevelScrollBtnsState("both");}
else{
var overflowWidth=JSUtils.findAbsolutePosition(JSUtils.$("OverflowAreaOpen")).r;
if (tab_start_position < overflowWidth){
firstLevelScrollable.scrollLeft -= (overflowWidth - tab_start_position);
updateFirstLevelScrollBtnsState("both");}
}}

else if( firstLevelScrollLimitR && typeof(firstLevelScrollLimitR) != 'undefined'){
firstLevelScrollable.scrollLeft=firstLevelScrollLimitR;}
};
var draw1stLevelOverflowMenu=function(clickedObj){
if (!LSAPI.AFPPlugin.configuration.isRTL()){
draw1stLevelOverflowMenuLTR(clickedObj);}
else{
draw1stLevelOverflowMenuRTL(clickedObj);}
};
var draw1stLevelOverflowMenuLTR=function(clickedObj){
var nodeElAbsolutePosition;
var idPrefix="topTabMenuItem";
var items=[];
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
if (!firstLevelPosition) firstLevelPosition=JSUtils.findAbsolutePosition(firstLevelScrollable);
var firstTabToOverflow=null;
nodeElAbsolutePosition=JSUtils.findAbsolutePosition(JSUtils.$(firstLevelTabIdsArr[TLN_NUMBER_OF_FIXED_TABS]).parentNode);
for (var i=0; i < firstLevelTabIdsArr.length; i++){
var nodeEl=JSUtils.$(firstLevelTabIdsArr[i]).parentNode;
var tab_end_position=nodeElAbsolutePosition.x - firstLevelPosition.x + parseInt(nodeEl.getAttribute(SAVED_CLIENT_WIDTH_ATTR));
var tab_start_position=nodeElAbsolutePosition.x;
var isOverflowing=( !isFixedTab(i))&&
((tab_end_position-5 > parseInt(firstLevelScrollable.style.width,0)) ||
(tab_start_position < (firstLevelPosition.x-5)));
if (firstTabToOverflow == null && tab_end_position > parseInt(firstLevelScrollable.style.width,0)){
firstTabToOverflow=i;}

var item={
title: nodeEl.getAttribute(DISPLAY_NAME_ATTR),
isSelected: nodeEl.getAttribute(IS_SELECTED_ATTR),
origNodeEl: nodeEl,
isFirstVisibleRow: (firstTabToOverflow == i),
isOverflowing: isOverflowing,
tooltip: JSUtils.ESCAPE_TO_HTML(nodeEl.getAttribute("title")),
action: function(e){
this.origNodeEl.onclick(e);}
};
/*mouseDown: function(e){
var graspImgId="TabGraspImage"+((this.origNodeEl.id).split(TAB_INDEX_ATTR)[1]);
JSUtils.$(graspImgId).onmousedown(e);
}*/
items.push(item);
if(!isFixedTab(i)){
nodeElAbsolutePosition.x += parseInt(nodeEl.getAttribute(SAVED_CLIENT_WIDTH_ATTR));}
}
SingleNovaPopupMenu.draw(clickedObj, idPrefix, items);
var firstElm=JSUtils.$(idPrefix+"0");
if(firstElm) firstElm.focus();
};
var draw1stLevelOverflowMenuRTL=function(clickedObj){

var idPrefix="topTabMenuItem";
var items=[];
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
if (!firstLevelPosition) firstLevelPosition=JSUtils.findAbsolutePosition(firstLevelScrollable);
var firstTabToOverflow=null;
var nodeElAbsolutePosition=JSUtils.findAbsolutePosition(JSUtils.$(firstLevelTabIdsArr[TLN_NUMBER_OF_FIXED_TABS]).parentNode);
var overflowWidth=JSUtils.findAbsolutePosition(JSUtils.$("OverflowAreaOpen")).r;
for (var i=0; i < firstLevelTabIdsArr.length; i++){
var nodeEl=JSUtils.$(firstLevelTabIdsArr[i]).parentNode;
var tab_start_position=nodeElAbsolutePosition.x;
var tab_end_position=nodeElAbsolutePosition.x + parseInt(nodeEl.getAttribute(SAVED_CLIENT_WIDTH_ATTR));
var isOverflowing=( !isFixedTab(i))&&
((tab_start_position < overflowWidth) ||
(tab_end_position-65) > parseInt(firstLevelScrollable.style.width,0));
if (firstTabToOverflow == null && tab_start_position > parseInt(firstLevelScrollable.style.width,0)){
firstTabToOverflow=i;}

var item={
title: nodeEl.getAttribute(DISPLAY_NAME_ATTR),
isSelected: nodeEl.getAttribute(IS_SELECTED_ATTR),
origNodeEl: nodeEl,
isFirstVisibleRow: (firstTabToOverflow == i),
isOverflowing: isOverflowing,
tooltip: JSUtils.ESCAPE_TO_HTML(nodeEl.getAttribute("title")),
action: function(e){
this.origNodeEl.onclick(e);}
};
items.push(item);
if(!isFixedTab(i)){
nodeElAbsolutePosition.x -= parseInt(nodeEl.getAttribute(SAVED_CLIENT_WIDTH_ATTR));}
}
SingleNovaPopupMenu.draw(clickedObj, idPrefix, items);
var firstElm=JSUtils.$(idPrefix+"0");
if(firstElm) firstElm.focus();
};
var isTabOverflowedLTR=function isTabOverflowedLTR( nodeEl){
var firstLevelScrollable=JSUtils.$("firstLevelScrollable");
if (!firstLevelPosition) firstLevelPosition=JSUtils.findAbsolutePosition(firstLevelScrollable);
var nodeElAbsolutePosition=JSUtils.findAbsolutePosition(JSUtils.$(firstLevelTabIdsArr[TLN_NUMBER_OF_FIXED_TABS]).parentNode);
var tab_end_position=nodeElAbsolutePosition.x - firstLevelPosition.x + parseInt( nodeEl.getAttribute(SAVED_CLIENT_WIDTH_ATTR) );
var tab_start_position=nodeElAbsolutePosition.x;
var tabIndex=parseInt( nodeEl.getAttribute(TOP_TAB_INDEX_ATTR) );
var isOverflowing=( !isFixedTab(tabIndex))&&((tab_end_position-5 > parseInt(firstLevelScrollable.style.width,0))||(tab_start_position < (firstLevelPosition.x-5)));
return isOverflowing;
};
/********************************************************************/
/********************************************************************/
var subTabHover=function(tabObj){
if (TLN_AFP_IVIEW.selected_subTab==tabObj)
return;
tabObj.className="Tab SubTabHover";
};
var subTabStandard=function(tabObj){
if (!tabObj) return;
tabObj.className="Tab SubTabStandard";
};
var selectSecondLevelTab=function(tabObj){
if (TLN_AFP_IVIEW.selected_subTab){
TLN_AFP_IVIEW.selected_subTab.setAttribute(IS_SELECTED_ATTR, "false");
subTabStandard(TLN_AFP_IVIEW.selected_subTab);
updateTlnAccTooltip(TLN_AFP_IVIEW.selected_subTab, 2);}
tabObj.className="Tab SubTabDown";
TLN_AFP_IVIEW.selected_subTab=tabObj;
TLN_AFP_IVIEW.selected_subTab.setAttribute(IS_SELECTED_ATTR, "true");
updateTlnAccTooltip(TLN_AFP_IVIEW.selected_subTab, 2);
};
var draw2ndLevelOverflowMenu=function(clickedObj){
var idPrefix="subTabMenuItem";
var items=[];
for (var i=secondLevelStartOverflowTabIndex; i < secondLevelNodesArr.length; i++){
var node=secondLevelNodesArr[i];
var title=JSUtils.ESCAPE_TO_HTML(node.getTitle());
var tooltip=title;
if(AccessibilityManager.isAccessibilityModeOn()){
var levelParam=new Array();
levelParam[0]=2;
var tooltip=title + " - " + ResourceBundleStrings.unselectedEntry + " - " + JSUtils.messageFormat(ResourceBundleStrings.entryLevel, levelParam);}

var item={
title: title,
origNode: node,
nodeName: node.getName(),
tooltip: tooltip,
action: function(e){

LSAPI.AFPPlugin.service.navigate(this.origNode,this.origNode.getShowType(),'ExecuteLocally=true&DrillDownLevel='+(DRILL_DOWN_LEVEL-1));
selectSecondLevelTab(JSUtils.$(this.nodeName).parentNode);}
};
items.push(item);}
SingleNovaPopupMenu.draw(clickedObj, idPrefix, items);
var firstElm=JSUtils.$(idPrefix+"0");
if(firstElm) firstElm.focus();
};
/*******************************************************************/
/*******************************************************************/
/*******************************************************************/
var rearrangeTlnNodes=function(curTarget, dropBeforeNode){
if (!dropBeforeNode) return;
var targetId, beforeId;
var targetIdentifierDiv=curTarget.lastChild;
while(targetIdentifierDiv.tagName!="DIV")
targetIdentifierDiv=targetIdentifierDiv.previousSibling;
targetId=targetIdentifierDiv.id;
firstLevelTabIdsArr.splice(JSUtils.findItemInArray(firstLevelTabIdsArr, targetId), 1);
if (dropBeforeNode!="end" && dropBeforeNode.id!="firstLevelStrechedTab"){
var beforeIdentifierDiv=dropBeforeNode.lastChild;
while(beforeIdentifierDiv.tagName!="DIV")
beforeIdentifierDiv=beforeIdentifierDiv.previousSibling;
beforeId=beforeIdentifierDiv.id;
firstLevelTabIdsArr.splice(JSUtils.findItemInArray(firstLevelTabIdsArr, beforeId), 0, targetId);}
else{
firstLevelTabIdsArr.push(targetId);}
isPersonalized=true;
personalizationChange();
};
var beforeTabsetSwitched=function beforeTabsetSwitched(){

TLN_AFP_IVIEW.selected_tab=null;
rebuildTLN=true;
savePersonalization();
};
var savePersonalization=function savePersonalization(){

if (!isPersonalized){
return;}
isPersonalized=false;
if ((firstLevelTabIdsArr.length < 1) && (unDockedTabIdsArr.length < 1)){
return;}

var currentTabset=null;
if (LSAPI.getTabsetPlugin().isEnabled()){
currentTabset=LSAPI.getTabsetPlugin().getCurrentTabset();}
LSAPI.AFPPlugin.service.setInitialNodes(currentTabset, firstLevelTabIdsArr, unDockedTabIdsArr, updateDiscriminator);
};
var createTLNCollections=function createTLNCollections(){

if(LSAPI.AFPPlugin.configuration.getClientSideAttributeValue("TopLevel",PROP_DRAGABLEETABS) == "true"){

var persMenuCollection=top.LSAPI.Collections._private.collectionsModel._private.getCollection(AFP_PERS_MENU_ID);
if (!JSUtils.isEmpty(persMenuCollection)){

var title=top.LSAPI.AFPPlugin.configuration.getClientSideAttributeValue("TopLevel", MI_CLEAR_PERSONALIZE);
persMenuCollection.createItem("ClearPersonalizationItem", title, title, "javascript:if (parent.EPCM) {parent.EPCM.raiseEvent(\'urn:com.sapportals:navigation\',\'ClearPersonalization\',\'\');}", null);
top.LSAPI.Collections._private.collectionsModel._private.addFixedCollections([persMenuCollection],true);}
}
};
var clearPersonalization=function clearPersonalization(){
isPersonalized=false;
var paramsMap=new ParamMap();
paramsMap.put("action","setInitialNodes");
paramsMap.put("clearData", "true");
var servletParamsMap=new ParamMap();
LSAPI.AFPPlugin.urlhandler.addHierarchyParams(servletParamsMap);
var queryMap=JSUtils.getQueryAndParams(servletParamsMap);
if(typeof(queryMap) !== "undefined"){

queryMap.remove("CurrentWindowId");
paramsMap=paramsMap.merge(queryMap);}
var callback={
success: onClearPersonalizationCB
};
var cachingCretiriaArray=[];
cachingCretiriaArray[0]=CachingCretiria.INITIAL_NODES_PERSONALIZATION;
AFPConnection.requestIfUpdated(mm_servletLocation, paramsMap, callback, cachingCretiriaArray,RequestMethod.POST);
};
var updateDiscriminator=function(o){
var systemTime=(new Date()).getTime();
AFPConnection.setCacheTimestampValue(CachingCretiria.INITIAL_NODES_PERSONALIZATION, systemTime);
};
var onClearPersonalizationCB=function(){
JSUtils.refreshPortalToFirstNode();
};
var undockTlnNode=function(targetId){
firstLevelTabIdsArr.splice(JSUtils.findItemInArray(firstLevelTabIdsArr, targetId), 1);
unDockedTabIdsArr.push(targetId);
personalizationChange();
};
var screenModeChange=function(){
var visualPlugin=top.LSAPI.getVisualPlugin();
if (visualPlugin != null){
var screenMode=visualPlugin.getScreenMode();
if (screenMode == visualPlugin.SCREENMODE_NORMAL){
forceSetTLNSize=true;
TLN_AFP_IVIEW.setTlnSize();
updateSelectedNodes(LSAPI.AFPPlugin.model.getCurrentLaunchNode());}
else if (screenMode == visualPlugin.SCREENMODE_FULL){}
}
};
var initCssPrefixes=function initCssPrefixes(){
TabWorkCenterCSSClass="TabWorkCenter" + displayModePrefix;
TabHomeCSSClass="TabHome" + displayModePrefix;
DarkSeparator01CSSClass="DarkSeparator01" + displayModePrefix;
FirstLevelSeperatorCSSClass="Separator" + displayModePrefix;
WorkcenterStandardCSSClass="WorkcenterStandard" + displayModePrefix;
WorkcenterDownCSSClass="WorkcenterDown" + displayModePrefix;
WorkcenterHoverCSSClass="WorkcenterHover" + displayModePrefix;
HouseStandardCSSClass="HouseStandard" + displayModePrefix;
HouseDownCSSClass="HouseDown" + displayModePrefix;
HouseHoverCSSClass="HouseHover" + displayModePrefix;
TabHoverCSSClass="TabHover" + displayModePrefix;
TabDown00CSSClass="TabDown00" + displayModePrefix;
TabDown10CSSClass="TabDown10" + displayModePrefix;
TabDown20CSSClass="TabDown20" + displayModePrefix;
TabDownForSub00CSSClass="TabDownForSub00" + displayModePrefix;
TabDownForSub10CSSClass="TabDownForSub10" + displayModePrefix;
TabDownForSub20CSSClass="TabDownForSub20" + displayModePrefix;
TabDownForSub01CSSClass="TabDownForSub01" + displayModePrefix;
TabDownForSub11CSSClass="TabDownForSub11" + displayModePrefix;
TabDownForSub21CSSClass="TabDownForSub21" + displayModePrefix;
OverflowTabCSSClass="OverflowTab" + displayModePrefix;
DragMarker1CSSClass="DragMarker1" + displayModePrefix;
FirstLevelTabTextCSSClass="TabText" + displayModePrefix;
FirstLevelTabDownClass="TabDown" + displayModePrefix;
};
return{
"setInitialParams": setInitialParams,
"initTLN": initTLN,
"updateTLN": updateTLN,
"screenModeChange": screenModeChange,
"pixelImage": pixelImage,
"darkSeperatorHTML": darkSeperatorHTML,
"selected_tab": selected_tab,
"selected_subTab": selected_subTab,
"tabStandard": tabStandard,
"subTabStandard": subTabStandard,
"tabHover": tabHover,
"subTabHover": subTabHover,
"savePersonalization": savePersonalization,
"clearPersonalization": clearPersonalization,
"rearrangeTlnNodes": rearrangeTlnNodes,
"removeFirstLevelTab": removeFirstLevelTab,
"firstLevelTabIdsArr": firstLevelTabIdsArr,
"unDockedTabIdsArr": unDockedTabIdsArr,
"scrollAreaHover": scrollAreaHover,
"scrollAreaOut": scrollAreaOut,
"scrollAreaDown": scrollAreaDown,
"scrollAreaUp": scrollAreaUp,
"scrollBtnOut": scrollBtnOut,
"scrollBtnDown": scrollBtnDown,
"scrollBtnUp": scrollBtnUp,
"scrollBtnHover": scrollBtnHover,
"overflowHover": overflowHover,
"overflowStandard": overflowStandard,
"hideFirstLevelTabCloseButton": hideFirstLevelTabCloseButton,
"hideFirstLevelTabGrasp": hideFirstLevelTabGrasp,
"draw1stLevelOverflowMenu": draw1stLevelOverflowMenu,
"draw2ndLevelOverflowMenu": draw2ndLevelOverflowMenu,
"first_level_scroll": first_level_scroll,
"lastBodyWidth": lastBodyWidth,
"getFirstLevelPosition": getFirstLevelPosition,
"getFirstLevelScrollableElm": getFirstLevelScrollableElm,
"setFullScreenAttributes": setFullScreenAttributes,
"setTlnSize": setTlnSize,
"applyTabsetFilter": applyTabsetFilter,
"updateFirstLevelScrollBtnsState": updateFirstLevelScrollBtnsState,
"fixTLNWidth": fixTLNWidth,
"updateNavLevels": updateNavLevels,
"initCssPrefixes": initCssPrefixes,
"beforeTabsetSwitched": beforeTabsetSwitched
};
}();
EPCM.subscribeEventReliable( "urn:com.sapportals.portal:browser", "load", TLN_AFP_IVIEW.initTLN );
