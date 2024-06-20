package kr.co.planttycoon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.MemberDTO;

public interface MemberMapper {
	
	public MemberDTO read(String memberId);
	public int createMember(MemberDTO mDto);
	public int createMemberAuthority(String memberId);
	public int idCheck(String memberId);
	public int modifyMember(MemberDTO mDto);
	public int modifyEnabled(@Param("enabled") String enabled, @Param("memberId") String memberId);
	public List<MemberDTO> memberList(Criteria cri);
	public int getTotalCnt(Criteria cri);
	
}
