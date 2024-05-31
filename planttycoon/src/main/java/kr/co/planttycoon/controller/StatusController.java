package kr.co.planttycoon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.planttycoon.domain.MeasurementDTO;
import kr.co.planttycoon.service.IMeasurementService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class StatusController {
	private final IMeasurementService service;
	
	@Autowired
    public StatusController(IMeasurementService service) {
       this.service = service;
    }

	@GetMapping("/plant/status")
	public String plantstatus(Model model) {
		 // 최근 측정값을 가져와서 모델에 추가
        MeasurementDTO latestMeasurement = service.getLatestMeasurement();
        model.addAttribute("latestMeasurement", latestMeasurement);

        return "plant/status";
	}
	
	@GetMapping("/api/measurements")
    public ResponseEntity<List<MeasurementDTO>> getRecentMeasurements() {
        List<MeasurementDTO> measurements = service.getRecentMeasurements();
        return new ResponseEntity<>(measurements, HttpStatus.OK);
    }
}
