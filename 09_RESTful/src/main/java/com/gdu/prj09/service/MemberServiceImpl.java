package com.gdu.prj09.service;

import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.gdu.prj09.dao.MemberDao;
import com.gdu.prj09.dto.AddressDto;
import com.gdu.prj09.dto.MemberDto;
import com.gdu.prj09.utils.MyPageUtils;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

  private final MemberDao memberDao;
  private final MyPageUtils myPageUtils;
  
  @Override
  public ResponseEntity<Map<String, Object>> getMembers(int page, int display) {
    
    int total = memberDao.getTotalMemberCount();
    
    // 호출해서 넘기면 비긴과 앤드값의 계산이 끝난다
    myPageUtils.setPaging(total, display, page);
    
    // member_t의 쿼리문의 이름과 이 코드의 이름이 맞아야 한다
    // #{begin} = "begin"  /  #{end} = "end"
    
    // 반환타입이 맵으로 잡혀있는 이유 : total값과 List를 저장하기 위해서
    Map<String, Object> params = Map.of("begin", myPageUtils.getBegin()
                                      , "end", myPageUtils.getEnd());
    
    // 목록 불러오기
    List<AddressDto> members = memberDao.getMemberList(params);
    //member.jsp에서 쓴 것들
    return new ResponseEntity<Map<String,Object>>(Map.of("members", members
                                                          , "total", total
                                                          , "paging", myPageUtils.getAsyncPaging())
                                                        , HttpStatus.OK);
  }

  @Override
  public ResponseEntity<Map<String, Object>> getMemberByNo(int memberNo) {
    
    //address 목록 가져올 때 필요한 작업들
    int total = memberDao.getTotalAddressCountByNo(memberNo);
    int page = 1;
    int display = 20;
    
    myPageUtils.setPaging(total, display, page);
    
    Map<String, Object> params = Map.of("memberNo", memberNo
                                      , "begin", myPageUtils.getBegin()
                                      , "end", myPageUtils.getEnd());
    // address 목록 가져오기
    List<AddressDto> addressList = memberDao.getAddressListByNo(params); 
    // 회원정보
    MemberDto member = memberDao.getMemberByNo(memberNo);
    
    // 멤버정보와 주소들 이 모든 걸 반환하라
    return new ResponseEntity<Map<String,Object>>(Map.of("addressList", addressList
                                                       , "member", member)
                                                       , HttpStatus.OK); 
    
  }

  @Override
  public ResponseEntity<Map<String, Object>> registerMember(Map<String, Object> map
                                                          , HttpServletResponse response) {
    
    ResponseEntity<Map<String, Object>> result = null;
    
    try {
      
      MemberDto member = MemberDto.builder()
                          .email((String)map.get("email"))
                          .name((String)map.get("name"))
                          .gender((String)map.get("gender"))
                         .build();
      
      int insertCount = memberDao.insertMember(member);
      
      AddressDto address = AddressDto.builder()
                            .zonecode((String)map.get("zonecode"))
                            .address((String)map.get("address"))
                            .detailAddress((String)map.get("detailAddress"))
                            .extraAddress((String)map.get("extraAddress"))
                            .member(member)
                           .build();
                                
      insertCount += memberDao.insertAddress(address);
      
      result = new ResponseEntity<Map<String,Object>>(
                      Map.of("insertCount", insertCount),
                      HttpStatus.OK);
      
    } catch (DuplicateKeyException e) {  // catch(Exception e) { 이름 확인 : e.getClass().getName() }
            
      try {
        
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.println("이미 가입된 이메일입니다.");  // jqXHR 객체의 responseText 속성으로 확인 가능
        out.flush();
        out.close();
        
      } catch (Exception e2) {
        e.printStackTrace();
      }
      
    }
    
    return result;
    
  }

  @Override
  public ResponseEntity<Map<String, Object>> modifyMember(Map<String, Object> map) {
    
    int updateMemberCount = memberDao.updateMember(map);
    int updateAddressCount = memberDao.updateAddress(map);
    
    if(updateAddressCount == 0) {
      AddressDto address = AddressDto.builder()
                                     .zonecode((String)map.get("zonecode"))
                                     .address((String)map.get("address"))
                                     .detailAddress((String)map.get("detailAddress"))
                                     .extraAddress((String)map.get("extraAddress"))
                                     .member(MemberDto.builder()
                                                      .memberNo(Integer.parseInt((String)map.get("memberNo")))
                                                      .build())
                                     .build();
      
      // 여기에 모두 성공했을 때 숫자 2가 들어있어야 한다.
      updateAddressCount = memberDao.insertAddress(address);
    }
    
    
    // jackson이라는 애가 데이터를 json으로 바꿔준다 이 데이터가 member.jsp로 전달된다.
    return new ResponseEntity<Map<String,Object>>(Map.of("updateCount", updateMemberCount + updateAddressCount)
                                                , HttpStatus.OK) ;
  }

  @Override
  public ResponseEntity<Map<String, Object>> removeMember(int memberNo) {
    return new ResponseEntity<Map<String,Object>> (Map.of("deleteCount", memberDao.deleteMember(memberNo))
                                                      , HttpStatus.OK);
  }

  @Override
  public ResponseEntity<Map<String, Object>> removeMembers(String memberNoList) { 
    return new ResponseEntity<Map<String,Object>>(Map.of("deleteCount", memberDao.deleteMembers(Arrays.asList(memberNoList.split(","))))
                                                  , HttpStatus.OK);
  }

}