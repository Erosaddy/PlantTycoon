package kr.co.planttycoon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.planttycoon.service.ILedcontrolService;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
public class LedController {
	
	private final ILedcontrolService service;

	@Autowired
	public LedController(ILedcontrolService service) {
	    this.service = service;
	}
	
	@GetMapping("/led/status")
	public String getLedStatus(@RequestParam String memberId) {
	    String ledStatus = service.getMemberIdByMemberId(memberId);
	    log.info("LED 상태 조회 - MemberId: " + memberId + ", LED 상태: " + ledStatus);
	    
	    return "{\"ledStatus\":\"" + ledStatus + "\"}";
//	    return ledStatus;
	}
}
	

