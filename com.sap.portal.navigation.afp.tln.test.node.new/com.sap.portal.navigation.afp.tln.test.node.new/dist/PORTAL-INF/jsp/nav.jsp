<%@ page import = "com.sapportals.portal.prt.component.IPortalComponentRequest" %>
<%@ page import = "com.sapportals.portal.prt.component.IPortalComponentContext" %>

<script type="text/javascript">
	function updateNavigationMenu(currentNode){
	     EPCM.getSAPTop().LSAPI.AFPPlugin.model.getNavigationSubTree(null,drawTree,null);
	     }
	
	function drawTree(nodes, container)
	{
	     var pathArray = EPCM.getSAPTop().LSAPI.AFPPlugin.model.getCurrentSelectedPath();
	     //alert(pathArray[0].getTitle());
	     EPCM.raiseEvent( "urn:com.node.test", "currentNode", "Current Node", pathArray[0].getTitle());
	}
</script>