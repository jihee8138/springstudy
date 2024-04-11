package com.gdu.myapp.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
 
public class UploadDto {
  
  private int uploadNo;
  private int attachCount;
  private String title, contents, createDt, modifyDt;
  private UserDto user;

}
