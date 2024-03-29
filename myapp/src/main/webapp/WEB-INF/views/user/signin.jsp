<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 로그인 화면 구성 -->

<!-- include libraries(jquery, bootstrap) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.css">
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>

</head>
<body>
  
  <h1>Sign In</h1>
  
  <div>
    <form method="POST"
          action="${contextPath}/user/signin.do">
          <!-- db까지 전달되어야 하는 데이터들 -->
      <div>
        <label for="email">아이디</label>
        <input type="text" id="email" name="email" placeholder="example@naver.com">
      </div>      
      <div>
        <label for="pw">비밀번호</label>
        <input type="password" id="pw" name="pw" placeholder="●●●●">
      </div>   
      <!-- Model 로 저장한 건 EL 로 확인할 수 있다. 실제로 로그인을 수행할 때 같이 보내줘야 한다. -->
      <!-- Model 에 저장되어 있는 건 한 번만 저장되는 일회용이다.  --> 
      <div>
        <input type="hidden" name="url" value="${url}">
        <button type="submit">Sign In</button>
        
      </div>  
    </form>
  </div>

</body>
</html>