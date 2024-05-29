package kr.co.planttycoon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/journal/*")
public class JournalController {

	@GetMapping("/list")
	public void doMember() {
		
		log.info("logged in member to journal list");
	}
	
}
