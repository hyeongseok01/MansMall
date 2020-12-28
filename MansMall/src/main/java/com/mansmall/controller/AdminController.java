package com.mansmall.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mansmall.domain.AdminVO;
import com.mansmall.dto.AdminDTO;
import com.mansmall.service.AdminService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	//관리자 메인
	@GetMapping("main")
	public String adminMain() {
		
		return "/admin/main";
	}
	
	//관리자 메인
	@GetMapping("login")
	public String loginGET() {
		return "/admin/login";
	}
		
	//관리자 로그인(post)
	@PostMapping("login")
	public String loginPost(AdminDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception{
		logger.info("=====login(POST) execute()");
		logger.info("=====AdminDTO : " + dto.toString());
		
		AdminVO vo = null;
		vo = service.login(dto);
		String msg = "";
		
		if(vo!=null) {
			// remember me 체크 부분
			/*
			if (dto.isUseCookie()) {
				int amount = 60 * 60 * 24 * 7; // 7일 간 쿠키 저장
				Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount)); 
				service.keepLogin(vo.getAdmin_id(), session.getId(), sessionLimit);
				}
			
			// 로그인 성공 시
			// 세션정보 처리시 key("admin") 는 다르게 사용해야 한다.예를 들어 사용자로그인과 동일하지 않아야한다.
			 * 
			 */
			session.setAttribute("admin", vo);
			msg ="LOGIN_SUCCESS";
		} else {
			// 로그인 실패 시
			msg = "LOGIN_FAIL";
		}
		rttr.addFlashAttribute("msg", msg);
		return "redirect:/admin/main";
	}
	
	//로그아웃(GET)
	@GetMapping("logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		logger.info("====== logout(POST) execute");
		
		session.invalidate();
		rttr.addFlashAttribute("msg","LOGOUT_SUCCESS" );
		
		return "redirect:/admin/main";
		
	}
	
	
	
}
