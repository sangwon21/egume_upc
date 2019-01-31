<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:import url="header.jsp" />
<html lang="en">

<script>

function loginValidation() {
	var id = $("#id").val();
	var pw = $("#password").val();
	var result = false;
	if(id == "") {
		alert("아이디를 입력해 주십시오.");
		$("#id").focus();
	} else if(pw == "") {
		alert("패스워드를 입력해 주십시오.");
		 $("#password").focus();
	} else {
		$.ajax({
			type:'GET',
			url:'/egume_upc/rgstid/prtnumCheck',
			data:{'prtnum' : id},
			dataType:"text",
			async:false,
			success:function(data) {
				if(data > 0) {
					result = true;
				}
				else {
					alert("존재하지 않는 아이디입니다.");
					$("#id").focus();
				}
			}, error:function(request, status, error) {
				console.log("id check error >> code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
			}
		});
	}
	if(result) {
		document.loginForm.action = "${pageContext.request.contextPath}/user/login";
		document.loginForm.method = "POST";
		document.loginForm.submit();
	} else{
		return result;
	}
	
}


function fnJoin(){
	var url = "${pageContext.request.contextPath}/rgstid/join.do";
	document.loginForm.action =  "${pageContext.request.contextPath}/rgstid/join.do";
	document.loginForm.method = "GET";
	$("#id").val(null);
	$("#password").val(null);
	document.loginForm.submit(); 
}

</script>
  <head>
  </head>
  <body>
<div id="contentsWrapper">
<!-- First Container--> 
<div id="section1"  class="bg1 container text-center" style="position: inherit;"></div>


<sec:authorize access="isAnonymous()">
 <form id="loginForm" name="loginForm" method="POST" action="${pageContext.request.contextPath}/user/login">
<div class="container">
<div class="container login">
	<div class="row">
	<div class="col-sm-2 col-md-1" style="margin-top:5px"></div>
	<div class="col-sm-2 col-md-2" style="margin-top:5px" align="center"><font size="5" color="#3083ba"><span class="glyphicon glyphicon-off" style="color:#3083ba;"> </span> <strong> &nbsp;LOGIN</strong></font></div>
	<div class="col-sm-2 col-md-2" style="margin-top:5px; min-width:250px"><input type="text" class="form-control" id="id" name="id" placeholder="사업자등록번호"></div>
	<div class="col-sm-2 col-md-2" style="margin-top:5px; min-width:250px"><input type="password" class="form-control" id="password" name="password"  placeholder="패스워드"></div>
	<div class="col-sm-3 col-md-3" style="margin-top:5px;">
		<div class="btn-group">
		<input type="submit" class="btn btn-primary" onclick="return loginValidation();" value="로그인">
  		<input type="button" class="btn btn-success" onclick="fnJoin()" value="가입하기">
  		</div>
	</div>
	<div class="col-sm-1 col-md-1 col-md-offset-0" style="margin-top:5px"></div>
	</div>
</div>
</div>
<c:set var="error" value="${param.error }" />
<c:if test="${param.error != null}">
	<script>
		alert('아이디와 비밀번호가 일치하지 않습니다.');
	</script>
</c:if>	  			
</form>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
<div class="container login"  align='center'>
		<h4><sec:authentication property="principal.cmpnnm"/>
			<sec:authentication property="principal.mgrname"/> 
			<c:if test="${prepayyn != null && rmncnt != null && (prepayyn eq 'Y' || rmncnt ne 0)}">
			(잔여발급가능건수 : <span class="text-primary"><b>${rmncnt }</b></span> 건)</c:if> 님 환영합니다.</h4>
</div>

</sec:authorize>

<input type="hidden" name="loginRedirect" value="${loginRedirect}" />
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

 <!-- Second Container -->
<div class="container panel-group">
	<div class="panel panel-default">
		<div class="panel-heading text-center"> 
 			<h3>구매확인서 발급신청 대행 서비스 이용안내</h3>
 		</div>
	<div class="panel-body text-center">
  		<span class="glyphicon glyphicon-ok"> </span> 사전발급 : 구매일 기준 익월 10일까지 신청건, 세금계산서 수취전 발급<br>
  		<span class="glyphicon glyphicon-ok "> </span> 사후발급 : 10일 이후 신청건, 세금계산서(과세/영세율) 필요
  		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
  		<div class="row" align="center">
  		<div class="col-sm-2 col-sm-offset-0"></div>
  		<div class="col-sm-2"  style="width:160px; margin:15px;"><p id="rcorners2"><img alt="서비스가입" src="${pageContext.request.contextPath}/img/m_icn01.png" style="margin: 5px"><a href="${pageContext.request.contextPath}/join"><button type="button" class="btn btn-info"><strong>서비스가입</strong></button></a></p> </div>
  		<div class="col-sm-2"  style="width:160px; margin:15px;"><p id="rcorners2"><img alt="발급지원신청" src="${pageContext.request.contextPath}/img/m_icn02.png" style="margin: 5px"><button type="button" class="btn btn-info"><strong>발급신청</strong></button></a></p></div>
  		<div class="col-sm-2"  style="width:160px; margin:15px;"><p id="rcorners2"><img alt="견본확인" src="${pageContext.request.contextPath}/img/m_icn04.png" style="margin: 5px"><button type="button" class="btn btn-info"><strong>견본확인</strong></button></p></div>
  		<div class="col-sm-2"  style="width:160px; margin:15px;"><p id="rcorners2"><img alt="발행확인" src="${pageContext.request.contextPath}/img/m_icn06.png" style="margin: 5px"><button type="button" class="btn btn-info"><strong>구매확인서발행</strong></button></p></div>
  		<div class="col-sm-2 col-sm-offset-4"></div>
		</div>
	</div>

	<div class="panel panel-default">
		<div class="panel-heading text-center"> 
  			<h3>구매확인서 발급 대행 운영시간 및 문의 및 제출처 </h3>
  		</div>
   		<div class="panel-body text-center">
     		<div class="col-sm-2"></div>
    		<div class="col-sm-1">
    			<img src="${pageContext.request.contextPath}/img/icon_info_pc.png" class="img-responsive margin" alt="Image" style="float: left">
    		</div>
    		<div class="col-sm-6 text-left"> 
 				 <!--   <p>평일  :  09:00~18:00 발급<br>
      				매월 10일은 09:00~21:00발급<br>(휴일인 경우, 다음 근무일 적용)</p> --> 
      				<p>당일 16시까지 접수건은 당일 발급, 16시 이후 익일 발급</p>
      				<p> ※ 매월 월마감일(10일, 공휴일인 경우 다음 근무일)은 신청의 폭주로 인해 접수 누락 및 발급이 지연될 경우가 있으니 사전(2일전)에 신청하여야 하며, 반드시 진행상황을 확인하여 주시기 바랍니다</p>
    		</div>
    		<div class="col-sm-3 text-left"> 
      			<span class="glyphicon glyphicon-phone-alt"> 전화: 02-6000-2056</span><br>
      			<span class="glyphicon glyphicon-list-alt"> 팩스: 02-6000-2053 </span><br>
      			<span class="glyphicon glyphicon-envelope"> 이메일: service@ktnet.co.kr</span><br>
    		</div>
  		</div>
	</div>
</div>
</div>
</div>
</body>
<c:import url="footer.jsp" />
</html>
    