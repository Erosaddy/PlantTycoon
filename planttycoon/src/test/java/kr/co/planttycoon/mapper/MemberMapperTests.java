package kr.co.planttycoon.mapper;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import kr.co.planttycoon.domain.MemberDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class MemberMapperTests {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	
	@Test
	public void testRead() {

		MemberDTO mDto = mapper.read("admin90");
		
		log.info(mDto);
		
		mDto.getAuthList().forEach(authDTO -> log.info(authDTO));
		/*
		 * if (mDto != null) { log.info("해당 아이디로 조회한 이름 : " + mDto.getUserName()); }
		 * else { log.warn("해당 아이디를 가진 사용자가 존재하지 않음"); }
		 */
	}
}
