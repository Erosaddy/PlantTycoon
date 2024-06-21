package kr.co.planttycoon.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.ControlDTO;
import kr.co.planttycoon.mapper.LedcontrolMapper;
import kr.co.planttycoon.service.ILedcontrolService;

@Service
public class LedcontrolServiceImpl implements ILedcontrolService {
	
	private final LedcontrolMapper mapper;
	
	@Autowired
    public LedcontrolServiceImpl(LedcontrolMapper mapper) {
		this.mapper = mapper;
	}
    
	@Override
	public String getMemberIdByMemberId(String memberId) {
		return mapper.selectLedControlByMemberId(memberId);
	}

	@Override
	public void updateLedStatus(String memberId, String ledStatus) {
		mapper.updateLedControlByMemberId(memberId, ledStatus);
		
	}

}
