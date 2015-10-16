<%
// In case of smartphone device.
if ( ("DeviceType.Smartphone".equalsIgnoreCase(DeviceType)) || ("DeviceType.Tablet".equalsIgnoreCase(DeviceType)) ) {
	%> 
	<link rel="stylesheet" type="text/css" href="/logon_ui_resources/css/mobile/mobile.css" >
	<%
	if("DeviceType.Smartphone".equalsIgnoreCase(DeviceType)) {
		%> 
		<link rel="stylesheet" type="text/css" href="/logon_ui_resources/css/mobile/smartphone.css" >
		<%
	} else if ("DeviceType.Tablet".equalsIgnoreCase(DeviceType)) {
		%> 
		<link rel="stylesheet" type="text/css" href="/logon_ui_resources/css/mobile/tablet.css" >
		<%
	}
	
	otherUiLoaded = true;
	uiFrameTopMargin = "margin-top:30px;";
%>

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

<div data-role="page" id="page" class="smartphoneIDPSelectionPageHeightStrech">
	<div data-role="header">
		<div id="mobileHeaderStrip"></div>
		<h1 id="mobileHeaderTitle">SAP NetWeaver</h1>
	</div> <!-- Header -->
		
	<div data-role="content">
		<table id="tblFrmUI" valign="middle" dir="ltr" align="<%=uiFrameAllign%>" cellPadding="0" cellSpacing="0">
		  <tr>
			<td class="mobile_urTdPadding" width="100%">
			<%
			  if (isRTLMode) {
			%>
			<table id="tblInnerCnt" dir="rtl" cellpadding="0" cellspacing="0">
			  <%
				} else {
			  %>
			  <table id="tblInnerCnt" dir="ltr" cellpadding="0" cellspacing="0">
				<%
				  }
				%>
				<tr>
				  <table cellPadding="0" cellSpacing="0">
					<tr>
					  <td valign="top" align="left">
					  <div class="urLogonData">
					  <table class="urLogonTable" cellSpacing="3px" cellPadding="0" valign="top">
						<tr>
						  <td>
						  <div class="urMessageArea">
						  <div class="mobile_urMsgBarErr"><sap:errormsg styleClass="mobileErrorMessageText" imageClass="mobileMsgBarImgOk" /></div>
						  </div>
						  </td>
						</tr>
						<tr>
						  <td><sap:form type="discoverIdPForm">
							<%
							  if (isRTLMode) {
							%>
							<input type="hidden" name="sap_rtl" value="true">
							<%
							  }
							%>
							<table width="100%" class="mobileIDPSelectionBottomTableFix">
								<tr>
									<td colspan="3"><sap:label type="saml2IdP" styleClass="mobileSubText" /></td>
								</tr>
								<tr>
									<td colspan="3"><sap:select type="saml2IdP" styleClass="mobileDropDown mobileDropDownImportantWidth" ></sap:select></td>
								</tr>
								<tr>
									<td colspan="3"><sap:button type="saml2IdP" styleClass="mobileButton mobileButtonBlue" /><sap:button type="skipIdP" styleClass="mobileButton" /></td>
								</tr>
							</table>
						  </sap:form></td>
						</tr>
						<tr>
						  <td><sap:form type="skipIdPForm">
						  </sap:form></td>
						</tr>
					  </table>
					  </div>
					  </td>
					</tr>
				  </table>
				  </td>
				</tr>
			  </table>
			  </td>
			  </tr>
			</table>
	</div>
	
	<div data-role="footer" data-position="fixed" class="mobileFooter">
		<div class="urCopyrightFrame">	
			<div class="urCopyrightImage mobileCopyrightImage"><img src="<%=webpath%>layout/sap_logo.png" alt="<%=logonLocale.get("SAPAG")%>" title="<%=logonLocale.get("SAPAG")%>" width="55" height="27"></div>		
			<div class="mobile_urCopyrightText"><%=logonLocale.get("COPY_RIGHT")%></div>					
		</div>
	</div> <!-- Footer -->

</div> <!-- Page -->

<% } %>