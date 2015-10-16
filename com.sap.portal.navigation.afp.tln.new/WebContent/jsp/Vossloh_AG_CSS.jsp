<style>
/*
	CSS extraído de la página web de Vossloh - http://www.vossloh.com/en/investors/investor_relations_platform/investor_relations_platform.html
	Esta sección de CSS es la que controla el aspecto de la web en general
*/


@CHARSET "ISO-8859-1";
body {
	background-color:#ffffff;
	margin:0px;
	padding:0px;
	text-align:center;
	
	background: url("../media/images/background/background.jpg") no-repeat center center fixed; 
    -webkit-background-size: cover;
    /*-moz-background-size: cover;*/
    -o-background-size: cover;
    background-size: cover;
	
	/*
	background-image: url("./media/images/background/background.jpg");
	background-repeat:no-repeat;
	background-attachment: fixed;
	*/
}


#bg_image {
	/*background-image: url("./media/images/background/background.jpg");
	background-repeat:no-repeat;
	background-attachment: fixed;*/
}


body, input, select{
	color:#000000;
	font:11px Verdana,Arial,Helvetica,sans-serif;
	line-height:16px;
}

tr, table{
	color:#000000;
	font:11px Verdana,Arial,Helvetica,sans-serif;
	line-height:16px;
	text-align: left;
}

th
{
	color:#000000;
	font:11px Verdana,Arial,Helvetica,sans-serif;
	line-height:16px;
	background-color: #c0c0c0;
}
p{
	height:20px;
	line-height:20px;
	margin:0px;
	padding:0px;
}

img {
	border:0px;
}

table .thumb {
	border:1px solid #000000;
	margin-top:4px;
	margin-bottom:4px;
}



.imageright250leg_bottom, .imageleft250leg_bottom{
	width:262px;
	font-style:italic;
	margin-bottom:35px;
}

.imageleft755leg_bottom{
	font-style:italic;
}

.imageright250leg_bottom{
	float:right;
	margin-left:15px;
}

.imageleft250leg_bottom, .imageleft755leg_bottom{
	float:left;
	margin-right:15px;
}

.imageright250leg_bottom img, .imageleft250leg_bottom img, .imageleft250leg_right img, .imageleft250text_right img, .imageleft755leg_bottom img{
	padding-right:12px;
}

.legend_right_image{
	float:left;
	margin-right:6px;
}

.legend_right{
	float:left;
	width:320px;
}

.imageleft250text_right h1{
	margin-bottom:4px;
}

.imageleft250leg_right, .imageleft250text_right, .imageleft755leg_bottom{
	margin-bottom:35px;
	margin-top:20px;
	margin-right:15px;
}

.imageleft250leg_right{
	font-style:italic;
}

/* DIV - Container */

#metanavigation {
	font-size:9px;
	width:970px;
	height:20px;
	line-height:20px;
	margin-bottom:20px;
	text-align:left;
	background-color:#F4F4F4;
	border:1px solid #f4f4f4;
	border-top:0px;
}

#subnavigation {
	float:left;
	width:198px;
	text-align:left;
	background-color:#F4F4F4;
	margin-bottom:20px;
}


#headhome {
	width:970px;
	height:250px;
	text-align:left;
	clear:both;
	border:1px solid #CCCCCC;
}

#headcontent {
	width:970px;
	height:140px;
	text-align:left;
	clear:both;
	border:1px solid #CCCCCC;
	/* añadido para centrar la etiqueta div */
	margin-left: 2%;
    margin-right: auto;
    background-color: #FFFFFF;
}

.modulhome{
	clear:both;
	margin-left:203px;
}

.modulhomeheadline{
	width:180px;
	float:left;
	font-weight:bold;
}

.modulhomecontent{
	width:580px;
	float:left;
}

.line{
	clear:both;
	height:21px;
	background-image:url(../images_1/general/line.gif);
	background-repeat:repeat-x;
	background-position:0px 11px;
	overflow:hidden;
}

.distance35{
	clear:both;
	height:35px;
	overflow:hidden;
}

#contenthome {
	width:970px;
	margin-top:15px; 
	text-align:left;
	clear:both;
}

#contentcontainer {
	width:970px;
	text-align:left;
	clear:both;
}


#contentcontainer {
	border-top:1px solid #cccccc;
	margin-top:15px;
}

#breadcrumb{
	text-align:right;
	font-size:9px;
	margin-top:8px;
	margin-bottom:22px;
	line-height:9px;
}

#footer{
	font-size:9px;
	margin-top:35px;
	line-height:9px;
	margin-bottom:20px;
}

.newsdate{
	clear:both;
	float:left;
	width:90px;
	line-height:18px;
}

.newslink{
	float:left;
	width:480px;
	line-height:18px;
}

#update {
	font-size:9px;
	width:970px;
	height:5px;
	text-align:right;
}

#content {
	float:left;
	margin-left:15px;
	width:755px;
}

.firstrow{
	width:190px;
	float:left;
	background-color: #FFFFFF;
}

.secondrow{
	width:162px;
	float:left;
	padding:0px 10px 0px 8px;
}

.thirdrow{
	width:600px;
	float:right;
	background-color:#F4F4F4;
}

#language{
	float:right;
}

#headhome .secondrow {
	width:180px;
	padding:0px 0px 0px 0px;
	/*background-image:url(../images_1/navigation/bg_navigation.gif);*/
	background-repeat:repeat-y;
	background-color:#f4f4f4;
	height:249px;
}

#headcontent .secondrow {
	width:180px;
	padding:0px 0px 0px 0px;
	/*background-image:url(../images_1/navigation/bg_navigation.gif);*/
	background-repeat:repeat-y;
	background-color:#f4f4f4;
	height:139px;
}


.thirdrow img{
	float:right;
}

.slideshow{
	margin:20px 0px 20px 0px;
	height:347px;
}

.slideshow img{
	margin-right:10px;
}


#footnote {
	padding-top:4px;
	font-size:9px;
	line-height:14px;
	display:block;
}

.manualfootnote {
	font-size:9px;
	line-height:20px;
}

.rowcolor{
	background-color:red;
}

.rowcolorhighlight{
	background-color:green;
}

/* Headlines */

h1 {
	margin-top:0px;
	color:#000000;
	font-size:12px;
	font-weight:bold;
	margin-bottom:10px;
}


/* FORM */

form, select, input, textarea {
	font-family:Verdana,Arial,Helvetica,sans-serif;
	margin:0px;
	padding:0px;
	font-size:11px;
	line-height:13px;
}

select, input, textarea {
	color:#33ae33;
}

textarea {
	padding:2px;
}

.searchfield{
	width:100px;
	font-size:10px;
	line-height:11px;
	margin-top:2px;
	float:right;
	color:#33ae33;
}

.formbuttons{
	padding-right:20px;
	font-size:9px;
	font-weight:normal;
}

.button{
	background-color:#ffffff;
	border:1px solid #ffffff;
	font-size:9px;
	height:20px;
	font-weight:normal;
	color:#000000;
	float:left;
}

/* Styles for Listen */

#content ul, #popupcontent ul{
	list-style-image:url(../images_1/general/list_bullet.gif);
	list-style-type:circle;
	padding:0px 0px 0px 16px;
	margin:0px 0px 10px;
}

#navigation ul, #navigation li, #subnavigation ul, #subnavigation li{
	list-style-type:none;
	line-height:0%;
	padding:0px;
	margin:0px;
}

#metanavigation ul, #metanavigation li{
	list-style-type:none;
	padding:0px;
	margin:0px;
}

#metanavigation li{
	float:left;
}

.linklist li{
	margin-bottom:10px;
}

/* Tabellen allgemein */

table{
	table-layout:fixed;
	width:755px;
	border-collapse:collapse;
	empty-cells:show;

}

.lastrow{
	border-bottom:1px solid #999999;
}

th, td {
	vertical-align:bottom;
	padding:2px 6px 2px 6px;
}

td {
	border-bottom:1px solid #CCCCCC;
}

th {
	border-top:1px solid #999999;
	border-bottom:1px solid #999999;
	font-weight:bold;
}

.download{
	width:580px;
}

.download td{
	vertical-align:middle;
}

.stocksleft{
	width:320px;
	float:left;
}

.stocksleft table{
	margin-top:0px;
	margin-bottom:10px;
	width:200px;
}

.stocksleft th, .stocksleft td {
	font-weight:bold;
	padding:2px 0px 2px 0px;
}

.stocksleft td {
	border-bottom:0px;
}

.stocksleft th {
	color:#33ae33;
	border-top:0px;
	border-bottom:0px;
}




.webform{
	width:520px;
	table-layout:auto;
	background-color:#F4F4F4;
}
	
.webform input, .webform select{
	width:240px;
}

.webform textarea{
	margin-bottom:4px;
	margin-top:14px;
}

.webform th{
	background-color:#ffffff;
	border-top:1px solid #999999;
	border-bottom:1px solid #999999;
}

.webform th, .webform td{
	padding:0px 20px 2px 20px;
	
}

.webform td{
	height:30px;
	border-bottom:0px;
}

.webform hr{
	color:#cccccc;
	height:1px;
	border-style:solid;
	padding:0px;
}

.press_release td{
	vertical-align:top;
}

.colored{
	background-color:#F4F4F4;
}

.engage20{
	padding-left:20px;
}

.engage40{
	padding-left:40px;
}

.engage60{
	padding-left:65px;
}

/* float */

.f_left{
	float:left;
}

.f_right{
	float:right;
}

.f_clear{
	clear:both;
}


/* Distance */

.moduldistance{
	height:7px;
	clear:both;
	overflow:hidden;
}

.smalldistance{
	height:10px;
	clear:both;
	overflow:hidden;
}

.bigdistance{
	height:30px;
	clear:both;
	overflow:hidden;
}


/* format text */

.standardgreen, .boldgreen{
	color:#33ae33;
}

.standardgrey,.boldgrey{
	color:#7F7F7F;
}

.boldgreen, .boldgrey{
	font-weight:bold;	
}


/* Display Analysts */

#display_analysts{
	width:461px;
	height:48px;
	background-image:url(../images_1/stock_analyst/bar_bg.gif);
	background-repeat:no-repeat;
}

#lable_buy{
	float:left;
	width:60px;
	text-align:center;
}

#lable_hold{
	float:left;
	width:340px;
	text-align:center;
}

#lable_sell{
	float:left;
	width:60px;
	text-align:center;
}

/* media_download2col */

.mediaDownload2col {
	width: 337px;
	float: left;
	margin-right: 40px;
}

.mediaDownload2col .legend_right{
	width: 235px;
}

.mediaDownload2col .legend_right .f_left, .mediaDownload2col .legend_right .f_right{
	float:none;
}

.mediaDownload1col {
	width: 337px;
	margin-right: 40px;
}

.mediaDownload1col .legend_right{
	width: 235px;
}

.mediaDownload1col .legend_right .f_left, .mediaDownload1col .legend_right .f_right{
	float:none;
}


.distanceSmall{
	margin-bottom: 45px;
}

.distanceBig {
	margin-bottom: 65px;
}

.mediaDownload1col{
	clear:both;
}

.mediaDownloadclearBoth{
	clear:both;
}

/* text_image pictureLink */

.imageright250leg_bottom a.pictureLink, .imageleft250leg_bottom a.pictureLink, .imageleft250leg_right a.pictureLink, .imageleft250text_right a.pictureLink img, .imageleft755leg_bottom a.pictureLink {
	background: none;
}

/*google-site-search results*/
h3 {
	margin-top:0px;
	color:#000000;
	font-size:12px;
	font-weight:bold;
	margin-bottom:10px;
}


/* Personalización de estilo para la cabecera de NX10 */

#Admin_Familias {
	top: 0px;
}

#Key_Users {
	top: -15px;
}

#Implantacion {
	top: -30px;
}

#Recomendaciones {
	top: -45px;
	height: 520px; 
}

#Proyectos {
	top: -45px;
}


#Revisar {
	text-align: left;
	position: relative;
	left: 100px;
	width: 300px;
	border:2px;
}

#Deformables {
	text-align: left;
	position: relative;
	left: 450px;
	top: -140px;
	width: 400px;
	border:2px;
}

.Info {
	background-color: white;
	width: 900px;
	clear:both;
	border:1px solid #CCCCCC;
	position: relative;
	/*margin-left: auto;*/
	margin-left: 4%;
    margin-right: auto;
    display: none;
}

#advert {
	list-style-type: none;
	font-style: italic;
	font-size: 10px;
    font-weight: bold;
}

#Help {
	width: 20%;
	height: 141px;
	position: relative;
	left: 780px;
	background: url("../media/images/background/bihar-train-accident_sat.jpg");
	background-size: 80px 60px;
    -webkit-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
    background-color: white;
}

.Help_H1 {
	color: white;
	text-decoration: underline;
	position:relative;
	top:-120px;
	text-align: center;
}

.Help_Table{
	width: 100%;
	position:relative;
	top:-120px;
}

.Help_cabecera{
	color:white;
}

.Help_fila {
	color:white;
}

#Mail {
	background-color: white;
	width: 600px;
	clear:both;
	border:1px solid #CCCCCC;
	position: relative;
	margin-left: 4%;
    margin-right: auto;
    top: -30px;
}


7************ ENLACES ********************/
/*
	CSS extraído de la página web de Vossloh - http://www.vossloh.com/en/investors/investor_relations_platform/investor_relations_platform.html
	Esta sección de CSS es la que controla el aspecto de los enlaces del menú de navegación principal de la cabecera de la web
*/

a{
	color:#000000;
}

a:hover{
	color:#33ae33;
}

#navigation a{
	display:block;
	padding-left:13px;
	line-height:20px;
	border-right:1px solid #cccccc;
	text-decoration:none;
	background-image:url(../media/images/navigation/btn_navi.gif);
	background-position:0px 0px;
	background-repeat:no-repeat;
}

#navigation a:hover{
	color:#33ae33;
	background-image:url(../media/images/navigation/btn_navi_h.gif);
}

#navigation a.selected{
	color:#33ae33;
	background-color:#EBEBEB;
	background-image:url(../media/images/navigation/btn_navi_s.gif);
}

.Help_Table a{
	color:white;
}

.Help_fila a:hover {
	color:#33ae33;
}

.incidencias_link{
	position:relative;
}

.incidencias_link{
	position:relative;
	top: -110px;
	color:white;
	left:10px;
}

.incidencias_link a:hover {
	color:#33ae33;
}
</style>