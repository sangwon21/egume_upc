<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/user.css" />
	<meta charset="UTF-8">
	<script>
	function fn_popup() {
		new daum.Postcode({
			oncomplete:function(data) {
				var roadAddr = data.roadAddress; // 도로명 주소 변수
			    $("#addr1").val(roadAddr);
			 }
		}).open();
	}
	
	/*
	 * 유효성 체크
	 */
	function fn_validationCheck(button) {
		fn_checkboxValue();
		
		var result=false;
		
		if(!fn_cmpnnm()) {alert("상호명을 바르게 입력해주십시오.");	}
		else if(!fn_ceonm()) {alert("대표자명을 바르게 입력해주십시오.");	}
		else if(!fn_addr1()) {alert("주소를 바르게 입력해주십시오.");	}
		else if(!fn_addr2()) {alert("상세주소를 바르게 입력해주십시오.");	}
		else if(!fn_mgrname()) {alert("담당자명을 바르게 입력해주십시오.");	}
		else if(!fn_mgrtel()) {alert("담당자 전화번호를 바르게 입력해주십시오.");	}
		else if(!fn_mgrphone()) {alert("담당자 휴대번호를 바르게 입력해주십시오.");}
		else if(!fn_mgrpstn()) {alert("담당자 부서/직위를 바르게 입력해주십시오.");	}
		else if(!fn_mgrfax()) {alert("담당자 팩스번호를 바르게 입력해주십시오.");	}
		else if(!fn_mgremail()) {alert("담당자 이메일을 바르게 입력해주십시오.");	}
		else if(!fn_bsnsfile()) {alert("사업자등록증사본을 바르게 등록해주십시오.");	}
		else {
			result = true;
		}
		return result;
	}
	
	
	/*
	 * 상호명 체크
	 */
	function fn_cmpnnm() {
		
		var result = false;
		
		var cmpnnm = $("#cmpnnm").val();
		
		var length = $("#cmpnnm").val().length;
		var regexp = /[A-Za-z0-9가-힣]/;
		
		if(length == 0) {
			$("#cmpnnm-notEmpty").show();
			$("#cmpnnm-length").hide();
			$("#cmpnnm-regexp").hide();
		} else if(length > 25 && !regexp.test(cmpnnm)) {
			$("#cmpnnm-length").show();
			$("#cmpnnm-regexp").show();
			$("#cmpnnm-notEmpty").hide();
		} else if(length <= 25  && !regexp.test(cmpnnm)) {
				$("#cmpnnm-regexp").show();
				$("#cmpnnm-notEmpty").hide();
				$("#cmpnnm-length").hide();
		} else {
			$("#cmpnnm-notEmpty").hide();
			$("#cmpnnm-length").hide();
			$("#cmpnnm-regexp").hide();
			
			result = true;
		}
		
		return result;
	}

	/*
	 * 대표자명 체크
	 */
	function fn_ceonm() {
		
		var result = false;
		var ceonm = $("#ceonm").val();
		
		var length = $("#ceonm").val().length;
		var regexp = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
		
		if(length == 0) {
			$("#ceonm-notEmpty").show();
			$("#ceonm-length").hide();
			$("#ceonm-regexp").hide();
		} else if(length > 25 && !regexp.test(ceonm)) {
			$("#ceonm-length").show();
			$("#ceonm-regexp").show();
			$("#ceonm-notEmpty").hide();
		} else if(length <= 25  && !regexp.test(ceonm)) {
				$("#ceonm-regexp").show();
				$("#ceonm-notEmpty").hide();
				$("#ceonm-length").hide();
		} else {
			$("#ceonm-notEmpty").hide();
			$("#ceonm-length").hide();
			$("#ceonm-regexp").hide();
			
			result = true;
		}
		
		return result;
	}

	/* 
	 * 주소 체크
	 */
	function fn_addr1() {
		var result = false;
		
		var addr1 = $("#addr1").val();
		
		var length = $("#addr1").val().length;
		var regexp = /[A-Za-z0-9가-힣]/;
		
		if(length == 0) {
			$("#addr1-notEmpty").show();
			$("#addr1-length").hide();
			$("#addr1-regexp").hide();
		} else if(length > 35 && !regexp.test(addr1)) {
			$("#addr1-length").show();
			$("#addr1-regexp").show();
			$("#addr1-notEmpty").hide();
		} else if(length <= 35  && !regexp.test(addr1)) {
				$("#addr1-regexp").show();
				$("#addr1-notEmpty").hide();
				$("#addr1-length").hide();
		} else {
			$("#addr1-notEmpty").hide();
			$("#addr1-length").hide();
			$("#addr1-regexp").hide();
			
			result = true;
		}
		
		return result;
		
	}

	/* 
	 * 상세 주소 체크
	 */
	function fn_addr2() {
		var result = false;
		
		var addr2 = $("#addr2").val();
		
		var length = $("#addr2").val().length;
		var regexp = /[A-Za-z0-9가-힣]/;
		
		if(length == 0) {
			$("#addr2-notEmpty").show();
			$("#addr2-length").hide();
			$("#addr2-regexp").hide();
		} else if(length > 35 && !regexp.test(addr2)) {
			$("#addr2-length").show();
			$("#addr2-regexp").show();
			$("#addr2-notEmpty").hide();
		} else if(length <= 35  && !regexp.test(addr2)) {
				$("#addr2-regexp").show();
				$("#addr2-notEmpty").hide();
				$("#addr2-length").hide();
		} else {
			$("#addr2-notEmpty").hide();
			$("#addr2-length").hide();
			$("#addr2-regexp").hide();
		
			result = true;
		}
		
		return result;
	}

	/*
	 * 사업자등록증사본 파일 확장자 체크
	 */
	function fn_bsnsfile() {
		var bsnsfile = $("#bsnsfileid").val();
		var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|zip)$/i;
		var result = false;
		
		if(bsnsfile != null && bsnsfile != '') {
			$("#bsnsfile-notEmpty").hide();
			if(!regexp.test(bsnsfile)) {
				 $("#bsnsfile-extension").show();
			} else {
			   	$("#bsnsfile-extension").hide();
			    result = true;
			}
		} else {
			$("#bsnsfile-notEmpty").show();
		    $("#bsnsfile-extension").hide();

		}
		return result;
		
	}
	
	/*
	 * 파일업로드 시 첨부한 파일명 보여주기(사업자등록증사본)
	 */
	function fn_bsnsFileChange(file) {
		if(file == 'bsnsFile') {
			var fileValue = $("#bsnsFile").val().split("\\");
			var fileName = fileValue[fileValue.length-1]; // 파일명
			$("#bsnsfileid").val(fileName);
			$("#checkFileChange").val("Y");
			$("#bsnsfileid").attr('onclick',null);
			$("#bsnsfileid").attr('style',null);
		} else if(file == 'bsnsFileAtt') {
			var fileValue = $("#bsnsFileAtt").val().split("\\");
			var fileName = fileValue[fileValue.length-1]; // 파일명
			$("#bsnsfileidAtt").val(fileName);
		}
	}
	
	</script>
	<title>사용자 정보 수정</title>
</head>
<body>
	<div class="wrapper">
	<c:import url="header.jsp"></c:import>
	<div class="container">
		<div class="title">사용자 정보 수정</div>
	</div>
	
	<div class="tab-content clearfix">
		<div id="WriteForm" class="tab-pane fade in active">
	   		<form class="form-horizontal" id="form" method="POST" action="${pageContext.request.contextPath}/admin/userMdfReq" enctype="multipart/form-data" >
	   			<div class="container">
		    		<div class="container col-lg-6">
						<h5><span class="glyphicon glyphicon-plus-sign icon"></span> 업체정보 </h5>
						<table class="userInfo">
							<colgroup>
								<col style="width:50%;">
								<col style="width:35%;">
								<col style="width:15%;">
							</colgroup>
							<tr>
								<td><label for="prtnum">사업자등록번호<span class="text-danger">*</span></label></td>
								<td colspan="2"><input type="number" class="form-control input-sm" name="prtnum" id="prtnum" value="${userMdfVO.prtnum}" readonly >
								</td>
							</tr>
							<tr>
								<td><label for="cmpnnm">상호<span class="text-danger">*</span></label></td>
								<td colspan="2"><input type="text" class="form-control input-sm" name="cmpnnm" id="cmpnnm" onkeyup="fn_cmpnnm()" value="${userMdfVO.cmpnnm}" autocomplete="off">
									<small class="help-block" id="cmpnnm-notEmpty">상호명을 입력해주십시오.</small>
									<small class="help-block" id="cmpnnm-length" >상호명은 25자 이하로 입력해주십시오.</small>
									<small class="help-block" id="cmpnnm-regexp" >상호명이 올바르지 않습니다.</small>
								</td>
							</tr>
							<tr>
								<td><label for="ceonm">대표자<span class="text-danger">*</span></label></td>
								<td colspan="2"><input type="text" class="form-control input-sm" name="ceonm" id="ceonm" onkeyup="fn_ceonm()" value="${userMdfVO.ceonm}" autocomplete="off">
									<small class="help-block" id="ceonm-notEmpty" >대표자명을 입력해주십시오.</small>
									<small class="help-block" id="ceonm-length" >대표자명은 25자 이하로 입력해주십시오.</small>
									<small class="help-block" id="ceonm-regexp" >대표자명이 올바르지 않습니다.</small>
								</td>
							</tr>
							<tr>
								<td><label for="addr1">주소<span class="text-danger">*</span></label></td>
								<td><input type="text" class="form-control input-sm" name="addr1" id="addr1" onkeyup="fn_addr1()" value="${userMdfVO.addr1}" autocomplete="off">
									<small class="help-block" id="addr1-notEmpty" >주소를 입력해주십시오.</small>
									<small class="help-block" id="addr1-length" >주소는 35자 이하로 입력해주십시오.</small>
									<small class="help-block" id="addr1-regexp" >주소가 올바르지 않습니다.</small>
								</td>
								<td><button type="button" class="btn btn-sm btn-default" onclick="fn_popup()"> 검색 <span class="glyphicon glyphicon-search"></span></button></td>
							</tr>
							<tr>
								<td></td>
								<td colspan="2"><input type="text" class="form-control input-sm" name="addr2" id="addr2" onkeyup="fn_addr2()" value="${userMdfVO.addr2}" autocomplete="off">
									<small class="help-block" id="addr2-notEmpty" >상세주소를 입력해주십시오.</small>
									<small class="help-block" id="addr2-length" >상세주소는 35자 이하로 입력해주십시오.</small>
									<small class="help-block" id="addr2-regexp" >상세주소가 올바르지 않습니다.</small>
								</td>
							</tr>
							<tr>
								<td><label for="bsnsfileid" id="fileLabel">사업자등록증사본<span class="text-danger">*</span></label></td>
								<td><input type="text" class="form-control input-sm" id="bsnsfileid" name="bsnsfileid" value="${userMdfVO.filenm}" style="cursor:pointer" readonly <c:if test="${userMdfVO.bsnsfileid != null}"> onclick="location.href='${pageContext.request.contextPath}/filedownload?fileseq=${userMdfVO.bsnsfileid}'" </c:if>>
									<small class="help-block bsnsfileValidation" >업로드 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, zip</small>
								</td>
								<td><label class="btn btn-sm btn-primary btn-file">
									<span class="glyphicon glyphicon-upload"></span>업로드<input type="file" class="form-control" id="bsnsFile" name="bsnsFile" onchange="fn_bsnsFileChange(this.id); fn_bsnsfile();" style="display:none" >
									</label>
								</td>
							</tr>
							<tr>
								<td><label>계정상태<span class="text-danger">*</span></label></td>
								<td colspan="2">
									<select class="form-control input-sm" id="sts" name="sts">
										<option value="P"
											<c:if test="${userMdfVO.sts eq 'P'}">selected</c:if>>승인 중</option>
										<option value="Y"
											<c:if test="${userMdfVO.sts eq 'Y'}">selected</c:if>>사용 중</option>
										<option value="N"
											<c:if test="${userMdfVO.sts eq 'N'}">selected</c:if>>사용 안함</option>
									</select> 
								</td>
							</tr>
						</table>
						<!-- hidden data (사업자등록증사본을 바꾸었는지 체크) -->
						<input type="hidden" id="checkFileChange" name="checkFileChange" value="N"/>
						<!-- -------------------------------- -->
					</div>
					<div class="container col-lg-6">
						<h5><span class="glyphicon glyphicon-plus-sign icon"></span> 담당자 정보 </h5>
						<table class="userInfo">
							<colgroup>
								<col style="width:50%;">
								<col style="width:25%;">
								<col style="width:25%;">
							</colgroup>
							<tr>
								<td><label for="mgrname">성명<span class="text-danger">*</span></label></td>
								<td colspan="2"><input type="text" class="form-control input-sm" name="mgrname" id="mgrname" onkeyup="fn_mgrname()" value="${userMdfVO.mgrname}" autocomplete="off">
									<small class="help-block" id="mgrname-notEmpty" >담당자 성명을 입력해주십시오.</small>
									<small class="help-block" id="mgrname-length" >담당자 성명은 25자 이하로 입력해주십시오.</small>
									<small class="help-block" id="mgrname-regexp" >담당자 성명이 올바르지 않습니다.</small>
								</td>
							</tr>
							<tr>
								<td><label for="mgrtel">전화번호<span class="text-danger">*</span></label></td>
								<td colspan="2"><input type="text" class="form-control input-sm" name="mgrtel" id="mgrtel" onkeyup="fn_mgrtel()" value="${userMdfVO.mgrtel}" autocomplete="off">
									<small class="help-block" id="mgrtel-notEmpty" >담당자 전화번호를 입력해주십시오.</small>
									<small class="help-block" id="mgrtel-regexp" >담당자 전화번호가 올바르지 않습니다.</small>
								</td>
							</tr>
							<tr>
								<td><label for="mgrphone">휴대전화<span class="text-danger">*</span></label></td>
								<td colspan="2"><input type="text" class="form-control input-sm" name="mgrphone" id="mgrphone" onkeyup="fn_mgrphone()" value="${userMdfVO.mgrphone}" autocomplete="off">
									<small class="help-block" id="mgrphone-notEmpty" >담당자 휴대번호를 입력해주십시오.</small>
									<small class="help-block" id="mgrphone-regexp" >담당자 휴대번호가 올바르지 않습니다.</small>
								</td>
							</tr>
							<tr>
								<td><label for="mgrpstn">부서직위<span class="text-danger">*</span></label></td>
								<td colspan="2"><input type="text" class="form-control input-sm" name="mgrpstn" id="mgrpstn" onkeyup="fn_mgrpstn()" value="${userMdfVO.mgrpstn}" autocomplete="off">
									<small class="help-block" id="mgrpstn-notEmpty" >담당자 부서/직위를 입력해주십시오.</small>
									<small class="help-block" id="mgrpstn-length" >담당자 부서/직위는 35자 이하로 입력해주십시오.</small>
									<small class="help-block" id="mgrpstn-regexp" >담당자 부서/직위가 올바르지 않습니다.</small>
								</td>
							</tr>
							<tr>
								<td><label for="mgrfax">팩스번호<span class="text-danger">*</span></label></td>
								<td colspan="2"><input type="text" class="form-control input-sm" name="mgrfax" id="mgrfax" onkeyup="fn_mgrfax()" value="${userMdfVO.mgrfax}" autocomplete="off">
									<small class="help-block" id="mgrfax-notEmpty" >담당자 팩스번호를 입력해주십시오.</small>
									<small class="help-block" id="mgrfax-regexp" >담당자 팩스번호가 올바르지 않습니다.</small>
								</td>
							</tr>
							<tr>
								<td><label for="mgremail">이메일<span class="text-danger">*</span></label></td>
								<td colspan="2"><input type="email" class="form-control input-sm" name="mgremail" id="mgremail" onkeyup="fn_mgremail()" value="${userMdfVO.mgremail}" autocomplete="off">
									<small class="help-block" id="mgremail-notEmpty" >담당자 이메일을 입력해주십시오.</small>
									<small class="help-block" id="mgremail-regexp" >담당자 이메일이 올바르지 않습니다.</small>
								</td>
							</tr>
							<tr>
								<td><label>알림서비스</label></td>
								<td><input type="checkbox" name="emailyn" class="emailyn" <c:if test="${userMdfVO.emailyn=='Y'}">checked</c:if>>이메일 수신 동의</td>
								<td><input type="checkbox" name="smsyn" class="smsyn" <c:if test="${userMdfVO.smsyn=='Y'}">checked</c:if>>sms 수신 동의</td>
							</tr>
							<tr> 
								<td><label>선불요금제</label></td>
								<td><input type="checkbox" name="prepayyn" class="prepayyn" <c:if test="${userMdfVO.prepayyn=='Y'}">checked</c:if>>이용 신청</td>
							</tr>
						</table>
					</div>
				</div>
				<br><br>		
				<hr/>
				<div class="container " style="padding-bottom:50px; padding-top:50px;">
						<div class="col-sm-4"></div>
						<div class="col-sm-4 row text-center">
							<button type="button" class="btn btn-default" onclick="history.back()">취소</button>
							<button type="submit" class="btn btn-primary" onclick="return fn_validationCheck(this.id)" id="submission">수정</button>
						</div>
						<div class="col-sm-4"></div>
				</div>
			</form>
		</div>		
	</div>	
	<div class="push"></div>
	</div>
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script src="${pageContext.request.contextPath}/js/usrInf.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</body>
<footer style="margin-top:0px;"><c:import url="../footer.jsp" /></footer>

</html>