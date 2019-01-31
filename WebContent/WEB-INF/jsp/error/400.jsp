<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/error.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:500" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Titillium+Web:700,900" rel="stylesheet">

<title>Insert title here</title>
</head>
<body>
<div id="error">
	<div class="error">
		<div class="error-400">
			<h1>400</h1>
		</div>
		<h2>잘못된 요청으로 요청사항을 수행할 수 없습니다.</h2>
		<p>Sorry, The request cannot be fulfilled due to bad syntax.</p>
		<sec:authorize access="hasAnyAuthority('M')"> 
			<a href="${pageContext.request.contextPath}/admin/userJoinReqList.do"><span class="glyphicon glyphicon-home"></span> 홈으로</a>
		</sec:authorize>
		<sec:authorize access="hasAnyAuthority('R')"> 
			<a href="${pageContext.request.contextPath}/admin/applrcpt/prchCnfrmApplList.do"><span class="glyphicon glyphicon-home"></span> 홈으로</a>
		</sec:authorize>
		<sec:authorize access="hasAnyAuthority('W')"> 
			<a href="${pageContext.request.contextPath}/admin/wrtlist.do"><span class="glyphicon glyphicon-home"></span> 홈으로</a>
		</sec:authorize>
		<sec:authorize access="hasAuthority('Y')">
			<a href="${pageContext.request.contextPath }" ><span class="glyphicon glyphicon-home"></span> 홈으로</a>
		</sec:authorize>
	</div>
</div>
</body>
</html>