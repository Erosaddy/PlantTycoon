package kr.co.planttycoon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.ControlDTO;
import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.mapper.LedcontrolMapper;
import kr.co.planttycoon.mapper.MemberMapper;
import kr.co.planttycoon.service.IMemberService;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements IMemberService {
	
	private final MemberMapper mapper;
	
	private final PasswordEncoder pwencoder;
	
	private final LedcontrolMapper ledmapper;
	
	@Autowired
	public MemberServiceImpl(MemberMapper mapper, PasswordEncoder pwencoder, LedcontrolMapper ledmapper) {
		this.mapper = mapper;
		this.pwencoder = pwencoder;
		this.ledmapper = ledmapper;
	}
	
	@Transactional
	@Override
	public int join(MemberDTO mDto) {
	    try {
	        mDto.setMemberPw(pwencoder.encode(mDto.getMemberPw()));
	        mapper.createMember(mDto);

	        int result = mapper.createMemberAuthority(mDto.getMemberId());

	        // LED 상태 추가
	        ControlDTO ledControlDTO = new ControlDTO();
	        ledControlDTO.setMemberId(mDto.getMemberId());
	        //ledControlDTO.setLedStatus("F"); // 초기 LED 상태 설정
	        ledmapper.insertLedControl(ledControlDTO);

	        return result;
	    } catch (Exception e) {
	        e.printStackTrace(); // 상세한 예외 메시지를 출력
	        throw new RuntimeException("회원가입 중 예외가 발생했습니다: " + e.getMessage(), e);
	    }
	}
	
	@Override
	public int idCheck(String memberId) {
		return mapper.idCheck(memberId);
	}

	@Override
	public int modifyMember(MemberDTO mDto) {
	    
	    try {
            
	        int result = mapper.modifyMember(mDto);
	        
	        return result;
	        
        } catch (Exception e) {
            e.getStackTrace();
            throw new RuntimeException("회원 정보 수정 중 예외가 발생했습니다.");
        }
	}
	
	@Override
	public int modifyEnabled(String enabled, String memberId) {
	    return mapper.modifyEnabled(enabled, memberId);
	}
	
	@Override
	public int updatePassword(String memberPw, String memberId) {
	    String hashedPw = pwencoder.encode(memberPw);
	    
	    return mapper.updatePassword(hashedPw, memberId);
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
    public MemberDTO read(String memberId) {
        return mapper.read(memberId);
    }

	
}
