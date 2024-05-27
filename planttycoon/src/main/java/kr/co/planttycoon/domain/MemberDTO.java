package kr.co.planttycoon.domain;

import java.time.LocalDate;
import java.util.List;

import lombok.Data;

@Data
public class MemberDTO {

	private String userid;
	private String userpw;
	private String userName;
	private boolean enabled;
	
	private LocalDate regDate;
	private LocalDate updateDate;
	private List<AuthDTO> authList;
	
}
