<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/main.css">
    <title>UPC-로그인 페이지</title>
</head>
<header>
	<c:import url="header.jsp"></c:import>
</header>
<style>
	
/*
 * Card component
 */
.card {
    background-color: #F7F7F7;
    /* just in case there no content*/
    padding: 20px 25px 30px;
    margin: 0 auto 25px;
    margin-top: 50px;
    /* shadows and rounded borders */
    -moz-border-radius: 2px;
    -webkit-border-radius: 2px;
    border-radius: 2px;
    -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
}

.profile-img-card {
    width: 96px;
    height: 96px;
    margin: 0 auto 10px;
    display: block;
    -moz-border-radius: 50%;
    -webkit-border-radius: 50%;
    border-radius: 50%;
}

</style>
<body style="height:100%;">

<!-- First Container--> 
<div id="section1"  class="bg1 container-fluid text-center">
</div>
	 <div class="container" style="padding-top:70px;">
        <div class="card card-container col-lg-6" style="float:none; margin:0 auto;">
           <img id="profile-img" class="profile-img-card" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" />
           <form name="loginForm" id="loginForm" method="POST" action="${pageContext.request.contextPath }/user/login">
					<div class="form-group" style="padding-top:50px; padding-bottom:50px;">
					<label for="id" class="col-sm-4 control-label">사업자등록번호</label>
					<div class="col-sm-8">
						<input type="number" class="form-control" name="id" id="id">
					</div>
				</div>
				<div class="form-group"  style="padding-bottom:100px;">
					<label for="password" class="col-sm-4 control-label">패스워드</label>
					<div class="col-sm-8">
						<input type="password" class="form-control" name="password" id="password" >
					</div>
				</div>
				<div class="btn-group col-sm-12">
					<button type="submit" class="btn btn-primary col-sm-6"> 로그인 </button>
					<a href="${pageContext.request.contextPath}/rgstid/join.do" class="btn btn-success col-sm-6"> 회원가입</a>
				</div>

				<hr />
				
				<input type="hidden" name="loginRedirect" value="${loginRedirect}" />
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<c:set var="error" value="${param.error }" />
				<c:if test="${param.error != null}">
					<p>::${error}</p>
					<script>
						alert('아이디와 비밀번호가 일치하지 않습니다.');
					</script>
				</c:if>	  			
				</form>
        </div><!-- /card-container -->
    </div><!-- /container -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
<footer style="position:absolute; bottom: 0; width: 100%; height:115px;">
	<c:import url="footer.jsp"/>
</footer>
</html>
