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

<div data-role="page" id="page" class="mobileHelpPageHeightStrech">
	<div data-role="header">
		<div id="mobileHeaderStrip"></div>
		<h1 id="mobileHeaderTitle">SAP NetWeaver</h1>
	</div> <!-- Header -->
		
	<div data-role="content">
		<table id="tblFrmUI" valign="middle" dir="ltr" align="<%=uiFrameAllign%>" cellPadding="0" cellSpacing="0" >
			<tr>
				<td width="100%">		
					<% if(isRTLMode){ %>
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
													<sap:form type="helpForm">			
													<% if(isRTLMode){ %>
								<input type="hidden" name="sap_rtl" value="true">
							  <% } %>																			
													<table class="urLogonTable" cellSpacing="3px" cellPadding="0" valign="top">																									
														<tr><td colspan="3">
															<div class="urMessageArea">																		
																<sap:if display="errormsg">
																	<!-- display error message if there is one -->
																	<div class="mobile_urMsgBarErr">
																		<sap:errormsg styleClass="mobileErrorMessageText" imageClass="mobileMsgBarImgError" />
																	</div>
																</sap:if>														
															</div>
														</td></tr>
														<!-- header line -->
														<tr><td align="left" colspan="3">
															<div class="mobileFormTitle" tabindex=0><%=logonLocale.get("HAVE_TROUBLE")%></div>
														</td></tr>
														<tr><td align="left" colspan="3">
															<div class="mobileSubText" tabindex=0><%=logonLocale.get("SELECT_HELP")%></div>
														</td></tr>
														<!-- line with select box for help type -->
														<tr>
															<td colspan="3">
																<label class="mobileSubText" for="helptypefield">
																	<nobr><%=logonLocale.get("HOW_HELP")%></nobr>
																</label>
															</td>
														</tr>
														<tr>
															<td colspan="3">
																<sap:select type="helpAction" styleClass="mobileDropDown" size="1">
																	<sap:option type="requestPasswordReset" />
																	<sap:option type="otherLogonProblem" />
																</sap:select>
															</td>
														</tr>												
														<!-- submit button -->
														<tr>
															<td colspan="3">
																<sap:button type="submitHelpPage" styleClass="mobileButton mobileButtonBlue"/>
															</td>
														</tr>
														<tr>
															<td colspan="3">
																<sap:button type="cancelHelpPage" styleClass="mobileButton mobileButtonGray"/>
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

<% } %>