/**
 * 어드민 등록 javascript
 * @author 김진혁
 * @since 2019.01.10
 * @version 1.0
 * @return
 * @see
 * 수정이력
 * Date			Author		Contents
 * ===========	=========	===================================
 * 2019.01.10	김진혁			최초작성
 */
	 window.onload=function(){
		$("#id-success").hide();
		$("#id-danger").hide();
		$("#pw-success").hide();
		$("#pw-danger").hide();
		$("#id-length").hide();
		$("#id-regexp").hide();
		$("#pw-length").hide();
		$("#pw-regexp").hide();
		$("#nm-regexp").hide();
		$("#tel-regexp").hide();
	};
	
	/*
	 * 유효성 체크
	 */
	function validationCheck() {
		if ($("#admid").val() == "" || $("#pw").val() == ""
			|| $("#name").val() == "" || $("#email").val() == ""
			|| $("#tel").val() == "") {
			alert("모든 항목을 입력해 주십시오."); 
			return false; 
		}
	}
	
	/*
	 * 아이디 중복 체크, 아이디 포맷 검사
	 */
	function idCheck() {
		var id = $("#admid").val();
		$.ajax({
			type: "POST", 
			url: "/egume_upc/admin/checkIdAjax", 
			data: id, 
			dataType : "json", 
			contentType: "application/json",
			success: function(data) {
				var length = $("#admid").val().length;
				var regexp = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
				if(data.cnt>0){	//아이디 중복일때,
				    $("#id-danger").show();
				    $("#submission").attr("disabled", "disabled");
				    if(length < 6 || length > 20 && !regexp.test(id)) {
						$("#id-length").show();
						$("#id-regexp").show();
					} else if(length >=6 && length <= 20  && !regexp.test(id)) {
						$("#id-length").hide();
						$("#id-regexp").show();
					} else {
						$("#id-length").hide();
						$("#id-regexp").hide();
					}
				}
				else{			//아이디 중복 아닐 때,
					 $("#id-danger").hide();
					 if(length < 6 || length > 20 && !regexp.test(id)) {
						$("#id-success").hide();
						$("#id-length").show();
						$("#id-regexp").show();
						$("#submission").attr("disabled", "disabled");
					 } else if(length >=6 && length <= 20  && !regexp.test(id)) {
						$("#id-success").hide();
						$("#id-length").hide();
						$("#id-regexp").show();
						$("#submission").attr("disabled", "disabled");
					 } else {
						$("#id-success").show();
						$("#id-length").hide();
						$("#id-regexp").hide();
						$("#submission").removeAttr("disabled");
					 }
				}
			}, 
			error: function(request, status, error) {
				//alert("Ajax 에러 발생");
				console.log("code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
			}
		});
	}
	
	// 패스워드 포맷 검사
	function fn_password(){
		var result= false;
		var pw = $("#pw").val();
		
		var length = $("#pw").val().length;
		var regexp = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
		
		if(length < 6 || length > 20 && !regexp.test(pw)) {
			$("#pw-length").show();
			$("#pw-regexp").show();
		} else if(length >=6 && length <= 20  && !regexp.test(pw)) {
			$("#pw-regexp").show();
			$("#pw-length").hide();
		} else {
			$("#pw-length").hide();
			$("#pw-regexp").hide();
			result = true;
		}
		return result;
	}
	
	/*
	 * 패스워드 일치/불일치 체크
	 */
	function passwordCheck() {
		var pw1 = $("#pw").val();
		var pw2 = $("#pw2").val();
		if(pw1 != "" || pw2 != ""){
			if(pw1 == pw2){
			    $("#pw-success").show();
			    $("#pw-danger").hide();
			    $("#submission").removeAttr("disabled");
			} else{
			    $("#pw-success").hide();
			    $("#pw-danger").show();
			    $("#submission").attr("disabled", "disabled");
			}    
		}
	}
	
	//이름 포맷 검사
	function fn_nm() {
		var result = false;
		var nm = $("#name").val();
		var regexp = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
		
		if(!regexp.test(nm)) {
			$("#nm-regexp").show();
			$("#submission").attr("disabled", "disabled");
		} else {
			$("#nm-regexp").hide();
			$("#submission").removeAttr("disabled");
			result = true;
		}
		return result;
	}
	
	//전화번호 포맷 검사
	function fn_tel() {
		var result = false;
		var tel = $("#tel").val();
		var regexp = /01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/;
		
		if(!regexp.test(tel)) {
			$("#tel-regexp").show();
			$("#submission").attr("disabled", "disabled");
		} else {
			$("#tel-regexp").hide();
			$("#submission").removeAttr("disabled");
			result = true;
		}
		return result;
	}