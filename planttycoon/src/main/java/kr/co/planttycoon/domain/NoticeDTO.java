package kr.co.planttycoon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeDTO {
	private int noticeId;
	private String noticeTitle;
	private String noticeContent;
	private String memberId;
	private Date Regdate;
	private String nickname;
}
