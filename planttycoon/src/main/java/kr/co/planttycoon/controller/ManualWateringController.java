package kr.co.planttycoon.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import kr.co.planttycoon.service.IWateringService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class ManualWateringController {
	private final IWateringService service;
//  private final RestTemplate restTemplate;
//  
  @Autowired
  public ManualWateringController(IWateringService service) {
     this.service = service;
//     this.restTemplate = restTemplate;
  }


  @GetMapping("/startPump")
  @ResponseBody
   public String requestWatering(Principal principal) {
       String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
       service.addManualWateringRecord(memberId); // 수동 물주기 기록 추가 메서드 호출
       return "success"; // 요청이 성공했음을 응답으로 전송
   }
//	private final IWateringService service;
//	private final RestTemplate restTemplate;
//	
//	@Autowired
//	public ManualWateringController(IWateringService service, RestTemplate restTemplate) {
//		this.service = service;
//		this.restTemplate = restTemplate;
//	}


//	@GetMapping("/plant/requestWatering")
//	@ResponseBody
//    public String requestWatering(Principal principal) {
//        String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
//        service.addManualWateringRecord(memberId); // 수동 물주기 기록 추가 메서드 호출
//        return "ON"; // 요청이 성공했음을 응답으로 전송
//    }
	
 // 아두이노로 HTTP 요청 보내는 메서드
//    private void sendRequestToArduino() {
//        String arduinoUrl = "http://192.168.0.188/relay_control"; // 아두이노가 제공하는 제어 API 주소
//        ResponseEntity<String> response = restTemplate.getForEntity(arduinoUrl, String.class);
//        // 응답 처리 (필요에 따라)
//        // String responseBody = response.getBody();
//        // 처리할 내용 추가
//    }
//
//    // 클라이언트에서의 요청을 처리하는 메서드
//    @GetMapping("/activateRelay")
//    @ResponseBody
//    public String activateRelay() {
//        try {
//            sendRequestToArduino();
//            return "Relay activated successfully!";
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "Failed to activate relay: " + e.getMessage();
//        }
//    }
}
