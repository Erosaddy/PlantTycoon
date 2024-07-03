package kr.co.planttycoon.member;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.assertj.core.api.Assertions;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import kr.co.planttycoon.domain.AuthorityDTO;
import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.mapper.MemberMapper;
import kr.co.planttycoon.security.CustomUserDetailsService;
import kr.co.planttycoon.service.IMemberService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/test/resources/root-context-test.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class MemberJoinTest {

	@Autowired private MemberMapper mapper;
	@Autowired private IMemberService service;
	@Autowired private CustomUserDetailsService detailsService;
	@Autowired private DataSource ds;
	@Autowired private PasswordEncoder pwencoder;
	
//	@Test
//	public void memberCreateLoadsTest() {
//		
//		MemberDTO mDto = new MemberDTO();
//		
//		for (int i=1; i <= 100; i++) {
//			
//			mDto.setMemberId("member" + i + "@gmail.com");
//			mDto.setMemberPw("999999");
//			mDto.setNickname("member" + i);
//			
//			service.join(mDto);
//		}
//	}
	@Transactional
	@Test
    public void memberCreateTest() {
        
        MemberDTO mDto = new MemberDTO();
            
        mDto.setMemberId("member2000@gmail.com");
        mDto.setMemberPw("999999");
        mDto.setNickname("member2000");
        mDto.setPlant("산세비에리아 (Snake Plant)");
        
        service.join(mDto);
        
        MemberDTO member = mapper.read(mDto.getMemberId());
        
        Assertions.assertThat(member.getMemberId()).isEqualTo(mDto.getMemberId());
    }
	
	@Transactional
	@Test
	public void memberReadTest() {
	    MemberDTO mDto = new MemberDTO();
        
        mDto.setMemberId("member2000@gmail.com");
        mDto.setMemberPw("999999");
        mDto.setNickname("member2000");
        mDto.setPlant("산세비에리아 (Snake Plant)");
        
        service.join(mDto);
        
        MemberDTO findMemberById = service.read(mDto.getMemberId());
        
        Assertions.assertThat(findMemberById.getMemberId()).isEqualTo(mDto.getMemberId());
	}
	
//	@Test
//	public void memberListTest() {
//		
//		Criteria cri = new Criteria();
//		
//		service.memberList(cri);
//	}
		
		
//		String sql = "insert into member(memberId, memberPw, nickname) values(?,?,?)";
//
//		for(int i = 0; i < 100; i++) {
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			
//			try {
//				con = ds.getConnection();
//				pstmt = con.prepareStatement(sql);
//				
//				pstmt.setString(2, pwencoder.encode("pw" + i));
//				
//				if(i < 90) {
//					
//					pstmt.setString(1, "member" + i);
//					pstmt.setString(3, "일반회원" + i);
//					
//				} else {
//					
//					pstmt.setString(1, "admin" + i);
//					pstmt.setString(3, "관리자" + i);
//				}
//				
//				pstmt.executeUpdate();
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//			} finally {
//				if(pstmt != null) { try { pstmt.close(); } catch(Exception e) {} }
//				if(con != null) { try { con.close(); } catch(Exception e) {} }
//			}
//		} // end for
//	}
	
//	String sql = "insert into member(memberId, memberPw, nickname) values(?,?,?)";
//	
//	for(int i = 0; i < 100; i++) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(sql);
//			
//			pstmt.setString(2, pwencoder.encode("pw" + i));
//			
//			if(i < 90) {
//				
//				pstmt.setString(1, "member" + i);
//				pstmt.setString(3, "일반회원" + i);
//				
//			} else {
//				
//				pstmt.setString(1, "admin" + i);
//				pstmt.setString(3, "관리자" + i);
//			}
//			
//			pstmt.executeUpdate();
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			if(pstmt != null) { try { pstmt.close(); } catch(Exception e) {} }
//			if(con != null) { try { con.close(); } catch(Exception e) {} }
//		}
//	} // end for
	
//	
//	@Test
//	public void memberAuthorityCreateTest() {
//		String memberId = "boomer";
//		
//		int saveId = mapper.createMemberAuthority(memberId);
//		
//		if (saveId == 1) {
//			log.info("권한생성 성공......");
//		} else {
//			log.info("권한생성 실패......");
//		}
//	}
	
//	@Test
//	public void joinTest() {
//		MemberDTO mDto = new MemberDTO();
//		mDto.setMemberId("testaccount");
//		mDto.setMemberPw(pwencoder.encode("1111"));
//		log.info("인코딩된 비밀번호.......... : " + mDto.getMemberPw());
//		mDto.setNickname("testaccount");
//		
//		int result = memberServiceImpl.join(mDto);
//		
//		if (result == 1) {
//			log.info("성공.........");
//		} else {
//			log.info("실패.........");
//		}
//	}

}
