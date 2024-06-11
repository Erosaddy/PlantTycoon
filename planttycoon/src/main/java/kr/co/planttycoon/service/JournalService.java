package kr.co.planttycoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.JournalDTO;
import kr.co.planttycoon.mapper.JournalMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JournalService {

    private final JournalMapper mapper;

    @Transactional
    public void register(JournalDTO jDto) {
        mapper.insert(jDto);
    }

    public List<JournalDTO> listAll(String memberId) {
        return mapper.listAll(memberId);
    }

    public JournalDTO get(int journalId) {
        return mapper.get(journalId);
    }

    public void modify(JournalDTO jDto) {
        mapper.update(jDto);
    }

    public boolean remove(int journalId) {
        return mapper.delete(journalId) == 1;
    }

    public int getTotalCount(String memberId, Criteria cri) { // 메서드 통합
        return mapper.getTotalCount(memberId, cri);
    }

    public List<JournalDTO> getListWithPaging(String memberId, Criteria cri) {
        return mapper.getListWithPaging(memberId, cri);
    }

    public List<JournalDTO> getList(Criteria cri, String memberId) {
        return mapper.getList(cri, memberId);
    }
}
