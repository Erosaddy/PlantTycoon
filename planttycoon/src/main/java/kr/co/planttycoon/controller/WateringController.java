package kr.co.planttycoon.controller;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.Principal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
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
	
	private final String nodeMCUIP = "192.168.0.188"; // NodeMCU의 IP 주소 입력
    private final String command = "on"; // 물주기 시작 명령
    private final String endpoint = "http://" + nodeMCUIP + "/water?water=" + command;
    
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
        
        return new ResponseEntity<>(monthlyWateringData, HttpStatus.OK);
    }
    
    @Scheduled(cron = "0 * * * * *") // 분마다 실행
    public void startAutomaticWatering() {
        String memberId = "hanul301@gmail.com"; // 물주기를 실행할 회원의 ID

        // 스케줄러가 실행되는지 로그로 확인
        System.out.println("자동 물주기 스케줄러가 실행되었습니다.");
        
        // 마지막 자동 물주기 시간 조회
        Date lastAutoWateringDate = service.getLastWateringDate(memberId);
        log.info("마지막 자동 물주기 시간 : " + lastAutoWateringDate);

        // 사용자의 물주기 주기 조회
        int wateringInterval = service.getWateringIntervalByMemberId(memberId);
        log.info("사용자의 물주기 주기 : " + wateringInterval);
        
        if (lastAutoWateringDate != null) {
            LocalDateTime lastWateringDateTime = lastAutoWateringDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
            LocalDateTime currentDateTime = LocalDateTime.now();
            Duration duration = Duration.between(lastWateringDateTime, currentDateTime);
            //long daysSinceLastWatering = duration.toDays();
            long daysSinceLastWatering = duration.toMinutes(); // 테스트를 위해 분 단위로 변환

            // 물주기 주기가 지난 경우 자동 물주기 실행
            if (daysSinceLastWatering >= wateringInterval) {
                executeAutoWatering(memberId);
            }
        } else {
        	// 마지막 자동 물주기 기록이 없는 경우, 가입 일시를 기준으로 초기 물주기를 실행할지 판단
            Date memberJoinDate = service.getMemberJoinDate(memberId); // 가입 일시 조회 메서드 필요
            if (memberJoinDate != null) {
                LocalDateTime joinDateTime = memberJoinDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
                LocalDateTime currentDateTime = LocalDateTime.now();
                Duration duration = Duration.between(joinDateTime, currentDateTime);
//                long daysSinceJoin = duration.toDays();
                long daysSinceJoin = duration.toMinutes(); // 테스트를 위해 분 단위로 변환

                // 가입 후 지난 시간이 물주기 주기보다 크거나 같으면 초기 물주기 실행
                if (daysSinceJoin >= wateringInterval) {
                    executeAutoWatering(memberId);
                }
            } else {
                log.error("사용자의 가입 일시를 조회할 수 없습니다.");
                // 예외 처리 또는 로깅을 추가할 수 있음
            }
        }
    }

    private void executeAutoWatering(String memberId) {
        try {
            // HTTP 요청을 보내기 위한 준비
            URL url = new URL(endpoint);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            // 요청과 응답 코드 처리
            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                service.addAutoWateringRecord(memberId); // 자동 물주기 기록 추가 메서드 호출
                System.out.println("자동 물주기 완료");
            } else {
                System.out.println("물주기를 시작하는 중에 문제가 발생했습니다. 응답 코드: " + responseCode);
            }
        } catch (IOException e) {
            // 예외 발생 시 처리
            e.printStackTrace();
            System.out.println("물주기를 시작하는 중에 예기치 않은 오류가 발생했습니다.");
        }
    }
    
}
