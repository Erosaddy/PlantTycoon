package kr.co.planttycoon.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.planttycoon.domain.MeasurementDTO;
import kr.co.planttycoon.service.ILedcontrolService;
import kr.co.planttycoon.service.IMeasurementService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MonitoringController {
	private final IMeasurementService service;
	private final ILedcontrolService ledservice;
	
	@Autowired
    public MonitoringController(IMeasurementService service, ILedcontrolService ledservice) {
       this.service = service;
       this.ledservice = ledservice;
    }
	
	@GetMapping("/plant/monitoring")
	public String plantstatus(Model model, Principal principal) {
		String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
		
		// 최근 측정값을 가져와서 모델에 추가
        MeasurementDTO latestMeasurement = service.getLatestMeasurement();
        model.addAttribute("latestMeasurement", latestMeasurement);

        // 사용자의 조명 상태를 가져와서 모델에 추가
        String ledStatus = ledservice.getMemberIdByMemberId(memberId);
        model.addAttribute("ledStatus", ledStatus); // String 형태의 ledStatus를 모델에 추가

        
        return "plant/monitoring";
	}
	
	@PostMapping("/led/toggle")
    @ResponseBody
    public ResponseEntity<?> toggleLedStatus(Principal principal) {
        String memberId = principal.getName();
        String currentLedStatus = ledservice.getMemberIdByMemberId(memberId);

        // LED 상태를 토글 (예시)
        String newLedStatus = currentLedStatus.equals("T") ? "F" : "T";
        ledservice.updateLedStatus(memberId, newLedStatus);

        // 변경된 LED 상태를 JSON 응답으로 반환
        return ResponseEntity.ok().body(newLedStatus);
    }
}
