package kr.co.planttycoon.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.co.planttycoon.service.IWateringService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class ManualWateringController {
	private final IWateringService service;
	
	@Autowired
	public ManualWateringController(IWateringService service) {
		this.service = service;
	}

//	@GetMapping("/plant/requestWatering")
//	@ResponseBody
//    public String requestWatering(Principal principal) {
//        String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
//        service.addManualWateringRecord(memberId); // 수동 물주기 기록 추가 메서드 호출
//        return "ON"; // 요청이 성공했음을 응답으로 전송
//    }
	
	@GetMapping("/plant/requestWatering")
	@ResponseBody
    public String requestWatering() {

        return "ON"; // 요청이 성공했음을 응답으로 전송
    }

}
