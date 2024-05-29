package kr.co.planttycoon.member;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.mapper.MemberMapper;
import kr.co.planttycoon.service.IMemberService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class MemberJoinTest {

	@Autowired
	private IMemberService service;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Test
	public void memberJoinTest() {

		MemberDTO mDto = new MemberDTO();
		mDto.setMemberId("zxz7648");
		mDto.setMemberPw(pwencoder.encode("691103"));
		log.info("인코딩된 비밀번호.......... : " + mDto.getMemberPw());
		mDto.setNickname("Erosaddy");
		
		int saveId = service.join(mDto);
		
		if (saveId == 1) {
			log.info("회원가입 성공......");
		} else {
			log.info("회원가입 실패......");
		}
	}

}
