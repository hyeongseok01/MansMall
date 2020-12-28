package com.mansmall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import com.mansmall.dto.LoginDTO;

public class LoginInterceptor implements HandlerInterceptor {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("======== LoginInterceptor preHandle() 실행중 ========");
		
		//세션처리 작업
		HttpSession session = request.getSession();
		LoginDTO user =  (LoginDTO) session.getAttribute("user");
		
		if(user == null) { // 관리자 미 로그인 시, 로그인 페이지 로드
			logger.info("user계정 로그인이 되지 않았습니다.");
			// 로그인 페이지 로드 전에 요청된 페이지 정보 저장
			saveDest(request);
			
			response.sendRedirect("/member/login");
			return false;
		}	
		return true;
	}

		// 인터셉터 동작 전에 요청된 주소 정보를 저장하는 메소드
		private void saveDest(HttpServletRequest request) {

			String query = request.getQueryString();
			String uri = request.getRequestURI();

			if (query == null || query.equals("null")) {
			query = "";
			} else {
			query = "?" + query;
			}
			
			if (request.getMethod().equals("GET")) {
			
			logger.info("dest: " + (uri + query));
			
			request.getSession().setAttribute("dest", uri + query);
			
				}
			
			}
}
