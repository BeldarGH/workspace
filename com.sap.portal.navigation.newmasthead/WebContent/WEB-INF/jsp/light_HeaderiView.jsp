<%@ page session="false" %>
<%@ page import = "java.util.ResourceBundle" %>
<%@ page import = "java.util.Locale" %>
<%@ page import = "com.sapportals.htmlb.*" %>
<%@ page import = "com.sapportals.portal.prt.session.IUserContext" %>
<%@ page import = "com.sapportals.portal.prt.component.*" %>
<%@ page import = "com.sapportals.portal.prt.service.laf.*" %>
<%@ page import = "com.sap.security.api.UMFactory" %>
<%@ page import = "com.sapportals.portal.prt.service.license.ILicenseService"%>
<%@ page import = "com.sapportals.admin.wizardframework.util.ILocaleListService"%>

<%@ page import = "com.sap.portal.core.utils.ILocalesListService"%>

<%@ page import = "com.sapportals.portal.navigation.*" %>
<%@ page import = "com.sapportals.portal.prt.runtime.PortalRuntime" %>
<%@ page import = "com.sapportals.portal.prt.util.DeprecatedStringUtils" %>
<%@ taglib uri="prt:taglib:tlframework" prefix="frm" %>
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
	final String LOGOFF_CONFIRM_MSG_ARGS_NS = "Height=170,Width=350";
	final String LOGOFF_CONFIRM_WINDOW_NAME = "LOG_OFF_WINDOW";
	final String HELP_URL = "HelpUrl";
	final String SAP_STORE_URL = "SAPStoreURL";
	final String SAP_STORE_LINK_TITLE = "SAPStoreURLTitle";
	final String SHOW_SAP_STORE_LINK = "ShowSAPStoreLink";
	final String HELP_WINDOW_NAME = "HELP_WINODW";
	final String SHOW_PERSONALIZE_LINK = "ShowPersonalizeLink";
	final String SHOW_HELP_LINK = "ShowHelpLink";
	final String SHOW_NEW_WINDOW_LINK = "ShowNewWindowLink";
	final String SHOW_LOG_OFF_LOG_ON_LINK = "ShowLogInLogOffLink";
	final String SHOW_ANONYMOUS_LANGUAGE = "ShowAnonymousLanguage";
	final String SHOW_PORTAL_PLACE = "ShowPortalPlace";
	final String PORTAL_PLACE_TITLE = "PortalPlaceTitle";
	final String PORTAL_PLACE_BACK = "PortalPlaceBack";
	final String BACK_TARGET_REDIRECT_COMPONENT = "BackTargetComponent";

	//String constants for NLS
	final String WELCOME_CLAUSE = "WELCOME_CLAUSE";
	final String HELP_TEXT = "HELP_TEXT";
	final String LOG_OFF_TEXT = "LOG_OFF_TEXT";
	final String LOG_ON_TEXT = "LOG_ON_TEXT";
	final String PERSONALIZE_TEXT = "PERSONALIZE_TEXT";
	final String PERSONALIZE_PORTAL_TEXT = "PERSONALIZE_PORTAL_TEXT";
	final String NEW_WINDOW_TEXT = "NEW_WINDOW_TEXT";

	final String HELP_TOOLTIP = "HELP_TOOLTIP";
	final String LOG_OFF_TOOLTIP = "LOG_OFF_TOOLTIP";
	final String LOG_ON_TOOLTIP = "LOG_ON_TOOLTIP";
	final String PERSONALIZE_TOOLTIP = "PERSONALIZE_TEXT";
	final String PERSONALIZE_PORATL_TOOLTIP = "PERSONALIZE_PORATL_TOOLTIP";
	final String NEW_WINDOW_TOOLTIP = "NEW_WINDOW_TOOLTIP";
	final String BEGINNING_OF_PAGE = "BEGINNING_OF_PAGE";
	final String MASTHEAD_ENTER_TOOLTIP = "MASTHEAD_ENTER_TOOLTIP";
	final String MASTHEAD_EXIT_TOOLTIP = "MASTHEAD_EXIT_TOOLTIP";
	final String PORTAL_PLACE_BACK_TOOLTIP = "PORTAL_PLACE_BACK_TOOLTIP";
	final String PORTAL_PLACE_BACK_TEXT = "PORTAL_PLACE_BACK_TEXT";

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
			} else if ((firstName == null) && (salutation != null)) {
				return java.text.MessageFormat.format(welcomeClause,
						new Object[] { " ", lastName, salutation }).toString();
			} else {
				return java.text.MessageFormat.format(welcomeClause,
						new Object[] { userContext.getUniqueName(), " ", " " })
						.toString();
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

	private String getPortalPlaceTitle(IPortalComponentRequest request) {
		String value = (String) request.getNode().getValue(PORTAL_PLACE_TITLE);
		return value;
	}

	private String getPortalPlaceBackTarget(IPortalComponentRequest request) {
		String value = (String) request.getNode().getValue(PORTAL_PLACE_BACK);
		return value;
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

	private String GetLogoffConfirmMsgURL(IPortalComponentRequest request) {
		String componentName = request.getComponentContext().getComponentName();
		componentName = componentName.substring(0, componentName
				.lastIndexOf(".") + 1);

		IPortalComponentURI msgURI = request.createPortalComponentURI();
		msgURI.setContextName(componentName + LOGOFF_CONFIRM_MSG_COMPONENT);
		return msgURI.toString();
	}

	private String GetLogoffURL(IPortalComponentRequest request) {
		String logoffURLComponent = null;
		NavigationEventsHelperService helperService = (NavigationEventsHelperService) PortalRuntime
				.getRuntimeResources().getService(
						NavigationEventsHelperService.KEY);
		if (helperService != null) {
			logoffURLComponent = helperService.getLogoffURLComponent();
		}
		return logoffURLComponent;
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
				+ "/" + currentTheme + "/prtl";
		return url;
	}

	//Get the external logoff URL
	private String getExternalLogOffUrl() {

		return UMFactory.getProperties().getDynamic("ume.logoff.redirect.url",
				null);
	}

	//Get the external logoff Mode (silent / not silent)
	private boolean getExternalLogOffMode() {
		String strSilent = UMFactory.getProperties().getDynamic(
				"ume.logoff.redirect.silent", Boolean.FALSE.toString());
		return Boolean.parseBoolean(strSilent);
	}

	private boolean isAnonymous(IPortalComponentRequest request) {
		NavigationEventsHelperService helperService = (NavigationEventsHelperService) PortalRuntime
				.getRuntimeResources().getService(
						NavigationEventsHelperService.KEY);
		return helperService.isAnonymousUser(request);
	}

	private List getDisplayLanguagesName(IPortalComponentRequest request) {
		ILocalesListService localesService = (ILocalesListService) PortalRuntime
				.getRuntimeResources().getService(ILocalesListService.KEY);
		Locale globalLocale = request.getLocale();
		List allLocales = localesService
				.getListOfLocalesOrderedByDisplayName(globalLocale);

		//		ILocaleListService localeService = (ILocaleListService)PortalRuntime.getRuntimeResources().getService(ILocaleListService.KEY);
		//		Locale globalLocale = request.getLocale();
		//		List allLocales = localeService.getListOfPersLocalesOrderedByDisplayName(globalLocale);

		List allLocaleDisplayNames = localesService.getDisplayNamesForLocales(
				allLocales, globalLocale);

		return allLocaleDisplayNames;
	}

	private List getTechLanguagesName(IPortalComponentRequest request) {
		ILocalesListService localesService = (ILocalesListService) PortalRuntime
				.getRuntimeResources().getService(ILocalesListService.KEY);
		Locale globalLocale = request.getLocale();
		List allLocales = localesService
				.getListOfLocalesOrderedByDisplayName(globalLocale);

		//		ILocaleListService localeService = (ILocaleListService)PortalRuntime.getRuntimeResources().getService(ILocaleListService.KEY);
		//		Locale globalLocale = request.getLocale();
		//		List allLocales = localeService.getListOfPersLocalesOrderedByDisplayName(globalLocale);

		List allLocaleTechNames = localesService
				.getTechnicalNamesForLocales(allLocales);

		return allLocaleTechNames;
	}

	private String getLocaleTechName(IPortalComponentRequest request) {
		ILocaleListService localeService = (ILocaleListService) PortalRuntime
				.getRuntimeResources().getService(ILocaleListService.KEY);
		Locale globalLocale = request.getLocale();

		return localeService.getLocaleTechnicalName(request.getLocale());
	}

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
	String welcomeClauseStr = getNLSString(componentRequest,
			WELCOME_CLAUSE);
	String helpTextStr = getNLSString(componentRequest, HELP_TEXT);
	String logOffTextStr = getNLSString(componentRequest, LOG_OFF_TEXT);
	String logInTextStr = getNLSString(componentRequest, LOG_ON_TEXT);
	String personalizeTextStr = getNLSString(componentRequest,
			PERSONALIZE_TEXT);
	String newWindowTextStr = getNLSString(componentRequest,
			NEW_WINDOW_TEXT);
	String helpTooltipStr = getNLSString(componentRequest, HELP_TOOLTIP);
	String logOffTooltipStr = getNLSString(componentRequest,
			LOG_OFF_TOOLTIP);
	String logInTooltipStr = getNLSString(componentRequest,
			LOG_ON_TOOLTIP);
	String personalizeTooltipStr = getNLSString(componentRequest,
			PERSONALIZE_TOOLTIP);
	String personalizePortalTooltipStr = getNLSString(componentRequest,
			PERSONALIZE_PORATL_TOOLTIP);
	String beginningOfPageStr = getNLSString(componentRequest,
			BEGINNING_OF_PAGE);
	String newWindowStr = getNLSString(componentRequest,
			NEW_WINDOW_TOOLTIP);
	String mastheadEnterTable = getNLSString(componentRequest,
			MASTHEAD_ENTER_TOOLTIP);
	String mastheadExitTable = getNLSString(componentRequest,
			MASTHEAD_EXIT_TOOLTIP);
	String backToolTipStr = getNLSString(componentRequest,
			PORTAL_PLACE_BACK_TOOLTIP);
	String backTextStr = getNLSString(componentRequest,
			PORTAL_PLACE_BACK_TEXT);

	boolean showPersonalizeLink = getParameter(componentRequest,
			SHOW_PERSONALIZE_LINK);
	boolean showHelpLink = getParameter(componentRequest,
			SHOW_HELP_LINK);
	boolean showNewWindowLink = getParameter(componentRequest,
			SHOW_NEW_WINDOW_LINK);
	boolean ShowLogInLogOffLink = getParameter(componentRequest,
			SHOW_LOG_OFF_LOG_ON_LINK);
	boolean ShowDDLAnonymousLanguage = getParameter(componentRequest,
			SHOW_ANONYMOUS_LANGUAGE);

	String SAPStoreURL = getSAPStoreUrl(componentRequest);
	String SAPStoreLinkTitle = getSAPStoreLinkTitle(componentRequest);
	boolean showSAPStoreLink = getParameter(componentRequest,
			SHOW_SAP_STORE_LINK);

	//Portal Place properties values from server
	boolean showPortalPlace = getParameter(componentRequest,
			SHOW_PORTAL_PLACE);
	String portalPlaceTitle = getPortalPlaceTitle(componentRequest);

	String mode = (String) componentRequest.getNode().getValue("mode");
	if ((mode != null) && (mode.equals("preview"))) {
		isPreview = true;
	}

	String themeRootURLPath = GetThemeURLPath(componentRequest);
	boolean isAnonymous = isAnonymous(componentRequest);
	boolean isAccessabilityOn = isAccessabilityOn(componentRequest);

	if (isAccessabilityOn) {
		helpTooltipStr = helpTextStr + ", " + helpTooltipStr;
		logOffTooltipStr = logOffTextStr + ", " + logOffTooltipStr;
		logInTooltipStr = logInTextStr + ", " + logInTooltipStr;
		newWindowStr = newWindowTextStr + ", " + newWindowStr;
		personalizePortalTooltipStr = personalizeTextStr + ", "
				+ personalizePortalTooltipStr;
		backToolTipStr = backTextStr + ", " + backToolTipStr;
	}
%>
<script>
function openLogoffMsg()
{
<%if (!isPreview) {%>
        if (navigator.appName == "Microsoft Internet Explorer")
        {
        	var val = window.showModalDialog('<%=GetLogoffConfirmMsgURL(componentRequest)%>', '', '<%=LOGOFF_CONFIRM_MSG_ARGS_IE%>');
        	if (val == 'logoff')
           		logoff();
        }
        else
        {
	        window.open('<%=GetLogoffConfirmMsgURL(componentRequest)%>', '<%=LOGOFF_CONFIRM_WINDOW_NAME%>', '<%=LOGOFF_CONFIRM_MSG_ARGS_NS%>');
	    }

<%}%>
}

var isLogoffFinalAllowed = true;
var logoffStartTime = (new Date).getTime();

function logoff()
{
    logoffStartTime = (new Date).getTime(); 
    //session termination
    if (self.EPCM)
    {
    	 EPCM.raiseEvent("urn:com.sapportals.portal:user", "logoff", ""); 
    }
    window.setTimeout("logoffDelay()", "50");
}

function logoffDelay()
{
	var isLogoffDelayElapsed = ((new Date).getTime() - logoffStartTime) > (60*1000);
	if(isLogoffFinalAllowed || isLogoffDelayElapsed) 
	{
		if (typeof(CloseAllObj) !== 'undefined' && CloseAllObj !== null) 
		{
			CloseAllObj.logoutFromThisWindow = true;
			CloseAllObj.setFlagValue(CloseAllObj.OUT);
		}
		logoffFinalCall();
	}
	else 
	{
		window.setTimeout("logoffDelay()","50"); 
	}
}

function logoffFinalCall()
{
    logoffThirdParty();
    document.forms["logoffForm"].submit();
}

function logIn()
{
    location.replace("<%=GetLoginURL(componentRequest)%>");
}

function runPersonalizePage()
{
}

function runPersonalizePortal()
{
<%if (!isPreview) {%>
	if (!disablePersonalize)
	{
		onPersonalizePortal();
	}
<%}%>
}

function onPersonalizePortalDisable()
{
	var linkElem = document.getElementById("personalizePortal");
	var linkSepElem = document.getElementById("personalizePortalSep");
	var linkLogoffSepElem = document.getElementById("logoffsep1");	
	
	if(linkElem != null)
		linkElem.style.display = "none";
	if(linkSepElem != null)
		linkSepElem.style.display = "none";
	if(linkLogoffSepElem != null)
		linkLogoffSepElem.style.display = "none";
	
}



function openNewPortalWindow()
{
	<%if (!isPreview) {%>
		if (typeof EPCM != "undefined")
		{
			var navTarget = top.gHistoryFrameworkObj.GetActiveTrackingEntryValue().URL;
			EPCM.doNavigate(navTarget, 2);
		}
		else
		{
			window.open(window.location);
		}
	<%}%>
}

function openHelp()
{
<%if (!isPreview) {%>
    window.open('<%=getHelpUrl(componentRequest)%>', '<%=HELP_WINDOW_NAME%>');
<%}%>
}

function openStoreLink()
{
<%if (!isPreview) {%>
    window.open(<%=getNavigationTargetForSAPStoreURL(componentRequest,
						SAPStoreURL)%>);
<%}%>
}

function backTarget()
{
		document.forms["backTargetForm"].submit()
}

function setFocusOnHeader()
{
	if (document.getElementById("welcome_message").currentStyle.display != "none")
		document.getElementById("welcome_message").focus();
	else if (document.getElementById("header_notch").currentStyle.display != "none")
		document.getElementById("header_notch").focus();
}

		

function logoffThirdParty()
{
	<%String externalUrl = getExternalLogOffUrl();
			if (externalUrl != null) {%> 
		var logOffUrl = '<%=externalUrl%>';
		var silent =  <%=getExternalLogOffMode()%>;
	   
		if(silent)
		{
			var newIFrame = document.getElementById("externalLogOffIframe");
			if(newIFrame == null)
			{
				 newIFrame = document.createElement("IFRAME");
				 newIFrame.style.visibility = "hidden";
				 newIFrame.width=0;
				 newIFrame.height=0;
				 newIFrame.id = "externalLogOffIframe";
				 newIFrame.src = logOffUrl;
				 document.body.appendChild(newIFrame);
			}
			else
			{
				newIFrame.src = "about:blank";
				newIFrame.src = logOffUrl;
			}
		}
	<%}%>
}

function languageChange()
{
	var sel = document.getElementById("DDPortalLanguages");
	location.replace("<%=GetPortalUrl(componentRequest)%>?lang="+sel.options[sel.selectedIndex].value);
}

</script>

  <!--<a href="#" tabindex=0 title= "<%=beginningOfPageStr%>" accesskey="m">
  <img src="<%=themeRootURLPath%>/../common/1x1.gif" border="0" style="display:none">
  </a>-->
  <%
  	if (isAccessabilityOn) {
  %>
  	  <TABLE width="100%" border="0" id="myTable" ti="0" tabindex="0" title="<%=mastheadEnterTable%>" onkeydown="sapUrMapi_skip('myTable',event)" ct="PortalMasthead" cellspacing="0" cellpadding="0" class="urGrpWhlWeb1 urScrl">
  <%
  	} else {
  %>
	  <TABLE width="100%" border="0" cellspacing="0" cellpadding="0" class="prtlHdrWhl" id="myTable">
 <%
 	}
 %>
 	<tbody>
		<TR>
	    <TD class="prtlHeaderNotch" id="header_notch" nowrap><img src="<%=themeRootURLPath%>/../common/1x1.gif" class="prtlHeaderNotchImgWidth"></TD>
	    <%
	    	if (showPortalPlace) {
	    %>
					<TD nowrap ti="0" tabIndex="0" class="prtlHdrWelcome" id="welcome_message"><%=DeprecatedStringUtils.escapeToHTML(GetWelcomeMsg(
						componentRequest, welcomeClauseStr))%><BR><%=portalPlaceTitle%></TD>
		<%
			} else {
		%>  					
					<TD nowrap class="prtlHdrWelcome" ti="0" tabIndex="0" id="welcome_message"><%=DeprecatedStringUtils.escapeToHTML(GetWelcomeMsg(
						componentRequest, welcomeClauseStr))%></TD>
		<%
			}
		%>
			<TD class="prtlHdrBrandImgContainer" ti="-1">&nbsp;<%=GetLicenseText(componentRequest)%></TD>
			<%
				if (showHelpLink || showPersonalizeLink || showNewWindowLink
						|| ShowLogInLogOffLink || showPortalPlace
						|| showSAPStoreLink
						|| (isAnonymous && ShowDDLAnonymousLanguage)) {
			%>
				<TD class="prtlHeaderFunctionsTable">
					<TABLE border="0" cellspacing="0" cellpadding="0" class="prtlHeaderFunctionsContainer" height="100%">
						<TR>
							<%
								if (showPortalPlace) {
							%>
								<TD nowrap><frm:portalBackTargetAnchor><%=backTextStr%></frm:portalBackTargetAnchor></TD>
							<%
								}
									if (showHelpLink) {
										if (showPortalPlace) {
							%>
									<TD nowrap id="helpPortalSep" class="prtlHdrSep"></TD>
							<%
								}
							%>
								<TD nowrap><frm:portalHelpAnchor><%=helpTextStr%></frm:portalHelpAnchor></TD>
								<TD nowrap>
							<%
								}
							%>
							<%
								if (!isAnonymous) {
										if (showPersonalizeLink) {
											if (showHelpLink || showPortalPlace) {
							%>
										<TD nowrap id="personalizePortalSep" class="prtlHdrSep"></TD>
									<%
										}
									%>
								   	<TD nowrap id="personalizePortal"><frm:personalizePortalAnchor><%=personalizeTextStr%></frm:personalizePortalAnchor></TD>
									<TD nowrap></TD>
						    	<%
						    		}
						    				if (showNewWindowLink) {
						    					if (showHelpLink || showPersonalizeLink
						    							|| showPortalPlace) {
						    	%>
								    	<TD nowrap id="newWindowSep" class="prtlHdrSep">&nbsp;</TD>
									<%
										} else {
									%>
										<TD nowrap>&nbsp;</TD>
									<%
										}
									%>
									
							    	<TD nowrap id="newWindow"><frm:newSessionAnchor><%=newWindowTextStr%></frm:newSessionAnchor></TD>
							 	<%
							 		}
							 			} else {
							 				if (ShowDDLAnonymousLanguage) {
							 					if (showHelpLink || showPortalPlace) {
							 	%>
														<TD nowrap id="portalLanguagesSep" class="prtlHdrSep"></TD>
								  			<%
								  				}
								  			%>
        	        	  	<TD nowrap id="portalLanguage"><SELECT ID="DDPortalLanguages"
        	        	  																			onChange="languageChange()">
																								           <%
																								           	List displayNames = getDisplayLanguagesName(componentRequest);
																								           				List techNames = getTechLanguagesName(componentRequest);
																								           				Iterator iterDisplayNames = displayNames.iterator();
																								           				Iterator iterTechNames = techNames.iterator();
																								           				String defaultLocale = getLocaleTechName(componentRequest);
																								           				while (iterDisplayNames.hasNext()
																								           						&& iterTechNames.hasNext()) {
																								           					String localTechName = (String) iterTechNames
																								           							.next();
																								           					if (!localTechName.equals(defaultLocale)) {
																								           %>
																								           			<OPTION VALUE="<%=localTechName%>"><%=(String) iterDisplayNames.next()%></OPTION>
																								           		<%
																								           			} else {
																								           		%>
																								           			<OPTION VALUE="<%=localTechName%>"selected><%=(String) iterDisplayNames.next()%></OPTION>
																								           	<%
																								           		}
																								           	%>	
																								          <%
																									          	}
																									          %>         
             																				 </SELECT></TD>
        	        	  <%
        	        	  	}
        	        	  		}
        	        	  		if (showSAPStoreLink) {
        	        	  			if (showHelpLink || showPersonalizeLink || showPortalPlace
        	        	  					|| showNewWindowLink) {
        	        	  %>
								    	<TD nowrap id="SAPStoreLinkSep" class="prtlHdrSep">&nbsp;</TD>
									<%
										} else {
									%>
										<TD nowrap>&nbsp;</TD>
									<%
										}
									%>
									
							    	<TD nowrap id="SAPStoreLinkTD"><frm:portalStoreAnchor><%=SAPStoreLinkTitle%></frm:portalStoreAnchor></TD>
							 	<%
							 		}
							 	%>
            	            <TD>
                	        <%
                	        	if (ShowLogInLogOffLink) {
                	        %>
								<TABLE cellspacing="0" cellpadding="0" border="0" class="prtlHeaderFunctionsContainer" height="100%">
									<TR><%
										if (showHelpLink || showPersonalizeLink
														|| showNewWindowLink || showPortalPlace
														|| (isAnonymous && ShowDDLAnonymousLanguage)) {
									%>
									    	<%
									    		if (!showHelpLink && !showNewWindowLink) {
									    	%>
												<TD nowrap id="logoffsep1" class="prtlHdrSep">&nbsp;</TD>
											<%
												} else {
											%>
									    		<TD nowrap id="logoffsep2" class="prtlHdrSep">&nbsp;</TD>
									    	<%
									    		}
									    	%>
									    	
											<TD nowrap>
										<%
											} else {
										%>
									    	<TD nowrap >&nbsp;&nbsp;</TD>
									    <%
									    	}
									    			if (isAnonymous) {
									    %>
    										<TD nowrap><frm:logInAnchor><%=logInTextStr%></frm:logInAnchor></TD>
											</TD>
	    							  <%
	    							  	} else {
	    							  %>
    										<TD nowrap><frm:logOffAnchor><%=logOffTextStr%></frm:logOffAnchor></TD>	    							  	
    								  <%
	    							  	    								  	}
	    							  	    								  %>
									</TR>
								</TABLE>
							<%
								}
							%>
						</TD>
					</TR>
				</TABLE>
			</TD>
			<%
				}
			%>
  		    <TD nowrap class="prtlHdrLogoContainer">&nbsp;
  		    	<%
  		    		if (isAccessabilityOn) {
  		    	%>
  		    		<span tabindex="0" id="myTable-skipend" ti="0" onkeydown="sapUrMapi_skip('myTable',event);" title="<%=mastheadExitTable%>" ></span>
  		    	<%
  		    		}
  		    	%>
  		    </TD>
		</TR>
		</tbody>
	</TABLE>

<form name="logoffForm" style="display:none;position:absolute;top:-5000;left:-5000" action="<%=GetLogoffURL(componentRequest)%>" method="POST">
	<input type="hidden" name="logout_submit" value="true"></input>
</form>

<form name="backTargetForm" style="display:none;position:absolute;top:-5000;left:-5000" action="<%=GetBackTargetURLComponent(componentRequest)%>" method="POST">
	<input type="hidden" name="backTarget_submit" value="true"></input>
</form>

<script>
 <%if (!isPreview) {%>
 		if (disablePersonalize) {
			onPersonalizePortalDisable();
 		}
  <%}%>
</script>
