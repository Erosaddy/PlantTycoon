package kr.co.planttycoon.controller;

import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.service.IMemberService;

@Controller
public class AuthController {
    
    private final IMemberService service;
    private final JavaMailSender mailSender;
    
    @Autowired
    public AuthController(IMemberService service, JavaMailSender mailSender) {
        this.service = service;
        this.mailSender = mailSender;
    }
    
    // 세션에서 사용하는 필드명 상수로 정의
    private static final String SESSION_AUTH_NUMBER = "authNumber";
    private static final String SESSION_AUTH_USER = "authUser";
    private static final String SESSION_AUTH_TOKEN = "authToken";
    private static final String SESSION_PASSWORD_CHANGE_ALLOWED = "passwordChangeAllowed";
    
    // map에 key로 사용할 문자열 상수로 정의
    private static final String STATUS = "status";
    private static final String MESSAGE = "message";
    private static final String PASSWORD_CHANGE_RESULT = "passwordChangeResult";
    
    @GetMapping("/login")
    public void loginInput(String error, String logout, Model model, @RequestParam(value = "resetSession", required = false) Boolean resetSession, HttpSession session) {
        
        if (Boolean.TRUE.equals(resetSession)) {
            session.removeAttribute(SESSION_AUTH_NUMBER);
            session.removeAttribute(SESSION_AUTH_USER);
            session.removeAttribute(SESSION_AUTH_TOKEN);
            session.removeAttribute(SESSION_PASSWORD_CHANGE_ALLOWED);
        }
        
        if (error != null) {
            if (error.equals("true")) {
                model.addAttribute("error", "아이디 혹은 비밀번호가 일치하지 않습니다.");
            } else if (error.equals("disabled")) {
                model.addAttribute("error", "비활성화된 계정입니다.");
            }
        } else if (logout != null) {
            model.addAttribute("logout", "로그아웃 되었습니다.");
        }
    }
    
    @GetMapping("/customLogout")
    public String logoutGET() {
        return "/customLogout";
    }
    
    @GetMapping("/join")
    public String joinInput() {
        return "/join";
    }
    
    @PostMapping("/join")
    public String join(MemberDTO mDto, RedirectAttributes rttr) {
        int result = service.join(mDto);
        
        if (result == 1) {
            rttr.addFlashAttribute("signUpResult", "success");
        } else {
            rttr.addFlashAttribute("signUpResult", "failure");
        }
        
        return "redirect:/login";
    }
    
    @PostMapping("/findAuth")
    @ResponseBody
    public Map<String, Object> findAuth(MemberDTO mDto, HttpSession session) {
        Map<String, Object> map = new HashMap<>();

        try {
            // 사용자 존재 여부 확인
            MemberDTO isUser = service.read(mDto.getMemberId());
            if (isUser == null) {
                map.put(STATUS, false);
                map.put(MESSAGE, "존재하지 않는 사용자입니다.");
                return map;
            }

            // 랜덤 인증번호 생성
            SecureRandom secureRandom = new SecureRandom();
            int num = 100000 + secureRandom.nextInt(900000);
            
            // 인증번호를 세션에 저장
            session.setAttribute(SESSION_AUTH_NUMBER, num);
            session.setAttribute(SESSION_AUTH_USER, isUser.getMemberId());

            // 이메일 내용 작성
            String setFrom = "blackyokel@naver.com";
            String tomail = isUser.getMemberId();
            String title = "[PlantTycoon] 비밀번호 변경 인증 이메일입니다.";
            StringBuilder sb = new StringBuilder();
            sb.append(String.format("안녕하세요 %s님\n", isUser.getNickname()));
            sb.append(String.format("PlantTycoon 비밀번호 찾기(변경) 인증번호는 %d입니다.", num));
            String content = sb.toString();

            // 이메일 전송
            MimeMessage msg = mailSender.createMimeMessage();
            MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "utf-8");
            msgHelper.setFrom(setFrom);
            msgHelper.setTo(tomail);
            msgHelper.setSubject(title);
            msgHelper.setText(content);
            mailSender.send(msg);

            // 성공적으로 메일을 보낸 경우
            map.put(STATUS, true);
            map.put("num", num);
            map.put("memberId", isUser.getMemberId());
            map.put(MESSAGE, "해당 메일로 인증 번호를 전송했습니다.");
        } catch (MessagingException e) {
            map.put(STATUS, false);
            map.put(MESSAGE, "메일 전송 중 오류가 발생했습니다.");
        } catch (Exception e) {
            map.put(STATUS, false);
            map.put(MESSAGE, "서버 오류가 발생했습니다.");
        }

        return map;
    }
    
    @PostMapping("/verifyAuth")
    @ResponseBody
    public Map<String, Object> verifyAuth(@RequestParam int authNumber, HttpSession session, RedirectAttributes rttr) {
        
        Map<String, Object> map = new HashMap<>();
        Integer sessionAuthNumber = (Integer) session.getAttribute(SESSION_AUTH_NUMBER);
        String sessionAuthUser = (String) session.getAttribute(SESSION_AUTH_USER);

        if (sessionAuthNumber != null && sessionAuthNumber == authNumber) {
            // 고유 토큰 생성
            String token = UUID.randomUUID().toString();
            session.setAttribute(SESSION_PASSWORD_CHANGE_ALLOWED, true);
            session.setAttribute(SESSION_AUTH_TOKEN, token);
            
            map.put(STATUS, true);
            map.put(MESSAGE, "인증에 성공했습니다.");
            map.put("memberId", sessionAuthUser);
            map.put(SESSION_AUTH_TOKEN, token);
        } else {
            map.put(STATUS, false);
            map.put(MESSAGE, "인증번호가 일치하지 않습니다.");
        }

        return map;
    }
    
    @GetMapping("/changePassword")
    public String changePassword(@RequestParam("token") String token, HttpSession session) {
         Boolean passwordChangeAllowed = (Boolean) session.getAttribute(SESSION_PASSWORD_CHANGE_ALLOWED);
         String sessionToken = (String) session.getAttribute(SESSION_AUTH_TOKEN);
         
         if (passwordChangeAllowed != null && passwordChangeAllowed && token.equals(sessionToken)) {
            return "/changePassword"; // 비밀번호 변경 폼 페이지로 이동
         } else {
            return "/accessError"; // 접근이 허용되지 않음을 알리는 페이지로 이동
         }
    }
    
    @PostMapping("/changePassword")
    public String changePassword(@RequestParam String newPassword, @RequestParam String token, HttpSession session, RedirectAttributes rttr) {
        String sessionAuthUser = (String) session.getAttribute(SESSION_AUTH_USER);
        String sessionToken = (String) session.getAttribute(SESSION_AUTH_TOKEN);
        
        if (sessionAuthUser != null && sessionToken != null && sessionToken.equals(token)) {

            int result = service.updatePassword(newPassword, sessionAuthUser);
            
            if (result == 1) {
                rttr.addFlashAttribute(PASSWORD_CHANGE_RESULT, "비밀번호가 변경되었습니다.");
            } else {
                rttr.addFlashAttribute(PASSWORD_CHANGE_RESULT, "비밀번호 변경에 실패했습니다.");
            }

        } else {
            rttr.addFlashAttribute(PASSWORD_CHANGE_RESULT, "비밀번호 변경 권한이 없습니다.");
        }
        
        session.removeAttribute(SESSION_AUTH_NUMBER);
        session.removeAttribute(SESSION_AUTH_USER);
        session.removeAttribute(SESSION_AUTH_TOKEN);
        session.removeAttribute(SESSION_PASSWORD_CHANGE_ALLOWED);

        return "redirect:/login";
    }
    
}
