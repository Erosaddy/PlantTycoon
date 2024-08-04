package kr.co.planttycoon.journal;

import org.assertj.core.api.Assertions;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.JournalDTO;
import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.mapper.JournalMapper;
import kr.co.planttycoon.service.IMemberService;
import kr.co.planttycoon.service.JournalService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration ({
    "file:src/test/resources/root-context-test.xml",
    "file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
public class JournalTest {
	
	@Autowired private JournalService Service;
	@Autowired private JournalMapper Mapper;
	@Autowired private IMemberService memberService;
	
	@Transactional
    @Test
    public void testCreate() throws Exception {
        
        MemberDTO mDto = new MemberDTO();
        
        mDto.setMemberId("testaccount");
        mDto.setMemberPw("999999");
        mDto.setNickname("tester");
        mDto.setPlant("산세비에리아 (Snake Plant)");
        
        memberService.join(mDto);
        
        JournalDTO jDto = new JournalDTO();
        jDto.setJournalTitle("테스트임2");
        jDto.setJournalContent("테스트임2");
        jDto.setMemberId("testaccount");
        
        Service.register(jDto);
        
        JournalDTO createJournal = Mapper.get(jDto.getJournalId());
        
        Assertions.assertThat(createJournal.getJournalTitle()).isEqualTo("테스트임2");
        
    }
}
