package kr.co.planttycoon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MeasurementDTO {
	private int measurementId;
	private String memberId;
	private double temperature;
	private double humidity;
	private int illuminance;
	private int soilMoisture;
	private Date measurementRegdate;
}
