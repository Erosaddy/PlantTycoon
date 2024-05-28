package kr.co.planttycoon.security;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.mapper.MemberMapper;
import kr.co.planttycoon.security.domain.CustomUser;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

		log.warn("Load User By UserName : " + userName);
		
		// userName means userid
		MemberDTO dto = memberMapper.read(userName);
		
		log.warn("queried by member mapper : " + dto);
		
		return dto == null ? null : new CustomUser(dto);
	}

}
