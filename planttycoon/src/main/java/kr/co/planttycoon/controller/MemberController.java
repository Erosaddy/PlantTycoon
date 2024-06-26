package kr.co.planttycoon.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.domain.PageDTO;
import kr.co.planttycoon.security.CustomUserDetailsService;
import kr.co.planttycoon.security.domain.CustomUser;
import kr.co.planttycoon.service.IMemberService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MemberController {
	
	private final IMemberService service;
	
	private final CustomUserDetailsService detailsService;
	
	private final JavaMailSender mailSender;
	
	@Autowired
	public MemberController(IMemberService service, CustomUserDetailsService detailsService, JavaMailSender mailSender) {
		this.service = service;
		this.detailsService = detailsService;
		this.mailSender = mailSender;
	}

	@GetMapping({"/login", "/"})
	public String loginInput(String error, String logout, Model model) {
		
		if (error != null) {
			model.addAttribute("error", "아이디 혹은 비밀번호가 일치하지 않습니다.");
		}
		
		if (logout != null) {
			model.addAttribute("logout", "로그아웃 되었습니다.");
		}
		
		return "/login";
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
		int result = service.join(mDto);
		
		if (result == 1) {
		    rttr.addFlashAttribute("signUpResult", "success");
		} else {
		    rttr.addFlashAttribute("signUpResult", "failure");
		}
		
		return "redirect:/login";
	}
	
	@PostMapping("/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("memberId") String memberId) throws Exception {
		int cnt = service.idCheck(memberId);
		
		return cnt;
	}
	
	@PostMapping("/members/modify")
	public String modifyMember(MemberDTO mDto, RedirectAttributes rttr, HttpServletRequest request, HttpServletResponse response, Principal principal) {
		
	    String memberId = principal.getName();
	    
		int result = service.modifyMember(mDto);
		
		if(result == 1) {
			rttr.addFlashAttribute("modifyMemberResult", "success");
		} else {
			rttr.addFlashAttribute("modifyMemberResult", "failure");
		}
		
		CustomUser updatedMember = (CustomUser) detailsService.loadUserByUsername(memberId);
		
		UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(updatedMember, updatedMember.getPassword(), updatedMember.getAuthorities());
		
		SecurityContextHolder.getContext().setAuthentication(newAuth);
		
		String referer = request.getHeader("Referer");
		
		return "redirect:" + (referer != null ? referer : "/home");
	}
	
	@GetMapping("/management")
	public void getMemberList(Criteria cri, Model model) {
		
		model.addAttribute("memberList", service.memberList(cri));
		
		int total = service.getTotalCnt(cri);
		
	    model.addAttribute("pageMaker", new PageDTO(total, cri));
	}
	
	@PostMapping("/toggleEnabled")
	@ResponseBody
	public int toggleEnabled(@RequestParam("enabled") String enabled, 
							 @RequestParam("memberId") String memberId) throws Exception {
		
		int cnt = service.modifyEnabled(enabled, memberId);
		
		return cnt; 
	}
	
	@PostMapping("/findAuth")
    @ResponseBody
    public Map<String, Object> findAuth(MemberDTO mDto, HttpSession session) {
        Map<String, Object> map = new HashMap<>();

        try {
            // 사용자 존재 여부 확인
            MemberDTO isUser = service.read(mDto.getMemberId());
            if (isUser == null) {
                map.put("status", false);
                map.put("message", "존재하지 않는 사용자입니다.");
                return map;
            }

            // 이메일 주소 확인
            if (!isUser.getMemberId().equals(mDto.getMemberId())) {
                map.put("status", false);
                map.put("message", "이메일 주소가 일치하지 않습니다.");
                return map;
            }

            // 랜덤 인증번호 생성
            Random r = new Random();
            int num = r.nextInt(999999);
            
            // 인증번호를 세션에 저장
            session.setAttribute("authNumber", num);
            session.setAttribute("authUser", isUser.getMemberId());

            // 이메일 내용 작성
            String setFrom = "blackyokel@naver.com";
            String tomail = isUser.getMemberId();
            String title = "[PlantTycoon] 비밀번호 변경 인증 이메일입니다.";
            StringBuilder sb = new StringBuilder();
            sb.append(String.format("안녕하세요 %s님\n", isUser.getNickname()));
            sb.append(String.format("PlantTycoon 비밀번호 찾기(변경) 인증번호는 %d입니다.", num));
            String content = sb.toString();

            // 이메일 전송
            MimeMessage msg = mailSender.createMimeMessage();
            MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "utf-8");
            msgHelper.setFrom(setFrom);
            msgHelper.setTo(tomail);
            msgHelper.setSubject(title);
            msgHelper.setText(content);
            mailSender.send(msg);

            // 성공적으로 메일을 보낸 경우
            map.put("status", true);
            map.put("num", num);
            map.put("memberId", isUser.getMemberId());
            map.put("message", "해당 메일로 인증 번호를 전송했습니다.");
        } catch (MessagingException e) {
            map.put("status", false);
            map.put("message", "메일 전송 중 오류가 발생했습니다.");
        } catch (Exception e) {
            map.put("status", false);
            map.put("message", "서버 오류가 발생했습니다.");
        }

        return map;
    }
	
	@PostMapping("/verifyAuth")
	@ResponseBody
    public Map<String, Object> verifyAuth(@RequestParam int authNumber, HttpSession session, RedirectAttributes rttr) {
		
	    Map<String, Object> map = new HashMap<>();
        Integer sessionAuthNumber = (Integer) session.getAttribute("authNumber");
        String sessionAuthUser = (String) session.getAttribute("authUser");

        if (sessionAuthNumber != null && sessionAuthNumber == authNumber) {
            // 고유 토큰 생성
            String token = UUID.randomUUID().toString();
            session.setAttribute("passwordChangeAllowed", true);
            session.setAttribute("authToken", token);
            
            map.put("status", true);
            map.put("message", "인증에 성공했습니다.");
            map.put("memberId", sessionAuthUser);
            map.put("authToken", token);
        } else {
            map.put("status", false);
            map.put("message", "인증번호가 일치하지 않습니다.");
        }

        return map;
    }
	
	@GetMapping("/changePassword")
	public String changePassword(@RequestParam("token") String token, HttpSession session) {
		 Boolean passwordChangeAllowed = (Boolean) session.getAttribute("passwordChangeAllowed");
	     String sessionToken = (String) session.getAttribute("authToken");
	     
	     if (passwordChangeAllowed != null && passwordChangeAllowed && token.equals(sessionToken)) {
            return "/changePassword"; // 비밀번호 변경 폼 페이지로 이동
         } else {
            return "/accessError"; // 접근이 허용되지 않음을 알리는 페이지로 이동
         }
	}
	
	@PostMapping("/changePassword")
    public String changePassword(@RequestParam String newPassword, @RequestParam String token, HttpSession session, RedirectAttributes rttr) {
        String sessionAuthUser = (String) session.getAttribute("authUser");
        String sessionToken = (String) session.getAttribute("authToken");
        
        if (sessionAuthUser != null && sessionToken != null && sessionToken.equals(token)) {

            int result = service.updatePassword(newPassword, sessionAuthUser);
            
            if (result == 1) {
                rttr.addFlashAttribute("passwordChangeResult", "비밀번호가 변경되었습니다.");
            } else {
                rttr.addFlashAttribute("passwordChangeResult", "비밀번호 변경에 실패했습니다.");
            }

            
        } else {
            rttr.addFlashAttribute("passwordChangeResult", "비밀번호 변경 권한이 없습니다.");
        }
        
        // 세션 데이터 삭제
        session.removeAttribute("authUser");
        session.removeAttribute("authToken");
        session.removeAttribute("passwordChangeAllowed");

        return "redirect:/login";
	}
	
}
