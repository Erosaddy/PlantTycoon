package kr.co.planttycoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.JournalDTO;
import kr.co.planttycoon.mapper.JournalMapper;

@Service
public class JournalService {
	
	private final JournalMapper Mapper;
	
	@Autowired
    public JournalService(JournalMapper Mapper) {
		this.Mapper = Mapper;
	}
	
	public List<JournalDTO> listAll(String memberId) {
		return Mapper.listAll(memberId);
	}
	
	public JournalDTO detail(int journalId) {
		return Mapper.detail(journalId);
	}
	
	public void create(JournalDTO jDto) {
		Mapper.insert(jDto);
	}
	
	public void modify(JournalDTO jDto) {
		Mapper.update(jDto);
	}
	
	public void remove(int journalId) {
		Mapper.delete(journalId);
	}
	
    public int getTotalCount(String memberId, Criteria cri) {
        return Mapper.getTotalCount(memberId, cri);
    }

    public List<JournalDTO> getListWithPaging(String memberId, Criteria cri) {
        return Mapper.getListWithPaging(memberId, cri);
    }
}
