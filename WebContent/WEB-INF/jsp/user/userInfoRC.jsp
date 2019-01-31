<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/user.css" />
<title>UPC-회원정보조회</title>
</head>
<script type="text/javascript" >
/*
 * 제출 전 필수입력사항 체크
 */
function fn_validationCheck() {

	fn_checkboxValue();

	$("#rgstid").val($("#prtnum").val());
	$("#rgstidAtt").val($("#prtnumAtt").val());
	
	var result = false;
	
	if(fn_mgrname() && fn_mgrtel() && fn_mgrphone()
			&& fn_mgrpstn() && fn_mgrfax() && fn_mgremail()) {
		$("#submission").attr('data-toggle', "modal");

	} 
	else {
		alert("입력사항을 올바르게 입력해주십시오.");
		$("#submission").removeAttr('data-toggle');
	}
	
	return result;
}

/*
 * 회원 탈퇴/수정을 위한 패스워드 확인
 */
function fn_modPwCheck(id) {
	var pw;
	if(id == "update") {
		pw = $("#modPwConfirm").val();
	} else if(id =="delete") {
		pw = $("#delPwConfirm").val();
	}
	
	var result = false;
	
	if(pw != null && pw != '') {
		$.ajax({
			type:'GET',
			url:'/egume_upc/user/usrinf/pwCheck',
			data:{'pw' : pw },
			dataType:"text",
			async:false,
			success:function(data) {
				if(data == ("true")) {
					result = true;
				} else {
					alert("패스워드가 올바르지 않습니다.");
				}
			}, error:function(request, status, error) {
				console.log("pw check error >> code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
			}
		});
	} else {
		alert("패스워드를 입력해주십시오.");
	}
	
	return result;
	
}
</script>
<body>
<div id="contentsWrapper">
	<c:import url="../header.jsp" />
	<div class="container header">
    	<div class="title">회원정보 조회</div>
	</div>
    <div class="container">
   		<form class="form-horizontal" id="form" method="post" action="${pageContext.request.contextPath}/user/usrinf/userInfo">
    		<div class="container">
	    		<div class="container col-lg-6">
	    		<h5 class="mini-title"><span class="glyphicon glyphicon-ok-circle icon"></span>  업체정보 <label class="pull-right text-primary"> 변경문의: 02)123-1234</label></h5>
					<table class="userInfo">
						<colgroup>
							<col style="width:30%;">
							<col style="width:70%;">
						</colgroup>
						<tr>
							<td><label for="prtnum">사업자등록번호<span class="text-danger">*</span></label></td>
							<td><input type="text" class="form-control" name="prtnum" id="prtnum" value="${usrInf.prtnum }" readonly></td>
						</tr>
						<tr>
							<td><label for="pw">패스워드<span class="text-danger">*</span></label></td>
							<td><input type="password" class="form-control" name="pw" id="pw" onkeyup="fn_pwCheck()">
								<small class="help-block" id="pw-notEmpty" >패스워드를 입력해주십시오.</small>
								<small class="help-block" id="pw-length" >패스워드는 6자 이상 20자 이하로 입력해주십시오.</small>
								<small class="help-block" id="pw-regexp" >숫자와 영문을 혼합하여 입력해주십시오.</small>
							</td>
						</tr>
						<tr>
							<td><label for="pwCheck">패스워드확인<span class="text-danger">*</span></label></td>
							<td><input type="password" class="form-control" name="pwCheck" id="pwCheck" onkeyup="fn_pwConfirm()">
								<small class="help-block" id="pw-identical" >패스워드가 일치하지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="cmpnnm">상호<span class="text-danger">*</span></label></td>
							<td><input type="text" class="form-control" name="cmpnnm" id="cmpnnm" value="${usrInf.cmpnnm }" readonly></td>
						</tr>
						<tr>
							<td><label for="ceonm">대표자<span class="text-danger">*</span></label></td>
							<td><input type="text" class="form-control" name="ceonm" id="ceonm" value="${usrInf.ceonm }" readonly></td>
						</tr>
						<tr>
							<td><label for="addr1">주소<span class="text-danger">*</span></label></td>
							<td><input type="text" class="form-control" name="addr1" id="addr1" value="${usrInf.addr1 }" readonly></td>
						</tr>
						<tr>
							<td></td>
							<td><input type="text" class="form-control" name="addr2" id="addr2" value="${usrInf.addr2 }" readonly></td>
						</tr>
						<tr>
							<td><label for="bsnsfileid">사업자등록증사본</label></td>
							<td><input type="text" id="bsnsfileid" class="form-control" name="bsnsfileid" value="${usrInf.bsnsfileid }" readonly></td>
						</tr>
					</table>
				</div>
				<div class="container col-lg-6">
				<h5 class="mini-title"><span class="glyphicon glyphicon-ok-circle icon"></span>  담당자정보 </h5>		
					<table class="userInfo">
						<colgroup>
							<col style="width:30%;">
							<col style="width:70%;">
						</colgroup>
						<tr>
							<td><label for="mgrname">성명<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="text" class="form-control" name="mgrname" id="mgrname" value="${usrInf.mgrname }" onkeyup="fn_mgrname()">
								<small class="help-block" id="mgrname-notEmpty" >담당자 성명을 입력해주십시오.</small>
								<small class="help-block" id="mgrname-length" >담당자 성명은 10자 이하로 입력해주십시오.</small>
								<small class="help-block" id="mgrname-regexp" >담당자 성명이 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="mgrtel">전화번호<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="text" class="form-control" name="mgrtel" id="mgrtel" value="${usrInf.mgrtel }" onkeyup="fn_mgrtel()">
								<small class="help-block" id="mgrtel-notEmpty" >담당자 전화번호를 입력해주십시오.</small>
								<small class="help-block" id="mgrtel-regexp" >담당자 전화번호가 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="mgrphone">휴대전화</label></td>
							<td colspan="2"><input type="text" class="form-control" name="mgrphone" id="mgrphone" value="${usrInf.mgrphone }" onkeyup="fn_mgrphone()">
								<small class="help-block" id="mgrphone-notEmpty" >담당자 휴대번호를 입력해주십시오.</small>
								<small class="help-block" id="mgrphone-regexp" >담당자 휴대번호가 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="mgrpstn">부서직위</label></td>
							<td colspan="2"><input type="text" class="form-control" name="mgrpstn" id="mgrpstn" value="${usrInf.mgrpstn }" onkeyup="fn_mgrpstn()">
								<small class="help-block" id="mgrpstn-notEmpty" >담당자 부서/직위를 입력해주십시오.</small>
								<small class="help-block" id="mgrpstn-length" >담당자 부서/직위는 10자 이하로 입력해주십시오.</small>
								<small class="help-block" id="mgrpstn-regexp" >담당자 부서/직위가 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="mgrfax">팩스번호</label></td>
							<td colspan="2"><input type="text" class="form-control" name="mgrfax" id="mgrfax" value="${usrInf.mgrfax }" onkeyup="fn_mgrfax()">
								<small class="help-block" id="mgrfax-notEmpty" >담당자 팩스번호를 입력해주십시오.</small>
								<small class="help-block" id="mgrfax-regexp" >담당자 팩스번호가 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="mgremail">이메일<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="email" class="form-control" name="mgremail" id="mgremail" value="${usrInf.mgremail }" onkeyup="fn_mgremail()">
								<small class="help-block" id="mgremail-notEmpty" >담당자 이메일을 입력해주십시오.</small>
								<small class="help-block" id="mgremail-regexp" >담당자 이메일이 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label class="control-label">알림서비스</label></td>
							<td><label class="checkbox-inline">
									<c:choose>
										<c:when test="${usrInf.emailyn eq 'Y'}">
											<input type="checkbox" name="emailyn" class="emailyn" checked>&nbsp;이메일
										</c:when>
										<c:otherwise>
											<input type="checkbox" name="emailyn" class="emailyn">&nbsp;이메일
										</c:otherwise>
									</c:choose>
								</label>
								<label class="checkbox-inline">
									<c:choose>
										<c:when test="${usrInf.smsyn eq 'Y'}">
											<input type="checkbox" name="smsyn" class="smsyn" checked>&nbsp;SMS
										</c:when>
										<c:otherwise>
											<input type="checkbox" name="smsyn" class="smsyn">&nbsp;SMS
										</c:otherwise>
									</c:choose>
								</label>
							</td>
						</tr>
						<c:if test="${usrInf.prepayyn eq 'Y' or usrInf.rmncnt ne 0}">
						<tr>
							<td><label class="control-label">잔여발급가능건수</label></td>
							<td><h4><label class="label label-primary">
								${usrInf.rmncnt } 건
								</label></h4>
							</td>
						</tr>
						</c:if>
					</table>
					
				</div>
				
			</div>
			<br>
			<div class="container center">
				<div class="col-sm-12 box" style="padding-bottom:20px;">
				<h5 class="marginBottom"><span class="glyphicon glyphicon-ok-circle icon"></span>  이용정보 </h5>
				<table class="userInfo">
					<colgroup>
						<col style="width:15%;">
						<col style="width:85%;">
					</colgroup>
					<tr>
						<td><label class="control-label">선불요금제</label></td>
						<td align="left"><label class="checkbox-inline">
								<c:choose>
									<c:when test="${usrInf.prepayyn eq 'Y'}">
										<input type="checkbox" name="prepayyn" class="prepayyn" checked>&nbsp;이용신청
									</c:when>
									<c:otherwise>
										<input type="checkbox" name="prepayyn" class="prepayyn">&nbsp;이용신청
									</c:otherwise>
								</c:choose>(이용 가능 건수 및 요금 : 11건 110,000원, 11번째 신청 건 무료지원)
								
							</label>
						</td>
					</tr>
					<tr>
						<td><label class="control-label">발급지원 수수료</label></td>
						<td><label class="control-label">11,000원/건당(입금계좌 : 우리은행, 1005-901-807807883, (주)한국무역정보통신)</label></td>
					</tr>
				</table>
				</div>
			</div>
			<div class="container" style="padding:30px;">
				<div class="col-sm-4"></div>
				<div class="col-sm-4 text-center row">
					<button type="button" id="deleteInfo" class="btn btn-default" data-toggle="modal" data-target="#deleteInfModal">탈퇴</button>
					<button type="button" class="btn btn-primary" onclick="return fn_validationCheck()" id="submission" data-toggle="modal" data-target="#updateInfModal">수정</button>
				</div>
				<div class="col-sm-4"></div>
			</div>
			
			<!-- 회원정보수정 Modal -->
			<div class="modal fade" id="updateInfModal" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
			          			<h4 class="modal-title">회원정보 수정</h4>
							</div>
							<div class="modal-body">
						        	<div class="form-group" >
						        		<label for="pw" class="col-sm-2 control-label">패스워드<span class="text-danger">*</span></label>
										<div class="col-sm-10">
											<input type="password" class="form-control input-sm" name="pwConfirm" id="modPwConfirm">
										</div>
						        	</div>
						        	<br>
					        </div>
							<div class="modal-footer">
					        	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					        	<button type="submit" id="update" class="btn btn-default" onclick="return fn_modPwCheck(this.id)">확인</button>
					        </div>
					</div>
				</div>
			</div>
		</form>
	</div>
		
</div>
	<!-- 회원탈퇴 Modal -->
	<div class="modal fade" id="deleteInfModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<form class="form-horizontal" method="post" action="${pageContext.request.contextPath }/user/usrinf/deleteInfo">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
	          			<h4 class="modal-title">회원 탈퇴</h4>
					</div>
					<div class="modal-body">
				        	<p>회원 탈퇴를 신청한 시간으로 부터 1년간 휴면계정으로 전환됩니다.</p>
				        	<p>이후 회원과 관련된 모든 정보가 삭제되며 탈퇴 완료 됩니다.</p>
				        	<div class="form-group" >
				        		<label for="pw" class="col-sm-2 control-label">패스워드<span class="text-danger">*</span></label>
								<div class="col-sm-10">
									<input type="password" class="form-control input-sm" name="pwConfirm" id="delPwConfirm">
								</div>
				        	</div>
				        	<br>
				       
			        </div>
					<div class="modal-footer">
			        	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			        	<button type="submit" id="delete" class="btn btn-default" onclick="return fn_modPwCheck(this.id)">확인</button>
			        </div>
			    </form>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.2/js/bootstrapValidator.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/usrInf.js"></script>
</body>
<footer><c:import url="../footer.jsp" /></footer>
</html>