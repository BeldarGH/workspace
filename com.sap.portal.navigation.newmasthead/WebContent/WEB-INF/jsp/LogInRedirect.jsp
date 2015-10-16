<%@ page session="false" %>
<%@ page import = "com.sapportals.portal.prt.runtime.PortalRuntime" %>
<%@ page import = "com.sapportals.portal.navigation.*" %>

<%
INavigationGenerator navigationService = (INavigationGenerator)PortalRuntime.getRuntimeResources().getService(INavigationService.KEY);
String URL = navigationService.getPortalURL(componentRequest, null);
%>
<script>
location.replace("<%=URL%>");
</script>

