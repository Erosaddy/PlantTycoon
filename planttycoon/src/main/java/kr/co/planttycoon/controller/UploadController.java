package kr.co.planttycoon.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UploadController {

//    @Value("${upload.path}")
    private String uploadPath;

    @PostMapping("/journal/upload/image")
    @ResponseBody
    public Map<String, Object> uploadImage(@RequestParam("upload") MultipartFile file, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();

        
        try {
            // 이미지 파일 유효성 검사
            if (file == null || file.isEmpty()) {
                throw new IOException("이미지 파일이 없습니다.");
            }
            if (!file.getContentType().startsWith("image/")) {
                throw new IOException("이미지 파일만 업로드 가능합니다.");
            }

            // 이미지 파일 저장 로직
            String originalFilename = file.getOriginalFilename();
            String extension = FilenameUtils.getExtension(originalFilename);
            String savedFileName = UUID.randomUUID().toString() + "." + extension;

            // 저장 경로 설정 (외부 경로)
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File targetFile = new File(uploadPath, savedFileName);
            file.transferTo(targetFile);

            // CKEditor 응답 형식에 맞게 JSON 데이터 생성
            response.put("uploaded", 1);
            response.put("fileName", originalFilename);
            response.put("url", "/display?fileName=" + savedFileName);
        } catch (IOException e) {
            response.put("uploaded", 0);
            response.put("error", Map.of("message", e.getMessage()));
            e.printStackTrace(); // 또는 로깅 처리
        }

        return response;
    }
}