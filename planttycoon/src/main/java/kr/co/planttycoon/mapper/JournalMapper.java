package kr.co.planttycoon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.JournalDTO;

@Mapper
public interface JournalMapper {
	
	List<JournalDTO> getListWithPaging(@Param("memberId") String memberId, @Param("cri") Criteria cri);
	
	@Select ("SELECT * FROM journal ORDER BY journalid DESC")
	List<JournalDTO> listAll(@Param("memberId") String memberId);
	
	@Select ("SELECT * FROM journal WHERE journalid = #{journalId}")
	JournalDTO get(@Param("journalId") int journalId);
	
	@Insert ("INSERT INTO journal (journalid, journaltitle, journalcontent, memberid, journalregdate) VALUES (journal_seq.nextval, #{journalTitle}, #{journalContent}, #{memberId}, SYSDATE)")
	void insert(JournalDTO jDto);
	
	@Update ("UPDATE journal SET journaltitle = #{journalTitle}, journal_content = #{journalContent} WHERE journalid = #{journalId}")
	void update (JournalDTO jDto);
	
	@Delete("DELETE FROM journal WHERE journalid = #{journalId}")
    int delete(int journalId);
	
	@Select("SELECT count(*) FROM journal WHERE memberid = #{memberId}")
    int getTotalCount(@Param("memberId") String memberId, @Param("cri") Criteria cri);

	List<JournalDTO> getList(@Param("cri") Criteria cri, @Param("memberId") String memberId);

    int getTotalCount(@Param("cri") Criteria cri, @Param("memberId") String memberId);
    
	
	
}
