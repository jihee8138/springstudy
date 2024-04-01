package com.gdu.myapp.mapper;

import java.util.Map;

import com.gdu.myapp.dto.LeaveUserDto;
import com.gdu.myapp.dto.UserDto;

public interface UserMapper {
  UserDto getUserByMap(Map<String, Object> map);
  int insertAccessHistory(Map<String, Object> map);
  LeaveUserDto getLeaveUserByMap(Map<String, Object> map);  // 탈퇴한 사용자 정보 반환
  int insertUser(UserDto user);
}