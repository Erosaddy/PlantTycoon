package kr.co.planttycoon.controller;

import java.security.Principal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
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
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
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
        
        // 마지막 자동 물주기 시간 조회
        Date lastAutoWateringDate = Wservice.getLastWateringDate(memberId);
        log.info("마지막 자동 물주기 시간 : " + lastAutoWateringDate);

        // 사용자의 물주기 주기 조회
        int wateringInterval = Wservice.getWateringIntervalByMemberId(memberId);
        log.info("사용자의 물주기 주기 : " + wateringInterval);

        // 가입일을 기준으로 남은 시간 계산
        Date joinDate = Wservice.getMemberJoinDate(memberId); // Date 객체로 가입일 가져오기
        LocalDateTime joinDateTime = LocalDateTime.ofInstant(joinDate.toInstant(), ZoneId.systemDefault());
        
        LocalDateTime nextWateringDateTime;
        if (lastAutoWateringDate != null) {
            LocalDateTime lastWateringDateTime = lastAutoWateringDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
            nextWateringDateTime = lastWateringDateTime.plusDays(wateringInterval);
        } else {
            // 가입일을 기준으로 남은 시간 계산
            nextWateringDateTime = joinDateTime.plusDays(wateringInterval);
        }

        // 현재 시간과의 차이 계산
        LocalDateTime currentDateTime = LocalDateTime.now();
        Duration duration = Duration.between(currentDateTime, nextWateringDateTime);
        long days = duration.toDays();
        long hours = duration.toHours() % 24;
        long minutes = duration.toMinutes() % 60;

        model.addAttribute("daysLeft", days);
        model.addAttribute("hoursLeft", hours);
        model.addAttribute("minutesLeft", minutes);
        
        return "/home";
	}
}
