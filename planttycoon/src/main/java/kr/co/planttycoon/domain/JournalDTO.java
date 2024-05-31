package kr.co.planttycoon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class JournalDTO {
	private int journalId;
	private String journalTitle;
	private String journalContent;
	private String memberId;
	private Date journalRegdate;
}
