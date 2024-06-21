package kr.co.planttycoon.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.planttycoon.domain.WateringrecordDTO;

public interface WateringMapper {
	public List<WateringrecordDTO> getWateringRecordsByMemberId(@Param("memberId") String memberId);

	public Date getLastWateringDate(@Param("memberId") String memberId);

	public void insertAutoWateringRecord(@Param("memberId") String memberId);

	public void insertManualWateringRecord(@Param("memberId") String memberId);

	public int getWateringIntervalByMemberId(@Param("memberId") String memberId);

	public void updateWateringInterval(@Param("memberId") String memberId, @Param("wateringInterval") int wateringInterval);
}
