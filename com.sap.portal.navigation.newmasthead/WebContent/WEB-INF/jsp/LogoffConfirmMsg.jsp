<%@ page session="false" %>
<%@ page import = "java.util.ResourceBundle" %>
<%@ page import = "com.sapportals.portal.navigation.NavigationEventsHelperService" %>
<%@ page import = "com.sapportals.portal.prt.runtime.PortalRuntime" %>
<%@ page import = "com.sapportals.htmlb.*" %>
<%@ page import = "com.sapportals.portal.prt.component.*" %>
<%@ taglib uri="prt:taglib:tlhtmlb" prefix="hbj" %>
<%@ page import = "com.sapportals.portal.prt.session.IUserContext" %>
<%!

//String constants for NLS
final String LOG_OFF_CONFIRM_MSG = "LOG_OFF_CONFIRM_MSG";
final String LOG_OFF_CONFIRM_MSG_CLOSE_ALL = "LOG_OFF_CONFIRM_MSG_ALL_WIN";
final String LOG_OFF_CONFIRM_MSG_UNSAVED = "LOG_OFF_CONFIRM_MSG_UNSAVED";
final String LOG_OFF_YES_TOOLTIP = "LOG_OFF_YES_TEXT";
final String LOG_OFF_YES_TEXT = "LOG_OFF_YES_TEXT";
final String LOG_OFF_NO_TEXT = "LOG_OFF_NO_TEXT";
final String LOG_OFF_NO_TOOLTIP = "LOG_OFF_NO_TEXT";

private String getNLSString(IPortalComponentRequest request, String resource_key)
{
	try
	{
	    ResourceBundle bundle = request.getResourceBundle();
		if(bundle != null)
		{
			return bundle.getString(resource_key);
	    }
		return resource_key;
	 }
	 catch(MissingResourceException e)
	 {
		return resource_key;
	 }
}

private boolean isAccessabilityOn(IPortalComponentRequest request)
{	
	//End: Temporary, till there's a way to set the accessibility for a user
    IUserContext user = request.getUser();
    if (user.getAccessibilityLevel() != IUserContext.DEFAULT_ACCESSIBILITY_LEVEL) // 508 is on
    	return true;
    return false;
}
%>

<%

NavigationEventsHelperService helperService = (NavigationEventsHelperService)PortalRuntime.getRuntimeResources().getService(NavigationEventsHelperService.KEY);

// initializaing the labels with the localized labels
String logOffConfirmMsgStr = helperService.enableCloseAll() ? getNLSString(componentRequest, LOG_OFF_CONFIRM_MSG_CLOSE_ALL) : getNLSString(componentRequest, LOG_OFF_CONFIRM_MSG);
String logOffYesTextStr = getNLSString(componentRequest, LOG_OFF_YES_TEXT);
String logOffNoTextStr = getNLSString(componentRequest, LOG_OFF_NO_TEXT);

// ----- WORKPROTECT BEGIN 
String logOffUnsavedDataMsgStr = getNLSString(componentRequest,LOG_OFF_CONFIRM_MSG_UNSAVED);
boolean isUnsavedData  =  Boolean.valueOf( request.getParameter("UnsavedData") ).booleanValue(); 
// ----- WORKPROTECT END
%>
<script>
    function logoff()
    {
        if (EPCM.getUAType() == EPCM.MSIE)
        {
            window.returnValue = 'logoff';
        }
        else
        {
			if(typeof(window.opener.performLogOff)=='function')
			{
				window.opener.performLogOff();
			}
			else
			{
				window.opener.logoff();
			}
 
        }
        closeWindow();
    }

    function closeWindow()
    {
        window.close();
    }
    
    
</script>
<hbj:content id="LogOffContext">
<hbj:page title="LogOff Area">
<hbj:form id="LogOffForm" >
	<table DataTable="0" border="0" cellspacing="5" cellpadding="0">
		<tr>
			<td class="ctrlMsgBarImgWarning">&nbsp;</td>
			<%if (isAccessabilityOn(componentRequest))
			  {
			  	if(isUnsavedData)
			  	{%>
					<td title="<%=logOffUnsavedDataMsgStr%>" ti="1" tabindex="1" class="ctrlTxtStd" ><%=logOffUnsavedDataMsgStr%></td>
				<%}
				else // no unsavd data (accessability still on).
				{%>
					<td title="<%=logOffConfirmMsgStr%>" ti="1" tabindex="1" class="ctrlTxtStd"><%=logOffConfirmMsgStr%></td>
				<%} 
			  }
			  else // No Accessability
			  {		  
			  	if(isUnsavedData)
			  	{%>
					<td class="ctrlTxtStd"><%=logOffUnsavedDataMsgStr%></td>
				<%}
				else // no unsavd data (accessability still off).
				{%>
					<td class="ctrlTxtStd"><%=logOffConfirmMsgStr%></td>
			  <%} 
			  }%>
		</tr>
		<tr>
			<td colspan="2" height="10">&nbsp;</td>
		</tr>
		<tr>
			<td align="left" nowrap colspan="2">
				<hbj:button id="yesBtn" text="<%=logOffYesTextStr%>" tooltip="<%=logOffYesTextStr%>">
				<% yesBtn.setOnClientClick("javascript:logoff();");%>
				</hbj:button>
				<hbj:button id="noBtn" text="<%=logOffNoTextStr%>" tooltip="<%=logOffNoTextStr%>">
				<% noBtn.setOnClientClick("javascript:closeWindow();");%>
				</hbj:button>
			

            </td>
		</tr>
	</table>
</hbj:form>
</hbj:page>
</hbj:content>
