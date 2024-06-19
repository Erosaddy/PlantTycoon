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
import kr.co.planttycoon.domain.JournalDTO;
import kr.co.planttycoon.domain.PageDTO;
import kr.co.planttycoon.service.JournalService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class JournalController {
	
	private final JournalService Service;
	
	@Autowired
	public JournalController(JournalService Service) {
		this.Service = Service;
	}
	
	@GetMapping("/journal/list")
	public String list(Criteria cri, Model model, Principal principal) {
	    String memberId = principal.getName(); // 로그인 사용자 정보 가져오기

	    // 전체 게시글 수 조회 (한 번만 호출)
	    int total = Service.getTotalCount(memberId, cri); 

	    // 페이징 처리
	    PageDTO pageDTO = new PageDTO(total, cri); 
	    List<JournalDTO> list = Service.getListWithPaging(memberId, cri); 
	    
	    model.addAttribute("list", list);
	    model.addAttribute("pageMaker", pageDTO);  // pageMaker 속성으로 PageDTO 객체 전달
	    model.addAttribute("cri", cri); // 검색 조건 유지
	    model.addAttribute("total", total); // total 속성으로 전체 게시글 수 전달

	    return "journal/list";
	    
	}
	
//    @GetMapping("/journal/list")
//    public String list(Criteria cri, Model model, Principal principal) {
//        
//        String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
//        int total = Service.getTotalCount(memberId, cri);
//        
//        // 페이징 처리
//        PageDTO pageDTO = new PageDTO(Service.getTotalCount(memberId, cri), cri); 
//        List<JournalDTO> list = Service.getListWithPaging(memberId, cri); 
//        model.addAttribute("total", String.valueOf(total));
//        
//        model.addAttribute("list", list);
//        model.addAttribute("pageMaker", pageDTO);
//        
//        // 검색 조건 유지
//        model.addAttribute("cri", cri);
//
//        return "journal/list";
//    }

	@GetMapping("/journal/get")
	public String get(@RequestParam("journalId") int journalId, Model model, Principal principal) {
	    String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
	    JournalDTO journal = Service.get(journalId);

	    if (journal != null && journal.getMemberId().equals(memberId)) { // 작성자 확인
	        model.addAttribute("journal", journal);
	        return "journal/detail";
	    } else {
	        // 작성자가 아니거나 게시글이 존재하지 않는 경우 처리
	        return "redirect:/journal/list"; 
	    }
	}
	
//	@GetMapping("/journal/detail/{journalId}")
//	public String detail(@PathVariable int journalId, Model model, HttpSession session) {
//		JournalDTO jDto = Service.detail(journalId);
//		String memberId = (String) session.getAttribute("memberId");
//		if(jDto != null && jDto.getMemberId().equals(memberId)) {
//			model.addAttribute("jDto", jDto);
//			return "journal/detail";
//		} else {
//			return "redirect:/journal/list";
//		}
//	}
	
	@GetMapping("/journal/register")
	public String writeForm(Model model) {
        return "journal/register"; // 뷰 이름은 그대로 유지 (register.jsp)
    }

    @PostMapping("/journal/register")
    public String registerPOST(JournalDTO journal, RedirectAttributes rttr, Principal principal) {
        log.info("journalDTO: " + journal);

        String memberId = principal.getName(); // 로그인된 사용자 ID 가져오기
        journal.setMemberId(memberId); // JournalDTO에 memberId 설정

        Service.register(journal); // 게시글 등록 서비스 호출

        rttr.addFlashAttribute("result", "register success"); // 등록 성공 메시지

        return "redirect:/journal/list"; // 목록 페이지로 리다이렉트
    }
   
    @GetMapping("/journal/modify")
    public void modify(@RequestParam("journalId") int journalId, Model model, Principal principal) {
        log.info("modify: " + journalId);

        // 로그인 사용자 정보 가져오기
        String memberId = principal.getName();

        // 게시글 정보 조회
        JournalDTO jDto = Service.get(journalId);

        // 작성자 확인
        if(jDto != null && jDto.getMemberId().equals(memberId)) {
            model.addAttribute("jDto", jDto);
        } else {
            throw new AccessDeniedException("수정 권한이 없습니다."); // 접근 권한 예외 발생
        }
        model.addAttribute("journal", Service.get(journalId)); // 게시글 정보를 "journal"이라는 이름으로 모델에 추가
    }

    @PostMapping("/journal/modify")
    public String modifyPost(@ModelAttribute("journal") JournalDTO journal, RedirectAttributes rttr, Principal principal) {
        log.info("modifyPost: " + journal);

        // 작성자 확인
        String principalMemberId = principal.getName();
        if (journal != null && journal.getMemberId().equals(principalMemberId)) {
            // 수정 성공 여부에 따라 다른 메시지 전달
            if (Service.modify(journal)) {
                rttr.addFlashAttribute("result", "modify success");
            } else {
                rttr.addFlashAttribute("result", "modify fail");
            }
        } else {
            rttr.addFlashAttribute("result", "notAuthorized");
        }

        rttr.addAttribute("journalId", journal.getJournalId());
        return "redirect:/journal/get";
    }
    
//	@PostMapping("/journal/modify/{journalId}")
//	public String write(@ModelAttribute JournalDTO jDto, HttpSession session) {
//		String memberId = (String)session.getAttribute("memberId");
//		jDto.setMemberId(memberId);
//		Service.register(jDto);
//		return "redirect:/journal/list";
//	}
//	
//	@GetMapping("/journal/modify/{journalId}")
//	public String modifyForm(@PathVariable int journalId, Model model, HttpSession session) {
//		JournalDTO jDto =  Service.get(journalId);
//		String memberId = (String) session.getAttribute("memberId");
//		if(jDto != null && jDto.getMemberId().equals(memberId)) {
//			model.addAttribute("jDto", jDto);
//			return "journal/modify";
//		} else {
//			return "redirect:/journal/list";
//		}
//	}
//	@PostMapping("/journal/modify")
//	public String modify(@ModelAttribute JournalDTO jDto, HttpSession session) {
//		String memberId = (String) session.getAttribute("memberId");
//		if(jDto.getMemberId().equals(memberId)) {
//			Service.modify(jDto);
//		}
//		return "redirect:/journal/list";
//	}
	
    @GetMapping("/journal/remove") // GET 방식으로 삭제 요청 처리
    public String remove(@RequestParam("journalId") int journalId, RedirectAttributes rttr, Principal principal) {
        String memberId = principal.getName(); // 로그인 사용자 정보 가져오기
        JournalDTO journal = Service.get(journalId);

        if (journal != null && journal.getMemberId().equals(memberId)) { // 작성자 확인
            if (Service.remove(journalId)) { // 삭제 성공 시
                rttr.addFlashAttribute("result", "success");
            } else {
                rttr.addFlashAttribute("result", "fail");
            }
        } else {
            rttr.addFlashAttribute("result", "notAuthorized"); // 삭제 권한 없음
        }

        return "redirect:/journal/list"; // 목록 페이지로 리다이렉트
    }
    
//	@GetMapping("/journal/delete")
//	public String delete(@PathVariable int journalId, HttpSession session) {
//		JournalDTO jDto = Service.get(journalId);
//		String memberId = (String) session.getAttribute("memberId");
//		if(jDto != null && jDto.getMemberId().equals(memberId)) {
//			Service.remove(journalId);
//		}
//		return "redirect:/journal/list";
//	}
}
