package kr.co.planttycoon.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.jaas.AuthorityGranter;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	// 로그인을 했을 시 해당 회원이 가진 권한에 따라 서로 다른 페이지로 분기하는 클래스
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		log.warn("Login Success");
		
		List<String> roleNames = new ArrayList<>();
		
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("ROLE NAMES : " + roleNames);
		
		if (roleNames.contains("ROLE_ADMIN")) {
			
			response.sendRedirect("/");
			return;
		}
		
		if (roleNames.contains("ROLE_MEMBER")) {
			
			response.sendRedirect("/");
			return;
		}
		
		response.sendRedirect("/accessError");
		
	}

}
