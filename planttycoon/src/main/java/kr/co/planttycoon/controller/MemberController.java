package kr.co.planttycoon.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	
	@RequestMapping("/findAuth")
    @ResponseBody
    public Map<String, Object> findAuth(MemberDTO mDto) {
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
        } catch (MessagingException e) {
            map.put("status", false);
            map.put("message", "메일 전송 중 오류가 발생했습니다.");
        } catch (Exception e) {
            map.put("status", false);
            map.put("message", "서버 오류가 발생했습니다.");
        }

        return map;
    }
}
