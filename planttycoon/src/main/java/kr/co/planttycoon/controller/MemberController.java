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
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
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
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MemberController {
	
	private final IMemberService service;
	private final CustomUserDetailsService detailsService;
	
	
	@Autowired
	public MemberController(IMemberService service, CustomUserDetailsService detailsService, JavaMailSender mailSender) {
		this.service = service;
		this.detailsService = detailsService;
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
	
}
