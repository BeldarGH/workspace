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

<div data-role="page" id="page" class="mobileLogonProblemPageHeightStrech">
	<div data-role="header">
		<div id="mobileHeaderStrip"></div>
		<h1 id="mobileHeaderTitle">SAP NetWeaver</h1>
	</div> <!-- Header -->
		
	<div data-role="content">
		<table id="tblFrmUI" valign="middle" dir="ltr" align="<%=uiFrameAllign%>" cellPadding="0" cellSpacing="0">
			<tr>		
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
										<div class="urLogonData">										
											<!-- data table starts after this line -->
											<sap:form type="logonProblem">
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
													<!-- 2 header lines -->
													<tr>
														<td align="left" colspan="3">
															<div class="mobileFormTitle" tabindex=0><%=logonLocale.get("HAVE_TROUBLE")%></div>
														</td>
													</tr>
													<tr>
														<td align="left" colspan="3">
															<div class="mobileSubText" tabindex=0><%=logonLocale.get("LOGON_PROBLEM_MSG")%></div>
														</td>
													</tr>
													<tr>
														<td colspan="3">
															<!-- userid -->
															<span id="userNameLabel">
																<sap:label type="username" styleClass="mobileHiddenString"/>
															</span>
															<sap:input type="username" styleClass="mobileInput mobileMultiInputFirst" />
															
															<!-- lastname -->
															<span id="userLastNameLabel">
																<sap:label type="lastName" styleClass="mobileHiddenString"/>
															</span>
															<sap:input type="lastName" styleClass="mobileInput mobileMultiInputMiddle" />

															<!-- firstname -->
															<span id="userFirstNameLabel">
																<sap:label type="firstName" styleClass="mobileHiddenString"/>
															</span>
															<sap:input type="firstName" styleClass="mobileInput mobileMultiInputMiddle mobileMultiInputThirdFix" />

															<!-- email -->
															<span id="userEmailLabel">
																<sap:label type="email" styleClass="mobileHiddenString"/>
															</span>
															<sap:input type="email" styleClass="mobileInput mobileMultiInputMiddle mobileMultiInputForthFix" />

															<!-- note to admin -->
															<span id="userNoteLabel">
																<sap:label type="note" styleClass="mobileHiddenString" />
															</span>
															<sap:input type="note" styleClass="mobileInput mobileMultiInputLast mobileMultiInputFifthFix mobileInputNote" cols="30" rows="3" />
														</td>
													</tr>						
													<!-- submit buttons -->
													<tr>
														<td colspan="3">
															<sap:button type="submitLogonProblem" styleClass="mobileButton mobileButtonBlue"/>
															<sap:button type="cancelLogonProblem" styleClass="mobileButton mobileButtonGray"/>
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
	var _userNameContainer = document.getElementById('userNameLabel');
	var _userLastNameContainer = document.getElementById('userLastNameLabel');
	var _userFirstNameContainer = document.getElementById('userFirstNameLabel');
	var _userEmailContainer = document.getElementById('userEmailLabel');
	var _userNoteContainer = document.getElementById('userNoteLabel');
	var _userNameLabel = _userNameContainer.getElementsByTagName('nobr')[0].childNodes[0].textContent;
	var _userLastNameLabel = _userLastNameContainer.getElementsByTagName('nobr')[0].childNodes[0].textContent;
	var _userFirstNameLabel = _userFirstNameContainer.getElementsByTagName('nobr')[0].childNodes[0].textContent;
	var _userEmailLabel = _userEmailContainer.getElementsByTagName('nobr')[0].childNodes[0].textContent;
	var _userNoteLabel = _userNoteContainer.getElementsByTagName('nobr')[0].childNodes[0].textContent;
	document.getElementById('logonuidfield').placeholder = _userNameLabel;
	document.getElementById('logonlastnamefield').placeholder = _userLastNameLabel;
	document.getElementById('logonfirstnamefield').placeholder = _userFirstNameLabel;
	document.getElementById('logonemailfield').placeholder = _userEmailLabel;
	document.getElementById('logonnotefield').placeholder = _userNoteLabel;
</script>
			
<% } %>