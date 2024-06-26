package kr.co.planttycoon.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.planttycoon.domain.Criteria;
import kr.co.planttycoon.domain.NoticeDTO;
import kr.co.planttycoon.domain.PageDTO;
import kr.co.planttycoon.service.NoticeService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class NoticeController {
	
	private final NoticeService Service;
	
	@Autowired
	public NoticeController(NoticeService Service) {
		this.Service = Service;
	}
	
	@GetMapping("/notice/list")
	public String list(Criteria cri, Model model, Principal principal) {
	    String memberId = principal.getName(); // 로그인 사용자 정보 가져오기

	    // 전체 게시글 수 조회 (한 번만 호출)
	    int total = Service.getTotalCount(cri); 

	    // 페이징 처리
	    PageDTO pageDTO = new PageDTO(total, cri); 
	    List<NoticeDTO> list = Service.getListWithPaging(cri); 
	    
	    model.addAttribute("list", list);
	    model.addAttribute("pageMaker", pageDTO);  // pageMaker 속성으로 PageDTO 객체 전달
	    model.addAttribute("cri", cri); // 검색 조건 유지
	    model.addAttribute("total", total); // total 속성으로 전체 게시글 수 전달
	    
	    log.info("pageDTO=============> " + pageDTO);

	    return "notice/list";
	    
	}
	
    @GetMapping("/notice/get")
    public String get(@RequestParam("noticeId") int noticeId, Model model) { // principal 제거
        NoticeDTO notice = Service.get(noticeId);
        model.addAttribute("notice", notice);
        return "notice/detail";
    }
	
	
	@GetMapping("/notice/register")
	public String writeForm(Model model) {
        return "notice/register"; // 뷰 이름은 그대로 유지 (register.jsp)
    }

    @PostMapping("/notice/register")
    public String registerPOST(NoticeDTO notice, RedirectAttributes rttr, Principal principal) {
        log.info("noticeDTO: " + notice);

        String memberId = principal.getName(); // 로그인된 사용자 ID 가져오기
        notice.setMemberId(memberId); // JournalDTO에 memberId 설정

        Service.register(notice); // 게시글 등록 서비스 호출

        rttr.addFlashAttribute("result", "register success"); // 등록 성공 메시지

        return "redirect:/notice/list"; // 목록 페이지로 리다이렉트
    }
   
    @GetMapping("/notice/modify")
    public void modify(@RequestParam("noticeId") int noticeId, Model model, Principal principal) {
        log.info("modify: " + noticeId);

        // 로그인 사용자 정보 가져오기
        String memberId = principal.getName();

        // 게시글 정보 조회
        NoticeDTO nDto = Service.get(noticeId);

        // 작성자 확인
        if(nDto != null && nDto.getMemberId().equals(memberId)) {
            model.addAttribute("nDto", nDto);
        } else {
            throw new AccessDeniedException("수정 권한이 없습니다."); // 접근 권한 예외 발생
        }
        model.addAttribute("notice", Service.get(noticeId)); // 게시글 정보를 "journal"이라는 이름으로 모델에 추가
    }

    @PostMapping("/notice/modify")
    public String modifyPost(@ModelAttribute("notice") NoticeDTO notice, RedirectAttributes rttr, Principal principal) {
        log.info("modifyPost: " + notice);

        // 작성자 확인
        String principalMemberId = principal.getName();
        if (notice != null && notice.getMemberId().equals(principalMemberId)) {
            // 수정 성공 여부에 따라 다른 메시지 전달
            if (Service.modify(notice)) {
                rttr.addFlashAttribute("result", "modify success");
            } else {
                rttr.addFlashAttribute("result", "modify fail");
            }
        } else {
            rttr.addFlashAttribute("result", "notAuthorized");
        }

        rttr.addAttribute("noticeId", notice.getNoticeId());
        return "redirect:/notice/get";
    }
    
    @GetMapping("/notice/remove") // GET 방식으로 삭제 요청 처리
    public String remove(@RequestParam("noticeId") int noticeId, RedirectAttributes rttr, Principal principal) {
        String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
        NoticeDTO notice = Service.get(noticeId);

        if (notice != null && notice.getMemberId().equals(memberId)) { // 작성자 확인
            if (Service.remove(noticeId)) { // 삭제 성공 시
                rttr.addFlashAttribute("result", "success");
            } else {
                rttr.addFlashAttribute("result", "fail");
            }
        } else {
            rttr.addFlashAttribute("result", "notAuthorized"); // 삭제 권한 없음
        }

        return "redirect:/notice/list"; // 목록 페이지로 리다이렉트
    }
}
