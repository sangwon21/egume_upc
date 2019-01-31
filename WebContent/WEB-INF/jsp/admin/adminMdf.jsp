<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<script src="${pageContext.request.contextPath}/js/admInf.js"></script>
	<meta charset="UTF-8">
	<title>어드민 정보 수정</title>
</head>
<body>
	<div class="wrapper">
	<c:import url="header.jsp"></c:import>
	<div class='container'>
		<div class="title">어드민 정보 수정</div>
		<div class='container col-lg-6' style="float:none; margin:0 auto;">
		<br>
			<div id="register_container">
				<form name="f" id="f" action="adminMdfReq" method="GET" role="form" >
				<table>
					<colgroup>
						<col style="width:400px;">
						<col style="width:600px;"> 
						<col style="width:800px;">
					</colgroup>
					<tr>
						<td align="left">
							<label for="userid">아이디 </label>
						</td>
						<td>
							<input type="text" name="admid" id="admid" value="${AdminVO.admid}" class="form-control" readonly>
						</td>
						<td> </td>
					</tr>
					<tr style="height:15px;"></tr>
					<tr>
						<td align="left">
							<label for="name">이 름 </label>
						</td>
						<td>
							<input type="text" name="name" id="name" value="${AdminVO.name}" class="form-control" autocomplete="off" onkeyup="fn_nm()">
						</td>
						<td>
							<small id="nm-regexp" style="margin-left:15px">이름이 올바르지 않습니다.</small>
						</td>
					</tr>
					<tr style="height:15px;"></tr>
					<tr>
						<td align="left"><label for="email">이메일 </label></td>
						<td>
							<input type="email" name="email" id="email" size="40" class="form-control" value="${AdminVO.email}" autocomplete="off">
						</td>
					</tr>
					<tr style="height:15px;"></tr>
					<tr>
						<td align="left"><label for="tel">휴대전화 </label></td>
						<td>
							<input type="text" name="tel" id="tel" value="${AdminVO.tel}" class="form-control" autocomplete="off" onkeyup="fn_tel()">
						</td>
						<td>
							<small id="tel-regexp" style="margin-left:15px">전화번호가 올바르지 않습니다.</small>
						</td>
					</tr>
					<tr style="height:15px;"></tr>
					<tr>
						<td align="left"><label for="role">역할 </label></td>
						<td>
							<select name="role" style="width:100px;" class="form-control">
								<option value="M" <c:if test="${AdminVO.role=='M'}"> selected </c:if> >관리자</option>
								<option value="R" <c:if test="${AdminVO.role=='R'}"> selected </c:if> >접수자</option>
								<option value="W" <c:if test="${AdminVO.role=='W'}"> selected </c:if> >작성자</option>
							</select>
						</td>
					</tr>
					<tr style="height:15px;"></tr>
					<tr> 
						<td align="left"><label for="useyn">계정상태 </label></td>
						<td>
							<select name="useyn" style="width:100px;" class="form-control">
								<option value="Y" <c:if test="${AdminVO.useyn=='Y'}"> selected </c:if>>사용</option>
								<option value="N" <c:if test="${AdminVO.useyn=='N'}"> selected </c:if>>정지</option>
							</select>
						</td>
					</tr>
				</table>
				<br>
				<div class="row">
					<div class="col-md-9 text-center">
						<button type="button" class="btn btn-default" onclick="history.back()" id="back">취소</button>
						<button type="submit" id="submission" onclick="return validationCheck()" class="btn btn-primary" style="margin:5px;">수정</button>
					</div>
				</div> 
				<p>
			</form>
			</div>
			</div>
	</div>
	<div class="push"></div>
	</div>	
</body>
<footer>
	<c:import url="../footer.jsp" />
</footer>

</html>

