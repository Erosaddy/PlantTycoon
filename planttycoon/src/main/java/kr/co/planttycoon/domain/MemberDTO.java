package kr.co.planttycoon.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberDTO {

	private String memberId;
	private String memberPw;
	private String nickname;
	private boolean enabled;
	
	private Date lastLogin;
	private Date regDate;
	private List<AuthorityDTO> authorityList;
	
}
