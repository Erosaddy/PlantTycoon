package kr.co.planttycoon.mapper;


import java.util.List;

import kr.co.planttycoon.domain.MeasurementDTO;
import kr.co.planttycoon.domain.MemberDTO;

public interface MeasurementMapper {
	public void insertMeasurement(MeasurementDTO measurement);
	public List<MemberDTO> getAllMembers();
	
	public MeasurementDTO getLatestMeasurement();
	public List<MeasurementDTO> getRecentMeasurements();
}
