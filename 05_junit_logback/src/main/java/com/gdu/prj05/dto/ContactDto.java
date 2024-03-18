package com.gdu.prj05.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class ContactDto {
  private int contactNo;
  private String name;
  private String mobile;
  private String email;
  private String address;
  private String createdAt;
}

// 칼럼 이름에 들어가는 밑줄을 밑줄 칼럼의 이름을 카멜 케이스로 바꿔서 이용하기 : 마이바티스의 옵션 이용하여
