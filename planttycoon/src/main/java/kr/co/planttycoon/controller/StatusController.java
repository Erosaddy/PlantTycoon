package kr.co.planttycoon.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@GetMapping("/api/data")
    public ResponseEntity<String> addMeasurement(
            @RequestParam("temperature") double temperature,
            @RequestParam("humidity") double humidity,
            @RequestParam("illuminance") int illuminance,
            @RequestParam("soilMoisture") int soilMoisture) {

        MeasurementDTO measurement = new MeasurementDTO();
        measurement.setTemperature(temperature);
        measurement.setHumidity(humidity);
        measurement.setIlluminance(illuminance);
        measurement.setSoilMoisture(soilMoisture);

        try {
        	service.saveMeasurement(measurement);
            return ResponseEntity.ok("Measurement data added successfully");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Failed to add measurement data");
        }
    }
	
	@GetMapping("/plant/status")
	public void plantstatus(HttpSession session, Principal principal) {
		String memberId = principal.getName();
		
		// 최근 측정값을 가져와서 모델에 추가
        MeasurementDTO latestMeasurement = service.getLatestMeasurement(memberId);
        session.setAttribute("latestMeasurement", latestMeasurement);
	}
	
	@GetMapping("/api/measurements")
    public ResponseEntity<List<MeasurementDTO>> getRecentMeasurements(Principal principal) {
		String memberId = principal.getName();
		
        List<MeasurementDTO> measurements = service.getRecentMeasurements(memberId);
        
        for (MeasurementDTO measurementDTO : measurements) {
			log.info(measurements);
		}
        
        return new ResponseEntity<>(measurements, HttpStatus.OK);
    }
}
