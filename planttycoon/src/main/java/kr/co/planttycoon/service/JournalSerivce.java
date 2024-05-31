package kr.co.planttycoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.planttycoon.domain.JournalDTO;
import kr.co.planttycoon.mapper.JournalMapper;

@Service
public class JournalSerivce {
	
	@Autowired
	private JournalMapper jMapper;
	
	public List<JournalDTO> listAll(String memberId) {
		return jMapper.listAll(memberId);
	}
	
	public JournalDTO detail(int journalId) {
		return jMapper.detail(journalId);
	}
	
	public void create(JournalDTO jDto) {
		jMapper.insert(jDto);
	}
	
	public void modify(JournalDTO jDto) {
		jMapper.update(jDto);
	}
	
	public void remove(int journalId) {
		jMapper.delete(journalId);
	}
}
