<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>

/* 
	Mensaje de bienvenida (nombre del usuario) de la parte izquierda de la cabecera
	Se dejan comentadas las configuraciones CSS originales.
*/
.prtlHdrWelcome{
	color:#000;
	font-style:normal;
	font-family:Arial, Helvetica, sans-serif;
	font-size:0.7em;
	font-weight:bold;
	/* text-align:left; */
	text-align:rigth;
	background-color:#FF9900;
	padding:0px 16px 0px 10px;
	/* Esta línea se comenta porque si no falla la carga de la imagen y se ve un fondo naranja 
	background-image:url(images/header/welcome_stretch.gif?7.31.11.0.1);
	*/
	background-position:top;
	background-repeat:repeat-x;
}

/* Primer nivel del menú principal. Esta clase controla la opción SELECCIONADA */
.prtlTopNav1stLvl-a{
	color:#FFF;
	font-weight:bold;
	font-size:medium;
	font-family:Arial,Helvetica,sans-serif;
	background-color:#323232;
	padding:3px 11px 3px 12px;
	border-style:none solid none none;
	border-width:0px 1px 0px 0px;
	border-color:#323232;
	cursor:default;
	/* personalizacion redondeado */
	border-radius: 85px 72px 72px 72px;
	-moz-border-radius: 85px 72px 72px 72px;
	-webkit-border-radius: 85px 72px 72px 72px;
	border: 1px solid #000000;
}

/* Primer nivel del menú principal. Esta clase controla el resto de opciones */
.prtlTopNav1stLvl-i{
	color:#323232;
	font-weight:normal;
	font-size:medium;
	font-family:Arial,Helvetica,sans-serif;
	background-color:#AEB6BA;
	padding:4px 11px 3px 12px;
	border-style:none solid solid none;
	border-width:1px;
	border-color:#AEB6BA;
	z-index:0;
	cursor:pointer;
	/* personalizacion redondeado */
	border-radius: 85px 72px 72px 72px;
	-moz-border-radius: 85px 72px 72px 72px;
	-webkit-border-radius: 85px 72px 72px 72px;
	border: 1px solid #000000;
}

/* Controla el aspecto de la opción activa del menú de nivel 2 */
.prtlTopNav2ndLvl-a{
	color:#FFF;
	font-weight:bold;
	font-size:medium;
	font-family:Arial,Helvetica,sans-serif;
	background-color:#323232;
	margin:1px 0px 0px 0px;
	padding:3px 4px 0px 6px;
	cursor:default;
	/* personalizacion redondeado */
	border-radius: 85px 72px 72px 72px;
	-moz-border-radius: 85px 72px 72px 72px;
	-webkit-border-radius: 85px 72px 72px 72px;
	border: 1px solid #000000;
}

/* Controla el aspecto de las opciones inactivas del menú de nivel 2 */
.prtlTopNav2ndLvl-i{
	color:#FFFFFF;
	font-weight:normal;
	font-size:medium;
	font-family:Arial,Helvetica,sans-serif;
	background-color:#323232;
	margin:1px 0px 0px 0px;
	padding:3px 4px 0px 11px;
	cursor:default;
	/* personalizacion redondeado */
	border-radius: 85px 72px 72px 72px;
	-moz-border-radius: 85px 72px 72px 72px;
	-webkit-border-radius: 85px 72px 72px 72px;
	border: 1px solid #000000;
}


/* Estilos personalizados extraídos de la página de Vossloh

#navigation a{
	display:block;
	padding-left:13px;
	line-height:20px;
	border-right:1px solid #cccccc;
	text-decoration:none;
	background-image:url(./media/images/navigation/btn_navi.gif);
	background-position:0px 0px;
	background-repeat:no-repeat;
}

#navigation a:hover{
	color:#000000;
	background-image:url(./media/images/navigation/btn_navi_h.gif);
}

#navigation a.selected{
	color:#000000;
	background-color:#EBEBEB;
	background-image:url(./media/images/navigation/btn_navi_s.gif);
}

#navigation a.selected:hover{
	background-image:url(./media/images/navigation/btn_navi_sh.gif);
}

</style>