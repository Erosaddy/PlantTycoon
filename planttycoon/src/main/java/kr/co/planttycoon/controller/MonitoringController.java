package kr.co.planttycoon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.planttycoon.domain.MeasurementDTO;
import kr.co.planttycoon.service.IMeasurementService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MonitoringController {
	private final IMeasurementService service;
	
	@Autowired
    public MonitoringController(IMeasurementService service) {
       this.service = service;
    }
	
	@GetMapping("/plant/monitoring")
	public String plantstatus(Model model) {
		// 최근 측정값을 가져와서 모델에 추가
        MeasurementDTO latestMeasurement = service.getLatestMeasurement();
        model.addAttribute("latestMeasurement", latestMeasurement);

        return "plant/monitoring";
	}
}
