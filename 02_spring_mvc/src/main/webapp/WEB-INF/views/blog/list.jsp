<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>블로그 목록</title>
<style>
  .blog {
    width: 200px;
    cursor: pointer;
    background-color: yellow;
  }
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>

  <c:forEach items="${blogList}" var="blog" varStatus="vs">
    <div class="blog">
      <span>${vs.index}</span>
      <span class="blog-no">${blog.blogNo}</span>
      <span>${blog.title}</span>
    </div>
  </c:forEach>
  
  <script type="text/javascript">
    
  // 화살표 함수에서는 this의 사용이 불가능하다
  // 연결되는 이벤트 대상과 형태가 일반함수와 차이가 있다. 
  // 화살표 함수 : 클릭했을 때 text 부분은 div로 인식하지 않고 span으로 인식
  // 클릭할 때 이벤트 대상을 어떨 땐 자식으로, 어떨 땐 부모로 인식
  // 일반함수 : 어디를 클릭하든 div로 인식
  
    <%--  
    화살표 함수 
    $('.blog').on('click', (evt)=> {
      alert(evt.target);
    })
    
    일반함수
    $('.blog').on('click', function(evt) {
      alert(this);
    })
    --%>
  
    $('.blog').on('click', function(evt) {
    	let blogNo = $(this).find('.blog-no').text();
    	location.href = '${contextPath}/blog/detail.do?blogNo=' + blogNo;
    });
  
  </script>
</body>
</html>