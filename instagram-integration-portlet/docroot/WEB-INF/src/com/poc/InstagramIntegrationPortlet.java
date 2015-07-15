package com.poc;

import java.io.IOException;

import javax.portlet.PortletException;
import javax.portlet.PortletSession;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.servlet.http.HttpServletRequest;

import com.liferay.portal.util.PortalUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;
import com.sola.instagram.InstagramSession;
import com.sola.instagram.auth.AccessToken;
import com.sola.instagram.auth.InstagramAuthentication;

/**
 * Portlet implementation class FriendlyURLPocPortlet
 */
public class InstagramIntegrationPortlet extends MVCPortlet {
 
	@Override
	public void render(RenderRequest request, RenderResponse response)
			throws PortletException, IOException {
		// TODO Auto-generated method stub
		
		HttpServletRequest httpServletRequest=PortalUtil.getHttpServletRequest(request);
		HttpServletRequest originalhttpRequest = PortalUtil.getOriginalServletRequest(httpServletRequest);
		String code = originalhttpRequest.getParameter("code");
		System.out.println("code"+code);
		if(code!=null){
			
			try {
				InstagramAuthentication auth =  new InstagramAuthentication();
				auth.setRedirectUri("http://localhost:2020/web/guest/home/-/poc")
				.setClientSecret("7a2b367f9e8f4b01956816ef46fe3268")
				.setClientId("8548ff7a03374c48b1a78875d905f8a9")
				;

				javax.portlet.PortletPreferences portletPreferences =request.getPreferences();
				AccessToken accessToken = auth.build(code);
				portletPreferences.setValue("accessTokenString", accessToken.getTokenString());
				portletPreferences.store();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		super.render(request, response);
	}

}
