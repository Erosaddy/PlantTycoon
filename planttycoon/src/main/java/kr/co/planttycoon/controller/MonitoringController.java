package kr.co.planttycoon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.planttycoon.domain.MeasurementDTO;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MonitoringController {
	@GetMapping("/plant/monitoring")
	public String plantstatus() {
        return "plant/monitoring";
	}
}
