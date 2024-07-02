package kr.co.planttycoon.controller;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.Principal;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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


//  @GetMapping("/startPump")
//  @ResponseBody
//   public String requestWatering(Principal principal) {
//       String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
//       service.addManualWateringRecord(memberId); // 수동 물주기 기록 추가 메서드 호출
//       return "success"; // 요청이 성공했음을 응답으로 전송
//   }
  
  @RequestMapping(value="/startPump", produces="application/json;charset=UTF-8", method=RequestMethod.GET)
  @ResponseBody
  public String startPump(Principal principal, HttpServletResponse response) {
	  String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
	  String nodeMCUIP = "192.168.0.188"; // NodeMCU의 IP 주소 입력
      String command = "on"; // 물주기 시작 명령
      String endpoint = "http://" + nodeMCUIP + "/water?water=" + command;

      try {
          // HTTP 요청을 보내기 위한 준비
          URL url = new URL(endpoint);
          HttpURLConnection conn = (HttpURLConnection) url.openConnection();
          conn.setRequestMethod("GET");

          // 요청과 응답 코드 처리
          int responseCode = conn.getResponseCode();
          response.setContentType("text/plain; charset=UTF-8");
          response.setCharacterEncoding("UTF-8");
          if (responseCode == HttpURLConnection.HTTP_OK) {
        	  service.addManualWateringRecord(memberId); // 수동 물주기 기록 추가 메서드 호출
              return "수동 물주기 완료";
          } else {
              return "물주기를 시작하는 중에 문제가 발생했습니다. 응답 코드: " + responseCode;
          }
      } catch (IOException e) {
          // 예외 발생 시 처리
          e.printStackTrace();
          response.setContentType("text/plain; charset=UTF-8");
          response.setCharacterEncoding("UTF-8");
          return "물주기를 시작하는 중에 예기치 않은 오류가 발생했습니다.";
      }
  }

}
