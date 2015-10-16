<%@ taglib uri="NavigationTagLibrary" prefix="nav" %>
<%@ taglib uri="FrameworkTagLibrary" prefix="frm" %>

<%-- Código extraído de  http://scn.sap.com/docs/DOC-56038 --%>

<%-- an include clause for css file  
<%@ include file="header_style_CSS3.jsp" %>   --%>

<%-- Estos estilos solo son compatibles para la version de IE  
<%@ include file="header_style.jsp" %> --%>

<%-- Engendro que trata de compatibilizar IE con el resto del universo 
<%@ include file="Hover_Menu_Style.jsp" %> --%>

<%-- Estilos CSS Vossloh AG --%>
<%@ include file="Vossloh_AG_CSS.jsp" %>

<script type="text/javascript">
var clicked = false;
var currEl = 0; //current Element

function TLNHover(navigationDiv) { //se le asigna un nombre a la función!
	//if (!document.all) return; // continue only for IE  . Esta propiedad es OBSOLETA. 
	//var nav = navigator.appName; //Obtengo el nombre del navegador
	// 
	//document.write(nav + "<br>"); //DEBUG
/*	if (nav != "Microsoft Internet Explorer") //Sólo continúo si el navegador es IE
	{
		alert(nav); //muestra en una ventana emergente
	//	return; //Si el navegador no es IE, termino.
	}*/
	//	else
	//{
	//intento 2-> cambiar el id de la div "navigation"  a "nav_ie" --> OK!!
	document.getElementById("navigation").id ='navie';
	navigationDiv= "navie";
	
		var liEls = document.getElementById(navigationDiv).getElementsByTagName("li"); //recoge en un array todos los elementos de lista de la div con id 7navigation<li>
		var id21;
		var countLevels1 = 0;  //Nº de elementos en level 1
		var brandingWidth = 0; //Longitud de la banda del menú
		for (var i=0; i<liEls.length; i++) { //Recorro todos los elementos de la lista desordenada <li>
			 liEls[i].setAttribute("idValue", i); 
			 //if (liEls[i].getAttribute("class") == "Level1") document.write("<br>"); //DEBUG
			// document.write("<br>" + liEls[i].innerHTML +  "idValue: " + liEls[i].getAttribute("idValue") + " | "); //DEBUG
			 
			// liEls[i].idValue = i;
			// según este planteamiento, los nodos de nivel uno tendrán atributo idValue e id2Value, que valdrán igual.
			// los nodos del nivel 2 solo tendrán atributo idValue
			 if(liEls[i].className == "current" || liEls[i].className == "Level1"){  //Si está en level 1 o en nivel actual (cambiar || por && cambia el diseño del menú a vertical)
				id21 = i; //id21 debe valer el valor del padre. Solo debe tener valor <> de idValue para nodos de nivel <> 1
				liEls[i].setAttribute("id2Value", id21); 
				//document.write("id2Value: " + liEls[i].getAttribute("idValue") + " <br>"); //DEBUG

				//liEls[i].id2Value = id21;  //determina si el elemento de nivel 1 tiene o no hijos. Si no tiene hijos id2Value = idValue
				var contentAEl = document.getElementById(navigationDiv).getElementsByTagName("a")[i].innerHTML; // Contenido de los enlaces <a>
			   // To set the width of the TLN we need to get the continue only for IE
			   brandingWidth = brandingWidth + (contentAEl.length)*7 ;  //brandingWidth parece medir la longitud del menú. ¿por qué multiplica por 7?
			   countLevels1++;
			}
				
	     /*
	     In the above figure it has four roles indicated as "Level1" and "current" class.  The class name assigned is "Level1" .
	     When the user clicks on the role for eg. "User Administration" the class name of that parent node / parent role is set to "current" and 
	     the current element€™s parent node / parent role class name is set to "currenthref".  The font color of parent node / parent role is set 
	     to the shade of red ("#C51733").
	     
	     If the roles do not have child elements, the idvalue will be same as of id2Value.

		 But for User Administration role  there are four child elements and so their idValues will be different from id2Value. The class  name 
	 	 assigned is "Level2" for these child elements. These id2Values are same as of their parent node as shown in below figure.  This will help 
	 	 to distinguish the node of the parent from the child elements to set the color and background color when the child element is selected.
	     */
	
	     // as shown in the above figure I have mainly added the above code to find out  the level one with level two node.
	     //Esto no hace nada
	     if(liEls[i].className == "Level2"){
	          liEls[i].setAttribute("id2Value", id21);
	          //añadir el atributo id="l1"
	          liEls[i].setAttribute("id", "l1");
	        //  document.write("id2Value: " + liEls[i].getAttribute("id2Value"));  //DEBUG
	          //liEls[i].id2Value = id21;
	     }
	
		
	     liEls[i].onmouseover = function() {
	          this.className += " hover"; //añade 'hover' a la class
	          var aEl = document.getElementById(navigationDiv).getElementsByTagName("a"); //todos los tag a de navigation
	         // aEl[this.id2Value].style.color="#C51733"; //cambia el color del enlace actual //DESCOMENTAR Y ACTUALIZAR VALOR
	          aEl[this.id2Value].style.backgroundColor="#5F6975"; //cambia el fondo del enlace actual
	          };
	
	     liEls[i].onmouseout = function() {
	          this.className = this.className.replace(new RegExp(" hover\\b"), ""); //elimina ' hover' de la class
	          var lEl = document.getElementById(navigationDiv).getElementsByTagName("li");
	          var aEl = document.getElementById(navigationDiv).getElementsByTagName("a");
	          var id2ValueAtt = this.getAttribute("id2Value");
	         
	          if(clicked)
	          { 
	            //  The if condition is used for used for work protect mode
	               //if(currEl != this.id2Value) //¿¿¿??id2Value no definido. Comprobar como se obtiene el valor del atributo
	               if(currEl != id2ValueAtt) 
	               {
	                   /*  Fallo por el ]
	                    this.id2Value].className = "Level1";
	                    this.id2Value].className = "";
	                    this.id2Value].style.color="#FFFFFF";
	                    */
	                    liEls[this.id2Value].className = "Level1";
	                    aEl[this.id2Value].className = "";
	                   // aEl[this.id2Value].style.color="#FFFFFF"; //DESCOMENTAR Y ACTUALIZAR VALOR
	                    aEl[this.id2Value].style.backgroundColor="#4B545F"; 
	                    
	                    lEl[currEl].className = "current"; //cambia la class del elemento li
	                    aEl[currEl].className = "currenthref"; //cambia la class del enlace a
	                    //aEl[currEl].style.color = "#C51733"; //DESCOMENTAR Y ACTUALIZAR VALOR
	               }
	          }
	          
	          else
	          {
	               //this.id2Value].style.color="#FFFFFF"; 
	               //this.id2Value.style.color="#FFFFFF"; //id2Value no  definido
	              // aEl[this.id2Value].style.color="#FFFFFF"; //DESCOMENTAR Y ACTUALIZAR VALOR
	               aEl[this.id2Value].style.backgroundColor="#4B545F";
	               
	               if(lEl[this.id2Value].className == "current") {
	                   // this.id2Value].style.color="#C51733"; Fallo por el ]
	                   // aEl[this.id2Value].style.color="#C51733"; //DESCOMENTAR Y ACTUALIZAR VALOR
	               }
	          }
	          
	     clicked = false;
	     };
	
	     liEls[i].onclick = function() {
	         //
	         //  one can uncomment the below code and can try also.  This was mainly used for work protect mode
	            /*   
	            var lEl = document.getElementById(navigationDiv).getElementsByTagName("LI");
	            var aEl = document.getElementById(navigationDiv).getElementsByTagName("A");
	            for(var j=0; j<lEl.length; j++)
	            {
	             if(lEl[j].className == "current") {
	             	lEl[j].className = "Level1"; aEl[j].className = "";
	              	aEl[j].style.color="#FFFFFF";
	               	break;
	             }
	       }
	       lEl[this.id2Value].className = "current";//05/06/2014
	       aEl[this.id2Value].className = "currenthref"; //05/06/2014
	       aEl[this.id2Value].style.color="#C51733";
	       //document.getElementById("level2").style.visibility="hidden";
	       clicked = true;
	       */
		 };
		 
		}//Añadido para cerrar el for

	
	/* The below code help to set the branding width of the TLN. The top level width is set depending upon the number of roles.  
	   The style set for the top level navigation are font family is Verdana with size of 12.  Each the role text length is taken and multipled by
	   7(on an average)  and then added to the brandingwidth.  The gap between the roles also need to be conisdered.  The gap between the roles is 
	   taken as 22 pixels and this gap is multipled by the number of roles and then added to the branding width. 
	*/

	//Estas dos líneas controlan el tamaño de la banda del menú. Si se comentan el tamaño del menú quedará 
	//adaptado al tamaño de la ventana del navegador automáticamente.
	//brandingWidth = brandingWidth + countLevels1*22;
	//document.getElementById(navigationDiv).style.width = brandingWidth;
}
</script>

<%-- this is the main navigation section --%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td  nowrap="nowrap">
			<div id="branding">
				<div id="navigation">
				<%-- start the unordered list --%>
					<ul>
						<%-- go through all the level 1 navigation nodes --%>
						<nav:iterateInitialNavNodes>
						     <li class="Level1" style="font-size: 12px;" ><nav:navNodeAnchor navigationMethod="byEPCM" />
							     <%-- check to see if there are level 2 nodes, if so start another <ul> and assign a CSS class --%>
							     <nav:ifNavNodeHasChildren>
							          <ul>
							          <%-- again go through all the nodes in level 2 --%>
							               <nav:iterateNavNodeChildren>
							               <%-- id l1 is written for second level hover and to set its css properties --%>
							                    <li  class="Level2"><nav:navNodeAnchor navigationMethod="byEPCM" /></li>
							        	   </nav:iterateNavNodeChildren>
		        					 </ul>
		    				 	</nav:ifNavNodeHasChildren>
		     				</li>
						</nav:iterateInitialNavNodes>
					</ul>
				</div>
			</div>
		</td>
	</tr>
</table>


 <script type="text/javascript">

 /********************************************************************
  * COMPROBACIÓN DEL NAVEGADOR Y EJECUCIÓN DEL JS SOLO PARA IE
  ***************************************************************** */

 var nav = navigator.appName; //Obtengo el nombre del navegador
 //
// document.write(nav + "<br>"); //DEBUG
 if (nav == "Microsoft Internet Explorer") //Sólo continúo si el navegador es IE
 {
 	//alert(nav); //muestra en una ventana emergente
 	TLNHover("navigation"); //aplica el javascript SOLO para IE
// 	return; //Si el navegador no es IE, termino.
 }


 //La función añade a los tag li los atributos idValue e id2Value,además de las funciones onMouseOver y onMouseOut
 var nodeNameFromNaviagation;
//Activar/Desactivar la función para añadir/quitar las clases de css en las etiquetas de las listas
//TLNHover("navigation");

 /*
 Whenever the navigation changes, the raiseEvent is fired with the current selected/clicked Node name. We can get the path of the current 
 selected/clicked Node by using the LSAPI's. The first element in the pathArray will be have the node name of the "Level one/Parent Node" of 
 the "Top Level Navigation". This event is subscribed using the function as mentioned below in the header.jsp in top level navigation war file
 */

// EPCM.subscribeEvent("urn:com.node.test", "currentNode", onCurrentNode ); //No se encuentra esta función en el portal SAP
 function onCurrentNode( eventObj ) {
   var aEls = document.getElementById("navie").getElementsByTagName("a");
   var lEls = document.getElementById("navie").getElementsByTagName("li");
   nodeNameFromNaviagation = eventObj.sourceId;
    //aEls[currEl].style.color="#FFFFFF"; //DESCOMENTAR Y ACTUALIZAR VALOR
   for(var n1=0;n1<aEls.length;n1++)
   {
        if(lEls[n1].className == "current") {
             lEls[n1].className = "Level1"; aEls[n1].className = "";
             //aEls[n1].style.color="#FFFFFF";
             }
   }
   
   for(var n=0;n<aEls.length;n++)
   {
        if(aEls[n].innerHTML == eventObj.sourceId){
             aEls[n].className = "currenthref";
             lEls[n].className = "current";
             //aEls[n].style.color = "#C51733"; //DESCOMENTAR Y ACTUALIZAR VALOR
             currEl = n;
             clicked =true;
             break;
           }
     }  
 }
 </script>