package kr.co.planttycoon.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.planttycoon.domain.AuthorityDTO;
import kr.co.planttycoon.domain.MemberDTO;

public interface MemberMapper {
	
	public MemberDTO read(String memberId);
	public int createMember(MemberDTO mDto);
	public int createMemberAuthority(String memberId);
	public int idCheck(String memberId);
	public int modifyNickname(MemberDTO mDto);
	
}
