package kr.co.planttycoon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.planttycoon.domain.JournalDTO;

@Mapper
public interface JournalMapper {
	
	@Select ("SELECT * FROM ORDER BY journalid DESC")
	List<JournalDTO> listAll(@Param("memberId") String memberId);
	
	@Select ("SELECT * FROM journal WHERE journalid = #{journalId}")
	JournalDTO detail(@Param("journalId") int journalId);
	
	@Insert ("INSERT INTO journal (journalid, journaltitle, journalcontent, memberid, journalregdate) VALUES (journal_seq.nextval, #{journalTitle}, #{journalContent}, #{memberId}, SYSDATE)")
	void insert(JournalDTO jDto);
	
	@Update ("UPDATE journal SET journaltitle = #{journalTitle}, journal_content = #{journalContent} WHERE journalid = #{journalId}")
	void update (JournalDTO jDto);
	
	@Delete ("DELETE FROM journal WHERE journalid = #{journalId}")
	void delete (@Param("journalId") int journalId);
}
