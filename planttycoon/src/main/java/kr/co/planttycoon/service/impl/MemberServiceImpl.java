package kr.co.planttycoon.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.AuthorityDTO;
import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.mapper.MemberMapper;
import kr.co.planttycoon.service.IMemberService;
import lombok.Setter;

@Service

public class MemberServiceImpl implements IMemberService {
	
	private final MemberMapper mapper;
	
	private final PasswordEncoder pwencoder;
	
	@Autowired
	public MemberServiceImpl(MemberMapper mapper, PasswordEncoder pwencoder) {
		this.mapper = mapper;
		this.pwencoder = pwencoder;
	}

	@Transactional
    @Override
    public int join(MemberDTO mDto) {
        try {
        	
        	mDto.setMemberPw(pwencoder.encode(mDto.getMemberPw()));
        	
            mapper.createMember(mDto);
            
            int result = mapper.createMemberAuthority(mDto.getMemberId());
            
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("회원가입 중 예외가 발생했습니다.");
        }
		
    }
	
	@Override
	public int idCheck(String memberId) {
		return mapper.idCheck(memberId);
	}


}
