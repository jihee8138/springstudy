<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- include libraries(jquery, bootstrap) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.css">
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>

<style type="text/css">
  @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css');
  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap')
  *{
    font-family: "Noto Sans KR", sans-serif;
    font-weight: 400;
  }
</style>

</head>
<body>

  <h1>Sign Up</h1>
  
  <form method="POST"
        action="${contextPath}/user/signup.do"
        id="frm-signup">
    <div class="mb-3">
      <lable for="email">아이디</lable>
      <input type="text" id="email" name="email" placeholder="example@example.com">
      <button type="button" id="btn-code">인증코드 받기</button>
      <div id="msg-email"></div>
    </div>
    <div class="mb-3">
      <input type="text" id="code" placeholder="인증코드입력" diasbled>
      <button type="button" id="btn-verify-code" class="btn-verify-code">인증하기</button>
    </div>
  
  </form>
  
  <script>
  const fnGetContextPath = ()=>{
	  const host = location.host;  /* localhost:8080 */
	  const url = location.href;   /* http://localhost:8080/mvc/getDate.do */
	  const begin = url.indexOf(host) + host.length;
	  const end = url.indexOf('/', begin + 1);
	  return url.substring(begin, end);
	}
  
  const fnCheckEmail = ()=> {
	  let email = document.getElementById('email');
	  let regEmail = /^[A-Aa-z0-9-_]{2,}@[A-Za-z0-9]+(\.[A-Za-z]{2,6}){1,2}$/;
	  if(!regEmail.test(email.value)){
		  alert('이메일 형식이 올바르지 않습니다.');
		  return;
	  }
	  // 이메일이 중복되는 지 확인 (db를 거쳐야 한다)
	  // 페이지는 그대로 유지하되, db를 거쳐야 한다? -> ajax 처리 해야함
		// ajax 처리 방식 2가지 : 자바스크립트 전역함수 fetch / 제이쿼리 함수
		// 컨트롤러에서 포스트 방식으로 이메일을 제이슨데이터로 만들어 보내기
		// 데이터를 보낼 때 데이터를 헤더가 아닌 본문에 실어서 보낸다
	  // 받는 자바쪽에선 에너테이션이 리퀘스트바디가 필요함 요청바디
	  
	  // 보내는 상황 : 포스트 방식으로 제이슨데이터를 보낸다
	  // 받는 쪽 : 에너테이션 리퀘스트바디로 받을 것
	  // 받을 때 쓸 실제 도구 : map
	  // 리퀘스트 바디와 맵으로 데이터를 받는다
	  // 잭슨 라이브러리가 해주는 것 : 보낼 땐 제이슨데이터, 받을 땐 맵으로 받기
		fetch(fnGetContextPath() + '/user/checkEmail.do', {
			method: "POST",
			headers:{  // 헤더값
				'Content-Type': 'application/json'
			}, 
			body: JSON.stringify({ // JSON 만들어 주는 함수. 괄호 안에 자바스크립트 객체를 넣으면 JSON으로 바뀐다
				'email': email.value
			})  
		})
		// fetch의 응답처리
		// 받아온 응답 객체(response 객체) 안에서 json만 꺼내겠다
		.then(response=>response.json())  //.then( (response) => { return response.json(); } )  
    // return 값을 받는 메소드가 추가로 들어가야한다
    // 제이슨을 받아오는 것도 then으로 받는다
    // 제이슨이 프로미스로 넘어오는 것
    // 제이슨 데이터를 서버 측에서 늦게 받더라도 기다렸다가 확실하게 넘겨주겠다
    // 그래야 비동기 작업이 순서대로 동작 가능함
    // 프로미스로 받는다 -> then으로 처리. then 안에서는 실제 데이터만 처리하면 됨
    // 이메일 중복체크 후 끝나는 작업이 아니기 때문에 비동기작업이 순차적으로 이뤄져야한다 
    // 순차처리 해주는 게 프로미스
    // 프로미스 코드는 내장되어있기때문에 적지 않아도 되지만 프로미스가 없으면 실행되지 않는다
    // then으로 받으면 순서대로 처리할 수 있음
		.then(resData => {
			// resData 안에 들어있는 데이터 딱 하나 : enableEmail
			
			// 중복 통과한 지점
			if(resData.enableEmail) {
  				// 이메일 중복체크 통과 후 인증코드 ㅂ다기
  			 fetch(fnGetContextPath() + '/user/sendCode.do', {
  				 method: "POST",
  			   headers:{ 
  				   'Content-Type': 'application/json'
  			   }, 
  			   body: JSON.stringify({ // JSON 만들어 주는 함수. 괄호 안에 자바스크립트 객체를 넣으면 JSON으로 바뀐다
  				   'email': email.value
  			 }) 
			});
			 
			 
				
			// 중복 통과 실패 지점 (중복 이메일이 있는 지점)	
			} else {
				document.getElementById('msg-email').innerHTML = '이미 사용 중인 이메일입니다.';
				return;
			}
		})
  }
  
  
  document.getElementById('btn-code').addEventListener('click', fnCheckEmail);
  
  
  </script>

  
</body>
</html>