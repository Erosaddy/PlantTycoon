package kr.co.planttycoon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.planttycoon.domain.MeasurementDTO;
import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.mapper.MeasurementMapper;
import kr.co.planttycoon.service.IMeasurementService;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MeasurementServiceImpl implements IMeasurementService {
	private final MeasurementMapper mapper;
	
	@Autowired
    public MeasurementServiceImpl(MeasurementMapper mapper) {
       this.mapper = mapper;
    }
	
	// 일정 시간마다 모든 사용자에게 데이터 등록
	@Override
	public void saveMeasurement(MeasurementDTO measurement) {
		List<MemberDTO> members = mapper.getAllMembers();
        for (MemberDTO member : members) {
            MeasurementDTO newMeasurement = new MeasurementDTO();
            newMeasurement.setMemberId(member.getMemberId()); // 각 멤버의 아이디 설정
            newMeasurement.setTemperature(measurement.getTemperature());
            newMeasurement.setHumidity(measurement.getHumidity());
            newMeasurement.setIlluminance(measurement.getIlluminance());
            newMeasurement.setSoilMoisture(measurement.getSoilMoisture());
            
            log.info("Saving measurement for memberId: " + member.getMemberId());
            
            mapper.insertMeasurement(newMeasurement);
        }
	}
	
	// 가장 마지막 데이터
	@Override
    public MeasurementDTO getLatestMeasurement() {
        return mapper.getLatestMeasurement();
    }
	
	// 최근 10개 데이터(차트)
	@Override
	public List<MeasurementDTO> getRecentMeasurements() {
		return mapper.getRecentMeasurements();
	}


}
