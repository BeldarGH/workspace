<style>

/* oculta los submenus en la carga del html */
#navigation ul ul{
	display: none;
}
/* muestra los subnavs lu hijos al posicionar el puntero del ratón sobre el nodo li padre */
	#navigation ul li:hover > ul {
			display: block;
		}
/* cambia el estilo de los nodos ul principales */
#navigation ul{
	background: #efefef; 
	background: linear-gradient(top, #efefef 0%, #bbbbbb 100%);  
	background: -moz-linear-gradient(top, #efefef 0%, #bbbbbb 100%); 
	background: -webkit-linear-gradient(top, #efefef 0%,#bbbbbb 100%); 
	box-shadow: 0px 0px 9px rgba(0,0,0,0.15);
	padding: 0 20px;
	border-radius: 10px;  
	position: relative;
	list-style: none;
	display: inline-table;
}
/* previene la aparición de los subnavs */
	#navigation ul:after {
			content: ""; clear: both; display: block;
		}
/* cambia la orientación de la lista */
#navigation ul li {
	float: left;
}
/*cambia el estilo de los elementos li cuando se posiciona sobre ellos el ratón */
	#navigation ul li:hover {
		background: #4b545f;
		background: linear-gradient(top, #4f5964 0%, #5f6975 40%);
		background: -moz-linear-gradient(top, #4f5964 0%, #5f6975 40%);
		background: -webkit-linear-gradient(top, #4f5964 0%,#5f6975 40%);
		
		/*redondeo menu principal*/
		border-radius: 72px 72px 72px 72px;
		-moz-border-radius: 72px 72px 72px 72px;
		-webkit-border-radius: 72px 72px 72px 72px;
		border: 0px solid #000000;
		
	}/* cambia el color de los enlaces al posicionar el ratón */
		#navigation ul li:hover a {
			color: #fff;
		}
	/*cambia el estilo de los enlaces de los subnavs*/
	#navigation ul li a {
		display: block; 
		padding: 5px 10px;
		color: #757575; 
		text-decoration: none;
	}
/*cambia el estilo de los subnavigations */
#navigation ul ul{
	background: #5f6975; border-radius: 0px; padding: 0;
	/* posicion del submenu!! -> Con relative el menú desplaza los elementos!!*/
	position: absolute; 
	/* añadiremos este desplazamiento si optamos por un menú vertical */
	/*left:100%;*/
	/*top: 100%;*/
} /*cambia el estilo de los subnavigations de segundo nivel */
	#navigation ul ul li {
		float: none; 
		border-top: 1px solid #6b727c;
		border-bottom: 1px solid #575f6a;
		position: relative;

	}/* cambia el estilo de los enlaces de los subnavigations de segundo nivel */
		#navigation ul ul li a {
			padding: 5px 10px;
			color: #fff;
		}	 /* cambia el estilo de los enlaces de los subnavigations de segundo nivel al posicionar el ratón sobre ellos */
			#navigation ul ul li a:hover {
				background: #4b545f;
			}
/* posiciona los subnavigations en relación a la posición del nodo padre */
#navigation ul ul ul{
	position: absolute; left: 100%; top:0;
}

/*
	Código extraído de http://scn.sap.com/docs/DOC-56038
	COMPATIBLE SOLO CON I.E.
	
	Se modifica el identificador de la etiqueta div que contiene el menú a navie en lugar de navigation
	lo cual posibilita la aplicación de las reglas CSS alternativas para IE.
*/
/*
#navie ul.Main {
	background-color:#000000;
	height: 22px;
}*/
/*cambia el color de fondo de la etiqueta div navie */
#navie {
	background-color:rgb(75, 84, 95);
}

/* se aplica a la lista desordenadas que sirve como contenedor de la lista ordenada que compone los menús de opciones */
#navie ul {
	margin-left: 0px;
	list-style: none;
	font: 11px  verdana;
	/*padding-top: 4px;*/
	/*padding-bottom: 4px;*/
	/*height: 22px;  */
	background-color:rgb(75, 84, 95);
}
/*
#navie ul.Sub {
	background-color: rgb(244,244,244);
}
*/
/* se aplica a todos los enlaces del tag navigation */
#navie a {
	padding-left: 10px;
	padding-right: 10px;
	padding-top: 4px;
	padding-bottom: 4px;
	text-decoration: none;
	/*background-color: #414141;*/
	/*color: #FFFFFF;*/
	display: block;
	width: auto;
	background-color:rgb(75, 84, 95);
	color:#FFFFFF;
}

/* enlace actual sobre el que se ha echo click */
#navie a.currenthref {
	padding-left: 10px;
	padding-right: 10px;
	padding-top: 4px;
	padding-bottom: 4px;
	text-decoration: none;
	/*background-color: #FFFFFF;*/
	/* color: #C51733; */
	display: block;
	width: auto;
}

/* enlace sobre el que se ha posicionado el ratón */
#navie a:hover {
	/* background-color: #F4F4F4;*/
	/* color: #C51733; */
	display: block;
	/* border-color: #FFFFFF; */
	font-weight: normal;
}
/* marca la disposición de los elementos de la lista a la izquierda (horizontal) pero solo para NIVEL 1 */
#navie li.Level1 {
	/*background-color: #616F9E;*/
	float: left;
}

#navie li ul {
	position: realtive;
	/*width: 17em;*/
	width: auto;
	white-space: nowrap;
	padding-top: 0px;
	padding-bottom: 0px;
	/* color: #ffff00; */
	/*left: -999em; - La versión original se basa en desplazamiento. Cambio la propiedad por display */
	display:none;
}

#navie li:hover ul {
	/*left: auto;*/
	display:block;
	width: auto;
	/*position: relative;*/
}
/* ESTA SECCIÓN ES LA QUE MUESTRA / OCULTA LOS ELEMENTOS DE LA LISTA ORDENADA DE SEGUNDO NIVEL */
#navie li:hover ul, #navie li.hover ul{
	left: auto;
	display: block;
	border: 1px solid #CBDBEA;
	position: absolute;
	/*background-color: rgb(95, 105, 117);*/ /*añade linea de separación entre opciones submenu */
}

#navie li.hover ul  a:hover{
	left: auto;
	display: block;
	border: 0px solid #CBDBEA;
	/*background-color: #F4F4F4;*/
	background-color: rgb(95, 105, 117);
	/* color: #414141; */
}

#navie .current {
	font: 0.4em  verdana;
/*	font-size: 11 px;*/
	border: 0px solid #000000;
/*	font-weight: light;*/
	/* background-color: #FFFFFF; */
	/* color: #C51733; */
}

#navie .Level1 {
	font: 0.4em  verdana;
/*	font-size: 11 px;*/
	border: 0px solid #000000;
/*	font-weight: light;*/
	/* background-color: #FFFFFF;*/
	/* color: #C51733; */
}

#navie .Level2 {
	font: 11px  verdana;
	border: 0px solid #000000;
	font-size: 11px;
	display: block;  
	width: 17em;
	white-space: nowrap;
	/* background-color: #F4F4F4; */
	/* color: #414141; */
	position:relative;
}

#navie .clicklink{
	/* background-color: #FFFF00; */
	background-color: rgb(95, 105, 117);
	/* color: #0000FF; */
}

#navie ul li.hover a{
	left: auto;
	display: block;
	border: 0px solid #CBDBEA;
	/* background-color: #F4F4F4; */
	font-weight: normal;
	/* color: #414141; */
}

#navie ul li.hover .Level2{
	left: auto;
	display: block;
	border: 0px solid #CBDBEA;
	/* background-color: #F4F4F4; */
	font-weight: normal;
	/* color: #414141; */
}

#navie ul li.hover a:hover{
	left: auto;
	display: block;
	border: 0px solid #CBDBEA;
	/* background-color: #F4F4F4; */
	background-color: rgb(95, 105, 117);
	/* color: #C51733; */
}

#navie .Level2 a{
	left: auto;
	display: block;
	border: 0px solid #CBDBEA;
	/* background-color: #F4F4F4;*/ 
	/* color: #FFFF00; */
}

#l1 a {
	width: auto;
	border: 0px solid #000000;
	/* background-color: #F4F4F4; */
	/* color: #414141; */
}

#l1 a:hover {
	width: auto;
	border: 0px solid #000000;
	/* background-color: #F4F4F4; */
	/* color: #414141; */
}

</style>