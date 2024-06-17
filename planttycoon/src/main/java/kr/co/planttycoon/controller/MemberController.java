package kr.co.planttycoon.controller;

import java.net.http.HttpResponse;
import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.RememberMeServices;
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
import kr.co.planttycoon.service.impl.MemberServiceImpl;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MemberController {
	
	private final IMemberService service;
	
	private final CustomUserDetailsService detailsService;
	
	private final RememberMeServices rememberMeServices;
	
	@Autowired
	public MemberController(IMemberService service, CustomUserDetailsService detailsService, RememberMeServices rememberMeServices) {
		this.service = service;
		this.detailsService = detailsService;
		this.rememberMeServices = rememberMeServices;
	}

	@GetMapping("/login")
	public void loginInput(String error, String logout, Model model) {
		
		if (error != null) {
			model.addAttribute("error", "아이디 혹은 비밀번호가 일치하지 않습니다.");
		}
		
		if (logout != null) {
			model.addAttribute("logout", "로그아웃 되었습니다.");
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
	
	@PostMapping("/modifyMemberInfo")
	public String modifyMemberInfo(MemberDTO mDto, RedirectAttributes rttr, HttpServletRequest request, HttpServletResponse response, Principal principal) {
		
	    String memberId = principal.getName();
	    
		int result = service.modifyMemberInfo(mDto);
		
		if(result == 1) {
			rttr.addFlashAttribute("modifyMemberInfoResult", "success");
		} else {
			rttr.addFlashAttribute("modifyMemberInfoResult", "failure");
		}
		
		CustomUser updatedMember = (CustomUser) detailsService.loadUserByUsername(memberId);
		
		UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(updatedMember, updatedMember.getPassword(), updatedMember.getAuthorities());
		
		SecurityContextHolder.getContext().setAuthentication(newAuth);
		
		rememberMeServices.loginSuccess(request, response, newAuth);
		
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
