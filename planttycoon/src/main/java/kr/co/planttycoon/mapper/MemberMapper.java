package kr.co.planttycoon.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.planttycoon.domain.MemberDTO;

public interface MemberMapper {
	
	public MemberDTO read(String userid);
}
