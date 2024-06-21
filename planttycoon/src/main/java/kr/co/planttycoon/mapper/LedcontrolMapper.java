package kr.co.planttycoon.mapper;

import org.apache.ibatis.annotations.Param;

import kr.co.planttycoon.domain.ControlDTO;

public interface LedcontrolMapper {
	public void insertLedControl(ControlDTO ledControlDTO);
	 // 아두이노가 조회할 LED 상태 조회
    public String selectLedControlByMemberId(@Param("memberId") String memberId);

    // 조명 상태 업데이트
    public void updateLedControlByMemberId(
        @Param("memberId") String memberId,
        @Param("ledStatus") String ledStatus
    );
}
