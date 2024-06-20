package kr.co.planttycoon.service;

import java.util.List;

import kr.co.planttycoon.domain.MeasurementDTO;

public interface IMeasurementService {
	public void saveMeasurement(MeasurementDTO measurement);
	
	public MeasurementDTO getLatestMeasurement(String memberId);
	public List<MeasurementDTO> getRecentMeasurements(String memberId);
}
