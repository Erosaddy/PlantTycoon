package kr.co.planttycoon.journal;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.planttycoon.domain.JournalDTO;
import kr.co.planttycoon.mapper.JournalMapper;
import kr.co.planttycoon.service.JournalService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration ({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
    "file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
public class JournalTest {
	
	@Autowired
	private JournalService Service;
	
	@Autowired
	private JournalMapper Mapper;
	
	@Test
	public void testCreate() throws Exception {
		JournalDTO jDto = new JournalDTO();
		jDto.setJournalTitle("테스트임2");
		jDto.setJournalContent("테스트임2");
		jDto.setMemberId("testaccount");
		
		Service.create(jDto);
		
		JournalDTO createJournal = Mapper.detail(jDto.getJournalId());
	}

}
