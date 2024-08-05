package kr.co.planttycoon.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.domain.PageDTO;
import kr.co.planttycoon.security.CustomUserDetailsService;
import kr.co.planttycoon.security.domain.CustomUser;
import kr.co.planttycoon.service.IMemberService;

@Controller
public class MemberController {
	
	private final IMemberService service;
	private final CustomUserDetailsService customUserDetailsService;
	
	
	@Autowired
	public MemberController(IMemberService service, CustomUserDetailsService customUserDetailsService, JavaMailSender mailSender) {
		this.service = service;
		this.customUserDetailsService = customUserDetailsService;
	}

	@PostMapping("/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("memberId") String memberId) {
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
		
		CustomUser updatedMember = (CustomUser) customUserDetailsService.loadUserByUsername(memberId);
		
		SecurityContext context = SecurityContextHolder.createEmptyContext();
		Authentication authentication = new UsernamePasswordAuthenticationToken(updatedMember, null, updatedMember.getAuthorities());
		context.setAuthentication(authentication);
		SecurityContextHolder.setContext(context);
		
//		기존에 사용했던 방법. 그러나 이처럼 객체 생성 없이 처리하면 thread-safe하지 않다.
//		SecurityContextHolder.getContext().setAuthentication(authentication);
		
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
							 @RequestParam("memberId") String memberId) {
		
		int cnt = service.modifyEnabled(enabled, memberId);
		
		return cnt; 
	}
	
}
