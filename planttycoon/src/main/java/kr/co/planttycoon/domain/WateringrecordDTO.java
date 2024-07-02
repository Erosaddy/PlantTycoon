package kr.co.planttycoon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class WateringrecordDTO {
	private int recordId;
	private Date wateredRegdate;
	private String wateringType;
	private String memberId;
	
	private String month; // 월 정보
    private int autoCount; // 자동 급수 횟수
    private int manualCount; // 수동 급수 횟수
    
    public WateringrecordDTO() {
    }
 // 생성자
    public WateringrecordDTO(String month, int autoCount, int manualCount) {
        this.month = month;
        this.autoCount = autoCount;
        this.manualCount = manualCount;
    }
}
