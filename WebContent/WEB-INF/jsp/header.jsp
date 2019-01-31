<!DOCTYPE html">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html lang="ko">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.2/css/bootstrapValidator.min.css"/>
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css" />

<script >
 $(document).ready(function(){
	
	$("#topnav li a").each(function(){
		
		//현재 url과 메뉴 url 값을 구한다
		var path= window.location.href;
		var current = path.substring(path.lastIndexOf('/')+1);
		var url = $(this).attr('href');
		url = url.substring(url.lastIndexOf('/')+1);
		
		if(current == url && url != ''){ //Home 제외하고 현재 메뉴 하이라이트 
			$(this).removeClass();
			$(this).addClass('active');
		}
	});
}); 

</script>
<head>
  <title>구매확인서 발급지원 서비스</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<div id="topnav" class="topnavi">
<div class="container">
	<ul>
   		<li style="float:left; width:300px;"><a style="text-align:left" href="${pageContext.request.contextPath}/"><font size="4">구매확인 발급지원 서비스</font></a></li>
   		<li style="float:right;"><sec:authorize access="isAnonymous()"><a href="${pageContext.request.contextPath}/user/loginForm.do" >로그인</a></sec:authorize></li>
   		<li style="float:right;"><sec:authorize access="isAuthenticated()"><a href="${pageContext.request.contextPath}/user/logout.do">로그아웃</a></sec:authorize></li>
 		<li style="float:right;"><a href="${pageContext.request.contextPath}/user/usrinf/userInfo.do">MyInfo</a></li>
  		<li style="float:right;"><a href="${pageContext.request.contextPath}/user/reqfrm/prchCnfrmApplList.do">현황조회</a></li>
  		<li style="float:right;"><a href="${pageContext.request.contextPath}/user/reqfrm/prchCnfrmApplCreate.do">발급신청</a></li>
  	</ul>
 </div>
</div>

</body>
</html>
