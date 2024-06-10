package kr.co.planttycoon.service;

import java.util.List;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.MemberDTO;

public interface IMemberService {

	public int join(MemberDTO mDto);
	public int idCheck(String memberId);
	public int modifyNickname(MemberDTO mDto);
	public List<MemberDTO> memberList(Criteria cri);
	public int getTotalCnt(Criteria cri);
	public int modifyEnabled(String enabled, String memberId);
}
