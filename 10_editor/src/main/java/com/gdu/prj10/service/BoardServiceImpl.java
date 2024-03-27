package com.gdu.prj10.service;

import java.io.File;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.prj10.utils.MyFileUtils;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service  // spring 컨테이너에 bean으로 보드서비스를 만들기 위해
// 이게 component다

public class BoardServiceImpl implements BoardService {
  
  private final MyFileUtils myFileUtils;

  @Override
  public ResponseEntity<Map<String, Object>> summernoteImageUpload(MultipartHttpServletRequest multipartRequest) {
    
    // 저장 경로
    String uploadPath = myFileUtils.getUploadPath();
    File dir = new File(uploadPath);
    if(!dir.exists()) {
      dir.mkdirs();
    }
    
    // 저장 파일
    MultipartFile multipartFile = multipartRequest.getFile("image");
    // 저장할 이름 결정
    String filesystemName = myFileUtils.getFilesystemName(multipartFile.getOriginalFilename());
    // file 객체로 만들기
    File file = new File(dir, filesystemName);
    
    // 실제 저장
    try {
      multipartFile.transferTo(file);
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    // 반환할 Map
    // view 단으로 보낼 src = "/prj10/upload/2024/03/27/1234567890.jpg"
    // servlet-context.xml 에서 <resources> 태그를 추가한다. 
    // <resources mapping="/upload/**" location="file:///upload/">
    
    // 로케이션 경로 작성 시 주의 프로젝트 외부의 일반경로의 경우 file: 붙여줘야함
    // file:///upload/ = c:/upload/
    
    // callback할 redirectUrl 반환
    // image 저장 -> image의 경로를  주소형식(contextPath부터 경로 생성)으로 생성 후 view 에게 넘겨줌
    Map<String, Object> map = Map.of("src", multipartRequest.getContextPath() + uploadPath + "/" + filesystemName);
    
    // 반환
    return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
  }

}
