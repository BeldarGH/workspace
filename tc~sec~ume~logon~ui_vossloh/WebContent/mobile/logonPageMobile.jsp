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

<div data-role="page" id="page" class="mobileLogonPageHeightStrech">
	<div data-role="header">
		<div id="mobileHeaderStrip"></div>
		<h1 id="mobileHeaderTitle">SAP NetWeaver</h1>
	</div> <!-- Header -->

	<div data-role="content">
		<% if(isRTLMode){ %>
		<table id="tblInnerCnt" valign="middle" dir="rtl" align="<%=uiFrameAllign%>" cellpadding="0" cellspacing="0">
		<% } else {%>
		<table id="tblInnerCnt" valign="middle" dir="ltr" align="<%=uiFrameAllign%>" cellpadding="0" cellspacing="0">
			<% } %>
			<tr>					
				<td>					
					<table cellPadding="0" cellSpacing="0">												
						<tr>
							<td valign="top" align="left">							
								<div class="urLogonData">										
									<!-- data table starts after this line -->
									<sap:form type="logon">
										<% if(isRTLMode){ %>
										<input type="hidden" name="sap_rtl" value="true">
										<% } %>
										<table class="urLogonTable" cellSpacing="3px" cellPadding="0" valign="top">																									
											<tr>
												<td colspan="3">
													<div class="urMessageArea">
														<!--	Federation Error Message				-->
														<sap:if display="FederateUserWarning">														
															<!-- display error message if there is one -->
															<div class="mobile_urMsgBarStd" style="border=0;">
																<sap:errormsg styleClass="mobileErrorMessageText" imageClass="urmsgbarimgwarning" />
															</div>					
														</sap:if>														
														<sap:if display="errormsg">
															<!-- display error message if there is one -->
															<div class="mobile_urMsgBarErr">
																<sap:errormsg styleClass="mobileErrorMessageText" imageClass="mobileMsgBarImgError" />
															</div>
														</sap:if>														
													</div>
												</td>
											</tr>												
											<sap:if display="selfreg">											
												<!-- display self-registration link if supposed to do so -->
												<tr>
													<td colspan="3" class="mobilePaddedTD mobileTDAlignTop">
														<sap:link type="selfReg" linkClass="mobileLink" textClass="mobileAdditionText mobileLinkSubTextMarginLeft" infoTextClass="mobileAdditionText"/>														
													</td>
												</tr>											
											</sap:if>				
											<!-- userid and password -->
											<tr>
												<td colspan="3">
													<!-- userid -->
													<span id="userNameLabel">
														<sap:label type="username" styleClass="mobileHiddenString" flagReqClass="urLblReq"/>
													</span>
													<sap:input type="username" styleClass="mobileInput mobileMultiInputFirst" />
													<!-- password -->
													<span id="passwordLabel">
														<sap:label type="password" styleClass="mobileHiddenString" flagReqClass="urLblReq"/>
													</span>
													<sap:input type="password" styleClass="mobileInput mobileMultiInputLast" />
												</td>
											</tr>
											<!-- create certificate -->
											<sap:if display="createcert">
												<tr>
													<td colspan="3" class="mobilePaddedTD mobileTDAlignBottom">
														<sap:input type="createcert"/>
														<sap:label type="createcert" styleClass="mobileAdditionText" flagReqClass="urLblReq"/>
													</td>
												</tr>
											</sap:if>
											<!-- Federate User checkbox -->
											<sap:if display="FederateUserChkBox">
												<!-- display checkbox if a user account federation is required -->
												<tr>
													<td>&nbsp;</td>
													<td>
														<sap:input type="FederateUserCheckbox"/>
														<sap:label type="FederateUserCheckbox" styleClass="mobile_urLblStdNew"/>
													</td>
													<td width="100%">&nbsp;</td>
												</tr>
											</sap:if>
											<tr>
												<td width="100%" colspan="3">	
												<!-- logon button -->
												<sap:button type="logon" styleClass="mobileButton mobileButtonBlue"/>
												<sap:if display="DisplayCancelButton">
													<!-- display cancel button incase of SP initiated SSO -->
													<sap:button type="cancelIdPLogon" styleClass="mobileButton"/>																
												</sap:if>
												</td>
											</tr>												
											<!-- link to certificate logon -->
											<sap:if display="CertLogonLink">
												<tr>
													<td align="right" class="mobilePaddedTD mobileTDAlignBottom" colspan="3">
														<sap:link type="certlogon" linkClass="mobileLink" textClass="mobileAdditionText"/>														
													</td>
												</tr>
											</sap:if>
											<!-- logon help -->
											<sap:if display="LogonHelpLink">
												<tr>
													<td align="right" class="mobilePaddedTD mobileTDAlignBottom" colspan="3">
														<sap:link type="logonhelp" linkClass="mobileLink" textClass="mobileAdditionText mobileLinkSubTextMarginLeft" infoTextClass="mobileAdditionText"/>														
													</td>
												</tr>
											</sap:if>
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
	</div> <!-- Content -->

	<div data-role="footer" data-position="fixed" class="mobileFooter">
		<div class="urCopyrightFrame">	
			<div class="urCopyrightImage mobileCopyrightImage"><img src="<%=webpath%>layout/sap_logo.png" alt="<%=logonLocale.get("SAPAG")%>" title="<%=logonLocale.get("SAPAG")%>" width="55" height="27"></div>		
			<div class="mobile_urCopyrightText"><%=logonLocale.get("COPY_RIGHT")%></div>					
		</div>
	</div> <!-- Footer -->

</div> <!-- Page -->

<script type="text/javascript">
	var _userNameContainer = document.getElementById('userNameLabel');
	var _passwordContainer = document.getElementById('passwordLabel');
	var _userNameLabel = _userNameContainer.getElementsByTagName('nobr')[0].childNodes[0].textContent;
	var _passwordLabel = _passwordContainer.getElementsByTagName('nobr')[0].childNodes[0].textContent;
	document.getElementById('logonuidfield').placeholder = _userNameLabel;
	document.getElementById('logonpassfield').placeholder = _passwordLabel;
</script>

<% } %>