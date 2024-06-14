package kr.co.planttycoon.service;

import java.util.List;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.MemberDTO;

public interface IMemberService {

	public int join(MemberDTO mDto);
	public int idCheck(String memberId);
	public int modifyMemberInfo(MemberDTO mDto);
	public int modifyEnabled(String enabled, String memberId);
	public List<MemberDTO> memberList(Criteria cri);
	public int getTotalCnt(Criteria cri);
}
