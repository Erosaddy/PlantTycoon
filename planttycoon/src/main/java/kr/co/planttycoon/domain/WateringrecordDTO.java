package kr.co.planttycoon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class WateringrecordDTO {
	private int recordId;
	private Date wateredRegdate;
	private String wateringType;
	private String memberId;
}
