<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<meta http-equiv="X-UA-Compatible" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>구매확인서 발급 서비스</title>

<link href="${pageContext.request.contextPath}/css/user.css" rel="stylesheet" type="text/css">
   	
<script script language="Javascript" type="text/javascript">

console.log("start of the script");


//contextPath찾아오는 함수
function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

function changeDate(searchPeriod) {
	
	var today = new Date();
	if (searchPeriod =='7D'){
		$("#dateTo").datepicker('setDate', 'today');
		$("#dateFrom").datepicker('setDate', '-7D');
	}
	else if (searchPeriod =='1M'){
		$("#dateTo").datepicker('setDate', 'today');
		$("#dateFrom").datepicker('setDate', '-1M');
	}
	else if (searchPeriod =='3M'){
		$("#dateTo").datepicker('setDate', 'today');
		$("#dateFrom").datepicker('setDate', '-3M');
	}
	else if(searchPeriod == '6M'){
		$("#dateTo").datepicker('setDate', 'today');
		$("#dateFrom").datepicker('setDate', '-6M');
	}
	else if(searchPeriod == '12M'){
		$("#dateTo").datepicker('setDate', 'today');
		$("#dateFrom").datepicker('setDate', '-12M');
	}
	}
	
	function redirctToApplicationPage(applnum, issuenum){
	    document.location.href = getContextPath() + '/user/reqfrm/prchCnfrmApplCreate.do?applnumFromList=' + applnum + '&issuenum=' + issuenum;
	}
	
	// 구매확인서 변경요청 이벤트
	function clickReqfrmChangeRequest(e){		
		
		var loginId = "${loginId}";
		var message = document.querySelector("#changeReqfrmMessage").value;
		
		
		var reqFrmListVO = function(applnum, issuemdfreq){
			this.prtnum = loginId;
			this.applnum = applnum;
			this.sts = "C2";
			this.issuemdfreq= issuemdfreq;
		};
		
		var checkedList = [];
		var validateSts = true;
		var validateNum = false;
		
		Date.prototype.subDays = function(days) {
		    this.setDate(this.getDate() - parseInt(days));
		    return this;
		};
		var today = new Date();
		var sevenDaysSub = today.subDays(7);
		let test = $( "input[name='checkRow']:checked" );
		$( "input[name='checkRow']:checked" ).each (function (){
			if($(this).parent().siblings('.codeName').text() !== '발행완료' ){
				alert("발행완료건만 선택 해주세요");
				validateSts = false;
				return false;
			} else {
				
				var rgsttm = new Date ($(this).parent().siblings('.rgsttm').text());
				if(rgsttm < sevenDaysSub){
					console.log(rgsttm);
					let confirmJudge = confirm("발행 후 7일 이후에는 변경발행 신청서를 작성하셔야합니다. 신청서 화면으로 이동하시겠습니까?");
					validateSts = false;
					if(confirmJudge){
						if($( "input[name='checkRow']:checked" ).length === 1){
							var applnum = $(this).parent().siblings('.applnum').text();
							var issuenum = $(this).parent().siblings('.issuenum').text();
							redirctToApplicationPage(applnum, issuenum);
						}
						else{
							alert("1건씩만 가능합니다.");
						}
					}
					else{
						closeChangeReqfrm.click();
						checkOffAll();
						$('#changeReqfrmMessage').val('')
					}
					return;
				}
				
				checkedList.push(new reqFrmListVO($(this).parent().siblings('.applnum').text(),message));
				validateNum = true;
			}
			
		});
		
		if( validateSts === false){
			return;
		}
		
		if( validateNum === false){
			alert("신청 건을 선택해주십시오");
			return;
		}
		

		updateStatus(checkedList);
		closeChangeReqfrm.click();
		checkOffAll();
		$('#changeReqfrmMessage').val('')
	}
	
	
	//견본변경신청 이벤트
	function clickSampleChangeRequest(e){
	    
	    var loginId = "${loginId}";
	    var message = document.querySelector("#changeSampleMessage").value;
	    var reqFrmListVO = function(applnum, smplmdfreq){
	            this.prtnum = loginId;
	            this.applnum = applnum;
	            this.sts = "S2";
	            this.smplmdfreq = smplmdfreq;
	    };
	    var checkedList = [];
	    var validateSts = true;
	    var validateNum = false;
	    var firstCodeName = $( "input[name='checkRow']:checked" )[0].parentNode
	                        .parentNode.getElementsByClassName("codeName")[0].textContent;
	    
	    
	    /* if(firstCodeName !== '견본완료' && firstCodeName !== '발행완료'){
	        alert("견본완료나 발행완료 중 하나만 변경이 가능합니다.");
	        return;
	    } */
	   
	    
	    $( "input[name='checkRow']:checked" ).each (function (){
	        //validate status
	        
	        if($(this).parent().siblings('.codeName').text() !== '견본완료'){
	            alert("견본완료건만 선택해주세요");
	            validateSts = false;
	            return false;
	        } else {
	            checkedList.push(new reqFrmListVO($(this).parent().siblings('.applnum').text(),message));
	            validateNum = true;
	            
	        }
	        
	    });
	    
	    if( validateSts === false){
	        return;
	    }
	    
	    if( validateNum === false){
	        alert("신청 건을 선택해주십시오");
	        return;
	    }
	    
	    updateStatus(checkedList);
	    //document.location.href = getContextPath() + '/user/reqfrm/list';
	    //window.location.reload();
	    closeChangeSample.click();
	    checkOffAll();
		$('#changeSampleMessage').val('')
	}
	
	
	// 견본 확인 이벤트
	function sampleConfirmation(){
	    
	    
	    var loginId = "${loginId}";
	    // 생성자
	    
	    
	    var reqFrmListVO = function(applnum){
	        this.prtnum = loginId;
	        this.cnfrmid = loginId;
	        this.cnfrmdt = "today;"
	        this.applnum = applnum;
	        this.sts = "S3"
	    }
	    var sampleList = [];
	    
	    $( "input[name='checkRow']:checked" ).each (function (){
	    	sampleList.push(new reqFrmListVO($(this).parent().siblings('.applnum').text()));
	    });
	    
	    updateSampleConfirm(sampleList);
	}
	
	// 상태 변경 함수
	function updateStatus(checkedList) {
	    $.ajax({
	        url: "/egume_upc/user/reqfrm/updateStatus", 
	        type: "PUT", 
	        contentType: "application/json", 
	        dataType : "json", 
	        data: JSON.stringify(checkedList), 
	        success: function(result) {
	            alert("변경 요청을 완료했습니다");
	            updateCodeName(result);
	        }, 
	        error: function(request, status, error) {
	            alert("변경 요청이 실패했습니다");
	            //console.log("code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
	        }
	    });
	}

	// 상태 이름 변경 함수
	function updateCodeName(resultObj) {
	    
	    function changeCodeName(item){
	        
	        
	        var jqueryStr = item.applnum;
	        // 견본 수정중인 상태
	        if(item.sts === 'S2'){
	            $('#'+jqueryStr).parent().children('.codeName').text('견본수정중');
	            $('#'+jqueryStr).parent().children('.icon').text(' ');
	        }
	        
	        else if(item.sts === 'C2'){
	            $('#'+jqueryStr).parent().children('.codeName').text('발행수정중');
	            $('#'+jqueryStr).parent().children('.icon').text(' ');
	            
	        }
	        else if(item.sts === 'S3'){
	            $('#'+jqueryStr).parent().children('.codeName').text('견본확인');
	            $('#'+jqueryStr).parent().children('.icon').text(' ');
	        }
	    }
	    
		for(var i = 0; i < resultObj.length; i++){
	    	changeCodeName(resultObj[i]);
		}
	    
	};
	
	function updateSampleConfirm(sampleList){
	    $.ajax({
	        url: "/egume_upc/user/reqfrm/updateStatus", 
	        type: "PUT", 
	        contentType: "application/json", 
	        dataType : "json", 
	        data: JSON.stringify(sampleList), 
	        success: function(result) {
	            alert("견본 변경 요청을 완료했습니다");
	            updateCodeName(result);
	        }, 
	        error: function(request, status, error) {
	            alert("견본 변경 요청이 실패했습니다");
	            //console.log("code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
	        }
	    });
	}
	
	// 체크박스 한꺼번에 체크하는 이벤트
	function checkAll() {
	    if( $("#checkAll").is(':checked') ){
	        $("input[name=checkRow]").prop("checked", true);
	    }else{
	        $("input[name=checkRow]").prop("checked", false);
	    }
	}
	
	// 체크박스 한꺼번에 없애는 이벤트
	function checkOffAll(){	
	    $("input[name=checkRow]").prop("checked", false);
	}
	
	// 구매확인서 다운로드
	function downloadForIssue(){
        if (!$('.downloadIssue')) return;
        var downloadIssue = $('.downloadIssue');
        for(var i=0; i<downloadIssue.length; i++){
            $(downloadIssue[i]).on('click', function(e){
                location.href="${pageContext.request.contextPath}/filedownload/?fileseq=" + e.currentTarget.getAttribute("value");
                
                })
            }
    }
    
	// 견본 구매확인서 다운로드
    function downloadForSample(){
        if(!$('.downloadSample')) return;
        let downloadSample =  $('.downloadSample');
        for(var i=0; i<downloadSample.length; i++){
            $(downloadSample[i]).on('click', function(e){
                location.href="${pageContext.request.contextPath}/filedownload/?fileseq=" + e.currentTarget.getAttribute("value");
                
                })
            }
    }
	
	// Hello
	function beforeChangeSampleInspection(){
		var validateSts = true;
		var len = $( "input[name='checkRow']:checked" ).length;
		if(len === 0 || len > 1){
			alert("견본완료 1건만 선택해주세요")
			return false;
		}
		$( "input[name='checkRow']:checked" ).each (function (){
		    //validate status
	        if($(this).parent().siblings('.codeName').text() !== '견본완료'){
	            alert("견본완료 1건만 선택해주세요");
	            validateSts = false;
	            return false;
        	}
		})
		 
		 if(validateSts === false){
			 $("#changeSampleButton").removeAttr('data-toggle');
			 return;
		 }
		
		 var judge = confirm("견본확인하시겠습니까? 변경을 원하시면 취소버튼을 누르십시오.");
		 if(judge){
			 sampleConfirmation();
			 $("#changeSampleButton").removeAttr('data-toggle');
		 }
		 else{
			 $("#changeSampleButton").attr('data-toggle', "modal");			 
		 }
	}
	
	function beforeChangeReqfrmInspection(){
		var validateSts = true;
		var len = $( "input[name='checkRow']:checked" ).length;
		if(len === 0 || len > 1){
			alert("발행완료 1건만 선택해주세요")
			return false;
		}
		$( "input[name='checkRow']:checked" ).each (function (){
		    //validate status
	        if($(this).parent().siblings('.codeName').text() !== '발행완료'){
	            alert("발행완료 1건만 선택해주세요");
	            validateSts = false;
	            return false;
        	}
		})
		 
		 if(validateSts === false){
			 $("#changeReqfrmButton").removeAttr('data-toggle');
			 return;
		 }
		 $("#changeReqfrmButton").attr('data-toggle', "modal");
	}
	
	window.onload = function(){
	var closeChangeSample = document.querySelector("#closeChangeSample");
	var closeChangeReqfrm = document.querySelector("#closeChangeReqfrm");
		
	$("#changeSampleButton").on("click", beforeChangeSampleInspection);
	$("#changeReqfrmButton").on("click", beforeChangeReqfrmInspection);
	
	downloadForIssue();		
	downloadForSample();
	// datePicker
	$.datepicker.setDefaults({
		dateFormat: 'yymmdd'
	});
	$("#dateFrom").datepicker();
	$("#dateTo").datepicker();
	
	// 기간 체크 용 이벤트 
    var inputs = document.querySelectorAll("label.radio-inline input");
    var inputsSize = inputs.length;
    
	/* for(var i = 0; i < inputsSize; i++){
		(function(j){
			inputs[j].addEventListener("click", changeDate);
			
		})(i)
	} */
	
	var periodCondition = document.querySelector("#period");
	periodCondition.addEventListener("click", function(e){
		changeDate(e.currentTarget.value);
	}) 
	
	
	 /** 모든 체크박스 선택 이벤트 달기 */
    document.getElementById("checkAll").addEventListener("click",checkAll);
	
	
	// 견본 확인 이벤트 
    var sampleConfirmBtns = document.querySelectorAll("button.sampleConfirm");
    var sampleConfirmBtnsSize = sampleConfirmBtns.length;
    
    
    for(var i = 0; i < sampleConfirmBtns.length; i++){
    	sampleConfirmBtns[i].addEventListener("click",sampleConfirmation);
    }
    
    
    /** 견본 변경 요청 이벤트 달기 */
    document.getElementById("changeSampleSubmit").addEventListener("click", clickSampleChangeRequest);
    
    /* 구매확인서 변경 요청 이벤트 다라기*/
    document.getElementById("changeReqfrmSubmit").addEventListener("click", clickReqfrmChangeRequest);
    
    /** 다운로드 기능 */
    $("#download").on('click', function() {
        var checkList=[];
        
        var validateSts = true;
        $("input[name=checkRow]:checked").each(function() {
        	if($(this).parent().siblings('.codeName').text() !== '발행완료' ){
	            alert("발행완료건만 선택해주세요");
	            validateSts = false;
	            return;
	        }
            checkList.push($(this).val());
        });
        if(validateSts === false)
        	return;
        location.href="${pageContext.request.contextPath}/filedownload/?fileseq="+checkList;
    });
    
    /** 페이징 URL 처리 */
    $('#paging > ul > li').children('a').on('click',function(e){
        
        $('#paging > ul > li').children('a').css('cursor','pointer');
        
        var url = $(location).attr('pathname')+'?';
        var search = $(location).attr('search');
        
        var paramArray = new Array();
        paramArray[0] = 'dateCondition';
        paramArray[1] = 'dateFrom';
        paramArray[2] = 'dateTo';
        paramArray[3] = 'searchCondition';
        paramArray[4] = 'conditionValue';
        paramArray[5] = 'pageIndex';
        paramArray[6] = 'searchStatus';
        
        $.urlParam = function(name) {
            var results = new RegExp('[\?&]'+ name + '=([^&#]*)').exec(window.location.href);
                if (results == null) {
                    
                    return null;
                } else {
                    
                    return results[1];
                }
          }
      
      for (var i = 0; i < paramArray.length; i++) {
           if (paramArray[i] == 'pageIndex') {
                 
                   if($(this).parent('li').hasClass("previous")){
                       
                       url += '&' + paramArray[i] + '=' + (Number($.urlParam(paramArray[i]))-1);
                   }else if($(this).parent('li').hasClass("next")){
                       
                       url += '&' + paramArray[i] + '=' + (Number($.urlParam(paramArray[i]))+1);
                   }else{
                       
                        url += '&' + paramArray[i] + '=' + $(this).text();
                   }
                   
                } else {
                     if($.urlParam(paramArray[i]) != null){
                         url += '&' + paramArray[i] + '=' + $.urlParam(paramArray[i]);
                     }
                }
          }
      
 	$(this).prop("href", url);
    });
    
    
	// end of Ready Function 
	}

	
	

	
</script>


<body>
<div id="contentsWrapper">
<c:import url="../header.jsp" />
	<div class="container header">
		<div class="title">신청현황</div>
	</div>
	<div class="container conditionBox well">
		<form class="needs-validation" name="option_form" role="form"
			action="prchCnfrmApplList.do" method="GET" id="form_container"
			accept-charset="utf-8">
			<div class="form-row">
				<div class="col-md-1">
					<label for="dateCondition" class="control-label searchText">조회날짜</label>
				</div>
				<div class="col-md-2">
					<select class="form-control" id="dateCondition" name="dateCondition">
						<option value="appldt"
							<c:if test="${searchVO.dateCondition eq 'appldt'}">selected</c:if>>신청일</option>
						<option value="rgsttm"
							<c:if test="${searchVO.dateCondition eq 'rgsttm'}">selected</c:if>>발급일</option>
					</select>
				</div>
				<div class="form-row col-md-4 dateInputParent" style="float: left;">
						<input type="text" class="form-control" autocomplete="off" name="dateFrom"
						id="dateFrom" value="${searchVO.dateFrom}" required />
					<label class="control-label col-md-1">~</label>
						<input type="text" class="form-control" autocomplete="off" name="dateTo" id="dateTo" value="${searchVO.dateTo}" required />
				</div>
				<div class="col-md-1">
					<label for="periodCondition" class="control-label searchText">기간</label>
				</div>
				<div class="col-md-2">
					<select class="form-control" id="period" name="period">
						<option value="7D"
							<c:if test="${searchVO.period eq '7D'}">selected</c:if> >일주일</option>
						<option value="1M"
							<c:if test="${searchVO.period eq '1M'}">selected</c:if> >1개월</option>
						<option value="3M"
							<c:if test="${searchVO.period eq '3M'}">selected</c:if> >3개월</option>
						<option value="6M"
							<c:if test="${searchVO.period eq '6M'}">selected</c:if> >6개월</option>
						<option value="12M"
							<c:if test="${searchVO.period eq '12M'}">selected</c:if>  >1년</option>			
					</select>
				</div>
			</div>
			<br>
			<br>
			<div class="form-row">
				<div class="col-md-1">
					<label for="searchCondition" class="control-label searchText">조회조건</label>
				</div>
				<div class="col-md-2">
					<select class="form-control" id="searchCondition"
						name="searchCondition">
						<option value="splyorgnm"
							<c:if test="${searchVO.searchCondition eq 'splyorgnm'}">selected</c:if>>공급자상호</option>
						<option value="issuenum"
							<c:if test="${searchVO.searchCondition eq 'issuenum'}">selected</c:if>>구매확인서번호</option>
					</select>
				</div>
				<div class="col-md-4">
					<input type="text" class="form-control" autocomplete="off" id="codition"
						name="conditionValue" value="${searchVO.conditionValue}"
						placeholder="내용을 입력해주세요">
				</div>
				<div class="col-md-1">
					<label for="searchCondition" class="control-label searchText">진행상태</label>
				</div>
				<div class="col-md-2">			
					<select class="form-control" id="stsCondi" name="searchStatus">
						<option value="all" <c:if test="${searchVO.searchStatus eq 'all'}">selected</c:if>>전체</option>
						<option value="all" <c:if test="${searchVO.searchStatus eq 'R1'}">selected</c:if>>신청완료</option>
						<option value="R2" <c:if test="${searchVO.searchStatus eq 'R2'}">selected</c:if>>접수완료</option>
						<option value="R3" <c:if test="${searchVO.searchStatus eq 'R3'}">selected</c:if>>입금확인</option>
						<option value="S1" <c:if test="${searchVO.searchStatus eq 'S1'}">selected</c:if>>견본완료</option>
						<option value="S2" <c:if test="${searchVO.searchStatus eq 'S2'}">selected</c:if>>견본수정중</option>
						<option value="S3" <c:if test="${searchVO.searchStatus eq 'S3'}">selected</c:if>>견본확인</option>
						<option value="C1" <c:if test="${searchVO.searchStatus eq 'C1'}">selected</c:if>>발행완료</option>
						<option value="C2" <c:if test="${searchVO.searchStatus eq 'C2'}">selected</c:if>>발행수정중</option>
					</select>
				</div>
				<div class="col-md-1">
					<button class="btn btn-primary" type="submit">검색</button>	
				</div>
			</div>
		</form>
	</div>
	<br>
	<div class="container ">
		
		<!--버튼-->
	
		<div class="row">
			<button class="btn btn-primary pull-right purBtn" id="download"> 다운로드</button>
			<!-- <div class="modal fade" id="download" role="dialog">
       			<div class="modal-dialog">	        
         			 Modal content
          			<div class="modal-content">
            			<div class="modal-header">
              				<button type="button" class="close" data-dismiss="modal">&times;</button>
              				<h4 class="modal-title">(견본)구매확인서 다운로드</h4>
            			</div>
            			<div class="modal-body">
              				<textarea class="form-control" rows="7" placeholder="다운로드 받을 파일들 목록"></textarea>
            			</div>
            			<div class="modal-footer">
              				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            			</div>
          			</div>
     			</div>
     		</div> -->
			<button class="btn btn-info pull-right purBtn" id="changeSampleButton" data-toggle="modal" data-target="#changeSampleBody">견본 확인/변경</button>
			<div class="modal fade" id="changeSampleBody" role="dialog">
       			<div class="modal-dialog">	        
         			 <!-- Modal content-->
          			<div class="modal-content">
            			<div class="modal-header">
              				<button type="button" class="close" data-dismiss="modal">&times;</button>
              				<h4 class="modal-title"> 견본변경요청</h4>
            			</div>
            			<div class="modal-body">
              				<textarea id="changeSampleMessage" class="form-control" rows="5" placeholder="변경을 원하는 사항을 써주세요"></textarea>
            			</div>
            			<div class="modal-footer">
              				<button type="button" class="btn btn-default" id="closeChangeSample"data-dismiss="modal">닫기</button>
              				<button type="button" class="btn btn-default" id="changeSampleSubmit">제출</button>
            			</div>
          			</div>
     				</div>
     			</div>
     			
     			
    			<button class="btn btn-info pull-right purBtn" id="changeReqfrmButton" data-toggle="modal" data-target="#changeReqfrmBody">구매확인서변경</button>
				<div class="modal fade" id="changeReqfrmBody" role="dialog">
	      			<div class="modal-dialog">	        
	        			 <!-- Modal content-->
	         			<div class="modal-content">
	           			<div class="modal-header">
	             				<button type="button" class="close" data-dismiss="modal">&times;</button>
	             				<h4 class="modal-title">구매확인서 변경요청</h4>
	           			</div>
	           			<div class="modal-body">
	             				<textarea id="changeReqfrmMessage" class="form-control" rows="5" placeholder="변경을 원하는 사항을 써주세요"></textarea>
	           			</div>
	           			<div class="modal-footer">
	             				<button type="button" class="btn btn-default" id="closeChangeReqfrm"data-dismiss="modal">닫기</button>
	             				<button type="button" class="btn btn-default" id="changeReqfrmSubmit">제출</button>
	           			</div>
	         			</div>
	    			</div>
    			</div>
		</div>
		<br>
		<div class="row">
			<div class="table-responsive">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th><input type="checkbox" name="checkAll" id="checkAll"></th>
							<th>#</th>
							<th>발급신청번호</th>
							<th>상태</th>
							<th>신청일</th>
							<th>공급자상호</th>
							<th>구매확인서번호</th>
							<th>파일</th>
							<th>발급일</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${searchVO.boardTotUnit eq 0}">
							<tr>
								<td colspan="11" align="center">검색 결과가 없습니다.</td>
							</tr>
						</c:if>
						<c:set var="num"
							value="${(searchVO.pageIndex-1)*searchVO.pageUnit+1}"></c:set>
						<c:forEach var="item" items="${list}">
							<tr>
								<td>
									<c:choose>
										<c:when test="${item.sts eq 'S1' }">
											<input type="checkbox" name="checkRow" value="${item.smplfileid }" />
										</c:when>
										<c:when test="${item.sts eq 'C1' }">
											<input type="checkbox" name="checkRow" value="${item.isuefileid }" />
										</c:when>
										<c:otherwise>
											<input type="checkbox" name="checkRow" value="" />
										</c:otherwise>
									</c:choose>
								</td>
								<td>${num }</td>
								<td class="applnum" id="${item.applnum }">${item.applnum }</td>
								<td class="codeName">${item.codenm}</td>
								<td>${item.appldt}</td>
								<td>${item.splyorgnm}</td>
								<td class="issuenum"><c:choose>
									<c:when test="${item.sts eq 'C1' }">
										${item.issuenum}
									</c:when>
									<c:otherwise>
									</c:otherwise>
									</c:choose></td>
								<td class="icon"><c:choose>
										<c:when test="${item.sts eq 'S1' }">
											<div  value="${item.smplfileid }" class="downloadSample pointer" >견본구매확인서</div>
										</c:when>
										<c:when test="${item.sts eq 'C1' }">
											<div value="${item.isuefileid }" class="downloadIssue pointer">구매확인서</div>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose></td>
								<td class='rgsttm'><c:choose>
										<c:when test="${item.sts eq 'C1' }">
	                 						 ${item.rgsttm}
	                 					 </c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose></td>
							</tr>
							<c:set var="num" value="${num+1}"></c:set>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div id='paging'>
			<ul class="pagination align-right">
				<c:if test="${searchVO.pageIndex != 1}">
					<li class="previous">
						<a href="">이전</a>
					</li>
				</c:if>
				
				<c:forEach begin="${searchVO.firstIndex}"
					end="${searchVO.lastIndex}" var="i">
					<c:choose>
						<c:when test="${searchVO.pageIndex == i}">
							<li class="active">
								<a href="">${i}</a>
							</li>
						</c:when>
						<c:otherwise>
							<li><a href="">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<c:if test="${searchVO.totPage > searchVO.lastIndex}">
					<li class="next">
						<a href="">다음</a>
					</li>
				</c:if>
			</ul>
		</div>
		</div>
	</div>



</div>
</body>
<c:import url="../footer.jsp" />
</html>