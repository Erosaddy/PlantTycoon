package kr.co.planttycoon.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.planttycoon.domain.WateringrecordDTO;
import kr.co.planttycoon.service.IWateringService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class WateringController {
	
	private final IWateringService service;
	
	@Autowired
	public WateringController(IWateringService service) {
		this.service = service;
	}
	
	@GetMapping("/plant/watering")
	public void plantwatering(Model model, Principal principal) {
		String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
		
		List<WateringrecordDTO> records = service.getWateringRecordsByMemberId(memberId);
        int wateringInterval = service.getWateringIntervalByMemberId(memberId);
        model.addAttribute("records", records);
        model.addAttribute("wateringInterval", wateringInterval);
	}
	
	// 자동 물주기 주기 업데이트
    @PostMapping("/plant/updateInterval")
    public String updateWateringInterval(@RequestParam int wateringInterval, Principal principal) {
    	String memberId = principal.getName();
        service.updateWateringInterval(memberId, wateringInterval);

        return "redirect:/plant/watering";
    }
}
