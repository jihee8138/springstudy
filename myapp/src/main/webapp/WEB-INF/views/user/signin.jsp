<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="../layout/header.jsp">
  <jsp:param value="Sign In" name="title"/>
</jsp:include>

<h1 class="title">Sign In</h1>
  
<div>
  <form method="POST"
        action="${contextPath}/user/signin.do">
        <!-- db로 가거나 서비스 로직이 필요한 것 : .do -->
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
    <div>
      <a href="${naverLoginURL}">
        <img src="${contextPath}/resources/2021_Login_with_naver_guidelines_Kr/btnG_아이콘원형.png">
      </a>
    </div>
  </form>
</div>

<%@ include file="../layout/footer.jsp" %>