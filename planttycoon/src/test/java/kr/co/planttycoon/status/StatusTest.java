package kr.co.planttycoon.status;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import kr.co.planttycoon.controller.StatusController;
import kr.co.planttycoon.domain.MeasurementDTO;
import kr.co.planttycoon.mapper.MeasurementMapper;
import kr.co.planttycoon.service.IMeasurementService;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class StatusTest {
	
	@Autowired private MeasurementMapper measurementMapper;
	@Autowired private IMeasurementService measurementService;
	
	 @Autowired
	    private StatusController measurementController;
//
//    @Test
//    public void testSaveMeasurement() {
//        // 테스트용 데이터 생성
//        MeasurementDTO measurement = new MeasurementDTO();
//        measurement.setTemperature(25.5);
//        measurement.setHumidity(60.0);
//        measurement.setIlluminance(500);
//        measurement.setSoilMoisture(75);
//
//        // 가짜 멤버 리스트 생성
//        List<MemberDTO> members = new ArrayList<>();
//        MemberDTO member1 = new MemberDTO();
//        member1.setMemberId("user1");
//        members.add(member1);
//        MemberDTO member2 = new MemberDTO();
//        member2.setMemberId("user2");
//        members.add(member2);
//
//        // 측정 데이터를 저장하고 결과 확인
//        measurementService.saveMeasurement(measurement);
//    }
	
	 @Test
	    public void testCreateMeasurement() throws Exception {
	        // 테스트용 데이터 생성
	        MeasurementDTO measurement = new MeasurementDTO();
	        measurement.setTemperature(22.5);
	        measurement.setHumidity(50.0);
	        measurement.setIlluminance(300);
	        measurement.setSoilMoisture(70);

	        // 컨트롤러 메서드 호출
	        measurementController.createMeasurement(measurement);

	       
	    }
	
}
