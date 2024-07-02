package kr.co.planttycoon.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.WateringrecordDTO;
import kr.co.planttycoon.mapper.WateringMapper;
import kr.co.planttycoon.service.IWateringService;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class WateringServiceImpl implements IWateringService {
	
	private WateringMapper mapper;
	
	@Autowired
    public WateringServiceImpl(WateringMapper mapper) {
		this.mapper = mapper;
	}
    
	@Override
	public List<WateringrecordDTO> getWateringRecordsByMemberId(String memberId, Criteria cri) {
		return mapper.getWateringRecordsByMemberId(memberId, cri);
	}

	@Override
	public Date getLastWateringDate(String memberId) {
		return mapper.getLastWateringDate(memberId);
	}

	@Override
	public void addAutoWateringRecord(String memberId) {
		mapper.insertAutoWateringRecord(memberId);
	}

	@Override
	public void addManualWateringRecord(String memberId) {
		mapper.insertManualWateringRecord(memberId);
	}

	@Override
	public int getWateringIntervalByMemberId(String memberId) {
		return mapper.getWateringIntervalByMemberId(memberId);
	}

	@Override
	@Transactional
	public void updateWateringInterval(String memberId, int wateringInterval) {
		mapper.updateWateringInterval(memberId, wateringInterval);
	}
	
	@Override
	public int getTotalCnt(Criteria cri, String memberId) {
	    return mapper.getTotalCnt(cri, memberId);
	}

	@Override
	public List<WateringrecordDTO> getMonthlyWateringData(String memberId) {
		return mapper.getMonthlyWateringData(memberId);
	}

	@Override
	public Date getMemberJoinDate(String memberId) {
		return mapper.getMemberJoinDate(memberId);
	}

}
