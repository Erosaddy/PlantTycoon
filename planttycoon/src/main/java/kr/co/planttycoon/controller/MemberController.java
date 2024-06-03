package kr.co.planttycoon.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.request;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.service.IMemberService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MemberController {
	
	private final IMemberService service;
	private final JavaMailSender mailSender;
	
	@Autowired
	public MemberController(IMemberService service, JavaMailSender mailSender) {
		this.service = service;
		this.mailSender = mailSender;
	}

	@GetMapping("/login")
	public void loginInput(String error, String logout, Model model) {
		
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		if (error != null) {
			model.addAttribute("error", "Login error. Please check your account.");
		}
		
		if (logout != null) {
			model.addAttribute("logout", "Logged out.");
		}
	}
	
	@GetMapping("/customLogout")
	public void logoutGET() {
		
		log.info("custom logout");
	}
	
	// 회원가입 페이지
	@GetMapping("/join")
	public void joinInput() {
		
	}
	
	@PostMapping("/join")
	public String join(MemberDTO mDto, RedirectAttributes rttr) {
		log.info("/join........");
		service.join(mDto);
		
		return "redirect:/login";
	}
	
	@PostMapping("/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("memberId") String memberId) throws Exception {
		int cnt = service.idCheck(memberId);
		
		return cnt;
	}
	
//	//이메일 발송을 위한 정보 받기 
//	@GetMapping("/getAuthNum")
//	@ResponseBody
//	public Map<String, Object> getAuthNum(@RequestParam("memberId") String memberId, HttpServletRequest request) {
//	    
//	    Map<String, Object> map = new HashMap<>();
//	    
//	    //사용자가 작성한 아이디를 기준으로 존재하는 사용자인지 확인한다.(id는 회원가입시 중복 체크를 했기 때문에 유니크하다.)
//	    int isUser = service.idCheck(memberId);
//	    
//	    if(isUser == 1) {//회원가입이 되어있는, 존재하는 사용자라면
//	        Random r = new Random();
//	        int num = r.nextInt(999999); //랜덤 난수 
//	        
//	        StringBuilder sb = new StringBuilder();
//	        
//            String setFrom = "blackyokel@naver.com";//발신자 이메일
//            String tomail = memberId;//수신자 이메일. 이메일이 아이디로 쓰이고 있기 때문에 다음과 같이 대입한다.
//            String title = "[PlantTycoon] 비밀번호 변경 인증 이메일입니다.";
////	            sb.append(String.format("안녕하세요 %s님\n", isUser.getM_nickname()));
//            sb.append(String.format("PlantTycoon 비밀번호 찾기(변경) 인증번호는 %d입니다.", num));
//            String content = sb.toString();
//            
//            try {
//                MimeMessage msg = mailSender.createMimeMessage();
//                MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "utf-8");
//                
//                msgHelper.setFrom(setFrom);
//                msgHelper.setTo(tomail);
//                msgHelper.setSubject(title);
//                msgHelper.setText(content);
//                
//                
//                //메일 전송
//                mailSender.send(msg);
//                
//                HttpSession session = request.getSession();
//                session.setAttribute("authNum", num);
//                session.setAttribute("authUser", memberId);
//                
//                //성공적으로 메일을 보낸 경우
//	            map.put("status", true);
//	            map.put("num", num);
//                
//            } catch (Exception e) {
//            	// 예외가 발생한 경우
//                System.out.println(e.getMessage());
//                map.put("status", false);
//                map.put("message", "이메일 전송에 실패했습니다.");
//            }
//	            
//	    } else {
//	    	// 사용자가 존재하지 않는 경우
//	    	map.put("status", false);
//	        map.put("message", "사용자를 찾을 수 없습니다.");
//	    }
//	    return map;
//	}
	
	
	
	
}
