package kr.co.planttycoon.service;

import kr.co.planttycoon.domain.ControlDTO;

public interface ILedcontrolService {
	public String getMemberIdByMemberId(String memberId);
    public void updateLedStatus(String memberId, String ledStatus);
}
