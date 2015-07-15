<%@page import="com.smartechz.tools.mygeoloc.Geobytes"%>
<%@page import="com.sola.instagram.util.PaginatedCollection"%>
<%@page import="com.sola.instagram.model.Media.Image"%>
<%@page import="com.sola.instagram.model.Media"%>
<%@page import="java.util.List"%>
<%@page import="com.sola.instagram.InstagramSession"%>
<%@page import="com.sola.instagram.auth.AccessToken"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@page import="com.sola.instagram.auth.InstagramAuthentication"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<portlet:defineObjects />

This is the <b>Friendly Url Poc</b> portlet in View mode.
<br>
<portlet:actionURL var="actionURL">
	<portlet:param name="mvcPath" value="/edit.jsp"/>
</portlet:actionURL>

<a href="<%=actionURL%>">click</a>

<br><br>
Note:
<ol>
<li>add configuration in liferay-portlet.xml</li>
<li>add url mapping xml in src folder</li>
<li>configure url mapping</li>
</ol>

<%

String accessTokenString = portletPreferences.getValue("accessTokenString", null);
System.out.println("accessTokenString"+accessTokenString);
InstagramAuthentication auth = new InstagramAuthentication();
auth.setRedirectUri("http://localhost:2020/web/guest/home/-/poc")
.setClientSecret("7a2b367f9e8f4b01956816ef46fe3268")
.setClientId("8548ff7a03374c48b1a78875d905f8a9")
;
%>

<c:choose>
	<c:when test="<%=accessTokenString==null %>">
		<%
		

			
			String authUrl = auth.getAuthorizationUri();
			
		%>
		<a href="<%=authUrl%>">Authorize</a>
	</c:when>
	<c:otherwise>
		<%
		auth.buildFromAccessToken(accessTokenString);
		InstagramSession instaSession = new InstagramSession(auth.getAccessToken());
		List<Media> feed= instaSession.searchMedia(Geobytes.get("Latitude"), Geobytes.get("Longitude"), null, null, 5000);
		/* PaginatedCollection<Media> feed = instaSession.getRecentPublishedMedia(auth.getAuthenticatedUser().getId());  */
		for(Media media: feed) {
			  Image image = media.getStandardResolutionImage();
			  
		    //do stuff
			  %>	  
			 <%=media.getUser().getUserName() %>
			 <%=media.getComments() %>
			<img src="<%=image.getUri()%>"></img><br>
		<%  }
		%>
	</c:otherwise>
</c:choose>




