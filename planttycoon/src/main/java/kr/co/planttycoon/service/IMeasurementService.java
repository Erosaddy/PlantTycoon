package kr.co.planttycoon.service;

import java.util.List;

import kr.co.planttycoon.domain.MeasurementDTO;

public interface IMeasurementService {
	public List<MeasurementDTO> getRecentMeasurements();
}
