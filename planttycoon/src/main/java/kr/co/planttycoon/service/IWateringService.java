package kr.co.planttycoon.service;

import java.util.Date;
import java.util.List;

import kr.co.planttycoon.domain.WateringrecordDTO;

public interface IWateringService {
	public List<WateringrecordDTO> getWateringRecordsByMemberId(String memberId);

	public Date getLastWateringDate(String memberId);

	public void addAutoWateringRecord(String memberId);

	public void addManualWateringRecord(String memberId);

	public int getWateringIntervalByMemberId(String memberId);

	public void updateWateringInterval(String memberId, int wateringInterval);
}
