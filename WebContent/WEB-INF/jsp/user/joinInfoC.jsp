<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/user.css" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">

/*
 * 주소 검색
 */
function fn_popup() {
	new daum.Postcode({
		oncomplete:function(data) {
			var roadAddr = data.roadAddress; // 도로명 주소 변수
		
		    $("#addr1").val(roadAddr);
			fn_addr1();
		 }
	}).open();
}

/*
 * 제출 전 필수입력사항 체크
 */
function fn_validationCheck(button) {

	fn_checkboxValue();

	$("#rgstid").val($("#prtnum").val());
	$("#rgstidAtt").val($("#prtnumAtt").val());
	
	var result = false;
	
	if(button == 'submission') {	// 웹 양식으로 제출할 경우 Validation Check
		
		if(!fn_prtnumCheck()) {alert("사업자등록번호를 바르게 입력해주십시오.");} 
		else if(!fn_pwCheck()) {alert("패스워드를 바르게 입력해주십시오.");	}
		else if(!fn_pwConfirm()) {alert("패스워드가 일치하지 않습니다.");}
		else if(!fn_cmpnnm()) {alert("상호명을 바르게 입력해주십시오.");	}
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
		
		else if($("#clickPrivate").val() == 0) {
			alert("개인정보 수집을 확인해주십시오.");
		} else if($("#clickServInf").val() == 0) {
			alert("이용약관을 확인해주십시오.");
		} else if ($("#private").prop("checked") == false) {
			alert("개인정보 수집 및 이용에 동의해주십시오.");
		} else if($("#servInf").prop("checked") == false) {
			alert("이용약관에 동의해주십시오.");
		} else {
			result = true;
		}
		
		return result;
	} else if(button == 'submissionAtt') {	// 첨부파일 양식으로 제출할 경우 Validation Check
		
		if(!fn_prtnumAttCheck()) {alert("사업자등록번호를 바르게 입력해주십시오.");} 
		else if(!fn_pwAttCheck()) {alert("패스워드를 바르게 입력해주십시오.");	}
		else if(!fn_pwAttConfirm()) {alert("패스워드가 일치하지 않습니다.");}
		else if(!fn_bsnsfileAtt()) {alert("사업자등록증사본을 바르게 등록해주십시오.");	}
		else if(!fn_applfile()) {alert("가입신청서를 바르게 등록해주십시오.");	}
		else {
			result = true;
		}
		return result;

	}
}

/*
 * 사업자등록번호 체크 (이미 등록된 회원 검사)
 */
function fn_prtnumCheck() {
	var result = false;
	var length = $("#prtnum").val().length;
	var prtnum = $("#prtnum").val();
	if(length == 10) {	//아이디 중복체크
		$("#id-length").hide();
		$.ajax({
			type:'GET',
			url:'/egume_upc/rgstid/prtnumCheck',
			data:{'prtnum' : prtnum},
			dataType:"text",
			success:function(data) {
				if(data > 0) {
					 $("#id-danger").show();
					result = false;
				} else {
					$("#id-danger").hide();
					result = true;
				}
				
			}, error:function(request, status, error) {
				console.log("id check error >> code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
			}
		});
	} else {
		$("#id-danger").hide();
	}
	
	if(length == 0) {
		$("#id-notEmpty").show();
		$("#id-length").hide();
		$("#id-callback").hide();
		result = false;
		
	} else if(length != 10) {
		$("#id-length").show();
		$("#id-notEmpty").hide();
		$("#id-callback").hide();
		result = false;

	} else if (length != 0 && !fn_prtnumCheckLogic(prtnum)){
		$("#id-callback").show();
		$("#id-notEmpty").hide();
		$("#id-length").hide();
		result = false;
		
	} else {
		result = true;
	}
	
	
	return result;
	
}

/*
 * 사업자등록번호 체크 (이미 등록된 회원 검사) - 첨부파일 양식
 */
function fn_prtnumAttCheck() {
	var result = false;
	var length = $("#prtnumAtt").val().length;
	var prtnum = $("#prtnumAtt").val();
	if(length == 10) {	//아이디 중복체크
		$("#idAtt-length").hide();
		$.ajax({
			type:'GET',
			url:'/egume_upc/rgstid/prtnumCheck',
			data:{'prtnum' : prtnum},
			dataType:"text",
			success:function(data) {
				if(data > 0) {
					 $("#idAtt-danger").show();
					result = false;
				} else {
					$("#idAtt-danger").hide();
					result = true;
				}
				
			}, error:function(request, status, error) {
				console.log("id check error >> code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
			}
		});
	} else {
		$("#idAtt-danger").hide();
	}
	
	if(length == 0) {
		$("#idAtt-notEmpty").show();
		$("#idAtt-length").hide();
		$("#idAtt-callback").hide();
		result = false;
		
	} else if(length != 10) {
		$("#idAtt-length").show();
		$("#idAtt-notEmpty").hide();
		$("#idAtt-callback").hide();
		result = false;

	} else if (length != 0 && !fn_prtnumCheckLogic(prtnum)){
		$("#idAtt-callback").show();
		$("#idAtt-notEmpty").hide();
		$("#idAtt-length").hide();
		result = false;
		
	} else {
		result = true;
	}
	
	
	return result;
	
}


/*
 * 패스워드 체크 - 첨부파일 양식
 */
function fn_pwAttCheck() {
	
	var result= false;
	var pw = $("#pwAtt").val();
	
	var length = $("#pwAtt").val().length;
	var regexp = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	
	if(length == 0) {
		$("#pwAtt-notEmpty").show();
		$("#pwAtt-length").hide();
		$("#pwAtt-regexp").hide();
	} else if(length < 6 || length > 20 && !regexp.test(pw)) {
		$("#pwAtt-length").show();
		$("#pwAtt-regexp").show();
		$("#pwAtt-notEmpty").hide();
	} else if(length >=6 && length <= 20  && !regexp.test(pw)) {
			$("#pwAtt-regexp").show();
			$("#pwAtt-notEmpty").hide();
			$("#pwAtt-length").hide();
	} else {
		$("#pwAtt-notEmpty").hide();
		$("#pwAtt-length").hide();
		$("#pwAtt-regexp").hide();
		
		result = true;
	}
	
	return result;
	
}

/*
 * 패스워드 확인(일치/불일치) 체크 - 첨부파일 양식
 */
function fn_pwAttConfirm() {
	var pw = $("#pwAtt").val();
	var pwCheck = $("#pwCheckAtt").val();
	
	if(pw != pwCheck) {
		$("#pwAtt-identical").show();
		
		return false;
	} else {
		$("#pwAtt-identical").hide();
		
		return true;
	}
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
	} else if(length > 25) {
		$("#cmpnnm-length").show();
		$("#cmpnnm-regexp").hide();
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
	} else if(length > 10) {
		$("#ceonm-length").show();
		$("#ceonm-regexp").hide();
		$("#ceonm-notEmpty").hide();
	} else if(length <= 10  && !regexp.test(ceonm)) {
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
	} else if(length > 35) {
		$("#addr1-length").show();
		$("#addr1-regexp").hide();
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
	} else if(length > 35) {
		$("#addr2-length").show();
		$("#addr2-regexp").hide();
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
	
	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp)$/i;
	
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
 * 사업자등록증사본 파일 확장자 체크 - 첨부파일 양식
 */
function fn_bsnsfileAtt() {
	var bsnsfileAtt = $("#bsnsfileidAtt").val();
	
	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp)$/i;
	var result = false;
	
	if(bsnsfileAtt != null && bsnsfileAtt != '') {
		$("#bsnsfileAtt-notEmpty").hide();
		if(!regexp.test(bsnsfileAtt)) {
			$("#bsnsfileAtt-extension").show();
		} else {
		    $("#bsnsfileAtt-extension").hide();
		    result = true;
		}
	} else {
		$("#bsnsfileAtt-notEmpty").show();
		$("#bsnsfileAtt-extension").hide();
	}
	
	return result;
	
}
/*
 * 가입신청서 확장자 체크
 */
function fn_applfile() {
	var applfile = $("#applfileid").val();
	
	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp)$/i;
	var result = false;
	if(applfile != null && applfile != '') {
		$("#applfile-notEmpty").hide();
		if(!regexp.test(applfile)) {
			 $("#applfile-extension").show();
		} else {
		    $("#applfile-extension").hide();
		    result = true;
		}
	} else {
		$("#applfile-notEmpty").show();
		$("#applfile-extension").hide();
	}
	return result;
	
}

/*
 * 개인정보수집/이용약관 클릭 시 클릭확인 처리
 */
function btnOkay(button) {
	
	if(button == 'btnPrivate') {
		var clickPrivate = $("#clickPrivate").val();
		
		
		clickPrivate++;
		$("#clickPrivate").val(clickPrivate);
		$("#private").attr('checked', true);
		
		return clickPrivate;
		
	}
	else if(button == 'btnServInf') {
		var clickServInf = $("#clickServInf").val();
		
		
		clickServInf++;
		$("#clickServInf").val(clickServInf);
		$("#servInf").attr('checked', true); 
		
		return clickServInf;
	}
	
}


/*
 * 파일업로드 시 첨부한 파일명 보여주기(사업자등록증사본)
 */
function fn_bsnsFileChange(file) {

	if(file == 'bsnsFile') {
		var fileValue = $("#bsnsFile").val().split("\\");
		var fileName = fileValue[fileValue.length-1]; // 파일명

		$("#bsnsfileid").val(fileName);

	} else if(file == 'bsnsFileAtt') {
		var fileValue = $("#bsnsFileAtt").val().split("\\");
		var fileName = fileValue[fileValue.length-1]; // 파일명

		$("#bsnsfileidAtt").val(fileName);

	}
	
}

/*
 * 파일업로드 시 첨부한 파일명 보여주기(가입신청서)
 */
function fn_applFileChange() {

	var fileValue = $("#applFile").val().split("\\");
	var fileName = fileValue[fileValue.length-1]; // 파일명

	$("#applfileid").val(fileName);

} 
</script>
<body>
<div id="contentsWrapper">
<c:import url="../header.jsp" />
<div class="container header">
  	<div class="title">서비스 이용신청</div>
  	<ul class="nav nav-tabs">
  		<li class="active"><a data-toggle="tab" href="#FileForm">신청서업로드</a></li>
  		<li><a data-toggle="tab" href="#WriteForm">신청서작성</a></li>
	</ul>
</div>

<div class="tab-content clearfix">
	<div id="WriteForm" class="tab-pane">
   		<form class="form-horizontal" id="form" method="post" action="${pageContext.request.contextPath}/rgstid/join" enctype="multipart/form-data" >
   			<div class="container" style="margin-top: 20px">
	    		<div class="container col-lg-6">
					<h5 class="mini-title"> 업체정보 </h5>
					<table class="userInfo">
						<colgroup>
							<col style="width:30%;">
							<col style="width:55%;">
							<col style="width:15%;">
						</colgroup>
						<tr>
							<td><label for="prtnum">사업자등록번호<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="number" class="form-control input-sm" name="prtnum" id="prtnum" onkeyup="fn_prtnumCheck()" placeholder="숫자 10자리를 입력해주십시오.">
								<input type="hidden" name="rgstid" id="rgstid" value="" />
								<small class="help-block" id="id-danger">이미 등록된 아이디 입니다.</small>
								<small class="help-block" id="id-notEmpty">사업자등록번호를 입력해주십시오.</small>
								<small class="help-block" id="id-length">사업자등록번호는 10자리로 입력해주십시오.</small>
								<small class="help-block" id="id-callback">사업자등록번호가 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="pw">패스워드<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="password" class="form-control input-sm" name="pw" id="pw" onkeyup="fn_pwCheck()">
								<small class="help-block" id="pw-notEmpty">패스워드를 입력해주십시오.</small>
								<small class="help-block" id="pw-length">패스워드는 6자 이상 20자 이하로 입력해주십시오.</small>
								<small class="help-block" id="pw-regexp">숫자와 영문을 혼합하여 입력해주십시오.</small>
							</td>
						</tr>
						<tr>
							<td><label for="pwCheck">패스워드확인<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="password" class="form-control input-sm" name="pwCheck" id="pwCheck" onkeyup="fn_pwConfirm()">
								<small class="help-block" id="pw-identical">패스워드가 일치하지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="cmpnnm">상호<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="text" class="form-control input-sm" name="cmpnnm" id="cmpnnm" onkeyup="fn_cmpnnm()">
								<small class="help-block" id="cmpnnm-notEmpty">상호명을 입력해주십시오.</small>
								<small class="help-block" id="cmpnnm-length" >상호명은 25자 이하로 입력해주십시오.</small>
								<small class="help-block" id="cmpnnm-regexp" >상호명이 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="ceonm">대표자<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="text" class="form-control input-sm" name="ceonm" id="ceonm" onkeyup="fn_ceonm()">
								<small class="help-block" id="ceonm-notEmpty" >대표자명을 입력해주십시오.</small>
								<small class="help-block" id="ceonm-length" >대표자명은 10자 이하로 입력해주십시오.</small>
								<small class="help-block" id="ceonm-regexp" >대표자명이 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="addr1">주소<span class="text-danger">*</span></label></td>
							<td><input type="text" class="form-control input-sm" name="addr1" id="addr1" onkeyup="fn_addr1()">
							</td>
							<td><button type="button" class="btn btn-sm btn-default btnWidth" onclick="fn_popup()">검색 <span class="glyphicon glyphicon-search"></span></button></td>
						</tr>
						<tr>
							<td></td>
							<td>
								<small class="help-block" id="addr1-notEmpty" >주소를 입력해주십시오.</small>
								<small class="help-block" id="addr1-length" >주소는 35자 이하로 입력해주십시오.</small>
								<small class="help-block" id="addr1-regexp" >주소가 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2"><input type="text" class="form-control input-sm" name="addr2" id="addr2" onkeyup="fn_addr2()">
								<small class="help-block" id="addr2-notEmpty" >상세주소를 입력해주십시오.</small>
								<small class="help-block" id="addr2-length" >상세주소는 35자 이하로 입력해주십시오.</small>
								<small class="help-block" id="addr2-regexp" >상세주소가 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="bsnsfileid" id="fileLabel">사업자등록증사본<span class="text-danger">*</span></label></td>
							<td><input type="text" class="form-control input-sm" id="bsnsfileid" name="bsnsfileid" readonly></td>
							<td><label class="btn btn-sm btn-default btn-file btnWidth">
								첨부<input type="file" class="form-control" id="bsnsFile" name="bsnsFile" onchange="fn_bsnsFileChange(this.id); fn_bsnsfile()" style="display:none" >
								</label>
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2"><small class="help-block" id="bsnsfile-notEmpty" >가입 신청서를 등록해주십시오.</small>
								<small class="help-block" id="bsnsfile-extension" >업로드 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp</small>
							</td>
						</tr>
						
					</table>
				</div>
				<div class="container col-lg-6">
					<h5 class="mini-title">담당자 정보 </h5>
					<table class="userInfo">
						<colgroup>
							<col style="width:30%;">
							<col style="width:70%;">
						</colgroup>
						<tr>
							<td><label for="mgrname">성명<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="text" class="form-control input-sm" name="mgrname" id="mgrname" onkeyup="fn_mgrname()">
								<small class="help-block" id="mgrname-notEmpty" >담당자 성명을 입력해주십시오.</small>
								<small class="help-block" id="mgrname-length" >담당자 성명은 10자 이하로 입력해주십시오.</small>
								<small class="help-block" id="mgrname-regexp" >담당자 성명이 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="mgrtel">전화번호<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="text" class="form-control input-sm" name="mgrtel" id="mgrtel" onkeyup="fn_mgrtel()" placeholder="02-123-1234">
								<small class="help-block" id="mgrtel-notEmpty" >담당자 전화번호를 입력해주십시오.</small>
								<small class="help-block" id="mgrtel-regexp" >담당자 전화번호가 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="mgrphone">휴대전화<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="text" class="form-control input-sm" name="mgrphone" id="mgrphone" onkeyup="fn_mgrphone()" placeholder="010-1234-1234">
								<small class="help-block" id="mgrphone-notEmpty" >담당자 휴대번호를 입력해주십시오.</small>
								<small class="help-block" id="mgrphone-regexp" >담당자 휴대번호가 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="mgrpstn">부서직위</label></td>
							<td colspan="2"><input type="text" class="form-control input-sm" name="mgrpstn" id="mgrpstn" onkeyup="fn_mgrpstn()">
								<small class="help-block" id="mgrpstn-length" >담당자 부서/직위는 10자 이하로 입력해주십시오.</small>
								<small class="help-block" id="mgrpstn-regexp" >담당자 부서/직위가 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="mgrfax">팩스번호</label></td>
							<td colspan="2"><input type="text" class="form-control input-sm" name="mgrfax" id="mgrfax" onkeyup="fn_mgrfax()" placeholder="02-123-1234">
								<small class="help-block" id="mgrfax-regexp" >담당자 팩스번호가 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="mgremail">이메일<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="email" class="form-control input-sm" name="mgremail" id="mgremail" onkeyup="fn_mgremail()" placeholder="test@test.com">
								<small class="help-block" id="mgremail-notEmpty" >담당자 이메일을 입력해주십시오.</small>
								<small class="help-block" id="mgremail-regexp" >담당자 이메일이 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label>알림서비스</label></td>
							<td><input type="checkbox" name="emailyn" class="emailyn" onclick="fn_checkboxValue()" checked>&nbsp;이메일 &nbsp;&nbsp;
								<input type="checkbox" name="smsyn" class="smsyn" onclick="fn_checkboxValue()" checked>&nbsp;SMS</td>
						</tr>
					</table>
				</div>
			</div>
			<br>
			<div class="container center">
				<div class="col-sm-12 box">
				<table class="userInfo">
					<colgroup>
						<col style="width:30%;">
						<col style="width:70%;">
					</colgroup>
					<tr>
						<th colspan="2"><p></p><span class="glyphicon glyphicon-ok-sign icon"></span> 이용정보 <p></th>
					</tr>
					<tr>
						<td><label>선불요금제</label></td>
						<td align="left"><input type="checkbox" name="prepayyn" class="prepayyn" checked>&nbsp;이용신청
							 (이용 요금 : 11건 110,000원, 11번째 신청 건 무료지원)
							<label class="control-label"></label>
						<td>
					</tr>
					<tr>
						<td><label>발급지원 수수료</label></td>
						<td><label>11,000원/건당
										(입금계좌 : 우리은행, 1005-901-807807883,	(주)한국무역정보통신) &nbsp; &nbsp;</label></td>
					</tr>
				</table>
				</div>					
			</div>
			<br>		
			<div class="container">
				<div class="col-sm-3"></div>
				<div class="col-sm-3 text-center">
					<input type="checkbox" id="private"><a data-toggle="modal" href="#consentModal" >&nbsp;개인정보 수집 및 이용동의</a>
					<input type="hidden" id="clickPrivate" value="0">
				</div>
				<div class="col-sm-3 text-center">
					<input type="checkbox" id="servInf"><a data-toggle="modal" href="#infoModal" >&nbsp;이용약관</a>
					<input type="hidden" id="clickServInf" value="0">
				</div>
				<div class="col-sm-3"></div>
			</div>
			<div class="container " style="padding:30px;">
					<div class="col-sm-4"></div>
					<div class="col-sm-4 row text-center">
						<button type="reset" class="btn btn-default" onclick="history.back()">취소</button>
						<button type="submit" class="btn btn-primary" onclick="return fn_validationCheck(this.id)" id="submission">승인요청</button>
					</div>
					<div class="col-sm-4"></div>
			</div>
		</form>
	</div>		

	<!-- 개인정보 수집 및 동의 Modal -->
	<div class="modal fade" id="consentModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
          			<h4 class="modal-title">개인정보 수집 및 동의</h4>
				</div>
				<div class="modal-body">
		        	<p>(주)한국무역정보통신은 수집한 개인정보를 다음의 목적으로 보유하고 활용합니다.</p>
		        	<p>- 수집하는 개인정보의 항목 : 이름, 주소, 전화번호, 핸드폰, 이메일, 회사명, 사업자등록번호, 생년월일(일반과세자)</p>
		        	<p>- 개인정보의 수집 및 이용목적 : 회원제 서비스 이용에 따른 본인확인, 가입의사 확인, 전자세금계산서 발행, 불만처리 등 민원처리, 고지사항 전달 등 발송</p>
		        	<p>- 개인정보의 보유 및 이용 기간 : 회원 탈퇴 시 1년간 휴면계정으로 전환 후 이후 삭제</p>
		        	<br>
		        </div>
				<div class="modal-footer">
		        	<button type="button" class="btn btn-default" id="btnPrivate" data-dismiss="modal" onclick="btnOkay(this.id)">확인</button>
		        </div>
			</div>
		</div>
	</div>
	
	<!-- 이용약관 Modal -->
	<div class="modal fade" id="infoModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
          			<h4 class="modal-title">이용약관</h4>
				</div>
				<div class="modal-body">
			        	<p><b>신청한 내용을 근거로 작성된 내용을 확인하기 위해 '외화획득용원료/기재 구매확인 신청서'를 보내드립니다.</b></p>
						<p>- 내용 확인 후 수정 내용 없을 시 명판과 인감 날인 후 지원센터로 발송 </p>
						<p>- 수정 내용 있을 시 수정 내용만 기재하여 지원센터로 발송 </p>
						<p><b>구매확인서 발급지원 신청은 당일 16시까지 접수된 것은 당일 지원하며, 16시 이후는 익일 발급합니다.</b></p>
			        	<p>특히, 매월 월마감일(10일)은 신청의 폭주로 인해 접수 누락 및 발급이 지연될 경우가 있으니, 사전(2일전)에 신청하여야 하며, 반드시 진행상황을 확인하여 주시기 바랍니다.</p>
			        	<p>(당사의 귀채사유로 이용신청자에게 손해가 발생한 경우, 서비스수수료의 3배를 한도로 하여 그 손해를 배상합니다.)</p>
			        	<p>* 마감일이 공휴일인 경우 다음 근무일 적용</p>
		        </div>
				<div class="modal-footer">
		        	<button type="button" class="btn btn-default" id="btnServInf" data-dismiss="modal" onclick="btnOkay(this.id)">확인</button>
		        </div>
			</div>
		</div>
	</div>
<!--  DIV END of "applicationForm" -->

	<div id="FileForm" class="tab-pane fade in active">
		<form class="form-horizontal" method="post" action="${pageContext.request.contextPath}/rgstid/join" enctype="multipart/form-data">
	   		<div class="container" style="margin-top: 20px">
	    		<div class="container col-lg-6">
					<h5 class="mini-title">업체정보</h5>
					<table class="userInfo">
						<colgroup>
							<col style="width:30%;">
							<col style="width:70%;">
						</colgroup>
						<tr>
							<td><label for="prtnum">사업자등록번호<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="number" class="form-control input-sm" name="prtnum" id="prtnumAtt" onkeyup="fn_prtnumAttCheck()" placeholder="숫자 10자리를 입력해주십시오.">
								<input type="hidden" name="rgstid" id="rgstidAtt" value="" />
								<small class="help-block" id="idAtt-danger" >이미 등록된 아이디 입니다.</small>
								<small class="help-block" id="idAtt-notEmpty" >사업자등록번호를 입력해주십시오.</small>
								<small class="help-block" id="idAtt-length" >사업자등록번호는 10자리로 입력해주십시오.</small>
								<small class="help-block" id="idAtt-callback" >사업자등록번호가 올바르지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label for="pw">패스워드<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="password" class="form-control input-sm" name="pw" id="pwAtt" onkeyup="fn_pwAttCheck()">
								<small class="help-block" id="pwAtt-notEmpty" >패스워드를 입력해주십시오.</small>
								<small class="help-block" id="pwAtt-length" >패스워드는 6자 이상 20자 이하로 입력해주십시오.</small>
								<small class="help-block" id="pwAtt-regexp" >숫자와 영문을 혼합하여 입력해주십시오.</small>
						
							</td>
						</tr>
						<tr>
							<td><label for="pwCheck">패스워드확인<span class="text-danger">*</span></label></td>
							<td colspan="2"><input type="password" class="form-control input-sm" name="pwCheck" id="pwCheckAtt" onkeyup="fn_pwAttConfirm()">
								<small class="help-block" id="pwAtt-identical" >패스워드가 일치하지 않습니다.</small>
							</td>
						</tr>
						<tr>
							<td><label>알림서비스</label></td>
							<td><input type="checkbox" name="emailyn" class="emailyn" onclick="fn_checkboxValue()" checked>&nbsp;이메일 &nbsp;&nbsp;
							<input type="checkbox" name="smsyn" class="smsyn" onclick="fn_checkboxValue()" checked>&nbsp;SMS</td>
						</tr>
						
					</table>
				</div>
				<div class="container col-lg-6">
					<h5 class="mini-title">첨부서류</h5>
					<table class="userInfo">
						<colgroup>
							<col style="width:30%;">
							<col style="width:40%;">
							<col style="width:15%;">
							<col style="width:15%;">
						</colgroup>
						<tr>
							<td><label>가입 신청서<span class="text-danger">*</span></label>
							</td>
							<td><input type="text" id="applfileid" class="form-control input-sm" name="applfileid" readonly>
								
							</td>
							<td><label class="btn btn-sm btn-default btn-file btnWidth">
	  							첨부<input type="file" id="applFile" class="form-control input-sm" name="applFile" onchange="fn_applFileChange(); fn_applfile()" style="display:none" >
								</label>
							</td>
							<td><a href="${pageContext.request.contextPath}/download/USER_REGI.zip" download> <button type="button" class="btn btn-sm btn-danger">양식다운</button></a></td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2"><small class="help-block" id="applfileAtt-notEmpty" >가입 신청서를 등록해주십시오.</small>
								<small class="help-block" id="applfile-extension" >업로드 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp</small>
							</td>
						</tr>
						<tr>
							<td><label for="bsnsfileid" id="fileLabel">사업자등록증사본<span class="text-danger">*</span></label></td>
							<td><input type="text" class="form-control input-sm" id="bsnsfileidAtt" name="bsnsfileid" readonly></td>
							<td><label class="btn btn-sm btn-default btn-file btnWidth">
								첨부<input type="file" class="form-control" id="bsnsFileAtt" name="bsnsFile" onchange="fn_bsnsFileChange(this.id); fn_bsnsfileAtt()" style="display:none" >
								</label>
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2"><small class="help-block" id="applfileAtt-notEmpty" >가입 신청서를 등록해주십시오.</small>
								<small class="help-block" id="bsnsfileAtt-extension" >업로드 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp</small>
							</td>
						</tr>
					</table>
				</div>
				<br>
				<div class="col-md-12 box" style="margin-top:20px;">
				<table>
					<colgroup>
						<col style="width:30%;">
						<col style="width:70%;">
					</colgroup>
					<tr>
						<th colspan="2"> <p></p><span class="glyphicon glyphicon-ok-sign icon"></span> &nbsp; 이용정보<p> </th>
					</tr>
					<tr>
						<td><label>선불요금제</label></td>
						<td colspan="2" align="left"><label><input type="checkbox" name="prepayyn" class="prepayyn" checked>&nbsp;이용신청
							 (요금 : 110,000원/11건 , 11번째 신청 건 무료지원)
							</label>
						</td>
					</tr>
					<tr>
						<td><label>발급지원 수수료</label></td>
						<td colspan="2"><label>11,000원/건 (입금계좌 : 우리은행, 1005-901-807807883, (주)한국무역정보통신) &nbsp;&nbsp;</label></td>
					</tr>
				</table>
				</div>					
			</div>	
			<br>
			<div class="container " style="padding:50px;">
				<div class="col-sm-4"></div>
				<div class="col-sm-4 row text-center">
					<button type="reset" class="btn btn-default" onclick="history.back()">취소</button>
					<button type="submit" class="btn btn-primary" onclick="return fn_validationCheck(this.id)" id="submissionAtt" >승인요청</button>
				</div>
				<div class="col-sm-4"></div>
			</div>
				
		</form>	
	</div> <!--  END OF DIV FileForm-->
</div>	
</div>

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script src="${pageContext.request.contextPath}/js/usrInf.js"></script>
<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
</body>
<footer><c:import url="../footer.jsp" /></footer>
</html>