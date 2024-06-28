package kr.co.planttycoon.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.MeasurementDTO;
import kr.co.planttycoon.domain.PageDTO;
import kr.co.planttycoon.domain.WateringrecordDTO;
import kr.co.planttycoon.service.IMeasurementService;
import kr.co.planttycoon.service.IWateringService;

@Controller
public class HomeController {
	private final IMeasurementService Mservice;
	private final IWateringService Wservice;
	
	@Autowired
	public HomeController(IMeasurementService Mservice, IWateringService Wservice) {
		this.Mservice = Mservice;
		this.Wservice = Wservice;
	}
	
	@GetMapping({"/home", "/"})
	public String plantwatering(HttpSession session, Model model, Principal principal, Criteria cri) {
		String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
		
		List<WateringrecordDTO> records = Wservice.getWateringRecordsByMemberId(memberId, cri);
        model.addAttribute("records", records);
        
        int total = Wservice.getTotalCnt(cri, memberId);
        model.addAttribute("pageMaker", new PageDTO(total, cri));
        
        // 최근 측정값을 가져와서 모델에 추가
        MeasurementDTO latestMeasurement = Mservice.getLatestMeasurement(memberId);
        session.setAttribute("latestMeasurement", latestMeasurement);
        
        return "/home";
	}
}
