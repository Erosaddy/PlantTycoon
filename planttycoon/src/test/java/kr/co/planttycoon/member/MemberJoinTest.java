package kr.co.planttycoon.member;

import org.assertj.core.api.Assertions;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.service.IMemberService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/test/resources/root-context-test.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
public class MemberJoinTest {

	@Autowired private IMemberService service;
	
	@Transactional
	@Test
    public void multipleMemberCreateTest() {
		
		Criteria cri = new Criteria();
        
		for (int i = 0; i < 100; i++) {		
			
			MemberDTO mDto = new MemberDTO();
			
			mDto.setMemberId("member" + i + "@gmail.com");
			mDto.setMemberPw("691103Zxz!" + i);
			mDto.setNickname("member" + i);
			mDto.setPlant("산세비에리아 (Sansevieria)");
			
			service.join(mDto);
		}
		
		int totalMember = service.getTotalCnt(cri);
		
		Assertions.assertThat(totalMember).isEqualTo(100);
    }
	
	@Transactional
	@Test
	public void memberReadTest() {
	    MemberDTO mDto = new MemberDTO();
        
        mDto.setMemberId("member2000@gmail.com");
        mDto.setMemberPw("999999");
        mDto.setNickname("member2000");
        mDto.setPlant("산세비에리아 (Snake Plant)");
        
        service.join(mDto);
        
        MemberDTO findMemberById = service.read(mDto.getMemberId());
        
        Assertions.assertThat(findMemberById.getMemberId()).isEqualTo(mDto.getMemberId());
	}
}
