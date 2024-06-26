package kr.co.planttycoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.JournalDTO;
import kr.co.planttycoon.domain.NoticeDTO;
import kr.co.planttycoon.mapper.JournalMapper;
import kr.co.planttycoon.mapper.NoticeMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeService {

    private final NoticeMapper mapper;

    @Transactional
    public void register(NoticeDTO nDto) {
        mapper.insert(nDto);
    }

    public List<NoticeDTO> listAll(String memberId) {
        return mapper.listAll(memberId);
    }

    public NoticeDTO get(int noticeId) {
    	return mapper.getWithNickname(noticeId);
    }
    
    @Transactional
    public boolean modify(NoticeDTO notice) {
    	int result = mapper.update(notice); 
        return mapper.update(notice) == 1;
    }
    
    public boolean remove(int noticeId) {
        return mapper.delete(noticeId) == 1;
    }

    public int getTotalCount(Criteria cri) { // 메서드 통합
        return mapper.getTotalCount(cri);
    }

    public List<NoticeDTO> getListWithPaging(Criteria cri) { // memberId 매개변수 제거
        return mapper.getNoticeListWithPaging(cri); // 수정된 Mapper 메서드 호출
    }

    public List<NoticeDTO> getList(Criteria cri, String memberId) {
        return mapper.getList(cri, memberId);
    }
}
