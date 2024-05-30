package kr.co.planttycoon.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
//	@GetMapping("/login")
//	public String login(Model model) {
//		return "login";
//	}
//	@GetMapping("/join")
//	public String join(Model model) {
//		return "join";
//	}
//	
//	@RequestMapping(value = "/journal/list", method = RequestMethod.GET)
//	public String journalList(Model model) {
//		return "/journal/list";
//	}
//	@RequestMapping(value = "/journal/detail", method = RequestMethod.GET)
//	public String journaldetail(Model model) {
//		return "/journal/detail";
//	}
//	@RequestMapping(value = "/journal/write", method = RequestMethod.GET)
//	public String journalwrite(Locale locale, Model model) {
//		return "/journal/write";
//	}
//	
//	@RequestMapping(value = "/notice/list", method = RequestMethod.GET)
//	public String noticeList(Locale locale, Model model) {
//		return "/notice/list";
//	}
//	@RequestMapping(value = "/notice/detail", method = RequestMethod.GET)
//	public String noticedetail(Locale locale, Model model) {
//		return "/notice/detail";
//	}
//	@RequestMapping(value = "/notice/write", method = RequestMethod.GET)
//	public String noticewrite(Locale locale, Model model) {
//		return "/notice/write";
//	}
	
	@RequestMapping(value = "/plant/monitoring", method = RequestMethod.GET)
	public String plantmonitoring(Locale locale, Model model) {
		return "/plant/monitoring";
	}
	@RequestMapping(value = "/plant/status", method = RequestMethod.GET)
	public String plantstatus(Locale locale, Model model) {
		return "/plant/status";
	}
	@RequestMapping(value = "/plant/watering", method = RequestMethod.GET)
	public String plantwatering(Locale locale, Model model) {
		return "/plant/watering";
	}
	
//	@RequestMapping(value = "/management", method = RequestMethod.GET)
//	public String management(Locale locale, Model model) {
//		return "/management";
//	}
}
