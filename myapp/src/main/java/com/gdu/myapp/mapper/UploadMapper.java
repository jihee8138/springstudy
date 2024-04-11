package com.gdu.myapp.mapper;

import java.util.List;
import java.util.Map;

import com.gdu.myapp.dto.AttachDto;
import com.gdu.myapp.dto.UploadDto;

public interface UploadMapper {
  int insertUpload(UploadDto upload);
  int insertAttach(AttachDto attach);
  int getUploadCount();
  List<UploadDto> getUploadList(Map<String, Object> map);
  

}
