package kr.co.planttycoon.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/sample/*")
@Controller
public class SampleController {
	
	@GetMapping("/all")
	public void doAll() {
		
		log.info("do all can access everybody");
	}
	
	//@PreAuthorize("hasAnyRole({'ROLE_MEMBER', 'ROLE_ADMIN'})")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/member")
	public void doMember() {
		
		log.info("logged in member");
	}
	
	@Secured("{ROLE_ADMIN}")
	//@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/admin")
	public void doAdmin() {
		
		log.info("admin only");
	}
	
//	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
//	@GetMapping("/annoMember")
//	public void doMember2() {
//		
//		log.info("logged annotation member");
//	}
//	
//	@Secured("{ROLE_ADMIN}")
//	@GetMapping("/annoAdmin")
//	public void doAdmin2() {
//		
//		log.info("admin annotation only");
//	}
	
}
