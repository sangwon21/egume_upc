<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
   	<link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
    <title>구매확인서 발급지원 어드민</title>
</head>

<body>
<div id="contentsWrapper">
<nav class="navbar navbar-inverse">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#"><strong>구매확인 발급지원 관리자 시스템</strong></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="https://admin.utrade.or.kr">uTHAdmin</a></li>
        <li><a href="https://ulocal.utradehub.or.kr/admin/index.jsp">ulocalAdmin</a></li>
        <li><a href="https://www.utradehub.or.kr">uTradeHub</a></li>
      </ul>
    </div>
  </div>
 </nav>
  <!-- First Container -->
 
<div class="container-fluid text-center" style="background-color:#F1F1F1;">
   <br>
 <!--  <img src="
 ${pageContext.request.contextPath}/img/admin_login.png" class="img-responsive img-circle margin" style="display:inline" width="350" height="300"> -->
  <img src="${pageContext.request.contextPath}/img/admin_login.png" class="img-thumbnail"  style="margin-bottom: 20px">
  <h4><strong>구매확인서 발급지원 관리자 로그인</strong></h4>
</div>
	<div class="container" style="margin-top: 10px;">
		<div class="col-sm-4"></div>
		<div class="col-sm-4">
			<c:url value="/admin/login" var="url" />
			<form id="form" method="POST" action="${url}">
	  			<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
					<input id="id" type="text" class="form-control" name="id" placeholder="Id">
	    		</div>
	    		<div class="input-group">
	      			<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
	      			<input id="pw" type="password" class="form-control" name="password" placeholder="Password">
	    		</div>
	    		<br>
	    		<div>
	    			<c:if test="${param.error != null}">
	    				<p> 아이디와 비밀번호가 일치하지 않습니다. </p>
	    			</c:if>
	    		</div>
	    		<br>
	    		<div align="center">
	    			<button type="submit" class="btn btn-default" onclick="return validation()">로그인</button>
	    		</div>
	    		<input type="hidden" name="loginRedirect" value="${loginRedirect}" />
	    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</div>
		<div class="col-sm-4"></div>
	</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/login.js"></script>
</div>
</body>
<footer>
	<c:import url="./footer.jsp"/>
</footer>
</html>
