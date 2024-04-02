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

<div class="m-3">

  <h1>Sign Up</h1>
  
  <form method="POST"
        action="${contextPath}/user/signup.do"
        id="frm-signup">
  
    <div class="row mb-3">
      <label for="inp-email" class="col-sm-3 col-form-label">아이디</label>
      <div class="col-sm-6"><input type="text" id="inp-email" name="email" class="form-control" placeholder="example@example.com"></div>
      <div class="col-sm-3"><button type="button" id="btn-code" class="btn btn-primary">인증코드받기</button></div>
      <div class="col-sm-3"id="msg-email"></div>
    </div>
    <div class="row mb-3">
      <label for="inp-code" class="col-sm-3 col-form-label">인증코드</label>
      <div class="col-sm-6"><input type="text" id="inp-code" class="form-control" placeholder="인증코드입력" disabled></div>
      <div class="col-sm-3"><button type="button" id="btn-verify-code" class="btn btn-primary" disabled>인증하기</button></div>
    </div>
    
    <hr class="my-3">
  
    <div class="row mb-3">
      <label for="inp-pw" class="col-sm-3 col-form-label">비밀번호</label>
      <div class="col-sm-6"><input type="password" id="inp-pw" name="pw" class="form-control"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-9" id="msg-pw"></div>
    </div>
    <div class="row mb-3">
      <label for="inp-pw2" class="col-sm-3 col-form-label">비밀번호 확인</label>
      <div class="col-sm-6"><input type="password" id="inp-pw2" class="form-control"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-9" id="msg-pw2"></div>
    </div>
    
    <hr class="my-3">
    
    <div class="row mb-3">
      <label for="inp-name" class="col-sm-3 col-form-label">이름</label>
      <div class="col-sm-9"><input type="text" name="name" id="inp-name" class="form-control"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-9" id="msg-name"></div>
    </div>

    <div class="row mb-3">
      <label for="inp-mobile" class="col-sm-3 col-form-label">휴대전화번호</label>
      <div class="col-sm-9"><input type="text" name="mobile" id="inp-mobile" class="form-control"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-9" id="msg-mobile"></div>
    </div>

    <div class="row mb-3">
      <label class="col-sm-3 form-label">성별</label>
      <div class="col-sm-3">
        <input type="radio" name="gender" value="none" id="rdo-none" class="form-check-input" checked>
        <label class="form-check-label" for="rdo-none">선택안함</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="gender" value="man" id="rdo-man" class="form-check-input">
        <label class="form-check-label" for="rdo-man">남자</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="gender" value="woman" id="rdo-woman" class="form-check-input">
        <label class="form-check-label" for="rdo-woman">여자</label>
      </div>
    </div>
    
    <hr class="my-3">
    
    <div class="form-check mb-3">
      <input type="checkbox" name="service" class="form-check-input" id="chk-service">
      <label class="form-check-label" for="chk-service">서비스 이용약관 동의(필수)</label>
    </div>
    <div>
      <textarea rows="5" class="form-control">본 약관은 ...</textarea>
    </div>
    
    <div class="form-check mb-3">
      <input type="checkbox" name="event" class="form-check-input" id="chk-event">
      <label class="form-check-label" for="chk-event">
        이벤트 알림 동의(선택)
      </label>
    </div>
    <div>
      <textarea rows="5" class="form-control">본 약관은 ...</textarea>
    </div>
    
    <hr class="my-3">
    
    <div class="m-3">
      <button type="submit" id="btn-signup" class="btn btn-primary">가입하기</button>
    </div>
    
  </form>

</div>
  
  <script>
  const fnGetContextPath = ()=>{
	  const host = location.host;  /* localhost:8080 */
	  const url = location.href;   /* http://localhost:8080/mvc/getDate.do */
	  const begin = url.indexOf(host) + host.length;
	  const end = url.indexOf('/', begin + 1);
	  return url.substring(begin, end);
	}
  
    /*
    new Promise((resolve, reject) => {
      $.ajax({
        url: '이메일중복체크요청'
      })
      .done(resData => {
        if(resData.enableEmail){
          resolve();
        } else {
          reject();
        }
      })
    })
    .then(() => {
      $.ajax({
        url: '인증코드전송요청'
      })
      .done(resData => {
        if(resData.code === 인증코드입력값)
      })
    })
    .catch(() => {
      
    })
  */
  
  /*
    fetch('이메일중복체크요청', {})
    .then(response=>response.json())
    .then(resData=>{
      if(resData.enableEmail){
        fetch('인증코드전송요청', {})
        .then(response=>response.json())
        .then(resData=>{  // {"code": "123asb"}
          if(resData.code === 인증코드입력값)
        })
      }
    })
  */
  
  
  const fnCheckEmail = ()=> {
	  let inpEmail = document.getElementById('inp-email');
	  let regEmail = /^[A-Za-z0-9-_]{2,}@[A-Za-z0-9]+(\.[A-Za-z]{2,6}){1,2}$/;
	  if(!regEmail.test(inpEmail.value)){
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
				'email': inpEmail.value
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
  				// 이메일 중복체크 통과 후 인증코드 받기
  			 fetch(fnGetContextPath() + '/user/sendCode.do', {
  				 method: "POST",
  			   headers:{ 
  				   'Content-Type': 'application/json'
  			   }, 
  			   body: JSON.stringify({ // JSON 만들어 주는 함수. 괄호 안에 자바스크립트 객체를 넣으면 JSON으로 바뀐다
  				   'email': inpEmail.value
  			 }) 
			})
  	  .then(response => response.json())
  	  .then(resData => {  // resData = {"code" : "123qaz"}
  	   let inpCode = document.getElementById('inp-code');
  	   let btnVerifyCode = document.getElementById('btn-verify-code');
  	   alert(inpEmail.value + '로 인증코드를 전송했습니다.');
  	   inpCode.disabled = false;
  	   btnVerifyCode.disabled = false;
  	   btnVerifyCode.addEventListener('click', (evt) => {
  		   if(resData.code === inpCode.value){
  			   alert('인증되었습니다.')
  		   } else {
  			   alert('인증되지 않았습니다.');
  		   }
  	   })  	   
  	  })
			 
			// 중복 통과 실패 지점 (중복 이메일이 있는 지점)	
			} else {
				document.getElementById('msg-email').innerHTML = '이미 사용 중인 이메일입니다.';
				return;
			}
		})
  }
  

  const fnCheckPassword = () => {
	  // 비밀번호 4~12자, 영문/숫자/특수문자 중 2개 이상 포함
	  let inpPw = document.getElementById('inp-pw');
	  let validCount = /[A-Za-z]/.test(inpPw.value)     // 영문 포함되어 있으면 true (JavaScript 에서 true 는 숫자 1 같다.)
	                 + /[0-9]/.test(inpPw.value)        // 숫자 포함되어 있으면 true
	                 + /[^A-Za-z0-9]/.test(inpPw.value) // 영문/숫자가 아니면 true
	  let passwordLength = inpPw.value.length;
	  passwordCheck = passwordLength >= 4
	               && passwordLength <= 12
	               && validCount >= 2
	  let msgPw = document.getElementById('msg-pw');
	  if(passwordCheck){
	    msgPw.innerHTML = '사용 가능한 비밀번호입니다.';
	  } else {
	    msgPw.innerHTML = '비밀번호 4~12자, 영문/숫자/특수문자 중 2개 이상 포함';
	  }
	}

	const fnConfirmPassword = () => {
	  let inpPw = document.getElementById('inp-pw');
	  let inpPw2 = document.getElementById('inp-pw2');
	  passwordConfirm = (inpPw.value !== '')
	                 && (inpPw.value === inpPw2.value)
	  let msgPw2 = document.getElementById('msg-pw2');
	  if(passwordConfirm) {
	    msgPw2.innerHTML = '';
	  } else {
	    msgPw2.innerHTML = '비밀번호 입력을 확인하세요.';
	  }
	}

	const fnCheckName = () => {
	  let inpName = document.getElementById('inp-name');
	  let name = inpName.value;
	  let totalByte = 0;
	  for(let i = 0; i < name.length; i++){
	    if(name.charCodeAt(i) > 127) {  // 코드값이 127 초과이면 한 글자 당 2바이트 처리한다.
	      totalByte += 2;
	    } else {
	      totalByte++;
	    }
	  }
	  nameCheck = (totalByte <= 100);
	  let msgName = document.getElementById('msg-name');
	  if(!nameCheck){
	    msgName.innerHTML = '이름은 100 바이트를 초과할 수 없습니다.';
	  } else {
	    msgName.innerHTML = '';
	  }
	}

	const fnCheckMobile = () => {
	  let inpMobile = document.getElementById('inp-mobile');
	  let mobile = inpMobile.value;
	  mobile = mobile.replaceAll(/[^0-9]/g, '');
	  mobileCheck = /^010[0-9]{8}$/.test(mobile);
	  let msgMobile = document.getElementById('msg-mobile');
	  if(mobileCheck) {
	    msgMobile.innerHTML = '';
	  } else {
	    msgMobile.innerHTML = '휴대전화를 확인하세요.';
	  }
	}

	const fnCheckAgree = () => {
	  let chkService = document.getElementById('chk-service');
	  agreeCheck = chkService.checked;
	}

	const fnSignup = () => {
	  document.getElementById('frm-signup').addEventListener('submit', (evt) => {
	    fnCheckAgree();
	    if(!emailCheck) {
	      alert('이메일을 확인하세요.');
	      evt.preventDefault();
	      return;
	    } else if(!passwordCheck || !passwordConfirm){
	      alert('비밀번호를 확인하세요.');
	      evt.preventDefault();
	      return;
	    } else if(!nameCheck) {
	      alert('이름을 확인하세요.');
	      evt.preventDefault();
	      return;
	    } else if(!mobileCheck) {
	      alert('휴대전화를 확인하세요.');
	      evt.preventDefault();
	      return;
	    } else if(!agreeCheck) {
	      alert('서비스 약관에 동의해야 서비스를 이용할 수 있습니다.');
	      evt.preventDefault();
	      return;
	    }
	  })
	}


	document.getElementById('btn-code').addEventListener('click', fnCheckEmail);
	document.getElementById('inp-pw').addEventListener('keyup', fnCheckPassword);
	document.getElementById('inp-pw2').addEventListener('blur', fnConfirmPassword);
	document.getElementById('inp-name').addEventListener('blur', fnCheckName);
	document.getElementById('inp-mobile').addEventListener('blur', fnCheckMobile);
	fnSignup();


	</script>
	  
	</body>
	</html>