package kr.co.planttycoon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.mapper.MemberMapper;
import kr.co.planttycoon.service.IMemberService;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
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

	@Override
	public int modifyNickname(MemberDTO mDto) {
		return mapper.modifyNickname(mDto);
	}

	@Override
	public List<MemberDTO> memberList(Criteria cri) {
		return mapper.memberList(cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) {
	    return mapper.getTotalCnt(cri);
	}

	@Override
	public int modifyEnabled(String enabled, String memberId) {
		log.info("ServiceImpl enabled ...... " + enabled);
		log.info("ServiceImpl memberId ...... " + memberId);
		return mapper.modifyEnabled(enabled, memberId);
	}
	
}
