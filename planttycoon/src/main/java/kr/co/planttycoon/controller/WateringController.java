package kr.co.planttycoon.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.PageDTO;
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
	public void plantwatering(Model model, Principal principal, Criteria cri) {
		String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
		
		List<WateringrecordDTO> records = service.getWateringRecordsByMemberId(memberId, cri);
        int wateringInterval = service.getWateringIntervalByMemberId(memberId);
        model.addAttribute("records", records);
        model.addAttribute("wateringInterval", wateringInterval);
        
        int total = service.getTotalCnt(cri, memberId);
        model.addAttribute("pageMaker", new PageDTO(total, cri));
	}
	
	// 자동 물주기 주기 업데이트
    @PostMapping("/plant/updateInterval")
    public String updateWateringInterval(@RequestParam int wateringInterval, Principal principal) {
    	String memberId = principal.getName();
        service.updateWateringInterval(memberId, wateringInterval);

        return "redirect:/plant/watering";
    }
    
    @GetMapping("/api/monthlyWateringData")
    public ResponseEntity<List<WateringrecordDTO>> getMonthlyWateringData(Principal principal) {
    	String memberId = principal.getName();
        
        List<WateringrecordDTO> monthlyWateringData = service.getMonthlyWateringData(memberId);
        
        // 현재 월까지의 월 데이터 생성
        List<String> months = new ArrayList<>();
        Calendar calendar = Calendar.getInstance();
        int currentMonth = calendar.get(Calendar.MONTH) + 1; // Calendar.MONTH는 0부터 시작하므로 +1
        
        for (int i = 1; i <= currentMonth; i++) {
            months.add(String.valueOf(i));
        }
        
        // 데이터가 없으면 0으로 초기화하여 추가
        if (monthlyWateringData.isEmpty()) {
            for (String month : months) {
                monthlyWateringData.add(new WateringrecordDTO(month, 0, 0));
            }
        }
        
        log.info("불러오니?" + monthlyWateringData);
        return new ResponseEntity<>(monthlyWateringData, HttpStatus.OK);
    }
    
    
}
