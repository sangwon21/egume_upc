/**
 * 간편 사용자 등록 javascript
 * @author 이수빈
 * @since 2018.12.12
 * @version 1.0
 * @return
 * @see
 * 수정이력
 * Date			Author		Contents
 * ===========	=========	===================================
 * 2018.12.14	이수빈		validation check, 첨부파일명 보이도록 수정
 * 2018.12.17	이수빈		간편사용자등록(첨부파일) 파일명 보이도록 추가
 * 2018.12.19	이수빈		validation check 수정 및 아이디 중복체크 구현
 * 2018.12.20	이수빈		회원 탈퇴를 위한 패스워드 일치/불일치 검사 함수 추가
 * 2018.12.27	이수빈		validation check 파일업로드 수정
 * 2019.01.02	이수빈		validation check 개인정보 수집동의 수정
 * 2019.01.06	이수빈		validation check 수정
 */

/**
 * 초기화면 설정 : validation 알림메세지 숨김
 **/
window.onload=function(){
	$(".help-block").hide();
};

/**
 * 사업자등록번호발급규칙유효성 검사
 * @param prtnum
 **/
function fn_prtnumCheckLogic(prtnum) {
	var sum = 0;
	var checknum = 0;
    var arrNumList = new Array();
	var arrCheckNum = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1); 
	
	for(var i = 0; i < 10; i++) {
		//alert($("#prtnum").val()[i]);
		arrNumList[i] = parseInt(prtnum[i]);
	} 
	for(var i = 0; i < 9; i++) {
		sum += arrNumList[i] * arrCheckNum[i];
	}
	
	sum += parseInt((arrNumList[8] * 5) / 10);
	checknum = (10 - (sum % 10)) % 10;
	return (checknum == arrNumList[9]);
}

/**
 * 패스워드 체크
 **/
function fn_pwCheck() {
	
	var result= false;
	var pw = $("#pw").val();
	
	var length = $("#pw").val().length;
	var regexp = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	
	if(length == 0) {
		$("#pw-notEmpty").show();
		$("#pw-length").hide();
		$("#pw-regexp").hide();
	} else if(length < 6 || length > 20 && !regexp.test(pw)) {
		$("#pw-length").show();
		$("#pw-regexp").show();
		$("#pw-notEmpty").hide();
	} else if(length >=6 && length <= 20  && !regexp.test(pw)) {
			$("#pw-regexp").show();
			$("#pw-notEmpty").hide();
			$("#pw-length").hide();
	} else {
		$("#pw-notEmpty").hide();
		$("#pw-length").hide();
		$("#pw-regexp").hide();
		
		result = true;
	}
	
	return result;
	
}

/**
 * 패스워드 확인(일치/불일치) 체크
 **/
function fn_pwConfirm() {
	var pw = $("#pw").val();
	var pwCheck = $("#pwCheck").val();
	
	if(pw != pwCheck) {
		$("#pw-identical").show();
		
		return false;
	} else {
		$("#pw-identical").hide();
		
		return true;
	}
}



/** 
 * 담당자명 체크
 **/
function fn_mgrname() {
	var result = false;
	
	var mgrname = $("#mgrname").val();
	
	var length = $("#mgrname").val().length;
	var regexp = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
	
	if(length == 0) {
		$("#mgrname-notEmpty").show();
		$("#mgrname-length").hide();
		$("#mgrname-regexp").hide();
	} else if(length > 10) {
		$("#mgrname-length").show();
		$("#mgrname-regexp").hide();
		$("#mgrname-notEmpty").hide();
	} else if(length <= 10  && !regexp.test(mgrname)) {
			$("#mgrname-regexp").show();
			$("#mgrname-notEmpty").hide();
			$("#mgrname-length").hide();
	} else {
		$("#mgrname-notEmpty").hide();
		$("#mgrname-length").hide();
		$("#mgrname-regexp").hide();
		
		result = true;
		
	}
	
	return result;
}

/** 
 * 담당자 전화번호 체크
 **/
function fn_mgrtel() {
	
	var result = false;
	
	var mgrtel = $("#mgrtel").val();
	
	var length = $("#mgrtel").val().length;
	var regexp = /([0-9]{2,3})-([0-9]{3,4})-([0-9]{4})$/;
	
	if(length == 0) {
		$("#mgrtel-notEmpty").show();
		$("#mgrtel-regexp").hide();
	} else if(!regexp.test(mgrtel)) {
			$("#mgrtel-regexp").show();
			$("#mgrtel-notEmpty").hide();
	} else {
		$("#mgrtel-notEmpty").hide();
		$("#mgrtel-regexp").hide();
		
		result= true;
		
	}
	return result;
}

/** 
 * 담당자휴대번호 체크
 **/
function fn_mgrphone() {
	
	var result = false;
	
	var mgrphone = $("#mgrphone").val();
	
	var length = $("#mgrphone").val().length;
	var regexp = /01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/;
	
	fn_checkboxValue();
	if($(".smsyn").val() == 'Y' && length == 0) {
		$("#mgrphone-notEmpty").show();
		$("#mgrphone-regexp").hide();
	} else if(length != 0 && !regexp.test(mgrphone)) {
			$("#mgrphone-regexp").show();
			$("#mgrphone-notEmpty").hide();
	} else {
		$("#mgrphone-notEmpty").hide();
		$("#mgrphone-regexp").hide();
		
		result = true;
	}
	
	return result;
}

/** 
 * 담당자 부서/직위 체크
 **/
function fn_mgrpstn() {
	var result = false;
	
	var mgrpstn = $("#mgrpstn").val();
	
	var length = $("#mgrpstn").val().length;
	var regexp = /[A-Za-z0-9가-힣]/;
	
	if(length > 10) {
		$("#mgrpstn-length").show();
		$("#mgrpstn-regexp").hide();
	} else if(length > 0 && length <= 10  && !regexp.test(mgrpstn)) {
			$("#mgrpstn-regexp").show();
			$("#mgrpstn-length").hide();
	} else {
		$("#mgrpstn-length").hide();
		$("#mgrpstn-regexp").hide();
		
		result = true;
	}
	
	return result;
	
}

/** 
 * 담당자팩스 체크
 **/
function fn_mgrfax() {
	var result = false;
	
	var mgrfax = $("#mgrfax").val();
	
	var length = $("#mgrfax").val().length;
	var regexp = /([0-9]{2,3})-([0-9]{3,4})-([0-9]{4})$/;
	
	if(length != 0 && !regexp.test(mgrfax)) {
		$("#mgrfax-regexp").show();
	} else {
		$("#mgrfax-regexp").hide();
		
		result = true;
	}
	
	return result;
}

/** 
 * 담당자 이메일 체크
 **/
function fn_mgremail() {
	var result = false;
	
	var mgremail = $("#mgremail").val();
	
	var length = $("#mgremail").val().length;
	var regexp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

	if(length == 0) {
		$("#mgremail-notEmpty").show();
		$("#mgremail-regexp").hide();
	} /*else if(!regexp.test(mgrfax)) {
			$("#mgremail-regexp").show();
			$("#mgremail-notEmpty").hide();
	} */ else {
		$("#mgremail-notEmpty").hide();
		$("#mgremail-regexp").hide();
		
		result = true;
	}
	
	return result;
}

/**
 * checkbox(알림 및 선불요금제 유무) value 설정
 **/
function fn_checkboxValue() {
	var emailyn = $(".emailyn").prop("checked");
	var smsyn = $(".smsyn").prop("checked");
	var prepayyn = $(".prepayyn").prop("checked");
	
	if(emailyn) {
		$(".emailyn").val("Y");
	}  else {
		$(".emailyn").val("N");
	}
	if(smsyn) {
		$(".smsyn").val("Y");
		if($("#mgrphone").val().length == 0) {
			$("#mgrphone-notEmpty").show();
		} else {
			$("#mgrphone-notEmpty").hide();
		}
	} else {
		$(".smsyn").val("N");
		$("#mgrphone-notEmpty").hide();
	}
	if(prepayyn) {
		$(".prepayyn").val("Y");
	} else {
		$(".prepayyn").val("N");
	}
}

