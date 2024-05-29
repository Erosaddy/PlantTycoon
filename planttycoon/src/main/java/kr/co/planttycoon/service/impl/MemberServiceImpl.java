package kr.co.planttycoon.service.impl;

import org.apache.el.stream.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.mapper.MemberMapper;
import kr.co.planttycoon.service.IMemberService;

public class MemberServiceImpl implements IMemberService{
	
	private final MemberMapper mapper;
	
	@Autowired
	public MemberServiceImpl(MemberMapper mapper) {
		this.mapper = mapper;
	}

	@Transactional
    @Override
    public int join(MemberDTO mDto) {
        try {
        	
            int result = mapper.createMember(mDto);
            
            mapper.createMemberAuthority(mDto);

            if (result == 1) {
                return 1; // 성공
            } else {
                throw new RuntimeException("회원가입 중 오류가 발생했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("회원가입 중 예외가 발생했습니다.");
        }
    }


}
