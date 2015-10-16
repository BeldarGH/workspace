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

<div data-role="page" id="page">
	<div data-role="header">
		<div id="mobileHeaderStrip"></div>
		<h1 id="mobileHeaderTitle">SAP NetWeaver</h1>
	</div> <!-- Header -->

	<div data-role="content">
		<table id="tblFrmUI" valign="middle" dir="ltr" align="<%=uiFrameAllign%>" cellPadding="0" cellSpacing="0" style="<%=uiFrameTopMargin%>">
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
													<sap:form type="logoff">
													<% if(isRTLMode){ %>
								<input type="hidden" name="sap_rtl" value="true">
							  <% } %>
													<table class="urLogonTable" cellSpacing="3px" cellPadding="0" valign="top">																									
														<!-- logout label -->
														<tr>
															<td width="100%">
																<div class="urMessageArea">
																  <sap:if display="logoutSuccessMsg">
																	  <sap:label type="logout" styleClass="mobileText"/>
																  </sap:if>		
																  <sap:if display="logoutErrorMsg">
																	<div class="mobile_urMsgBarErr">
																		<sap:errormsg styleClass="mobileErrorMessageText" imageClass="mobileMsgBarImgError" />
																	</div>
																  </sap:if>		
																</div>										
															</td>
														</tr>	
														<!-- button to logon again -->
														<sap:if display="LogonAgainButton">
															<tr>
																<td width="100%">
																 <sap:if display="logoutSuccessMsg">
																	<sap:button type="logonAgain" styleClass="mobileButton mobileButtonBlue"/>
																 </sap:if>   
																 <sap:if display="logoutErrorMsg">
																   <sap:button type="GoBack" styleClass="mobileButton mobileButtonGray"/>
																 </sap:if>   
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