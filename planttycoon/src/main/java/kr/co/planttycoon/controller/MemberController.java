package kr.co.planttycoon.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
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
import kr.co.planttycoon.service.IMemberService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MemberController {
	
	private final IMemberService service;
	
	@Autowired
	public MemberController(IMemberService service) {
		this.service = service;
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
	
	@PostMapping("/modifyNickname")
	public String modifyNickname(MemberDTO mDto, RedirectAttributes rttr, HttpServletRequest request) {
		
		int result = service.modifyNickname(mDto);
		
		if(result == 1) {
			rttr.addFlashAttribute("modifyNicknameResult", "success");
		} else {
			rttr.addFlashAttribute("modifyNicknameResult", "failure");
		}
		
		// Referer 헤더 값 가져오기
        String referer = request.getHeader("Referer");
        
        // Referer 값이 있는 경우 해당 페이지로 리다이렉트
        if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        }
        
        // Referer 값이 없는 경우 기본 페이지로 리다이렉트
        return "redirect:/defaultPage";
	}
	
	@GetMapping("/management")
	public void getMemberList(Criteria cri, Model model) {
		log.info("show all members.................");
		
		model.addAttribute("memberList", service.memberList(cri));
		
		int total = service.getTotalCnt(cri);

	    model.addAttribute("pageMaker", new PageDTO(total, cri));
	}
	
	// All is Well. I wish the github flow pull request goes as planned.
	
	// All is Well. Now the approval
	
	// Hello!!!
	
}
