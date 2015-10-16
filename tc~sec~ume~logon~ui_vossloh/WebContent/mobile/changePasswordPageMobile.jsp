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

<div data-role="page" id="page" class="pageHeightStrech">
	<div data-role="header">
		<div id="mobileHeaderStrip"></div>
		<h1 id="mobileHeaderTitle">SAP NetWeaver</h1>
	</div> <!-- Header -->
		
	<div data-role="content">	
		<table id="tblFrmUI" valign="middle" dir="ltr" align="<%=uiFrameAllign%>" cellPadding="0" cellSpacing="0" >
			<tr>
				<td width="100%">		
				<% if (isRTLMode) { %>
					<table id="tblInnerCnt" dir="rtl" cellpadding="0" cellspacing="0">
				<% } else {%>
					<table id="tblInnerCnt" dir="ltr" cellpadding="0" cellspacing="0">
				<% } %>
						<tr>
							<td>					
								<table cellPadding="0" cellSpacing="0">							
									<tr>
										<td valign="top" align="left">							
											<div class="urLogonData formStrech">										
												<!-- data table starts after this line -->
												<sap:form type="changepassword">
												<% if (isRTLMode) { %>
													<input type="hidden" name="sap_rtl" value="true">
												<% } %>
													<table class="urLogonTable" cellSpacing="3px" cellPadding="0" valign="top">																									
														<tr>
															<td colspan="3">
																<div class="urMessageArea">																					
																	<sap:if display="errormsg">
																		<!-- display error message if there is one -->
																		<div class="mobile_urMsgBarErr">
																			<sap:errormsg styleClass="mobileErrorMessageText" imageClass="mobileMsgBarImgError" />
																		</div>
																	</sap:if>														
																</div>
															</td>
														</tr>
														<!-- header line -->
														<tr>
															<td align="left" colspan="3">
																<div class="mobileFormTitle"><%=logonLocale.get("CHANGE_PASSWORD")%></div>
															</td>
														</tr>
														<!-- old password -->
														<tr>
															<td colspan="3">
																<span id="oldPassword">
																	<sap:label type="oldPassword" styleClass="mobileHiddenString" flagReqClass="urLblReq"/>
																	<sap:input type="oldPassword" styleClass="mobileInput mobileMultiInputFirst"/>
																</span>
																	<!-- new password -->
																<span id="newPassword">
																	<sap:label type="newPassword" styleClass="mobileHiddenString" flagReqClass="urLblReq"/>
																	<sap:input type="newPassword" styleClass="mobileInput mobileMultiInputMiddle"/>
																</span>
																	<!-- retype new password -->
																<span id="retypePassword">
																	<sap:label type="confirmPassword" styleClass="mobileHiddenString" flagReqClass="urLblReq"/>
																	<sap:input type="confirmPassword" styleClass="mobileInput mobileMultiInputLast mobileMultiInputThirdFix"/>
																</span>
															</td>
														</tr>
														<!-- submit buttons -->
														<tr>
															<td colspan="3">
																<sap:button type="changePassword" styleClass="mobileButton mobileButtonBlue"/>
																<sap:button type="cancelChangePassword" styleClass="mobileButton mobileButtonGray"/>
															</td>
														</tr>												
													</table>
												</sap:form>
												<!-- data table ends before this line -->
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

<script type="text/javascript">
	var _oldPasswordContainer = document.getElementById('oldPassword');
	var _newPasswordContainer = document.getElementById('newPassword');
	var _retypePasswordContainer = document.getElementById('retypePassword');
	var _oldPasswordLabel = _oldPasswordContainer.getElementsByTagName('nobr')[0].childNodes[0].textContent;
	var _newPasswordLabel = _newPasswordContainer.getElementsByTagName('nobr')[0].childNodes[0].textContent;
	var _retypePasswordLabel = _retypePasswordContainer.getElementsByTagName('nobr')[0].childNodes[0].textContent;
	document.getElementById('logonoldpassfield').placeholder = _oldPasswordLabel;
	document.getElementById('logonnewpassfield').placeholder = _newPasswordLabel;
	document.getElementById('logonretypepassfield').placeholder = _retypePasswordLabel;
</script>

<% } %>