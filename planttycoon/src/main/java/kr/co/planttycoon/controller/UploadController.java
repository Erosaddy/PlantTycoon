package kr.co.planttycoon.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
public class UploadController {

//    @Value("${upload.path}")
//    private String uploadPath;
//
//    @PostMapping("/journal/upload/image")
//    @ResponseBody
//    public Map<String, Object> uploadImage(@RequestParam("upload") MultipartFile file, HttpServletRequest request) {
//        Map<String, Object> response = new HashMap<>();
//
//        
//        try {
//            // 이미지 파일 유효성 검사
//            if (file == null || file.isEmpty()) {
//                throw new IOException("이미지 파일이 없습니다.");
//            }
//            if (!file.getContentType().startsWith("image/")) {
//                throw new IOException("이미지 파일만 업로드 가능합니다.");
//            }
//
//            // 이미지 파일 저장 로직
//            String originalFilename = file.getOriginalFilename();
//            String extension = FilenameUtils.getExtension(originalFilename);
//            String savedFileName = UUID.randomUUID().toString() + "." + extension;
//
//            // 저장 경로 설정 (외부 경로)
//            File uploadDir = new File(uploadPath);
//            if (!uploadDir.exists()) {
//                uploadDir.mkdirs();
//            }
//
//            File targetFile = new File(uploadPath, savedFileName);
//            file.transferTo(targetFile);
//
//            // CKEditor 응답 형식에 맞게 JSON 데이터 생성
//            response.put("uploaded", 1);
//            response.put("fileName", originalFilename);
//            response.put("url", "/display?fileName=" + savedFileName);
//        } catch (IOException e) {
//            response.put("uploaded", 0);
//            response.put("error", Map.of("message", e.getMessage()));
//            e.printStackTrace(); // 또는 로깅 처리
//        }
//
//        return response;
//    }
    

	private String saveUrl = "C:\\Users\\hanul\\git\\PlantTycoon\\planttycoon\\src\\main\\webapp\\resources\\fileUpload\\";
    private String loadUrl = "http://192.168.0.213:9090/resources/fileUpload/";

    @PostMapping("/ajax/image")
    public ResponseEntity<Map<String, Object>> image(MultipartHttpServletRequest request) {
        log.info("Upload request received");

        List<MultipartFile> fileList = request.getFiles("upload");
        Map<String, Object> response = new HashMap<>();
        String imgPath = null;

        for (MultipartFile mf : fileList) {
            if (mf.getSize() > 0) {
                try {
                    String originFileName = mf.getOriginalFilename();
                    log.info("Uploading file: " + originFileName);
                    String ext = FilenameUtils.getExtension(originFileName);
                    String newImgFileName = "img_" + UUID.randomUUID() + "." + ext;

                    imgPath = loadUrl + newImgFileName;

                    File file = new File(saveUrl + newImgFileName);
                    mf.transferTo(file);

                    log.info("File uploaded to: " + imgPath);
                } catch (IOException e) {
                    log.error("Error uploading file", e);
                    response.put("uploaded", false);
                    response.put("error", "Error uploading file");
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
                }
            }
        }

        response.put("uploaded", true);
        response.put("url", imgPath);
        log.info("Response: " + response);

        return ResponseEntity.ok(response);
    }
}