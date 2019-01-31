<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="referrer" content="no-referrer" />
        <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
        <title>구매확인서 발급 서비스</title>
    	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">
    	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <%-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.2/js/bootstrapValidator.min.js"></script>--%>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/usrInf.js"></script>
    <script>
    function fn_popup() {
    	new daum.Postcode({
    		oncomplete:function(data) {
    			var roadAddr = data.roadAddress; // 도로명 주소 변수
    		
    		    $("#splyaddr1").val(roadAddr);
    		    fn_addr1();
    		 }
    	}).open();
    }
    
    function getContextPath() {
		var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	};
	function getReqFrmVOFromController(resultObj){
		
		console.log(resultObj);
		
		if(resultObj.length === 0){
			alert('검색 결과가 없습니다')
			return;
		}
		var pushTable = document.querySelector("#pushTable");
		
		function addingEvent(element){
			var tr = document.createElement("tr");
			var applnum = document.createElement("td");
			var splyorgnm = document.createElement("td");
			var splyceonm = document.createElement("td");
			var splyaddr1 = document.createElement("td");
			var splyaddr2 = document.createElement("td");
			var issuenum = document.createElement("td");
			issuenum.innerText = element.issuenum;
			splyaddr2.innerText = element.splyaddr2;
			splyaddr1.innerText = element.splyaddr1;
			splyceonm.innerText = element.splyceonm;
			splyorgnm.innerText = element.splyorgnm;
			applnum.innerText = element.applnum;
			applnum.classList.add("pointer");
			tr.appendChild(applnum);
			tr.appendChild(splyorgnm);
			tr.appendChild(splyceonm);
			tr.appendChild(splyaddr1);
			tr.appendChild(splyaddr2);
			tr.appendChild(issuenum);
			applnum.addEventListener("click", function(){
				var documentSplyorgnm = document.querySelector("#splyorgnm");
				documentSplyorgnm.value = element.splyorgnm;
				
				var documentSplyaddr1 = document.querySelector("#splyaddr1");
				documentSplyaddr1.value = element.splyaddr1;
				
				var documentSplyaddr2 = document.querySelector("#splyaddr2");
				documentSplyaddr2.value = element.splyaddr2;
				
				var documentSplyceonm = document.querySelector("#splyceonm");
				documentSplyceonm.value = element.splyceonm;
				
				var documentSplyprtnum = document.querySelector("#splyprtnum");
				documentSplyprtnum.value = element.splyprtnum;
				
				var documentIssuenum = document.querySelector("#writeIssuenum");
				documentIssuenum.value = element.issuenum;
				
				document.querySelector("#searchClose").click();
			})
			pushTable.appendChild(tr);
		}
		
		for(var i = 0; i < resultObj.length; i++){
			addingEvent(resultObj[i]);
		}
		
	}
	function getReqFrmVOByApplnum(params) {
		$.ajax({
			url: "/egume_upc/user/reqfrm/searchByApplnum", 
			type: "GET", 
			contentType: "application/json", 
			dataType : "json", 
			data: params, 
			success: function(result) {
				alert("검색 요청을 완료했습니다");
				getReqFrmVOFromController(result);
			}, 
			error: function(request, status, error) {
				alert("검색  결과가 없습니다.");
			}
		});
	}
	
	function searchByApplnum(applnum){
		function param(){
			this.applnum = applnum
		}
		getReqFrmVOByApplnum(new param());
	}
	
    window.onload = function() {
    	var tableForWriteIssuemdfreq = '<div class="col-sm-12" id="writeIssuemdfreqForm">' +
            '<table table class="reason contents__box  table">' +
        	'<thead>'+
            	'<tr>'+
            		'<th scope="col">신청사유</th>' +
                '</tr>'+
            '</thead>'+
            '<tbody>' +
            	'<tr>' +
            		'<td><textarea rows="6" maxlength="50" name="issuemdfreq" ></textarea></td>' +	
                '</tr>' +
            '</tbody>' +
        '</table>' +
        '</div>';
    	
        if($("#applditcA").is(':checked')) {
    		if($("#writeIssuemdfreqForm").length === 0){
   	   	    	$("#buttonForWebSubmit").before(tableForWriteIssuemdfreq);
   	    	}
    		if($("#writeIssuenum").is(":disabled")){
	   	    	$("#writeIssuenum").val($("#hiddenIssuenum").val())
                $("#searchReqFrmForm").removeAttr("disabled");
	   	    	$("#writeIssuenum").removeAttr("disabled");
	   	    	$("#fileIssuenum").removeAttr("disabled");
    		}
    		$("#writeLi").addClass("active");
    		$("#fileLi").removeClass("active");
    		$("#WriteForm").addClass("in");
    		$("#WriteForm").addClass("active");
    		$("#FileForm").removeClass("in");
    		$("#FileForm").removeClass("active");
    	}
    	$(".help-block").hide();
    	
    	document.querySelector("#searchClose").addEventListener("click", function(){
    		 $("#pushTable").find("tr:gt(0)").remove();
    	})
    	
    	document.querySelector("#searchCloseBtn").addEventListener("click", function(){
    		 $("#pushTable").find("tr:gt(0)").remove();
    	})
    	
        
        var tableForFileIssuemdfreq = '<div class="col-sm-12" id="fileIssuemdfreqForm">' +
	        '<table table class="reason contents__box  table"> '+
	    	'<thead>'+
	        	'<tr>'+
	        		'<th scope="col">신청사유</th>'+
	            '</tr>'+
	        '</thead>'+
	        '<tbody>'+
	        	'<tr>'+
	        		'<td><textarea rows="6" maxlength="50" name="issuemdfreq" ></textarea></td>'+
	            '</tr>'+
	        '</tbody>'+
	    '</table>'+
	    '</div>';
	    
    	
        
        $( "#WriteForm input[value='O']" ).on("click", function(){
	    	if($("#writeIssuemdfreqForm").length !== 0  ){
		    	$("#writeIssuemdfreqForm").remove();
   	    		$("#searchReqFrmForm").attr("disabled", true);
   	    		$("#writeIssuenum").attr("disabled",true);
		    	$("#writeIssuenum").prop('required',false);
		    	 $("#searchReqFrmForm").removeAttr('data-toggle');
	    	}
        })
        
		$( "#FileForm input[value='O']" ).on("click", function(){
	    	if( $("#fileIssuenumTable").css('visibility') !== 'hidden'){
				$("#fileIssuemdfreqForm").remove();
   	    		$("#fileIssuenum").attr("disabled",true);
				$("#fileIssuenum").prop('required',false);
			}
        })
        
        $( "#WriteForm input[value='A']" ).on("click", function(){
   	    	if($("#writeIssuemdfreqForm").length === 0){
   	   	    	$("#buttonForWebSubmit").before(tableForWriteIssuemdfreq);
   	    	}
   	    	if($("#writeIssuenum").is(":disabled")){
		    	$("#writeIssuenum").removeAttr("disabled");
		    	$("#searchReqFrmForm").removeAttr("disabled");
   	    		$("#writeIssuenum").prop('required',true);
   	    		$("#searchReqFrmForm").attr('data-toggle', "modal");
   	    	}
        }) 
        
        $( "#FileForm input[value='A']" ).on("click", function(){
   	    	if($("#fileIssuemdfreqForm").length === 0){
		    	$('#buttonForFileSubmit').before(tableForFileIssuemdfreq);
   	   	    }
   	    	if($("#fileIssuenum").is(":disabled")){
				$("#fileIssuenum").removeAttr("disabled");
   	    		$("#fileIssuenum").prop("required",true);
   	    	}
        })
		
		document.querySelector("#searchAddress").addEventListener("click", fn_popup);
		
		document.querySelector("#searchForReqFrm").addEventListener("click", function(e){
			var applnum = $(this).siblings("#searchApplnum").val();
			searchByApplnum(applnum);
		})
		
		$(".file-input input:file").change(function (){     
	         var file = this.files[0];
	         var reader = new FileReader();
	         var tis = $(this);
	         // Set preview image into the popover data-content

	         reader.onload = function (e) {
	           
	        	tis.closest('div').parents('tr').find('.inputFile').find('.preview-filename').val(file.name);
	         }        
	         reader.readAsDataURL(file);
	     }); 
		
		var cancelBtn = document.querySelectorAll(".btnCancel");
		
		
		var url = getContextPath()+'/user/reqfrm/prchCnfrmApplList.do'
		
		cancelBtn[0].addEventListener("click", function(){
			$(location).attr('href', url);
		});
		cancelBtn[1].addEventListener("click", function(){
			$(location).attr('href', url);
		});
	}

    function fn_validationCheck() {

    	var result = false;
    	
    	if(!fn_prtnumCheck()){
    		alert("사업자등록번호를 확인해주십시오.");
    		$("#splyprtnum").focus();
    		return result;
    	}
    	if(!fn_addr1() || !fn_addr2()){
    		alert("주소를 확인해주십시오.")
    		$("#splyaddr2").focus();
    		return result;
    	} 
    	if(!fn_ceonm()){
    		alert("대표자명을 확인해주십시오.")
    		$("#splyceonm").focus();
    		return result;
    	}
    	if(!fn_cmpnnm()){
    		alert("상호를 확인해주십시오.");
    		$("#splyorgnm").focus();
    		return result;
    	}
    	
    	
   		if($("#writeSup1").val() !== "" && !writeSup1Check()){
   			alert("수출근거서류 파일을 확인해주십시오.");
   			return result;
   		}
   		if($("#writeSup2").val() !== "" && !writeSup2Check()){
   			alert("수출근거서류 파일을 확인해주십시오.");
   			return result;
   		}
   		if($("#writeSup3").val() !== "" && !writeSup3Check()){
   			alert("수출근거서류 파일을 확인해주십시오.");
   			return result;
   		}
   		if($("#writeTax1").val() !== "" && !writeTax1Check()){
   			alert("세금계산서 파일을 확인해주십시오.");
   			return result;
   		}
   		if($("#writeTax2").val() !== "" && !writeTax2Check()){
   			alert("세금계산서 파일을 확인해주십시오.");
   			return result;
   		}
   		if($("#writeTax3").val() !== "" && !writeTax3Check()){
   			alert("세금계산서 파일을 확인해주십시오.");
   			return result;
   		}
    	
   		
   		result = true;
    
    	return result;
    }
    
    
    
    function fileValidationCheck() {

    	var result = false;
    	
    	if(!applfrmCheck()){
    		alert("신청서 파일을 확인해주십시오.");
   			return result;
    	}
   		if($("#fileSup1").val() !== "" && !fileSup1Check()){
   			alert("수출근거서류 파일을 확인해주십시오.");
   			return result;
   		}
   		if($("#fileSup2").val() !== "" && !fileSup2Check()){
   			alert("수출근거서류 파일을 확인해주십시오.");
   			return result;
   		}
   		if($("#fileSup3").val() !== "" && !fileSup3Check()){
   			alert("수출근거서류 파일을 확인해주십시오.");
   			return result;
   		}
   		if($("#fileTax1").val() !== "" && !fileTax1Check()){
   			alert("세금계산서 파일을 확인해주십시오.");
   			return result;
   		}
   		if($("#fileTax2").val() !== "" && !fileTax2Check()){
   			alert("세금계산서 파일을 확인해주십시오.");
   			return result;
   		}
   		if($("#fileTax3").val() !== "" && !fileTax3Check()){
   			alert("세금계산서 파일을 확인해주십시오.");
   			return result;
   		}
   		result = true;
    	
    
    	return result;
    }
    
    /*
     * 사업자등록번호 체크
     */
    function fn_prtnumCheck() {
    	var result = false;
    	var length = $("#splyprtnum").val().length;
    	var prtnum = $("#splyprtnum").val();
    	
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
    		
    	} else if(length == 10 && fn_prtnumCheckLogic(prtnum)){
    		$("#id-callback").hide();
    		$("#id-notEmpty").hide();
    		$("#id-length").hide();
    		result = true;
    	}
    	
    	return result;
    	
    }
    

    /*
     * 상호명 체크
     */
    function fn_cmpnnm() {
    	
    	var result = false;
    	
    	var cmpnnm = $("#splyorgnm").val();
    	
    	var length = $("#splyorgnm").val().length;
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
    	var ceonm = $("#splyceonm").val();
    	
    	var length = $("#splyceonm").val().length;
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
    	
    	var addr1 = $("#splyaddr1").val();
    	
    	var length = $("#splyaddr1").val().length;
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
    	
    	var addr2 = $("#splyaddr2").val();
    	
    	var length = $("#splyaddr2").val().length;
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
    function writeTax1Check() {
    	var writeTax1 = "";
    	if($("#writeTax1").length !== 0){
    		writeTax1 = $("#writeTax1").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;
    	
    	var result = false;
    	
    	if(writeTax1 != null && writeTax1 != '') {
    		if(!regexp.test(writeTax1)) {
    			 $("#writeTax1-extension").show();
    		} else {
    		    $("#writeTax1-extension").hide();
    		    
    		    result = true;
    		}
    	} else {
    	    $("#writeTax1-extension").hide();
    	}
    	
    	return result;	
    	
    }
    function writeTax2Check(){
    	var writeTax2 = "";
    	if($("#writeTax2").length !== 0){
    		writeTax2 = $("#writeTax2").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;
    	
    	var result = false;
    	if(writeTax2 != null && writeTax2 != '') {
    		if(!regexp.test(writeTax2)) {
    			 $("#writeTax2-extension").show();
    		} else {
    		    $("#writeTax2-extension").hide();
    		    
    		    result = true;
    		}
    	} else {
    	    $("#writeTax2-extension").hide();
    	}
    	
    	return result;	
    }
    
    function writeTax3Check(){
    	var writeTax3 = "";
    	if($("#writeTax3").length !== 0){
    		writeTax3 = $("#writeTax3").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;

    	var result = false;

    	if(writeTax3 != null && writeTax3 != '') {
    		if(!regexp.test(writeTax3)) {
    			 $("#writeTax3-extension").show();
    		} else {
    		    $("#writeTax3-extension").hide();
    		    
    		    result = true;
    		}
    	} else {
    	    $("#writeTax3-extension").hide();
    	}
    	
    	return result;	

    }
    
    function writeSup1Check(){
    	var writeSup1 = "";
    	if($("#writeSup1").length !== 0){
    		writeSup1 = $("#writeSup1").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;

    	var result = false;

    	if(writeSup1 != null && writeSup1 != '') {
    		if(!regexp.test(writeSup1)) {
    			 $("#writeSup1-extension").show();
    		} else {
    		    $("#writeSup1-extension").hide();
    		    
    		    result = true;
    		}
    	} else {
    	    $("#writeSup1-extension").hide();
    	}
    	
    	return result;	

    }
    function writeSup2Check(){
    	var writeSup2 = "";
    	if($("#writeSup2").length !== 0){
    		writeSup2 = $("#writeSup2").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;

    	var result = false;
    	if(writeSup2 != null && writeSup2 != '') {
    		if(!regexp.test(writeSup2)) {
    			 $("#writeSup2-extension").show();
    		} else {
    		    $("#writeSup2-extension").hide();
    		    
    		    result = true;
    		}
    	} else {
    	    $("#writeSup2-extension").hide();
    	}
    	
    	return result;	

    }
    function writeSup3Check(){
    	var writeSup3 = "";
    	if($("#writeSup3").length !== 0){
    		writeSup3 = $("#writeSup3").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;

    	var result = false;

    	if(writeSup3 != null && writeSup3 != '') {
    		if(!regexp.test(writeSup3)) {
    			 $("#writeSup3-extension").show();
    		} else {
    		    $("#writeSup3-extension").hide();
    		    result = true;
    		}
    	} else {
    	    $("#writeSup3-extension").hide();
    	}
    	
    	return result;	

    }
    
    function fileTax1Check(){
    	var fileTax1 = "";
    	if($("#fileTax1").length !== 0){
    		fileTax1 = $("#fileTax1").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;

    	var result = false;
		
    	if(fileTax1 != null && fileTax1 != '') {
    		if(!regexp.test(fileTax1)) {
    			 $("#fileTax1-extension").show();
    		} else {
    		    $("#fileTax1-extension").hide();
    		    
    		    result = true;
    		}
    	} else {
    	    $("#fileTax1-extension").hide();
    	}
    	
    	return result;	
    }
    
    function fileTax2Check(){
    	var fileTax2 = "";
    	if($("#fileTax2").length !== 0){
    		fileTax2 = $("#fileTax2").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;

    	var result = false;

    	if(fileTax2 != null && fileTax2 != '') {
    		if(!regexp.test(fileTax2)) {
    			 $("#fileTax2-extension").show();
    		} else {
    		    $("#fileTax2-extension").hide();
    		    
    		    result = true;
    		}
    	} else {
    	    $("#fileTax2-extension").hide();
    	}
    	
    	return result;	

    }
    function fileTax3Check(){
    	var fileTax3 = "";
    	if($("#fileTax3").length !== 0){
    		fileTax3 = $("#fileTax3").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;

    	var result = false;

    	if(fileTax3 != null && fileTax3 != '') {
    		if(!regexp.test(fileTax3)) {
    			 $("#fileTax3-extension").show();
    		} else {
    		    $("#fileTax3-extension").hide();
    		    
    		    result = true;
    		}
    	} else {
    	    $("#fileTax3-extension").hide();
    	}
    	
    	return result;	

    }
    function fileSup1Check(){
    	var fileSup1 = "";
    	if($("#fileSup1").length !== 0){
    		fileSup1 = $("#fileSup1").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;

    	var result = false;

    	if(fileSup1 != null && fileSup1 != '') {
    		if(!regexp.test(fileSup1)) {
    			 $("#fileSup1-extension").show();
    		} else {
    		    $("#fileSup1-extension").hide();
    		    
    		    result = true;
    		}
    	} else {
    	    $("#fileSup1-extension").hide();
    	}
    	
    	return result;	

    }
    function fileSup2Check(){
    	var fileSup2 = "";
    	if($("#fileSup2").length !== 0){
    		fileSup2 = $("#fileSup2").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;

    	var result = false;

    	if(fileSup2 != null && fileSup2 != '') {
    		if(!regexp.test(fileSup2)) {
    			 $("#fileSup2-extension").show();
    		} else {
    		    $("#fileSup2-extension").hide();
    		    
    		    result = true;
    		}
    	} else {
    	    $("#fileSup2-extension").hide();
    	}
    	
    	return result;	

    }
    function fileSup3Check(){
    	var fileSup3 = "";
    	if($("#fileSup3").length !== 0){
    		fileSup3 = $("#fileSup3").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;

    	var result = false;

    	if(fileSup3 != null && fileSup3 != '') {
    		if(!regexp.test(fileSup3)) {
    			 $("#fileSup3-extension").show();
    		} else {
    		    $("#fileSup3-extension").hide();
    		    
    		    result = true;
    		}
    	} else {
    	    $("#fileSup3-extension").hide();
    	}
    	
    	return result;	

    }
    
    function applfrmCheck(){
    	var applfrm = "";
    	if($("#applfrm").length !== 0){
    		applfrm = $("#applfrm").val();
    	}

    	var regexp = /\.(jpg|jpeg|png|pdf|xlsx|docx|hwp|gif|zip)$/i;

    	var result = false;

    	if(applfrm != null && applfrm != '') {
    		if(!regexp.test(applfrm)) {
    			 $("#applfrm-extension").show();
    		} else {
    		    $("#applfrm-extension").hide();
    		    
    		    result = true;
    		}
    	} else {
    	    $("#applfrm-extension").hide();
    	}
    	
    	return result;	

    }
    </script>
    
    </head>

    <body>
      <div id="contentsWrapper">
     <c:import url="../header.jsp" />   
        <div class="container" >
	  		<div class="title"> 구매확인서 발급 지원 신청
	  		</div>
  			<ul class="nav nav-tabs">
  				<li id="writeLi"><a data-toggle="tab" href="#WriteForm">신청서작성</a></li>
    			<li class="active" id="fileLi"><a data-toggle="tab" href="#FileForm">신청서첨부</a></li>
			</ul>
        </div>
        <br>
        <div class="container tab-content clearfix center">
        <div id="WriteForm" class="tab-pane fade">  
            <form class="form-horizontal" action="${pageContext.request.contextPath}/user/reqfrm/prchCnfrmApplCreate" id="applForm" method="post" enctype="multipart/form-data">
				<div class="col-lg-6 typeSelectionDiv tabarea">
				<table class="table borderless" >
					<colgroup>
						<col style="width:30%;">
						<col style="width:70%;">
					</colgroup>
					<tbody>
						<tr id="typeSelectionForm">
							<th><label>신청구분</label></th>
							<td><input type="radio" name="applditc" id="applditcO"  value="O"  <c:if test="${method == 'O'}">checked="checked"</c:if>> 신규발행 &nbsp;
							<input type="radio" name="applditc" id="applditcA" value="A" <c:if test="${method == 'A'}">checked="checked"</c:if>> 변경발행
							</td>
						</tr>
					</tbody>
				</table>
				</div>
				<div id="issuenumTable"  class="container col-lg-6 tabarea">
	                <table class="table borderless">
	                	<colgroup>
	                		<col style="width:30%;">
							<col style="width:70%;">
						</colgroup>
	                    <tbody>
	                    	<tr>
	                    		<th><label for="prtnum"> 구매확인서번호</label></th>
	                    		<td><input type="text" id="writeIssuenum" name="issuenum" class="form-control" disabled="disabled" placeholder="구매확인서번호"></td>
	                    		<td>
									<div class="btn btn-default file-input btnWidth" id="searchReqFrmForm"  data-target="#searchReqFrm" disabled="disabled" ><span class="file-input-title">조회</span></div>
								</td>
	                        </tr>
	                    </tbody>
	                 </table>
	             </div>
				<div class="container col-lg-6">
	                <table class="table borderless">
	                	<colgroup>
							<col style="width:30%;">
							<col style="width:70%;">
						</colgroup>
	                	<thead>
	                    	<tr>
	                    		<th scope="col" colspan="3"> 구매자 </th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<tr>
	                    		<th><label for="prtnum"> 사업자등록번호</label></th>
	                    		<td colspan="2"> <input type="text" class="form-control" id="prtnum" name="prtnum" placeholder="${usrinfvo.prtnum }"  disabled>
	                    		</td>
	                        </tr>
	                        <tr>
	                        	<th scope="row"><label for="add1" >주소</label></th>
	                        	<td><input type="text" class="form-control"  placeholder="${usrinfvo.addr1 }" disabled></td>
	                        	<td><button class="btn btn-default btnWidth" disabled>찾기</button></td>
	                    	</tr>
	                   		<tr>
	                   			<th scope="row"></th>
	                   			<td colspan="2"><input type="text" class="form-control"  placeholder="${usrinfvo.addr2 }" disabled></td>
	                    	</tr>
	                    	<tr>
	                    		<th scope="row"><label for="purName" >대표자명</label></th>
	                        	<td colspan="2"><input type="text" class="form-control"  placeholder="${usrinfvo.ceonm }" disabled/></td>
							</tr>
							<tr >
								<th scope="row"><label for="add1" >상호</label></th>
	                        	<td colspan="2"><input type="text" class=" form-control"  placeholder="${ usrinfvo.cmpnnm }" disabled ></td>
	 						</tr>
	 					</tbody>
	 				</table>
 				</div>
 				<div class="container col-lg-6">
	                <table class="table borderless">	
	                	<colgroup>
							<col style="width:30%;">
							<col style="width:70%;">
						</colgroup>
	                	<thead>
	                    	<tr>
	                    		<th scope="col" colspan="3">공급자</th>
	                    		<td><input type="hidden" value=${reqfrmvo.issuenum} id="hiddenIssuenum"></td>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<tr>
	                    		<th><label for="splyprtnum" >사업자등록번호</label></th>
	                    		<td colspan="2"><input type="text" <c:if test="${reqfrmvo != null and reqfrmvo.comingFromWhere == 'list'}">value=${reqfrmvo.splyprtnum}</c:if> class="form-control" autocomplete="off" id="splyprtnum" name="splyprtnum" placeholder="사업자등록번호" required onkeyup="fn_prtnumCheck()">
	                    			<small class="help-block" id="id-danger">이미 등록된 아이디 입니다.</small>
									<small class="help-block" id="id-notEmpty">사업자등록번호를 입력해주십시오.</small>
									<small class="help-block" id="id-length">사업자등록번호는 10자리로 입력해주십시오.</small>
									<small class="help-block" id="id-callback">사업자등록번호가 올바르지 않습니다.</small>
	
	                    		</td>
	                        </tr>
	                        <tr>
	                        	<th scope="row"><label for="splyaddr1" >주소<span class="text-danger"></span></label></th>
	                        	<td><input type="text" <c:if test="${reqfrmvo != null and reqfrmvo.comingFromWhere == 'list'}">value=${reqfrmvo.splyaddr1}</c:if> class="form-control" autocomplete="off" id="splyaddr1" name="splyaddr1" placeholder="주소" required onkeyup="fn_addr1()">
	                        		<small class="help-block" id="addr1-notEmpty" >주소를 입력해주십시오.</small>
									<small class="help-block" id="addr1-length" >주소는 35자 이하로 입력해주십시오.</small>
									<small class="help-block" id="addr1-regexp" >주소가 올바르지 않습니다.</small>
	                        	</td>
	                        	<td><button type="button" id="searchAddress" class="btn btn-default btnWidth"> 찾기</button></td>
	                    	</tr>
	                   		<tr>
	                   			<th scope="row"></th>
	                   			<td colspan="2"><input type="text" <c:if test="${reqfrmvo != null and reqfrmvo.comingFromWhere == 'list'}">value=${reqfrmvo.splyaddr2}</c:if> class="form-control" autocomplete="off" id="splyaddr2" name="splyaddr2" placeholder="주소" required onkeyup="fn_addr2()">
	                   				<small class="help-block" id="addr2-notEmpty" >상세주소를 입력해주십시오.</small>
									<small class="help-block" id="addr2-length" >상세주소는 35자 이하로 입력해주십시오.</small>
									<small class="help-block" id="addr2-regexp" >상세주소가 올바르지 않습니다.</small>
	                   			</td>
	                    	</tr>
	                    	<tr>
	                    		<th scope="row"><label for="splyceonm" >대표자명</label></th>
	                        	<td colspan="2"><input type="text" <c:if test="${reqfrmvo != null and reqfrmvo.comingFromWhere == 'list'}">value=${reqfrmvo.splyceonm}</c:if> class="form-control" autocomplete="off" id="splyceonm" name="splyceonm" placeholder="성명" required onkeyup="fn_ceonm()">
	                        		<small class="help-block" id="ceonm-notEmpty" >대표자명을 입력해주십시오.</small>
									<small class="help-block" id="ceonm-length" >대표자명은 25자 이하로 입력해주십시오.</small>
									<small class="help-block" id="ceonm-regexp" >대표자명이 올바르지 않습니다.</small>
	
	                        	</td>
							</tr>
							<tr>
								<th scope="row"><label for="splyorgnm" >상호</label></th>
	                        	<td colspan="2"><input type="text" <c:if test="${reqfrmvo != null and reqfrmvo.comingFromWhere == 'list'}">value=${reqfrmvo.splyorgnm}</c:if> class="form-control" autocomplete="off" id="splyorgnm" name="splyorgnm" placeholder="상호명" required onkeyup="fn_cmpnnm()">
	                        		<small class="help-block" id="cmpnnm-notEmpty">상호명을 입력해주십시오.</small>
									<small class="help-block" id="cmpnnm-length" >상호명은 25자 이하로 입력해주십시오.</small>
									<small class="help-block" id="cmpnnm-regexp" >상호명이 올바르지 않습니다.</small>
	                        	</td>
	 						</tr>
	 						<tr>
	 					</tbody>
	                </table>
				</div>
                <div class="container col-lg-6">
	                <table class="table borderless">
	                	<colgroup>
							<col style="width:80%;">
							<col style="width:20%;">
						</colgroup>
	                	<thead>
	                    	<tr>
	                    		<th colspan="3"> 수출근거서류<font color="red">*</font>  
	        					<a data-toggle="modal"  href="#myModalExport"><span class="glyphicon glyphicon-info-sign"></span></a>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<tr>	
	                    		<td class="inputFile" colspan="2"><input type="text" class="form-control preview-filename"  disabled="disabled">
	                    			<small class="help-block" id="writeSup1-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
	                    		</td>
	                        	<td><div class="btn btn-default file-input btnWidth">
	                                <span class="glyphicon glyphicon-folder-open"></span>
	                                <span class="file-input-title">첨부</span>
	                                <input type="file" id="writeSup1"  onchange="writeSup1Check()";  name="sup"/>
	                                </div>
	                            </td>	                    		
	                        </tr>
	                        <tr>
	                        	<td class="inputFile" colspan="2"><input type="text" class="form-control preview-filename"  disabled="disabled">
	                        		<small class="help-block" id="writeSup2-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
	                        	</td>
	                        	<td><div class="btn btn-default file-input btnWidth">
	                                <span class="glyphicon glyphicon-folder-open"></span>
	                                <span class="file-input-title">첨부</span>
	                                <input type="file" id="writeSup2"  onchange="writeSup2Check()";  name="sup"/>
	                                </div>
	                            </td>	                        	
	                    	</tr>
	                   		<tr>
	                   			<td class="inputFile" colspan="2"><input type="text" class="form-control preview-filename"  disabled="disabled">
	                   				<small class="help-block" id="writeSup3-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
	                   			</td>

	                   			<td><div class="btn btn-default file-input btnWidth">
	                                <span class="glyphicon glyphicon-folder-open"></span>
	                                <span class="file-input-title">첨부</span>
	                                <input type="file" id="writeSup3"  onchange="writeSup3Check()";  name="sup"/>
	                                </div>
	                            </td>
	                    	</tr>	                    	
	 					</tbody>
	                </table>
                </div>
               
				
              	<small class="help-block" id="fileValidation">올바른 확장자를 입력해주십시오.</small>
              	<div class="container col-lg-6">
	                <table class="table borderless"> 
	                	<colgroup>
							<col style="width:80%;">
							<col style="width:20%;">
						</colgroup>
	                	<thead>
	                    	<tr>
	                    		<th colspan="3"> 세금계산서   
	             					<a data-toggle="modal"  href="#myModalTax"><span class="glyphicon glyphicon-info-sign"></span></a>
	             					<font class="text-primary" >(사후발급건만 첨부)</font>
	             				</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<tr>
	                    		<td class="inputFile" colspan="2"><input type="text" class="form-control preview-filename" disabled="disabled">
	                    			<small class="help-block" id="writeTax1-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
	                    		</td>
	                        	<td><div class="btn btn-default file-input btnWidth">
	                                <span class="glyphicon glyphicon-folder-open"></span>
	                                <span class="file-input-title">첨부</span>
	                                <input type="file" id="writeTax1" onchange="writeTax1Check()";  name="tax"/>
	                                </div>
	                            </td>	                    		
	                        </tr>
	                        <tr>
	                        	<td class="inputFile" colspan="2"><input type="text" class="form-control preview-filename"  disabled="disabled">
	                        		<small class="help-block" id="writeTax2-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
	                        	</td>
	                        	<td><div class="btn btn-default file-input btnWidth">
	                                <span class="glyphicon glyphicon-folder-open"></span>
	                                <span class="file-input-title">첨부</span>
	                                <input type="file" id="writeTax2"  onchange="writeTax2Check()";  name="tax"/>
	                                </div>
	                            </td>	                        	
	                    	</tr>
	                   		<tr>
	                   			<td class="inputFile" colspan="2"><input type="text" class="form-control preview-filename"  disabled="disabled">
	                   				<small class="help-block" id="writeTax3-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
	                   			</td>
	                   			<td><div class="btn btn-default file-input btnWidth">
	                                <span class="glyphicon glyphicon-folder-open"></span>
	                                <span class="file-input-title">첨부</span>
	                                <input type="file"  id="writeTax3"  onchange="writeTax3Check()";  name="tax"/>
	                                </div>
	                            </td>	                   			
	                    	</tr>
	 					</tbody>
	                </table>
                </div>
                <div class="container col-sm-12 text-center row btLayer" id="buttonForWebSubmit">           
                	<button type="text" class="btn btn-default btnCancel" >취소</button>
                	<button type="submit" id="submitBtn" class="btn btn-primary" onclick="return fn_validationCheck()">제출</button>
     			</div>
        </form>
    </div>
    
    
    <div id="FileForm" class="tab-pane fade in active">
    	<form class="form-horizontal" method="post" action="${pageContext.request.contextPath}/user/reqfrm/prchCnfrmApplFileCreate" enctype="multipart/form-data">
				<div class="col-lg-6 typeSelectionDiv tabarea">
				<table class="table borderless">
					<colgroup>
	                		<col style="width:20%;">
							<col style="width:40%;">
							<col style="width:40%;">
					</colgroup>
					<tbody>
						<tr id="typeSelectionForm">
							<th><label>신청구분</label></th>
							<td><input type="radio" name="applditc" id="applditcO"  value="O"  <c:if test="${method == 'O'}">checked="checked"</c:if>> 신규발행 &nbsp;
							<input type="radio" name="applditc" id="applditcA" value="A" <c:if test="${method == 'A'}">checked="checked"</c:if>> 변경발행
							</td>
							<td><input type="text" id="fileIssuenum" name="issuenum" disabled="disabled" class="form-control" placeholder="구매확인서번호"></td>
						</tr>
					</tbody>
				</table>
				</div>
				<div id="fileIssuenumTable" class="container col-lg-6 typeSelectionDiv tabarea">
	                <table class="table borderless">
	                	<colgroup>
	                		<col style="width:25%;">
							<col style="width:50%;">
							<col style="width:10%;">
							<col style="width:15%;">
						</colgroup>
	                    <tbody>
	                    	<tr>
	                    		<th> 신청서<font color="red">*</font></th>
	                    		<td class="inputFile">
									<input type="text" class="form-control preview-filename" disabled="disabled">
									<small class="help-block" id="applfrm-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
								</td>
								<td>
									<div class="btn btn-default file-input btnWidth">
										<span class="glyphicon glyphicon-folder-open"></span> 
										<span class="file-input-title">첨부</span> 
										<input type="file" name="applfrm" id="applfrm" placeholder="신청서" onchange="applfrmCheck()";
											required />
									</div>
								</td>
								<td align="left"><a href="${pageContext.request.contextPath}/download/APPL_REGI.zip" download>
									<button type="button" class="btn btn-danger">양식다운</button></a></td>
	                        </tr>
	                    </tbody>
	                 </table>
	             </div>
                <div class="container col-lg-6">
	                <table class="table borderless">
	                	<colgroup>
							<col style="width:80%;">
							<col style="width:20%;">
						</colgroup>
	                	<thead>
	                    	<tr>
	                    		<th colspan="3"> 수출근거서류<font color="red">*</font>  
	        					<a data-toggle="modal"  href="#myModalExport"><span class="glyphicon glyphicon-info-sign"></span></a>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<tr>
	                    		<td class="inputFile" colspan="2"><input type="text" class="form-control preview-filename"  disabled="disabled">
	                    			<small class="help-block" id="fileSup1-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
	                    		</td>
	                    		<td><div class="btn btn-default file-input btnWidth">
	                                <span class="glyphicon glyphicon-folder-open"></span>
	                                <span class="file-input-title">첨부</span>
	                                <input type="file" id="fileSup1"  onchange="fileSup1Check()";  name="sup"/>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                        	<td class="inputFile" colspan="2"><input type="text" class="form-control preview-filename"  disabled="disabled">
	                        		<small class="help-block" id="fileSup2-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
	                        	</td>
	                        	<td><div class="btn btn-default file-input btnWidth">
	                                <span class="glyphicon glyphicon-folder-open"></span>
	                                <span class="file-input-title">첨부</span>
	                                <input type="file" id="fileSup2"  onchange="fileSup2Check()";  name="sup"/>
	                                </div>
	                            </td>	                   
	                    	</tr>
	                   		<tr>
	                   			<td class="inputFile" colspan="2"><input type="text" class="form-control preview-filename"  disabled="disabled">
	                   				<small class="help-block" id="fileSup3-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
	                   			</td>
	                   			<td><div class="btn btn-default file-input btnWidth">
	                                <span class="glyphicon glyphicon-folder-open"></span>
	                                <span class="file-input-title">첨부</span>
	                                <input type="file" id="fileSup3"  onchange="fileSup3Check()";  name="sup"/>
	                                </div>
	                            </td>
	                   			
	                    	</tr>
	 					</tbody>
	                </table>
                </div>
               
				
              	<small class="help-block" id="fileValidation">올바른 확장자를 입력해주십시오.</small>
              	<div class="container col-lg-6">
	                <table class="table borderless"> 
	                	<colgroup>
							<col style="width:80%;">
							<col style="width:20%;">
						</colgroup>
	                	<thead>
	                    	<tr>
	                    		<th colspan="3"> 세금계산서   
	             					<a data-toggle="modal" href="#myModalTax"><span class="glyphicon glyphicon-info-sign"></span></a>
	             					<font class="text-primary"> (사후발급건만 첨부)</font>
	             				</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<tr>
	                    		<td class="inputFile" colspan="2"><input type="text" class="form-control preview-filename" disabled="disabled">
	                    			<small class="help-block" id="fileTax1-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
	                    		</td>
	                        	<td><div class="btn btn-default file-input btnWidth">
	                                <span class="glyphicon glyphicon-folder-open"></span>
	                                <span class="file-input-title">첨부</span>
	                                <input type="file" id="fileTax1" onchange="fileTax1Check()";  name="tax"/>
	                                </div>
	                            </td>	                    		
	                        </tr>
	                        <tr>
	                        	<td class="inputFile" colspan="2"><input type="text" class="form-control preview-filename"  disabled="disabled">
	                        		<small class="help-block" id="fileTax2-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
	                        	</td>
	                        	<td><div class="btn btn-default file-input btnWidth">
	                                <span class="glyphicon glyphicon-folder-open"></span>
	                                <span class="file-input-title">첨부</span>
	                                <input type="file" id="fileTax2"  onchange="fileTax2Check()";  name="tax"/>
	                                </div>
	                            </td>	                        
	                    	</tr>
	                   		<tr>
	                   			<td class="inputFile" colspan="2"><input type="text" class="form-control preview-filename"  disabled="disabled">
	                   				<small class="help-block" id="fileTax3-extension" >첨부 가능한 확장자 : jpg, png, pdf, xlsx, docs, hwp, gif, zip</small>
	                   			</td>
	                   			<td><div class="btn btn-default file-input btnWidth">
	                                <span class="glyphicon glyphicon-folder-open"></span>
	                                <span class="file-input-title">첨부</span>
	                                <input type="file"  id="fileTax3"  onchange="fileTax3Check()";  name="tax"/>
	                                </div>
	                            </td>	                   			
	                    	</tr>
	 					</tbody>
	                </table>
                </div>
				<div class="container col-sm-12 text-center row btLayer" id="buttonForFileSubmit" >           
		                <button type="text" class="btn btn-default btnCancel" >취소</button>
		                <button type="submit" id="submitBtn" class="btn btn-primary" onclick="return fileValidationCheck()">제출</button>
		     	</div>
       </form>
    </div>
   </div>
    
	<!-- Modal -->
	<div class="modal fade" id="myModalExport" role="dialog">
		<div class="modal-dialog">
	    <!-- Modal content-->
		    <div class="modal-content">
		    	<div class="modal-header">
		     		<button type="button" class="close" data-dismiss="modal">&times;</button>
		          	<h4 class="modal-title">수출근거서류 첨부안내</h4>
		        </div>
		        <div class="modal-body">
		          <p>1. 수출신용장<br>
		             *수출계약서(품목, 수량, 가격 등에 합의하여 서명한 수출계약 입증서류)<br>
		             *외화매입서/예치증명서<br>
		               -외화획득이행 관련 대금임이 서류에 의해 확인되는 경우만 해당<br>
		              <br>
		              2. 내국신용장/구매확인서<br>
		               -N차 공급자의 경우에 해당<br>
		                *수출신고필증<br>
		                *대외무역법시행령 제 26조 각호에 따른<br>
		                외화획득에 제공되는 물품 등을 생산하기 위한 경우임을 입증할 수 있는 서류<br>
		          </p>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        </div>
		    </div>
	    </div>
	</div>
	<div class="modal fade" id="myModalTax" role="dialog">
		<div class="modal-dialog">
	    
	      <!-- Modal content-->
	     <div class="modal-content">
	       <div class="modal-header">
	         <button type="button" class="close" data-dismiss="modal">&times;</button>
	         <h4 class="modal-title">세금계산서 첨부안내</h4>
	       </div>
	       <div class="modal-body">
	         <p>*사전발급: 구매일 기준 익월 10일 이전<br>
	             -외화획득용 원료/기재를 구매하려는 경우 세금계산서 없이 발급<br><br>
	             *사후발급: 구매일 기준 익월 10일 이후<br>
	             -외화획득용 원료/기재를 구매한 경우 세금계산서 정보 기재 후 발급
	         </p>
	       </div>
	       <div class="modal-footer">
	         <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	       </div>
	     </div>
	   </div>
	</div>
	
	<div class="modal fade" id="searchReqFrm" role="dialog">
		<div class="modal-dialog">
	    
	      <!-- Modal content-->
	     <div class="modal-content">
	       <div class="modal-header">
	         <button type="button" class="close" id="searchClose" data-dismiss="modal">&times;</button>
	         <h4 class="modal-title">발급지원번호로 검색하기</h4>
	       </div>
	       <div class="modal-body">
	         <input type="text" id="searchApplnum">
	         <button id="searchForReqFrm">검색</button>
	         <table class="table" id="pushTable">
	         	<tr>
	         		<td>발급신청번호</td>
	         		<td>공급자상호</td>
	         		<td>공급자대표자</td>
	         		<td>공급자주소1</td>
	         		<td>공급자주소2</td>
	         		<td>구매확인서번호</td>
	         	</tr>
	         		
	         </table>
	       </div>
	       <div class="modal-footer">
	         <button type="button" class="btn btn-default" id="searchCloseBtn" data-dismiss="modal">Close</button>
	       </div>
	     </div>
	   </div>
	</div>
</div>
</body>
<!-- script -->
<c:import url="../footer.jsp" />
</html>