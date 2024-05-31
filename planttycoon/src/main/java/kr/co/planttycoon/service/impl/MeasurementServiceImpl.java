package kr.co.planttycoon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.planttycoon.domain.MeasurementDTO;
import kr.co.planttycoon.mapper.MeasurementMapper;
import kr.co.planttycoon.service.IMeasurementService;

@Service
public class MeasurementServiceImpl implements IMeasurementService {
	private final MeasurementMapper mapper;
	
	@Autowired
    public MeasurementServiceImpl(MeasurementMapper mapper) {
       this.mapper = mapper;
    }
	
	@Override
    public MeasurementDTO getLatestMeasurement() {
        return mapper.getLatestMeasurement();
    }
	
	@Override
	public List<MeasurementDTO> getRecentMeasurements() {
		return mapper.getRecentMeasurements();
	}

}
