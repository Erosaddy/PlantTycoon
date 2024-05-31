package kr.co.planttycoon.mapper;

import java.util.List;

import kr.co.planttycoon.domain.MeasurementDTO;

public interface MeasurementMapper {
	public MeasurementDTO getLatestMeasurement();
	public List<MeasurementDTO> getRecentMeasurements();
}
