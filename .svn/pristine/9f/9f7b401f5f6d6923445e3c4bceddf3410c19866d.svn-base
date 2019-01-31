<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<script src="${pageContext.request.contextPath}/js/admInf.js"></script>
	<meta charset="UTF-8">
	<title>어드민 등록</title>
</head>
<body>
	<div class="wrapper">
	<c:import url="header.jsp"></c:import>
	<div class='container'>
		<div class="title">어드민 등록</div>
		<div class='container col-lg-7' style="float:none; margin:0 auto;">
		<br>
			<div id="register_container">
				<form name="f" id="form" action="adminRgst" method="post" role="form" >
				<table>
					<colgroup>
						<col style="width:400px;">
						<col style="width:600px;"> 
						<col style="width:800px;">
					</colgroup>
					<tr>
						<td align="left">
							<label for="userid">아이디</label>
						</td>
						<td> 
							<input type="text" name="admid" id="admid" placeholder="아이디를 입력하세요" class="form-control" onkeyup="idCheck();" autocomplete="off">
						</td>
						<td>
							<small id="id-success" style="margin-left:15px">사용 가능한 아이디 입니다.</small>  
							<small id="id-danger" style="margin-left:15px">이미 등록된 아이디 입니다.</small>
							<br>
							<small id="id-length" style="margin-left:15px">아이디는 6자 이상 20자 이하입니다.</small>
							<br>
							<small id="id-regexp" style="margin-left:15px">숫자와 영문을 혼합하여 입력해주십시오.</small>
						</td>
					</tr>
					<tr style="height:15px;"></tr>
					<tr>
						<td align="left">
							<label for="pw">비밀번호 </label>
						</td>
						<td>
							<input type="password" name="pw" id="pw" class="form-control" placeholder="비밀번호를 입력하세요" onkeyup="fn_password()">
						</td>
						<td>
							<small id="pw-length" style="margin-left:15px">패스워드는 6자 이상 20자 이하입니다.</small>
							<br>
							<small id="pw-regexp" style="margin-left:15px">숫자와 영문을 혼합하여 입력해주십시오.</small>
						</td>
					</tr>
					<tr style="height:15px;"></tr>
					<tr>
						<td align="left">
							<label for="upwd2">비밀번호확인 </label>
						</td>
						<td>
							<input type="password" name="pw2" id="pw2" class="form-control" placeholder="비밀번호를 재입력하세요" onkeyup="passwordCheck()">
						</td>
						<td>
							<small id="pw-success" style="margin-left:15px">비밀번호가 일치합니다</small>
							<small id="pw-danger" style="margin-left:15px">비밀번호가 일치하지 않습니다</small>
						</td>
					</tr>
					<tr style="height:15px;"></tr>
					<tr>
						<td align="left">
							<label for="name">이 름 </label>
						</td>
						<td>
							<input type="text" name="name" id="name" placeholder="이름을 입력하세요" class="form-control" autocomplete="off" onkeyup="fn_nm()">
						</td>
						<td>
							<small id="nm-regexp" style="margin-left:15px">이름이 올바르지 않습니다.</small>
						</td>
					</tr>
					<tr style="height:15px;"></tr>
					<tr>
						<td align="left"><label for="email">
								이메일 </label></td>
						<td><input type="email" name="email" id="email" class="form-control" placeholder="이메일을 입력하세요" autocomplete="off"></td>
					</tr>
					<tr style="height:15px;"></tr>
					<tr>
						<td align="left"><label for="tel">휴대전화</label></td>
						<td><input type="text" name="tel" id="tel" placeholder="전화번호를 입력하세요" class="form-control" autocomplete="off" onkeyup="fn_tel()"></td>
						<td>
							<small id="tel-regexp" style="margin-left:15px">전화번호가 올바르지 않습니다.</small>
						</td>
					</tr>
					<tr style="height:15px;"></tr>
					<tr>
						<td align="left"><label for="role">역할 </label></td>
						<td>
							<select name="role" style="width:100px;" class="form-control">
								<option value="M">관리자</option>
								<option value="R">접수자</option>
								<option value="W">작성자</option>
							</select>
						</td>
					</tr>
					<tr style="height:15px;"></tr>
					<tr>
						<td align="left"><label for="useyn">계정상태 </label></td>
						<td>
							<select name="useyn" style="width:100px;" class="form-control">
								<option value="Y">사용</option>
								<option value="N">정지</option>
							</select>
						</td>
					</tr>
				</table>
				<br>
				<div class="row">
					<div class="col-md-9 text-center">
						<button type="reset" class="btn btn-default">초기화</button>
						<button type="submit" id="submission" onclick="return validationCheck()" class="btn btn-primary" style="margin:5px;">등록</button>
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

