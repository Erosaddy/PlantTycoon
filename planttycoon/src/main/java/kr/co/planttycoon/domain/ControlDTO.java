package kr.co.planttycoon.domain;

import lombok.Data;

@Data
public class ControlDTO {
	private int ledId;
	private String ledStatus;
	private String memberId;
	private int wateringInterval;
}
