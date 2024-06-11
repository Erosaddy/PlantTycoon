package kr.co.planttycoon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.planttycoon.service.IMemberService;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	
	private final IMemberService service;
	
	@Autowired
	public CommonController(IMemberService service) {
		this.service = service;
	}
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg", "해당 페이지에 대한 권한이 없습니다.");
	}
	
}
