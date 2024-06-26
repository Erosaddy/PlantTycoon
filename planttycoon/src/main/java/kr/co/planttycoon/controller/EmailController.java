package kr.co.planttycoon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.co.planttycoon.domain.MemberDTO;
import kr.co.planttycoon.service.IMemberService;
import lombok.RequiredArgsConstructor;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@RequiredArgsConstructor
@RestController
public class EmailController {

    private final JavaMailSender mailSender;
    private final IMemberService service;
    
//    @RequestMapping("/findAuth")
//    @ResponseBody
//    public Map<String, Object> findAuth(MemberDTO mDto) {
//        Map<String, Object> map = new HashMap<>();
//
//        try {
//            // 사용자 존재 여부 확인
//            MemberDTO isUser = service.read(mDto.getMemberId());
//            if (isUser == null) {
//                map.put("status", false);
//                map.put("message", "존재하지 않는 사용자입니다.");
//                return map;
//            }
//
//            // 이메일 주소 확인
//            if (!isUser.getMemberId().equals(mDto.getMemberId())) {
//                map.put("status", false);
//                map.put("message", "이메일 주소가 일치하지 않습니다.");
//                return map;
//            }
//
//            // 랜덤 인증번호 생성
//            Random r = new Random();
//            int num = r.nextInt(999999);
//
//            // 이메일 내용 작성
//            String setFrom = "blackyokel@naver.com";
//            String tomail = isUser.getMemberId();
//            String title = "[PlantTycoon] 비밀번호 변경 인증 이메일입니다.";
//            StringBuilder sb = new StringBuilder();
//            sb.append(String.format("안녕하세요 %s님\n", isUser.getNickname()));
//            sb.append(String.format("PlantTycoon 비밀번호 찾기(변경) 인증번호는 %d입니다.", num));
//            String content = sb.toString();
//
//            // 이메일 전송
//            MimeMessage msg = mailSender.createMimeMessage();
//            MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "utf-8");
//            msgHelper.setFrom(setFrom);
//            msgHelper.setTo(tomail);
//            msgHelper.setSubject(title);
//            msgHelper.setText(content);
//            mailSender.send(msg);
//
//            // 성공적으로 메일을 보낸 경우
//            map.put("status", true);
//            map.put("num", num);
//            map.put("memberId", isUser.getMemberId());
//        } catch (MessagingException e) {
//            map.put("status", false);
//            map.put("message", "메일 전송 중 오류가 발생했습니다.");
//        } catch (Exception e) {
//            map.put("status", false);
//            map.put("message", "서버 오류가 발생했습니다.");
//        }
//
//        return map;
//    }
}

