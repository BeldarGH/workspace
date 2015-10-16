<%@ page session="false" %>
<%@ page import = "java.util.ResourceBundle" %>
<%@ page import = "java.util.Locale" %>
<%@ page import = "com.sapportals.htmlb.*" %>
<%@ page import = "com.sapportals.htmlb.hovermenu.*" %>
<%@ page import = "com.sapportals.portal.prt.session.IUserContext" %>
<%@ page import = "com.sapportals.portal.prt.component.*" %>
<%@ page import = "com.sapportals.portal.prt.service.laf.*" %>
<%@ page import = "com.sap.security.api.UMFactory" %>
<%@ page import = "com.sapportals.portal.prt.service.license.ILicenseService"%>
<%@ page import = "com.sapportals.admin.wizardframework.util.ILocaleListService"%>
<%@ page import = "com.sapportals.portal.navigation.*" %>
<%@ page import = "com.sapportals.portal.prt.runtime.PortalRuntime" %>
<%@ page import = "com.sapportals.htmlb.rendering.IPageContext" %>
<%@ page import = "com.sapportals.portal.prt.util.DeprecatedStringUtils" %>
<%@ page import="com.sapportals.portal.pcd.gl.PcdAccess"%>
<%@ page import="com.sapportals.portal.pcd.gl.WriteProtectInfo"%>
<%@ taglib uri = "prt:taglib:tlhtmlb" prefix="hbj" %>

<!--   include con los estilos CSS personalizados -->
<%@ include file="Masthead_style_Vossloh.jsp" %> 

<%!final String PERSONALIZE_PAGE_EVENT_URN = "urn:com.sapportals:navigation";
	final String PERSONALIZE_PAGE_EVENT_NAME = "PersonalizePage";
	final String PERSONALIZE_PAGE_EVENT_PARAMS = "";
	final String PERSONALIZE_PORTAL_EVENT_URN = "urn:com.sapportals:navigation";
	final String PERSONALIZE_PORTAL_EVENT_NAME = "PersonalizePortal";
	final String PERSONALIZE_PORTAL_EVENT_PARAMS = "";
	final String LOGOFF_CONFIRM_MSG_COMPONENT = "logoffConfirmMsg";
	final String LOGON_REDIRECT_COMPONENT = "logInComponent";
	final String LOGOFF_REDIRECT_COMPONENT = "LogOutComponent";
	final String LOGOFF_CONFIRM_MSG_ARGS_IE = "dialogHeight: 170px; dialogWidth: 350px; edge: Raised; center: Yes; help: No; resizable: No; status: No";
	final String LOGOFF_CONFIRM_WINDOW_NAME = "LOG_OFF_WINDOW";
	final String HELP_MENU_ENTRY_EVENT_BOB = "HelpMenuEntryBobParam";
	final String HELP_MENU_ENTRY_EVENT_LEARNING_CENTER = "HelpMenuEntryLearningCenterParam";
	final String HELP_WINDOW_NAME = "HELP_WINODW";
	final String HELP_URL = "HelpUrl";
	final String SAP_STORE_URL = "SAPStoreURL";
	final String SAP_STORE_LINK_TITLE = "SAPStoreURLTitle";
	final String SHOW_HELP_LINK = "ShowHelpLink";
	final String SHOW_SAP_STORE_LINK = "ShowSAPStoreLink";
	final String SHOW_HELP_CONTEXT_MENU = "ShowHelpContextMenu";
	final String HELP_MENU_ENTRY_HELP_ENTER = "HelpMenuEntryHelpCenter";
	final String HELP_MENU_ENTRY_BYD_HELP_ENTER = "HelpMenuEntryByDHelpCenter";
	final String HELP_MENU_ENTRY_LEARNING_ENTER = "HelpMenuEntryLearningCenter";
	final String SHOW_PERSONALIZE_LINK = "ShowPersonalizeLink";
	final String SHOW_PERSONALIZE_CONTEXT_MENU = "ShowPersonalizeContextMenu";
	final String SHOW_NEW_WINDOW_LINK = "ShowNewWindowLink";
	final String SHOW_LOG_OFF_LOG_ON_LINK = "ShowLogInLogOffLink";
	final String SHOW_ANONYMOUS_LANGUAGE = "ShowAnonymousLanguage";
	final String SHOW_PORTAL_PLACE = "ShowPortalPlace";
	final String PORTAL_PLACE_TITLE = "PortalPlaceTitle";
	final String PORTAL_PLACE_BACK = "PortalPlaceBack";
	final String BACK_TARGET_REDIRECT_COMPONENT = "BackTargetComponent";
	final String LOGOFF_CONFIRM_MSG_HEIGHT = "170";
	final String LOGOFF_CONFIRM_MSG_WIDTH = "350";

	//String constants for NLS
	final String WELCOME_CLAUSE = "WELCOME_CLAUSE";
	final String HELP_TEXT = "HELP_TEXT";
	final String HELP_CENTER_TEXT = "HELP_CENTER_TEXT";
	final String HELP_CENTER_BYD_TEXT = "HELP_CENTER_BYD_TEXT";
	final String HELP_TOOLTIP = "HELP_TOOLTIP";
	final String BOB_TEXT = "BOB_TEXT";
	final String LEARNING_CENTER = "LEARNING_CENTER";
	final String LOG_OFF_TEXT = "LOG_OFF_TEXT";
	final String LOG_ON_TEXT = "LOG_ON_TEXT";
	final String PERSONALIZE_TEXT = "PERSONALIZE_TEXT";
	final String PERSONALIZE_PORTAL_TEXT = "PERSONALIZE_PORTAL_TEXT";
	final String NEW_WINDOW_TEXT = "NEW_WINDOW_TEXT";
	final String LOG_OFF_TOOLTIP = "LOG_OFF_TOOLTIP";
	final String LOG_ON_TOOLTIP = "LOG_ON_TOOLTIP";
	final String NEW_WINDOW_TOOLTIP = "NEW_WINDOW_TOOLTIP";
	final String BEGINNING_OF_PAGE = "BEGINNING_OF_PAGE";
	final String MASTHEAD_ENTER_TOOLTIP = "MASTHEAD_ENTER_TOOLTIP";
	final String MASTHEAD_EXIT_TOOLTIP = "MASTHEAD_EXIT_TOOLTIP";
	final String UNLOAD_MSG = "UNLOAD_MSG";
	final String ANONYMOUS_DDL_TOOLTIP = "ANONYMOUS_DDL_TOOLTIP";
	final String PERSONALIZE_PAGE_MSG = "PERSONALIZE_PAGE_MSG";
	final String PERSONALIZE_PORTAL_MSG = "PERSONALIZE_PORTAL_MSG";
	final String PERSONALIZE_TOOLTIP = "PERSONALIZE_TEXT";
	final String PERSONALIZE_PORATL_TOOLTIP = "PERSONALIZE_PORATL_TOOLTIP";
	final String PORTAL_PLACE_BACK_TOOLTIP = "PORTAL_PLACE_BACK_TOOLTIP";
	final String PORTAL_PLACE_BACK_TEXT = "PORTAL_PLACE_BACK_TEXT";

	private boolean isPortalInReadOnlyMode() {
		WriteProtectInfo writeProtectInfo = PcdAccess.getPcdUtils()
				.getWriteProtectInfo();
		Boolean isWriteProtected = writeProtectInfo.isWriteProtected();
		String message = writeProtectInfo.getWriteProtectCause();
		return isWriteProtected;
	}

	private String GetWelcomeMsg(IPortalComponentRequest request,
			String welcomeClause) {
		IUserContext userContext = request.getUser();
		if (userContext != null) {
			String firstName = userContext.getFirstName();
			String lastName = userContext.getLastName();
			String salutation = userContext.getSalutation();

			if ((firstName != null) && (lastName != null)) {
				if (salutation != null) {
					return java.text.MessageFormat.format(welcomeClause,
							new Object[] { firstName, lastName, salutation })
							.toString();
				} else {
					return java.text.MessageFormat.format(welcomeClause,
							new Object[] { firstName, lastName, " " })
							.toString();
				}
			} else {
				return java.text.MessageFormat
						.format(
								welcomeClause,
								new Object[] { userContext.getDisplayName(),
										" ", " " }).toString();
			}
		}
		return "";
	}

	private String GetLicenseText(IPortalComponentRequest request) {
		ILicenseService license = (ILicenseService) request
				.getService(ILicenseService.KEY);
		if (license.sapInternalUsageOnly()) {
			return "<FONT color=orangeRed size=4><STRONG>&nbsp;Licensed For SAP Internal Usage</STRONG></FONT>";
		} else {
			return "&nbsp;";
		}
	}

	private boolean getParameter(IPortalComponentRequest request, String param) {
		String value = (String) request.getNode().getValue(param);
		return new Boolean(value).booleanValue();
	}

	private String getHelpUrl(IPortalComponentRequest request) {
		String value = (String) request.getNode().getValue(HELP_URL);
		return value;
	}

	private String getSAPStoreUrl(IPortalComponentRequest request) {
		String value = (String) request.getNode().getValue(SAP_STORE_URL);
		return value;
	}

	private String getSAPStoreLinkTitle(IPortalComponentRequest request) {
		String value = (String) request.getNode()
				.getValue(SAP_STORE_LINK_TITLE);
		return value;
	}

	private String getHelpMenuEntryEvent(IPortalComponentRequest request,
			String paramName) {
		String value = (String) request.getNode().getValue(paramName);
		return "parent.EPCM.doNavigate(\'" + value
				+ "\', 3,'toolbar=no',null,null,null,null,null);";
	}

	private String getPortalPlaceTitle(IPortalComponentRequest request) {
		String value = (String) request.getNode().getValue(PORTAL_PLACE_TITLE);
		return value;
	}

	private String getPortalPlaceBackTarget(IPortalComponentRequest request) {
		String value = (String) request.getNode().getValue(PORTAL_PLACE_BACK);
		return value;
	}

	private String GetLogoffConfirmMsgURL(IPortalComponentRequest request) {
		String componentName = request.getComponentContext().getComponentName();
		componentName = componentName.substring(0, componentName
				.lastIndexOf(".") + 1);

		IPortalComponentURI msgURI = request.createPortalComponentURI();
		msgURI.setContextName(componentName + LOGOFF_CONFIRM_MSG_COMPONENT);
		return msgURI.toString();
	}

	// Attaching the "UnsavedData=true" flag to the Confirm logoff message
	private String GetLogoffConfirmUnsavedMsgURL(IPortalComponentRequest request) {
		String basicUrl = GetLogoffConfirmMsgURL(request);
		String separator = (basicUrl.indexOf("?") >= 0) ? "&" : "?";
		return basicUrl + separator + "UnsavedData=true";
	}

	private String GetBackTargetURLComponent(IPortalComponentRequest request) {
		String componentName = request.getComponentContext().getComponentName();
		componentName = componentName.substring(0, componentName
				.lastIndexOf(".") + 1);
		IPortalComponentURI msgURI = request.createPortalComponentURI();
		msgURI.setContextName(componentName + BACK_TARGET_REDIRECT_COMPONENT);
		return msgURI.toString();
	}

	private boolean isAccessabilityOn(IPortalComponentRequest request) {
		//End: Temporary, till there's a way to set the accessibility for a user
		IUserContext user = request.getUser();
		//if((user.getAccessibilityLevel() != IUserContext.DEFAULT_ACCESSIBILITY_LEVEL) ||(isAccessibility == true) ) // 508 is on
		if (user.getAccessibilityLevel() != IUserContext.DEFAULT_ACCESSIBILITY_LEVEL) // 508 is on
			return true;
		return false;
	}

	private String GetLoginURL(IPortalComponentRequest request) {
		INavigationGenerator navigationService = (INavigationGenerator) PortalRuntime
				.getRuntimeResources().getService(INavigationService.KEY);
		StringBuffer URL = new StringBuffer(200).append(navigationService
				.getPortalURL(request, null));
		return URL.append("/login").toString();
	}

	private String GetPortalUrl(IPortalComponentRequest request) {
		INavigationGenerator navigationService = (INavigationGenerator) PortalRuntime
				.getRuntimeResources().getService(INavigationService.KEY);
		return navigationService.getPortalURL(request, null);
	}

	private String getNLSString(IPortalComponentRequest request,
			String resource_key) {
		try {
			ResourceBundle bundle = request.getResourceBundle();
			if (bundle != null) {
				return bundle.getString(resource_key);
			}
			return resource_key;
		} catch (MissingResourceException e) {
			return resource_key;
		}
	}

	private String GetThemeURLPath(IPortalComponentRequest request) {
		ILAFService iLAFService = (ILAFService) request
				.getService(ILAFService.KEY);

		String currentTheme = iLAFService.getCurrentTheme(request)
				.getThemeName();

		String url = iLAFService.getRelativeThemeRootURLPath(request,
				ILAFService.PORTAL_THEME)
				+ "/prtl";
		return url;
	}

	private boolean isAnonymous(IPortalComponentRequest request) {
		NavigationEventsHelperService helperService = (NavigationEventsHelperService) PortalRuntime
				.getRuntimeResources().getService(
						NavigationEventsHelperService.KEY);
		return helperService.isAnonymousUser(request);
	}

	private List getDisplayLanguagesName(IPortalComponentRequest request) {
		ILocaleListService localeService = (ILocaleListService) PortalRuntime
				.getRuntimeResources().getService(ILocaleListService.KEY);
		Locale globalLocale = request.getLocale();
		List allLocales = localeService
				.getListOfPersLocalesOrderedByDisplayName(globalLocale);
		List allLocaleDisplayNames = localeService.getDisplayNamesForLocales(
				allLocales, globalLocale);

		return allLocaleDisplayNames;
	}

	private List getTechLanguagesName(IPortalComponentRequest request) {
		ILocaleListService localeService = (ILocaleListService) PortalRuntime
				.getRuntimeResources().getService(ILocaleListService.KEY);
		Locale globalLocale = request.getLocale();
		List allLocales = localeService
				.getListOfPersLocalesOrderedByDisplayName(globalLocale);
		List allLocaleTechNames = localeService
				.getTechnicalNamesForLocales(allLocales);

		return allLocaleTechNames;
	}

	private String getLocaleTechName(IPortalComponentRequest request) {
		ILocaleListService localeService = (ILocaleListService) PortalRuntime
				.getRuntimeResources().getService(ILocaleListService.KEY);
		Locale globalLocale = request.getLocale();

		return localeService.getLocaleTechnicalName(request.getLocale());
	}

	//get navigation target for the store link
	private String getNavigationTargetForSAPStoreURL(
			IPortalComponentRequest request, String SAPStoreUrl) {
		//construct the following url:
		//if SAP store - http://www.sapstore.com/sap/cpa/redirect?pcntry=<country>&sap-language=<language>&utm_source=SAP-Portal&utm_medium=In-Product-Promotion
		//if Enterprise store - http://<storeURL>?pcntry=<country>&sap-language=<language>&utm_source=SAP-Portal&utm_medium=In-Product-Promotion
		StringBuilder sb = new StringBuilder();
		sb.append("\"");
		sb.append(SAPStoreUrl);

		if (SAPStoreUrl.equals("http://www.sapstore.com")) {
			sb.append("/sap/cpa/redirect");
		}

		sb.append("?pcntry=");
		sb.append(request.getLocale().getCountry());
		sb.append("&sap-language=");
		sb.append(request.getLocale().getLanguage());
		sb.append("&utm_source=SAP-Portal&utm_medium=In-Product-Promotion\"");

		return sb.toString();
	}%>

<%
boolean isPreview = false;
// initializaing the labels with the localized labels
String welcomeClauseStr = getNLSString(componentRequest, WELCOME_CLAUSE);
String helpTextStr = getNLSString(componentRequest, HELP_TEXT);
String helpCenterTextStr = getNLSString(componentRequest, HELP_CENTER_TEXT);
String ByDhelpCenterTextStr = getNLSString(componentRequest, HELP_CENTER_BYD_TEXT);
String learningCenterTextStr = getNLSString(componentRequest, LEARNING_CENTER);
String bobTextStr = getNLSString(componentRequest, BOB_TEXT);
String logOffTextStr = getNLSString(componentRequest, LOG_OFF_TEXT);
String logInTextStr = getNLSString(componentRequest, LOG_ON_TEXT);
String personalizeTextStr = getNLSString(componentRequest, PERSONALIZE_TEXT);
String newWindowTextStr = getNLSString(componentRequest, NEW_WINDOW_TEXT);
String helpTooltipStr = getNLSString(componentRequest, HELP_TOOLTIP);
String logOffTooltipStr = getNLSString(componentRequest, LOG_OFF_TOOLTIP);
String logInTooltipStr = getNLSString(componentRequest, LOG_ON_TOOLTIP);
String personalizeTooltipStr = getNLSString(componentRequest, PERSONALIZE_TOOLTIP);
String personalizePortalTooltipStr = getNLSString(componentRequest, PERSONALIZE_PORATL_TOOLTIP);
String beginningOfPageStr = getNLSString(componentRequest, BEGINNING_OF_PAGE);
String newWindowStr = getNLSString(componentRequest, NEW_WINDOW_TOOLTIP);
String mastheadEnterTable = getNLSString(componentRequest, MASTHEAD_ENTER_TOOLTIP);
String mastheadExitTable = getNLSString(componentRequest, MASTHEAD_EXIT_TOOLTIP);
String unLoadMsg = getNLSString(componentRequest, UNLOAD_MSG);
String anonymousLanguageToolTip = getNLSString(componentRequest,ANONYMOUS_DDL_TOOLTIP);
String personalizePageMsg = getNLSString(componentRequest, PERSONALIZE_PAGE_MSG);
String personalizePortalMsg = getNLSString(componentRequest, PERSONALIZE_PORTAL_MSG);
String backToolTipStr = getNLSString(componentRequest, PORTAL_PLACE_BACK_TOOLTIP);
String backTextStr = getNLSString(componentRequest, PORTAL_PLACE_BACK_TEXT);
String SAPStoreURL = getSAPStoreUrl(componentRequest);
String SAPStoreLinkTitle = getSAPStoreLinkTitle(componentRequest);
boolean pcdReadOnly = isPortalInReadOnlyMode();
boolean showPersonalizeAsMenu = getParameter(componentRequest, SHOW_PERSONALIZE_CONTEXT_MENU);
boolean showPersonalizeLink = (getParameter(componentRequest, SHOW_PERSONALIZE_LINK) || showPersonalizeAsMenu)&&!pcdReadOnly;
boolean showHelpAsMenu = getParameter(componentRequest, SHOW_HELP_CONTEXT_MENU);
boolean showHelpCenterMenuEntry = getParameter(componentRequest, HELP_MENU_ENTRY_HELP_ENTER);
boolean showByDHelpCenterMenuEntry = getParameter(componentRequest, HELP_MENU_ENTRY_BYD_HELP_ENTER);
boolean showLearningCenterMenuEntry = getParameter(componentRequest, HELP_MENU_ENTRY_LEARNING_ENTER);
boolean showHelpLink = getParameter(componentRequest, SHOW_HELP_LINK);
boolean showNewWindowLink = getParameter(componentRequest, SHOW_NEW_WINDOW_LINK);
boolean showSAPStoreLink = getParameter(componentRequest, SHOW_SAP_STORE_LINK);
boolean ShowLogInLogOffLink = getParameter(componentRequest, SHOW_LOG_OFF_LOG_ON_LINK);
boolean ShowDDLAnonymousLanguage = getParameter(componentRequest, SHOW_ANONYMOUS_LANGUAGE);

//Portal Place properties values from server
boolean showPortalPlace = getParameter(componentRequest, SHOW_PORTAL_PLACE);
String portalPlaceTitle = getPortalPlaceTitle(componentRequest);

String mode = (String)componentRequest.getNode().getValue("mode");
if ((mode != null) && (mode.equals("preview")))
{
    isPreview = true;
}
	
String themeRootURLPath = GetThemeURLPath(componentRequest);
boolean isAnonymous = isAnonymous(componentRequest);
boolean isAccessabilityOn = isAccessabilityOn(componentRequest);
String personalizeHoverMenuId = null;

if (isAccessabilityOn)
{
	helpTooltipStr = helpTextStr+", "+helpTooltipStr;
	logOffTooltipStr = logOffTextStr+", "+logOffTooltipStr;
	logInTooltipStr = logInTextStr+", "+logInTooltipStr;
	newWindowStr = newWindowTextStr+", "+newWindowStr;
	personalizePortalTooltipStr = personalizeTextStr+", "+personalizePortalTooltipStr;
	backToolTipStr = backTextStr+", "+backToolTipStr;
}

%>
<script type="text/javascript">
function openLogoffMsg()
{
<%if (!isPreview){%>
    if (EPCM.getUAType() == EPCM.MSIE)
    {
    	if(EPCM.getGlobalDirty())
    	{
    		 // unsaved data on the page, display modified dialog
	        var val = window.showModalDialog('<%=GetLogoffConfirmUnsavedMsgURL(componentRequest)%>', '', '<%=LOGOFF_CONFIRM_MSG_ARGS_IE%>');
    	    if (val == 'logoff')
        	{
    	       	//TODO to check if it can be done in the logoff api
        	//	disableWorkProtectCheck = true;
        		
        		 
	        	performLogOff();
    	    }
		}
		else //no unsaved data
		{
			// data saved, nothing get lost on the page, display normal dialog
           var val = window.showModalDialog('<%=GetLogoffConfirmMsgURL(componentRequest)%>', '', '<%=LOGOFF_CONFIRM_MSG_ARGS_IE%>');
           if (val == 'logoff')
            performLogOff();
        }		
    }
    else
    {
		//In firefox and safary browsers we don't have showModalDialog method so we have to calculate the location 
		//of the logoff window to be in the middle of its' parent window.
		var windowFeatures = calcWindowFeatures('<%=LOGOFF_CONFIRM_MSG_HEIGHT%>', '<%=LOGOFF_CONFIRM_MSG_WIDTH%>');		
    	if(EPCM.getGlobalDirty())
    	{
		   window.open('<%=GetLogoffConfirmUnsavedMsgURL(componentRequest)%>',  '<%=LOGOFF_CONFIRM_WINDOW_NAME%>', windowFeatures);
		   	
        }
        else
        {
 		   window.open('<%=GetLogoffConfirmMsgURL(componentRequest)%>', '<%=LOGOFF_CONFIRM_WINDOW_NAME%>', windowFeatures);
		   	
        }
    }
<%}%>
}

function performLogOff(){
	LSAPI.getSessionPlugin().logoff();
}

function logIn()
{
    location.replace("<%=GetLoginURL(componentRequest)%>");
}

function runPersonalizePage()
{
    EPCM.raiseEvent("<%=PERSONALIZE_PAGE_EVENT_URN%>", "<%=PERSONALIZE_PAGE_EVENT_NAME%>", "<%=PERSONALIZE_PAGE_EVENT_PARAMS%>");
}

function runPersonalizePortal()
{
<%if (!isPreview){%>
    EPCM.raiseEvent("<%=PERSONALIZE_PORTAL_EVENT_URN%>", "<%=PERSONALIZE_PORTAL_EVENT_NAME%>", "<%=PERSONALIZE_PORTAL_EVENT_PARAMS%>");
<%}%>
}

function onPersonalizePortalDisable()
{
  <% if (!showPersonalizeAsMenu) {%>
	var linkElem = document.getElementById("personalizePortal");
	var linkSepElem = document.getElementById("personalizePortalSep");
	linkElem.style.display = "none";
	linkSepElem.style.display = "none";
  <%} else {%>
	var currItem = findMenuItemById(menu, "GlobalSettingsMenuItem");
	mf_PopupMenu_removeItem(menu, currItem);
    mf_PopupMenu_apply(menu);
  <%}%>
	
}

EPCM.subscribeEvent("urn:com.sapportals:navigation", "PersonalizePortalDisable", onPersonalizePortalDisable);

function openNewPortalWindow()
{
	<%if (!isPreview){%>
		var navTarget = top.gHistoryFrameworkObj.GetActiveTrackingEntryValue().URL;
		var context = top.gHistoryFrameworkObj.GetActiveTrackingEntryValue().context;
		if (context != null && context.length > 0)
    	   EPCM.doNavigate(navTarget, 2, null, null, null, null, context);
    	else  
  		   EPCM.doNavigate(navTarget, 2);
	<%}%>
}

function openHelp()
{
<%if (!isPreview){%>
    window.open('<%=getHelpUrl(componentRequest)%>', '<%=HELP_WINDOW_NAME%>');
<%}%>
}
function openHelpComponent()
{
	JSUtils.waitForObject("LSAPI", function() { 
		top.LSAPI.getHelpCenterPlugin().openHelpCenter(); 
	});
}

function backTarget()
{
    document.forms["backTargetForm"].submit()
}

function setFocusOnHeader() {
	var melcomeMessage = document.getElementById("welcome_message");
	var headerNotch    = document.getElementById("header_notch");
	if(EPCM.getUAType()==EPCM.MOZILLA) {
	   // No focus
	} else {
		if(melcomeMessage!=null && melcomeMessage.currentStyle.display!="none") {
			melcomeMessage.focus();
		} else if(headerNotch!=null && headerNotch.currentStyle.display!="none") {
			headerNotch.focus();
		}
	}
}

		



var personalizeOptionMenu = {
};

function createMenuItem(id, text, action){
  var item = mf_PopupMenu_createItem(id);
  item.Text = text;
  item.Enabled = true;
  item.CanCheck = false;
  item.Checked = false;
  item.HasIcon = false;
  item.HasSeparator = false;
  item.HasEllipsis = false;
  item.HasSubMenu = false;
  // HACK: uses sapPopupStore to hide the menu
  var fixedAction = "parent.sapPopupStore[0].onblur(); " + action;
  item.POPUPMENUITEMSELECT =  fixedAction;
  return item;
}

function findMenuItemById(menu, itemId) {
		var currItem;
		for (var i=0; i < menu.items.length; i++) {
			currItem = mf_PopupMenu_getItemByIdx(menu, i);
			if (currItem.Id == itemId) { 
				return currItem;
			}
		}
		return null;
}

//This method calculates the new window location to be in the middle of the parent window
//according to the location of the parent window on the screen.
function calcWindowFeatures(height, width) {
  var winFeatures = "height=" + height + ",innerHeight=" + height;
  winFeatures += ",width=" + width + ",innerWidth=" + width;
  if (window) {
  
    //Get the parent location: (X,Y) relative to the screen
	var parentWinY = window.screenY;
    var parentWinX = window.screenX;

	//Get the parent height and width
	var parentWinH = window.outerHeight;
    var parentWinW = window.outerWidth;

	//Calculate the new window location to be in the middle of the parent window
	//according to the location of the parent window on the screen
    var newWinY = parentWinY + parentWinH / 2 - height / 2;
    var newWinX = parentWinX + parentWinW / 2 - width / 2;

    winFeatures += ",left=" + newWinX + ",screenX=" + newWinX;
    winFeatures += ",top=" + newWinY + ",screenY=" + newWinY;
  }
  return winFeatures;
}

</script>


<hbj:content id="PageContext">
 <hbj:page title="Header Area">
 	<hbj:form id="HeaderForm" > 
  <!--<a href="#" tabindex=0 title= "<%=beginningOfPageStr%>" accesskey="m">
  <img src="<%=themeRootURLPath%>/../common/1x1.gif" border="0" style="display:none">
  </a>-->
	  <% if (isAccessabilityOn)
		 {%>
  	  		<TABLE DataTable=0 width="100%" border="0" id="myTable" ti="0" 
  	  			   tabindex="0" title="<%=mastheadEnterTable%>" 
  	  			   onkeydown="nav_skip('myTable',event)" 
  	  			   ct="PortalMasthead" cellspacing="0" cellpadding="0" class="prtlHdrWhl prtlFocus">
	  <%} else
	  {%>
	 	 <TABLE width="100%" border="0" cellspacing="0" ti="0" 
  	  			tabindex="0" onkeydown="nav_skip('myTable',event)" 
  	  			cellpadding="0" class="prtlHdrWhl  prtlFocus" id="myTable" >
	 <%}%>
 		<tbody>
			<TR>
	    		<TD class="prtlHeaderNotch" id="header_notch" nowrap>
	    		<!--  Cambiar la imagen por defecto por el logo de Vossloh
	    			<img src="<%=themeRootURLPath%>/../common/1x1.gif"  
	    				 class="prtlHeaderNotchImgWidth"></TD>-->
	    			<img src="<%=themeRootURLPath%>/img/logo.gif"  
	    				 class="prtlHeaderNotchImgWidth"></TD>
	    			
	    			<% if (showPortalPlace)
	 				{%>
	 				<!--	  
 						<TD nowrap ti="0" tabIndex="0" class="prtlHdrWelcome" id="welcome_message"><%=DeprecatedStringUtils.escapeToHTML(GetWelcomeMsg(componentRequest, welcomeClauseStr))%><BR><%=portalPlaceTitle%></TD>
 					<%} else	  
 					{%>	
						<TD nowrap ti="0" tabIndex="0" class="prtlHdrWelcome" id="welcome_message" title="<%=DeprecatedStringUtils.escapeToHTML(GetWelcomeMsg(componentRequest, welcomeClauseStr))%>">
							<%=DeprecatedStringUtils.escapeToHTML(GetWelcomeMsg(componentRequest, welcomeClauseStr))%>
						</TD>
					<%}%>
				
				<TD class="prtlHdrBrandImgContainer" ti="-1">&nbsp;<%=GetLicenseText(componentRequest)%>
				</TD>
			<% if(showHelpLink || showHelpAsMenu || showHelpCenterMenuEntry || showHelpCenterMenuEntry || showLearningCenterMenuEntry || 
						showPersonalizeLink || showNewWindowLink || ShowLogInLogOffLink || showPortalPlace || showSAPStoreLink || ( isAnonymous && ShowDDLAnonymousLanguage)) { %>
				<TD class="prtlHeaderFunctionsTable">
					<TABLE border="0" cellspacing="0" cellpadding="0" 
						   class="prtlHeaderFunctionsContainer" height="100%">
						<TR>
							<%
							if (showPortalPlace)
 							{%>
 								<TD nowrap >
 									<hbj:link id="BackLink" tooltip="<%=backToolTipStr%>" 
 									linkDesign="FUNCTION" reference="#">
                                    <% if (!isPreview) { BackLink.setOnClientClick("javascript:backTarget();");} %>
                                    <hbj:textView nested="true" text="<%=backTextStr%>"/></hbj:link>									
 								</TD>
 							<%}
							 if(!showHelpAsMenu)	
							 { 
								 if (showPortalPlace) {%>
							 		<TD nowrap id="helpPortalSep" class="prtlHdrSep"></TD>
							 	<%}%>
								<TD nowrap >
								<% if (showHelpLink){ %>
									<!-- old help -->
									<hbj:link id="HelpLink" tooltip="<%=helpTooltipStr%>" linkDesign="FUNCTION" reference="#">
                                      <% if (!isPreview) {
                                      	 HelpLink.setOnClientClick("javascript:openHelp();");
                                         } %>
                                      <hbj:textView nested="true" text="<%=helpTextStr%>"/></hbj:link>									
								<% } else if(showHelpCenterMenuEntry){ %>
									<!-- help center as link -->
									<hbj:link id="helpCenter" tooltip="<%=helpCenterTextStr%>" linkDesign="FUNCTION" reference="#">
                                      <% if (!isPreview) { helpCenter.setOnClientClick("top.openHelpComponent();");} %>
                                      <hbj:textView nested="true" text="<%=helpCenterTextStr%>"/></hbj:link>
								<%} else if(showByDHelpCenterMenuEntry){ %>
								<!-- ByD help center as link -->
									<hbj:link id="A1SSecondaryHelp" tooltip="<%=ByDhelpCenterTextStr%>" linkDesign="FUNCTION" reference="#">
                                      <% if (!isPreview) { A1SSecondaryHelp.setOnClientClick("parent.EPCM.raiseEvent('com.sap.portal.secondaryhelp.HelpPanelContainer', 'OpenHelpPanel', '');");} %>
                                      <hbj:textView nested="true" text="<%=helpCenterTextStr%>"/></hbj:link>
								<%} else if(showLearningCenterMenuEntry){ %>
								<!-- Learning center as link -->
									<hbj:link id="learningCenterHelp" tooltip="<%=learningCenterTextStr%>" linkDesign="FUNCTION" reference="#">
                                      <% if (!isPreview) { learningCenterHelp.setOnClientClick(getHelpMenuEntryEvent(componentRequest,HELP_MENU_ENTRY_EVENT_LEARNING_CENTER));} %>
                                      <hbj:textView nested="true" text="<%=learningCenterTextStr%>"/></hbj:link>
								<%}%> 
								</TD>
							<% }else { %>
							<!-- show help as menu -->
								<%if (showPortalPlace) {%>
							 		<TD nowrap id="helpPortalSep" class="prtlHdrSep"></TD>
							 	<%}%>
								<TD nowrap>
									<hbj:hoverMenu id="HelpLinkHoverMenu" standAlone="false">
									<%if ( showHelpLink) {%>
										<hbj:hoverMenuItem id="HelpLink" text="<%=helpTextStr%>" clientSideScript="top.openHelp();"/>
									<%} if (showHelpCenterMenuEntry){%>
		                            	<hbj:hoverMenuItem id="helpCenter" text="<%=helpCenterTextStr%>" clientSideScript="top.openHelpComponent();"/>
		                             <%} if(showByDHelpCenterMenuEntry){ %>
                                      <hbj:hoverMenuItem id="A1SSecondaryHelp"   text="<%=helpCenterTextStr%>"  clientSideScript="parent.EPCM.raiseEvent('com.sap.portal.secondaryhelp.HelpPanelContainer', 'OpenHelpPanel', '');"/>
                                     <%} if(showLearningCenterMenuEntry){ %>
                                      <hbj:hoverMenuItem id="learningCenterHelp" text="<%=learningCenterTextStr%>" clientSideScript="<%=getHelpMenuEntryEvent(componentRequest,HELP_MENU_ENTRY_EVENT_LEARNING_CENTER)%>"/>
                                      <%} %>
                                    </hbj:hoverMenu>
                                    <hbj:popupTrigger id="popupTrigger" menuId="HelpLinkHoverMenu">
                                      <hbj:textView id="HelpLink" text="<%=helpTextStr%>" tooltip="<%=helpTooltipStr%>"/>
                                    </hbj:popupTrigger>
                                </TD>
							<%}%>
							<TD nowrap></TD>
						<% if(!isAnonymous)	{
							if(showPersonalizeLink)	{ 
								if(showHelpLink || showPortalPlace || showHelpAsMenu || 
										showHelpCenterMenuEntry || showHelpCenterMenuEntry || showLearningCenterMenuEntry ) { %>
									<TD nowrap id="personalizePortalSep" class="prtlHdrSep"></TD>
							  <%} %>
							  <% if(!showPersonalizeAsMenu) { %>
  								   <!-- old personalize -->								  
							   	<TD nowrap id="personalizePortal">
							   		<hbj:link id="PersonalizeLink" 
							   			      tooltip="<%=personalizePortalTooltipStr%>"
							   			      linkDesign="FUNCTION"
							   			      reference="#">
							   			<% if(!isPreview) {
							   				PersonalizeLink.setOnClientClick("javascript:runPersonalizePortal();");
							   			   } %>
							   			<hbj:textView nested="true" text="<%=personalizeTextStr%>"/></hbj:link>
							   	</TD>
							   	<% } else { %>
  								   <!-- new personalize -->
                                   <TD nowrap id="personalizePortal">
                                      <hbj:hoverMenu id="personalizeHoverMenu" standAlone="false">
                                      <%     IPageContext htmlbPageContext = null; 
                                             htmlbPageContext = (IPageContext) pageContext.getAttribute("PageContext");
                                             personalizeHoverMenuId = htmlbPageContext.getParamIdForComponent(personalizeHoverMenu);
                                      %>
                                      </hbj:hoverMenu>
                                      <script>
	                                   var menuId = '<%=personalizeHoverMenuId%>';
	                                   var menu = mf_PopupMenu_getObj(menuId);
		                                   var item = createMenuItem("GlobalSettingsMenuItem","<%=personalizePortalMsg%>","parent.runPersonalizePortal();");
		                                   mf_PopupMenu_addItem(menu, item);		
                                   	   mf_PopupMenu_apply(menu);
                                      </script>
                                      <hbj:popupTrigger id="personalizeLinkPopupTrigger"
                                         menuId="personalizeHoverMenu">
                                        <hbj:textView id="personalizeLink" text="<%=personalizeTextStr%>" tooltip="<%=personalizePortalTooltipStr%>"/>
                                      </hbj:popupTrigger>
                                   </TD>
                                   
                                   <% } %>
							   	
								<TD nowrap></TD>
					    	<% }
					    	   if(showNewWindowLink) {	
								if (showHelpLink || showPersonalizeLink || showPortalPlace || 
											showHelpCenterMenuEntry || showHelpCenterMenuEntry || showLearningCenterMenuEntry ) { %>
                                   	<TD nowrap id="newWindowSep" class="prtlHdrSep">&nbsp;</TD>
							  <% } else {%>
									<TD nowrap>&nbsp;</TD>
							  <%}%>
							    <TD nowrap id="newWindow">
							    	<hbj:link id="newWindowLink" tooltip="<%=newWindowStr%>" 
							    	           linkDesign="FUNCTION" 
							    	           reference="#">
							    	<% if(!isPreview) {
							    		newWindowLink.setOnClientClick("javascript:openNewPortalWindow();");
							    	   } %>
							    	<hbj:textView nested="true" text="<%=newWindowTextStr%>"/></hbj:link>
							    </TD>
						 <%}

        	        	 } else {
        	        	  	if (ShowDDLAnonymousLanguage) 
        	        	  	{
        	        	  		if (showHelpLink || showPortalPlace || showHelpAsMenu || 
        	        	  				showHelpCenterMenuEntry || showHelpCenterMenuEntry || showLearningCenterMenuEntry )
													{ %>
														<TD nowrap id="portalLanguagesSep" class="prtlHdrSep"></TD>
								  			<%} %>
        	        	  	<TD nowrap id="portalLanguage"><hbj:dropdownListBox
																								           id="DDPortalLanguages"
																								           tooltip="<%=anonymousLanguageToolTip%>"
																								           selection="<%=getLocaleTechName(componentRequest)%>"
																								           onSelect="onSelect"
																								           >     
																								           <%
																								           	List displayNames = getDisplayLanguagesName(componentRequest);
																								           	List techNames = getTechLanguagesName(componentRequest);
																								           	Iterator iterDisplayNames = displayNames.iterator();
																								           	Iterator iterTechNames = techNames.iterator();
																								           	while (iterDisplayNames.hasNext() && iterTechNames.hasNext())
																								           	{%>
																								           		<hbj:listBoxItem key="<%=(String)iterTechNames.next()%>" value="<%=(String)iterDisplayNames.next()%>"/>
																								           	<%}%>         
             																				 </hbj:dropdownListBox></TD>
        	        	  <%}}
        	        	  if (showSAPStoreLink)
					    	   {
									if (showHelpLink || showPersonalizeLink || showPortalPlace || 
											showHelpCenterMenuEntry || showHelpCenterMenuEntry || showLearningCenterMenuEntry || showNewWindowLink ) 
											{%>
												<TD nowrap id="sapStoreLinkSep" class="prtlHdrSep">&nbsp;</TD>
											<%}
									else
									{%>
										<TD nowrap>&nbsp;</TD>
									<%}%>
									<TD nowrap id="SAPStoreLinkTD">
									<hbj:link id="SAPStoreLink" tooltip="<%=SAPStoreLinkTitle%>" 
							    	           linkDesign="FUNCTION" 
							    	           reference="#">
										<% if(!isPreview) 
							    		{
							    			SAPStoreLink.setOnClientClick("javascript: window.open(" + getNavigationTargetForSAPStoreURL(componentRequest, SAPStoreURL) + ");");
							    		}%>
							    	<hbj:textView nested="true" text="<%=SAPStoreLinkTitle%>"/></hbj:link>
									</TD>
					    	   <%}%>
            	            <TD>
                	        <% if(ShowLogInLogOffLink) { %>
								<TABLE cellspacing="0" cellpadding="0" border="0" class="prtlHeaderFunctionsContainer" height="100%">
									<TR>
										<% if (showHelpLink || showPersonalizeLink || showNewWindowLink || showPortalPlace || ( isAnonymous && ShowDDLAnonymousLanguage) ) { %>
											<TD nowrap class="prtlHdrSep">&nbsp;</TD>
										<% }else { %>
									    	<TD nowrap >&nbsp;&nbsp;</TD>
									    <% }
    									   if(isAnonymous) { %>
    										<TD nowrap>
											<!--<hbj:link id="LoginLink" tooltip="<%=logInTooltipStr%>" linkDesign="FUNCTION" reference="javascript:logIn();"><hbj:textView nested="true" text="<%=logInTextStr%>"/></hbj:link>-->
    										<hbj:link id="LoginLink" 
    												  tooltip="<%=logInTooltipStr%>"
    											      linkDesign="FUNCTION" 
    											      reference="#">
                                                  <% LoginLink.setOnClientClick("javascript:logIn();"); %>
                                                  <hbj:textView nested="true" text="<%=logInTextStr%>"/></hbj:link>
    										</TD>
	    							  <% } else { %>
    										<TD nowrap>
    										<!--<hbj:link id="LogoffLink" tooltip="<%=logOffTooltipStr%>" linkDesign="FUNCTION" reference="javascript:openLogoffMsg();"><hbj:textView nested="true" text="<%=logOffTextStr%>"/></hbj:link>-->
    										 <hbj:link id="LogoffLink"
    										 	       tooltip="<%=logOffTooltipStr%>" 
    										 	       linkDesign="FUNCTION"
    										 	       reference="#">
                                                  <% if(!isPreview) {
                                                  	   LogoffLink.setOnClientClick("javascript:openLogoffMsg();");
                                                  	 } %>
                                                  <hbj:textView nested="true" text="<%=logOffTextStr%>"/></hbj:link>
    										</TD>	    							  	
    								   <%}%>
									</TR>
								</TABLE>
							<%} %>
						</TD>
					</TR>
				</TABLE>
			</TD>
			<%}%>
  		    <TD nowrap class="prtlHdrLogoContainer">&nbsp;
  		    	<% if (isAccessabilityOn) { %>
  		    		<span tabindex="0" id="myTable-skipend" ti="0" onkeydown="sapUrMapi_skip('myTable',event);" title="<%=mastheadExitTable%>" ></span>
  		    	<% } else
				  {%>
				 	 <span tabindex="0" id="myTable-skipend" ti="0" onkeydown="sapUrMapi_skip('myTable',event);" ></span>
				 <%}%>
  		    </TD>
		</TR>
		</tbody>
	</TABLE>
	</hbj:form>
 </hbj:page>
</hbj:content>


 <form name="backTargetForm" style="display:none;position:absolute;top:-5000;left:-5000" action="<%=GetBackTargetURLComponent(componentRequest)%>" method="POST">
 	<input type="hidden" name="backTarget_submit" value="true"></input>
 </form>
 
<script>
 <% if (!isPreview) {%>
 		if (disablePersonalize) {
			EPCM.raiseEvent("urn:com.sapportals:navigation", "PersonalizePortalDisable", "");
 		}
  <%}%>
setFocusOnHeader();
EPCM.subscribeEvent("urn:com.sapportals.portal:browser","load",setFocusOnHeader);
var showPersonalize = <% if(showPersonalizeAsMenu){%> true;<%} else{ %>false;<%}%>
personalizeOptionMenu.buildOptionMenu = function(ev)
{
	try
	{
		var menuId = '<%=personalizeHoverMenuId%>';
		if (menuId == null)
		  return;
		var menu = mf_PopupMenu_getObj(menuId);
		//removing all current elements
		var len = menu.items.length;
		for(var i = 0 ; i < len ; i++){
			var currItem = mf_PopupMenu_getItemByIdx(menu, 0);
			mf_PopupMenu_removeItem(menu, currItem);
		}
		if(typeof(ev.dataObject) == "string")
		{
			var arr = ev.dataObject.split("%%");
			var dataObject = new Object();
			dataObject.expand = eval(arr[0]);
			dataObject.refresh = eval(arr[1]);
			dataObject.personalize = eval(arr[2]);
			dataObject.help = eval(arr[3]);
			dataObject.details = eval(arr[4]);
			dataObject.print = eval(arr[5]);
			dataObject.favorites = eval(arr[6]);
			dataObject.title = arr[7];
		}
		else
		{
			var dataObject = ev.dataObject;
		}
        <% if (!isPreview) {%>		
  		  if (!disablePersonalize){
		    var item = createMenuItem("GlobalSettingsMenuItem","<%=personalizePortalMsg%>","parent.runPersonalizePortal();");
 		    mf_PopupMenu_addItem(menu, item);		
  		  }
  		<%}%>

		if(dataObject.personalize) {
		  var item = createMenuItem("ThisPageMenuItem","<%=personalizePageMsg%>","parent.EPCM.raiseEvent('urn:com.sapportals:navigation','PersonalizeWorkArea','');");
 		  mf_PopupMenu_addItem(menu, item);		
		}
		if(dataObject.help)
		{
		  var item = createMenuItem("HelpMenuItem","<%=helpTextStr%>","parent.EPCM.raiseEvent('urn:com.sapportals:navigation','HelpWorkArea','');");
 		  mf_PopupMenu_addItem(menu, item);		
		}
		mf_PopupMenu_apply(menu);	
	}	
	catch(e){
	}
} 
personalizeOptionMenu.addOptionMenu = function(ev)
{
	if (!showPersonalize){
		return;
	}
	var str = ev.dataObject;
	var arr = str.split("%%");
	var title = arr[0];
	var id = arr[1];
	var parameter = arr[1];
	var raiseStr = "parent.EPCM.raiseEvent(\"com.sap.portal.navigation\" , \"PageOptionClicked\" , \" " + parameter + "\")";
	var menuId = '<%=personalizeHoverMenuId%>';
	var menu = mf_PopupMenu_getObj(menuId);
    var item = createMenuItem(id,title,raiseStr);
	mf_PopupMenu_addItem(menu, item);		
	mf_PopupMenu_apply(menu);
}

personalizeOptionMenu.removeOptionMenu = function(ev)
{
	var id = ev.dataObject;

	var menuId = '<%=personalizeHoverMenuId%>';
	var menu = mf_PopupMenu_getObj(menuId);
	
	var currItem = findMenuItemById(menu, id);
	mf_PopupMenu_removeItem(menu, currItem);
    mf_PopupMenu_apply(menu);
}

 <% if(showPersonalizeAsMenu) { %>
EPCM.subscribeEvent('urn:com.sapportals:navigation' , 'setOptionMenu' , personalizeOptionMenu.buildOptionMenu);
EPCM.subscribeEvent('urn:com.sapportals:navigation' , 'addPageOptionMenu'  , personalizeOptionMenu.addOptionMenu);
EPCM.subscribeEvent('urn:com.sapportals:navigation' , 'deletePageOptionMenu'  , personalizeOptionMenu.removeOptionMenu);
<%}%>

</script>
