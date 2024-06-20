package kr.co.planttycoon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.JournalDTO;
import kr.co.planttycoon.domain.NoticeDTO;

@Mapper
public interface NoticeMapper {
	
	List<NoticeDTO> getListWithPaging(@Param("memberId") String memberId, @Param("cri") Criteria cri);
	
	@Select ("SELECT * FROM notice ORDER BY noticeid DESC")
	List<NoticeDTO> listAll(@Param("memberId") String memberId);
	
	@Select ("SELECT * FROM notice WHERE noticeid = #{noticeId}")
	NoticeDTO get(@Param("noticeId") int noticeId);
	
	@Update("UPDATE notice SET noticetitle = #{noticeTitle}, noticecontent = #{noticeContent} WHERE noticeid = #{noticeId}")
	int update(NoticeDTO notice);
	
	@Delete("DELETE FROM notice WHERE noticeid = #{noticeId}")
    int delete(int noticeId);
	
    int getTotalCount(@Param("memberId") String memberId, @Param("cri") Criteria cri);

	List<NoticeDTO> getList(@Param("cri") Criteria cri, @Param("memberId") String memberId);

    @Insert("INSERT INTO notice (noticeid, noticetitle, noticecontent, memberid, regdate) " +
            "VALUES (notice_seq.nextval, #{noticeTitle}, #{noticeContent}, #{memberId}, SYSDATE)")
    @Options(useGeneratedKeys = true, keyProperty = "noticeId", keyColumn = "noticeid") // keyColumn 추가
    int insert(NoticeDTO nDto);
    
    List<NoticeDTO> getNoticeListWithPaging(@Param("cri") Criteria cri); // 메서드 이름 변경
    
    @Select("SELECT n.*, m.nickname " +
            "FROM notice n JOIN member m ON n.memberid = m.memberid " +
            "WHERE n.noticeid = #{noticeId}")
    NoticeDTO getWithNickname(@Param("noticeId") int noticeId);
}
    
	
	

