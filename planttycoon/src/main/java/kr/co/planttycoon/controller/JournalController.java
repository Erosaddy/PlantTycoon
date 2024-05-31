package kr.co.planttycoon.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.planttycoon.domain.JournalDTO;
import kr.co.planttycoon.service.JournalSerivce;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class JournalController {

	@Autowired
	private JournalSerivce jService;
	
	@GetMapping("/journal/list")
	public String list(Model model, HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		List<JournalDTO> journals = jService.listAll(memberId);
		model.addAttribute("journals", journals);
		return "journal/list";
	}
	
	@GetMapping("/journal/detail/{journalId}")
	public String detail(@PathVariable int journalId, Model model, HttpSession session) {
		JournalDTO jDto = jService.detail(journalId);
		String memberId = (String) session.getAttribute("memberId");
		if(jDto != null && jDto.getMemberId().equals(memberId)) {
			model.addAttribute("jDto", jDto);
			return "journal/detail";
		} else {
			return "redirect:/journal/list";
		}
	}
	
	@GetMapping("/journal/write")
	public String writeForm(Model model) {
		return "journalwrite";
	}
	
	@PostMapping("/journal/modify/{journalId}")
	public String write(@ModelAttribute JournalDTO jDto, HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		jDto.setMemberId(memberId);
		jService.create(jDto);
		return "redirect:/journal/list";
	}
	
	@GetMapping("/journal/modify/{journalId}")
	public String modifyForm(@PathVariable int journalId, Model model, HttpSession session) {
		JournalDTO jDto =  jService.detail(journalId);
		String memberId = (String) session.getAttribute("memberId");
		if(jDto != null && jDto.getMemberId().equals(memberId)) {
			model.addAttribute("jDto", jDto);
			return "journal/modify";
		} else {
			return "redirect:/journal/list";
		}
	}
	@PostMapping("/journal/modify")
	public String modify(@ModelAttribute JournalDTO jDto, HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		if(jDto.getMemberId().equals(memberId)) {
			jService.modify(jDto);
		}
		return "redirect:/journal/list";
	}
	
	@GetMapping("/journal/delete")
	public String delete(@PathVariable int journalId, HttpSession session) {
		JournalDTO jDto = jService.detail(journalId);
		String memberId = (String) session.getAttribute("memberId");
		if(jDto != null && jDto.getMemberId().equals(memberId)) {
			jService.remove(journalId);
		}
		return "redirect:/journal/list";
	}
}
