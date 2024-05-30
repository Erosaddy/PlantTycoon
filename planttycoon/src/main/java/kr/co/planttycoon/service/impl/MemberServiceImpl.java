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
//@Primary // 어떤 이유에서인지 IMemberService와 MemberServiceImpl 두 개의 빈이 있어서 어떤 것을 의존성으로 주입해야 할지 모르겠다는 에러가 난다.
		 // 이 문제를 해결하기 위해 @Primary 어노테이션으로 구현체에 우선순위를 부여했다.
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


}
