package kr.co.planttycoon.service;

import kr.co.planttycoon.domain.MemberDTO;

public interface IMemberService {

	public int join(MemberDTO mDto);
	public int idCheck(String memberId);
	public int modifyNickname(MemberDTO mDto);
	
}
