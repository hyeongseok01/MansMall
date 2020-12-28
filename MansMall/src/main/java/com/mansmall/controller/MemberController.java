package com.mansmall.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mansmall.domain.MemberVO;
import com.mansmall.dto.LoginDTO;
import com.mansmall.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	MemberService service;
	
	//spring-security.xml  BCryptPasswordEncoder클래스가 bean객체로 설정.
	@Inject
	private BCryptPasswordEncoder crptPassEnc;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
		//회원가입 get
		@RequestMapping(value = "join", method = RequestMethod.GET)
		public void joinGet() {
		}
		
		//회원가입 post
		@RequestMapping(value="join", method = RequestMethod.POST)
		public String joinPost(MemberVO vo, RedirectAttributes rttr) throws Exception {
			//비밀번호 암호화  원래 비밀번호를 다른 문자로 생성
			
			logger.info("입력데이타:"+ vo.toString());
			
			//비밀번호 암호화 처리
			vo.setMb_pw(crptPassEnc.encode(vo.getMb_pw()));
			
			service.join(vo);
			rttr.addFlashAttribute("msg", "REGISTER_SUCCESS");
			
			return "redirect:/";  // 루트 주소로 이동. HomeController 에 있음. home.jsp에서 "msg" 키사용
		}
		
		
		//아이디 중복체크(ajax요청) js파일로 처리 ,/member/checkId  ResponseEntity를 쓰면 아래 상태 코드도 같이 보낼 수 있다.  
		@ResponseBody
		@RequestMapping(value ="checkId",method =RequestMethod.POST )
		public ResponseEntity<String> checkId(@RequestParam("mb_id") String mb_id) throws Exception {
			
			logger.info("===checkId execute()...");
			ResponseEntity<String> entity = null;
			try {
				String check = service.checkId(mb_id);
				//check가 null 이면 아이디 사용가능  not null이면 사용불가
				if(check != null ){
					//null 이 아닌경우 아이디존재해서 사용 불가
					entity = new ResponseEntity<String>("FAIL",HttpStatus.OK);
				}else {
					entity= new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				entity =  new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
				//400 : Bad Request, 요청이 부적절 할 때, 유효성 검증 실패, 필수 값 누락 등. 
			}
			
			return entity;
		}
		
		//닉네임중복체크
		@ResponseBody
		@PostMapping("checkNick")
		public ResponseEntity<String> checkNick(@RequestParam("mb_nickname") String mb_nickname) throws Exception{
			logger.info("===checkId execute()...");
			ResponseEntity<String> entity = null;
			try {
				String checkNick = service.checkNickName(mb_nickname);
				//check가 null 이면 아이디 사용가능  not null이면 사용불가
				if(checkNick != null ){
					//null 이 아닌경우 아이디존재해서 사용 불가
					entity = new ResponseEntity<String>("FAIL",HttpStatus.OK);
				}else {
					entity= new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				entity =  new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
				//400 : Bad Request, 요청이 부적절 할 때, 유효성 검증 실패, 필수 값 누락 등. 
			}
			
			return entity;
		}
		

		//이메일 인증코드 확인 - 입력된 인증코드와 세션에 저장해 두었던 인증 코드가 일치하는지 확인
		@ResponseBody
		@RequestMapping(value ="checkAuthCode", method = RequestMethod.POST)
		public ResponseEntity<String> checkAuthCode(@RequestParam("code") String code, HttpSession session){
			
			ResponseEntity<String> entity = null;
			
			try {
				if(code.equals(session.getAttribute("authcode"))){
				   //인증코드 일치
					entity = new ResponseEntity<String> ("SUCCESS",HttpStatus.OK);
			}else {
				   //인증코드 불일치
					entity = new ResponseEntity<String> ("FAIL",HttpStatus.OK);
			}
		} catch (Exception e) {
		  e.printStackTrace();
		  entity = new ResponseEntity<String> (HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}	
		
		//로그인 get /member/login   <a href="/member/login">로그인</a>   
		
		@RequestMapping(value ="login", method = RequestMethod.GET)
		public void loginGET() {
			// 리턴타입이 void인 경우에는 jsp파일명은 요청주소(/member/login)가 된다.
		}

		//로그인 post  /member/loginPost 
		@RequestMapping(value = "loginPost", method = RequestMethod.POST)
		public String loginPOST(LoginDTO dto, RedirectAttributes rttr, HttpSession session,
								HttpServletResponse response) throws Exception {
			
			logger.info("=====loginPost() execute...");
			
			
			//DB에서 암호화된 비밀번호가 저장.
			LoginDTO logDTO =  service.login(dto); 
		
			
			if(logDTO != null ) { //로그인 성공
				logger.info("=====로그인 성공");
				
				// 세션 작업 : 저장소 - 서버의 메모리(현재 연결된 사용자 사용이 가능)
				// logDTO : 아이디,비밀번호,  이름, 최근접속시간 
				session.setAttribute("user", logDTO); // session.getAttribute("user")
				
				rttr.addFlashAttribute("msg", "LOGIN_SUCCESS");
				return "redirect:/";  //index.jsp에서 "msg" 키사용
					
			}else {    // 로그인 실패
				logger.info("=====로그인 실패");
				
				//  RedirectAttributes 클래스 ? 주소이동시 정보를 제공하고자 할때 사용.
				rttr.addFlashAttribute("msg", "LOGIN_FAIL"); //로그인 페이지에서 "msg" 키가 사용됨.
					
			  return "redirect:/member/login"; // 해당 jsp 페이지로 이동
			}	
					

		}
		
		// 로그아웃  /member/logout  
	   @RequestMapping(value = "logout", method = RequestMethod.GET)
		public String logout(HttpSession session, RedirectAttributes rttr) {
		   logger.info("=====logout execute()...");
		   
		   session.invalidate(); // 세션으로 처리한 정보가 서버메모리에서 제거. 로그아웃기능
		   rttr.addFlashAttribute("msg", "LOGOUT_SUCCESS");
		   
		   return "redirect:/";
	   }
		
		/* 비밀번호 재확인(GET)  */
		/* 1)회원정보 수정 url=modify,  2)비밀번호 변경 url=changePw, 3)회원 탈퇴  url=delete */
		@RequestMapping(value = "checkPw", method = RequestMethod.GET)
		public void checkPwGET(@ModelAttribute("url") String url) {
			
		}
		
		
	    // 1)회원정보 수정 url=modify,  2)비밀번호 변경 url=changePw, 3)회원 탈퇴  url=delete 
		@RequestMapping(value = "checkPw", method = RequestMethod.POST)
		public String checkPwPOST(@RequestParam("url") String url,
								  @RequestParam("mb_pw") String pw,
								   HttpSession session, Model model,RedirectAttributes rttr) throws Exception{
			
			logger.info("=====checkPw() execute..."); 
			logger.info("=====url: " + url + ", mb_pw: " + pw); 
			// 인증된 사용자
			LoginDTO dto = (LoginDTO) session.getAttribute("user");
			logger.info("=====세션 저장 값: " + dto.toString());
			// 스프링 시큐리티(보안)
			if(crptPassEnc.matches(pw, dto.getMb_pw())) {
				// 비밀번호가 일치하는 경우, url 확인 
				if(url.equals("modify")) {
					model.addAttribute("vo", service.readUserInfo(dto.getMb_id())); //회원정보 수정 jsp에 보내기 위해서 전체 정보를 가져온 것.
					return "/member/modify"; // 회원정보 수정 뷰
					
				} else if (url.equals("changePw")) {
					return "/member/changePw"; // 비밀번호변경 뷰
				/*	
				} else if(url.equals("delete")) {
					//회원탈퇴
					
					//user에 이미 id,pw 세션정보가 담겨있다.
					LoginDTO logDTO = (LoginDTO) session.getAttribute("user");
					service.deleteMember(logDTO.getMb_id());
					//세션 소멸작업.
					session.invalidate();
					rttr.addFlashAttribute("msg", "DELETE_USER_SUCCESS");
					return "redirect:/";
					//return "/member/delete";  // 회원탈퇴 뷰
					*/
				}
			} 
			
			//아래는 비밀번호가 일치하지 않거나, 정해진 url이 아닌 경우 처리
			model.addAttribute("url", url);
			model.addAttribute("msg", "CHECK_PW_FAIL");
			
			return "/member/checkPw";
		}
		
		/*  비밀번호 확인을 위해 처리. 
		 *  서버에서 클라이언트로 응답 데이터를 전송하기 위해서   @ResponseBody 를 사용하여 
		 *  자바 객체를 HTTP 응답 본문의 객체로 변환하여 클라이언트로 전송 
		 */
		@ResponseBody
		@RequestMapping("checkPwAjax")
		public ResponseEntity<String> checkPwAjax(@RequestParam("mb_pw") String mb_pw, HttpSession session) {
			
			logger.info("=====checkPwAjax() execute...");
			ResponseEntity<String> entity = null;
			LoginDTO dto = (LoginDTO) session.getAttribute("user");
			logger.info("=====mb_pw: " + mb_pw);
			logger.info("=====dto: " + dto.toString());
			
			if(crptPassEnc.matches(mb_pw, dto.getMb_pw())) {
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
				
			} else {
				entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
			}
			
			return entity;
		}
		
		
		/* 회원 정보 수정(POST) */
		@RequestMapping(value = "modify", method = RequestMethod.POST)
		public String modify(MemberVO vo, RedirectAttributes rttr, HttpSession session) throws Exception{
			
			LoginDTO dto = new LoginDTO();
			dto.setMb_id(vo.getMb_id());
			dto.setMb_pw(vo.getMb_pw());
			
			//비밀번호 암호화 작업.
			vo.setMb_pw(crptPassEnc.encode(vo.getMb_pw()));
			service.modifyMemberInfo(vo); //회원수정
			
			// 처음에 로그인시 세션에 저장했던 정보를 다른곳에서 사용이 되어질 경우(회원수정, 비번변경, 회원탈퇴)
			// 그 정보가 수정이 발생이 되면,세션정보를 갱신해주어야 한다. ex) 비밀번호 변경 등
			// 아래 세션작업을 함( 수정중에서 변경된 정보를 세션에 새로 반영하는 의미.)
			session.setAttribute("user", service.login(dto));
			
			rttr.addFlashAttribute("msg","MODIFY_USER_SUCCESS");
			
			return "redirect:/";
		}
		
		// 비밀번호 변경(POST)
		@PostMapping("changePw")
		public String changePw(LoginDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception{
			
			logger.info("changePw execute");
			//비밀번호 암호화 후 변경코드
			dto.setMb_pw(crptPassEnc.encode(dto.getMb_pw()));
			service.changePw(dto);
			
			//세션의 비밀번호 재상정
			LoginDTO logDTO = (LoginDTO) session.getAttribute("user");
			logDTO.setMb_pw(dto.getMb_pw());
			session.setAttribute("user", logDTO);
			
			rttr.addFlashAttribute("msg", "CHANGE_PW_SUCCESS");
			return "redirect:/";
		}
		
		// 회원 탈퇴 GET
		@GetMapping("delete")
		public void deleteMember() {
			
		}
		
		
		// 회원 탈퇴 post
		@RequestMapping(value="delete", method = RequestMethod.POST)
		public String deleteMember(HttpSession session, RedirectAttributes rttr) throws Exception{
			logger.info("=====deletePOST() execute...");
			//user에 이미 id,pw 세션정보가 담겨있다.
			LoginDTO logDTO = (LoginDTO) session.getAttribute("user");
			service.deleteMember(logDTO.getMb_id());
			//세션 소멸작업.
			session.invalidate();
			rttr.addFlashAttribute("msg", "DELETE_USER_SUCCESS");
			return "redirect:/";
		}

}	
