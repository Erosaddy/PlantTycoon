package kr.co.planttycoon.member;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.AuthorityDTO;
import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.mapper.MemberMapper;
import kr.co.planttycoon.service.IMemberService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class MemberJoinTest {

	@Autowired private MemberMapper mapper;
	
	@Autowired private IMemberService memberServiceImpl;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
//	@Test
//	public void memberCreateTest() {
//
//		MemberDTO mDto = new MemberDTO();
//		mDto.setMemberId("boomer");
//		mDto.setMemberPw(pwencoder.encode("999999"));
//		log.info("인코딩된 비밀번호.......... : " + mDto.getMemberPw());
//		mDto.setNickname("okBoomer");
//		
//		int saveId = mapper.createMember(mDto);
//		
//		if (saveId == 1) {
//			log.info("회원가입 성공......");
//		} else {
//			log.info("회원가입 실패......");
//		}
//	}
//	
//	@Test
//	public void memberAuthorityCreateTest() {
//		String memberId = "boomer";
//		
//		int saveId = mapper.createMemberAuthority(memberId);
//		
//		if (saveId == 1) {
//			log.info("권한생성 성공......");
//		} else {
//			log.info("권한생성 실패......");
//		}
//	}
	
	@Test
	public void joinTest() {
		MemberDTO mDto = new MemberDTO();
		mDto.setMemberId("butcher");
		mDto.setMemberPw(pwencoder.encode("333333"));
		log.info("인코딩된 비밀번호.......... : " + mDto.getMemberPw());
		mDto.setNickname("okButcher");
		
		int result = memberServiceImpl.join(mDto);
		
		if (result == 1) {
			log.info("성공.........");
		} else {
			log.info("실패.........");
		}
	}

}
