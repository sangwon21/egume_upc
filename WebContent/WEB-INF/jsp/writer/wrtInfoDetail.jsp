<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>발급지원 작성 상세 조회</title>
<c:import url="../admin/header.jsp" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	var status = "${cnfrmprchreq.sts}";
	
	window.onload = function() {
		var rmncnt = ${cnfrmprchreq.rmncnt};
		
		if(status !== "S3" && status !== "C1" && status !== "C2") {
			$("#tabIssue").hide();
		} else {
			if( "${cnfrmprchreq.issuenum}" !== "" ) {
				var issuenum = document.getElementById("issueNum");
				issuenum.value = "${cnfrmprchreq.issuenum}";
				issuenum.readOnly = true;
				issuenum.style.backgroundColor = "#eee";
			}
		}
		
		if( rmncnt > 0 ) {
			$("#stsChangeBtn").hide();
		}
		
		if( "${cnfrmprchreq.smplmdfreq}" === "" ) {
			$("#smpMdfTable").hide();
		}
		
		if( "${cnfrmprchreq.issuemdfreq}" === "" ) {
			$("#issueMdfTable").hide();
		}

		eventListener();

	}

	function eventListener() {
		document.getElementById("searchAddress").addEventListener("click", fn_popup);
		
		document.getElementById("smpFileSubmit").addEventListener("click", submitSmpFile);
		document.getElementById("smpCnfrmFileSubmit").addEventListener("click", submitSmpCnfrmFile);
		document.getElementById("issueFileSubmit").addEventListener("click", submitIssueFile);
		
		/**파일 title 제거*/ 
		$(".file-clear").click(function(){
			$(this).closest("div").find(".preview-filename").val("");
			$(this).parent("span").children("div").children(".file-input input:file").val("");
			$(this).hide();
			$(this).parent("span").children("div").children(".file-input-title").text("업로드");
		}); 
		
		/**파일 업로드 시 보여주는 부분*/
		 $(".file-input input:file").change(function (){
			var file = this.files[0];
			var reader = new FileReader();
			var tis = $(this);
			
			if ( checkFile($(this)) === false ) {
				tis.closest("div").find("span.file-input-title").text("파일선택");
				tis.closest("div").closest("span").closest("div").find(".preview-filename").val("");
				return;
			}
			
			reader.onload = function (e) {
				tis.closest("div").find("span.file-input-title").text("변경");
				tis.closest("div").closest("span").find("button.file-clear").show();
				tis.closest("div").closest("span").find("button.file-download").hide();
				tis.closest("div").closest("span").closest("div").find(".preview-filename").val(file.name);
			}
			reader.readAsDataURL(file);
		});
		
		 $(".form-control.preview-filename.viewer").on("click",function(){
			var filename = $(this).val();
			var fileseq = $(this).data("fileseq");
			var fileLen = filename.length;
			var lastDot = filename.lastIndexOf('.');
			var type = filename.substring(lastDot, fileLen).toLowerCase();

			
			if(type==".pdf"){
				window.open("<%=request.getContextPath()%>/filepdfview?fileseq="+fileseq+"&type="+type);
			}else if(type==".jpg"){
				window.open("<%=request.getContextPath()%>/filepdfview?fileseq="+fileseq+"&type="+type,"preview","width=1500px, height=1000px");
			}else{
				alert("미리보기를 지원하지 않는 형식입니다.");
			}
			
		});
		
		//다운로드 버튼 이벤트 등록
		[].forEach.call(document.querySelectorAll(".file-download"), function(btn){
			btn.addEventListener("click", downloadFile, false);
		});
		
		//수정요청사항 저장 버튼 이벤트 등록
		[].forEach.call(document.querySelectorAll(".mdfBtn"), function(btn){
			btn.addEventListener("click", saveMdfReq, false);
		});
		
		if(location.hash) {
			$("a[href='" + location.hash + "']").tab("show");
		}
		$(document.body).on("click", "a[data-toggle]", function(event) {
			location.hash = this.getAttribute("href");
		});
		
		$(window).on("popstate", function() {
			var anchor = location.hash || $("a[data-toggle='tab']").first().attr("href");
			$("a[href='" + anchor + "']").tab("show");
		});

	}
	
	//주소 찾기 버튼 이벤트
	function fn_popup() {
		new daum.Postcode({
			oncomplete:function(data) {
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				$("#splyaddr1").val(roadAddr);
				$("#splyaddr2").val("");
			 }
		}).open();
	}
	
	//파일 확장자 검사
	function checkFile(evt) {
		var file = evt[0];
		
		if(!/\.(gif|jpg|jpeg|png|pdf|xlsx|docx|hwp|txt)$/i.test(file.files[0].name)) {
			alert("허용되지 않는 파일 형식입니다");
			file.value = "";
			return false;
		}

	}

	/*견본 등록 상태 체크
	*R1: 허용 안됨
	*R2, R3 ,S1, S2 : 허용
	*S3, C1, C2 : 허용 안됨
	*/
	function submitSmpFile(evt) {
		//진행 상태 확인
		if( status === "R1") {
			alert("접수완료 건만 견본을 등록할 수 있습니다");
			return;
		}
		if( status === "S3" ) {
			alert("이미 견본 확인이 되었습니다");
			return;
		}
		if( status === "C1" || status === "C2" ) {
			alert("이미 발행이 완료되었습니다");
			return;
		}

		if( document.getElementById("smpldocid").value == "" ) {
			alert("견본 전자문서번호를 입력해주십시오");
			return;
		}

		if( checkFileValue(document.getElementById("smpFile")) == false) {
			return;
		}
		
		uploadFile("sample");
	}
	
	//견본 확인 업로드 전 상태 체크
	function submitSmpCnfrmFile() {
		//진행 상태 확인
		if( status !== "S1" && status !== "S3" ) {
			alert("견본 완료된 이후에만 견본확인을 등록할 수 있습니다");
			return;
		}
		
		if( checkFileValue(document.getElementById("smpCnfrmFile")) == false) {
			return;
		}
		
		uploadFile("sampleConfirm");
	}
	
	function submitIssueFile() {
		//진행 상태 확인
		if( status !== "S3" && status !== "C1" && status !== "C2") {
			alert("견본 확인이 완료된 후에만 원본을 등록할 수 있습니다");
			return;
		}
		
		if( document.getElementById("issueNum").value == "" ) {
			alert("구매확인서 번호를 입력해주십시오");
			return;
		}
		
		if( checkFileValue(document.getElementById("issueFile")) == false) {
			return;
		}
		
		//구매확인서발급 문서구분 세팅
		var applditc = "${cnfrmprchreq.applditc}";
		if ( $("#issueTable tbody tr td").length !== 1 ) {
			applditc = "M";
		}
		
		document.getElementById("docditc").value = applditc;
		uploadFile("issue");
	}
	
	//파일 선택을 했는지 검사
	function checkFileValue(file) {
		//등록할 파일 존재 유무 체크
		if( file.value == "" ) {
			alert("파일을 선택해 주시길 바랍니다");
			return false;
		} 
		
		//파일 등록 한번더 확인
		if( confirm("파일을 등록하시겠습니까?") === false ) {
			return false;
		}
		
		return true;
	}

	//파일 업로드 함수
	function uploadFile(str) {
		if( str === "sample") {
			var formData = new FormData($("#smpFileForm")[0]);
			
			$.ajax({
				url: "/egume_upc/admin/uploadSmpFile", 
				type: "POST", 
				contentType: false,  
				data: formData, 
				processData: false,
				success: function(result) {
					if(result === "success"){
					} else if(result ==="rmncnt"){
						alert("잔여 건수가 없습니다.");
					} else {
						alert("견본 등록에 실패했습니다. 자세한 사항은 관리자에게 문의해주시길 바랍니다.");
					}
					
					//화면 새로고침
					location.reload(true);
				}, 
				error: function(request, status, error) {
					alert("ERROR\n"+"견본 등록에 실패했습니다");
					//console.log("code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
				}
			});
		}
		
		if( str === "sampleConfirm" ) {
			document.getElementById("smpCnfrmFileForm").submit();
		}
		
		if( str === "issue" ) {
			document.getElementById("issueFileForm").submit();
		}
		
	}

	
	//근거서류 다운로드
	function downloadFile(){
		var fileseq = $(this).data("fileseq");
		
		if( fileseq !== undefined ){
			var downloadUrl = "<%=request.getContextPath()%>/filedownload?fileseq="+fileseq;
			location.href = downloadUrl;
		}
	}
	
	//수정요청사항 저장
	function saveMdfReq(){
		var data = {
				applnum: "${cnfrmprchreq.applnum}",
				type: this.dataset.type,
				mdfReq: $(this).prev()[0].value
		};
		
		$.ajax({
			url: "/egume_upc/admin/updateMdfReq", 
			type: "PUT", 
			contentType: "application/json; charset=UTF-8", 
			dataType: "text", 
			data: JSON.stringify(data), 
			success: function(result) {
				if(result === "success"){
					alert("저장 완료");
				} else {
					alert("저장 실패\n자세한 사항은 관리자에게 문의해주시길 바랍니다");
				}
			}, 
			error: function(request, status, error) {
				alert("서버와 통신에 실패했습니다\n"+"저장 실패");
				console.log("code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
			}
		});
	}
	
	function clickConfirmDeposit(){	
		var checkedList = [];
		var wrtlistVO = {
				prtnum : "${cnfrmprchreq.prtnum}",
				applnum : "${cnfrmprchreq.applnum}",
				wrtrid : "${loginId}"
		};
		
		var validateSts = "${cnfrmprchreq.sts}";
		var validateNum = false;
		
		if( validateSts !== "R2") {
			alert("접수완료 상태만 입금 확인이 가능합니다");
			return false;
		}
		
		if (confirm("입금확인을 하시겠습니까?") == false) {
			return false;
		}

		checkedList.push(wrtlistVO);
		
		console.log(checkedList);
		updateStatus(checkedList);
	}
	
	//입금확인
	function updateStatus(checkedList) {
		$.ajax({
			url: "/egume_upc/admin/depositCnfrm", 
			type: "PUT", 
			contentType: "application/json", 
			dataType : "json", 
			data: JSON.stringify(checkedList), 
			success: function(result) {
				alert("입금확인이 완료됐습니다");
				location.reload(true);
			}, 
			error: function(request, status, error) {
				alert("입금확인 완료를 실패했습니다");
				//console.log("code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
			}
		});
	}
	

</script>
</head>

<body>
	<div class="container adminContainer">
		<div id="detailInfoTop">
			<div class="title">발급지원 작성 상세 정보</div>
			<input type="button" class="wrtInfoDetailBtn btn btn-default btn-sm" value="목록" onclick="location.href='wrtlist.do'">
			<ul class="nav nav-tabs" id="wrtTab">
				<li class="active"><a data-toggle="tab" href="#wrtInfoDetail">신청 상세정보</a></li>
				<li><a data-toggle="tab" href="#wrtInfoDetailSample">견본 및 견본 확인</a></li>
				<li id="tabIssue"><a data-toggle="tab" href="#wrtInfoDetailIssue">구매확인서 발행</a></li>
			</ul>
		</div>
	
	<div class="tab-content">
		<div id="wrtInfoDetail" class="tab-pane fade in active">
		<form name="detailInfoFrom" role="form" enctype="multipart/form-data" action="updateCnfrmPrchReqInfo" method = "POST"
					id="detailInfoFrom" accept-charset="utf-8">
			<h5 class="detailMenu"><span class="glyphicon glyphicon-plus-sign icn"></span> 상세정보</h5>
			<div id="detailInfoTable" class = "panel">
				<div class="detailInfoTable1">
					<table class="table table-bordered table-hover table-condensed">
						<colgroup>
							<col style="width:230px">
							<col style="width:30%">
							<col style="width:230px">
						</colgroup>
						<tbody>
							<tr>
								<th>발급신청번호</th>
								<td colspan="3"><input type="hidden" name="applnum" value="${cnfrmprchreq.applnum}">${cnfrmprchreq.applnum}</td>
							</tr>
							<tr>
								<th>진행상태</th>
								<td>${cnfrmprchreq.codenm}</td>
								<th>최종수정일</th>
								<td>
									<c:choose>
										<c:when test="${cnfrmprchreq.sts eq 'R2'}">${cnfrmprchreq.applrcvdt}</c:when>
										<c:when test="${cnfrmprchreq.sts eq 'S1'}">${cnfrmprchreq.smpldt}</c:when>
										<c:when test="${cnfrmprchreq.sts eq 'S2'}">${cnfrmprchreq.smpldt}</c:when>
										<c:when test="${cnfrmprchreq.sts eq 'S3'}">${cnfrmprchreq.cnfrmdt}</c:when>
										<c:when test="${cnfrmprchreq.sts eq 'C1'}">${cnfrmprchreq.rgsttm}</c:when>
										<c:when test="${cnfrmprchreq.sts eq 'C2'}">${cnfrmprchreq.rgsttm}</c:when>
									</c:choose>
								</td>
							</tr>
						</tbody>
					</table>
					
					<table id="wrtInfoDetailTitleTable">
						<colgroup>
							<col style="width:230px">
							<col style="width:30%">
							<col style="width:230px">
						</colgroup>
						<tbody>
							<tr>
								<td><h5 class="detailMenu"><span class="glyphicon glyphicon-plus-sign icn"></span> 구매자 정보</h5></td><td></td>
								<td><h5 class="detailMenu"><span class="glyphicon glyphicon-plus-sign icn"></span> 공급자 정보</h5></td><td></td>
							</tr>
						</tbody>
					</table>
					<table class="table table-bordered table-hover table-condensed">
						<colgroup>
							<col style="width:230px">
							<col style="width:30%">
							<col style="width:230px">
						</colgroup>
						<tbody>
							<tr>
								<th>사업자등록번호</th>
								<td><input type="hidden" name="prtnum" value="${cnfrmprchreq.prtnum}">${cnfrmprchreq.prtnum}</td>
								<th>공급자사업자등록번호</th>
								<td><input type="text" class="formCustom" id="splyprtnum" name="splyprtnum" value="${cnfrmprchreq.splyprtnum}" maxlength="10"></td>
							</tr>
							<tr>
								<th>구매자상호</th>
								<td>${cnfrmprchreq.cmpnnm}</td>
								<th>공급자상호명</th>
								<td><input type="text" class="formCustom" id="splyorgnm" name="splyorgnm" value="${cnfrmprchreq.splyorgnm}" maxlength="11"></td>
							</tr>
							<tr>
								<th>대표자명</th>
								<td>${cnfrmprchreq.ceonm}</td>
								<th>공급자대표명</th>
								<td><input type="text" class="formCustom" id="splyceonm" name="splyceonm" value="${cnfrmprchreq.splyceonm}" maxlength="11"></td>
							</tr>
							<tr>
								<th>주소</th>
								<td>${cnfrmprchreq.addr1}${cnfrmprchreq.addr2}</td>
								<th>공급자 주소</th>
								<td><input type="text" class="formCustom" id="splyaddr1" name="splyaddr1" value="${cnfrmprchreq.splyaddr1}" maxlength="30">
									<button class="btn btn-default rgst-btn" id="searchAddress" type="button">검색</button>
								</td>
							</tr>
							<tr>
								<th>담당자명</th>
								<td>${cnfrmprchreq.mgrname}</td>
								<th>공급자 상세주소</th>
								<td><input type="text" class="formCustom" id="splyaddr2" name="splyaddr2" value="${cnfrmprchreq.splyaddr2}" maxlength="30"></td>
							</tr>
							<tr>
								<th>메일주소</th>
								<td colspan="3">${cnfrmprchreq.mgremail}</td>
							</tr>
							<tr>
								<th>Fax번호</th>
								<td>${cnfrmprchreq.mgrfax}</td>
								<th>신청구분</th>
								<td>
									<c:if test="${cnfrmprchreq.applditc eq 'O'}">신규발행</c:if>
									<c:if test="${cnfrmprchreq.applditc eq 'A'}">변경발행</c:if>
								</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>${cnfrmprchreq.mgrtel}</td>
								<th>선불유무</th>
								<td>${cnfrmprchreq.prepayyn}</td>
							</tr>
							<tr>
								<th>휴대폰번호</th>
								<td>${cnfrmprchreq.mgrphone}</td>
								<th>잔여건수</th>
								<td>${cnfrmprchreq.rmncnt}</td>
							</tr>
						</tbody>
					</table>
					<table class="table table-bordered table-hover table-condensed">
						<colgroup>
							<col style="width:230px">
							<col style="width:30%">
							<col style="width:230px">
						</colgroup>
						<tbody>
							<tr>
								
							</tr>
							<tr>
								
								
							</tr>
							<tr>
								
							</tr>
						</tbody>
					</table>
				</div>
				<div>
					<table class="table table-bordered table-hover table-condensed detailInfo2">
						<thead class='bg-primary'>
							<tr>
								<th>진행상태</th>
								<th>접수자</th>
								<th>접수일자</th>
								<th>작성담당자</th>
								<th>비고사항</th>
							</tr>
						</thead>
						<tbody>
								<tr>
									<td>${cnfrmprchreq.codenm}</td>
									<td>${cnfrmprchreq.applrcvnm}</td>
									<td>${cnfrmprchreq.applrcvdt}</td>
									<td>${cnfrmprchreq.wrtrnm}</td>
									<td><input name="notes" class="formCustom" value="${cnfrmprchreq.notes}" maxlength="33"/></td>
								</tr>
						</tbody>
					</table>
				</div>
			</div>
			
			<h5 class="detailMenu"><span class="glyphicon glyphicon-plus-sign icn"></span> 근거서류정보</h5>
			<div class="detailContents">
				<div id="fileInfoTable">
					<table class="table table-bordered table-hover table-condensed">
						<thead class="bg-primary">
							<tr>
								<th id="fileTableHeaderth1" class="file-no-header">번호</th>
								<th id="fileTableHeader">수출근거서류</th>
								<th id="fileTableHeader">세금계산서</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="list" varStatus="i" items="${fileList}" begin="0" end="4" step="2">
								<tr>
									<td class="table-file-no">${i.count}</td>
									<td>
										<div class="input-group file-preview">
										<c:choose>
											<c:when test="${fileList[i.index+1] eq null}">
												<input type="text" class="form-control preview-filename "
													disabled="disabled">
												<span class="input-group-btn">
													<button type="button"
														class="btn btn-default file-download" id="tblFileDownBtn" style="display: none">
														<span class="glyphicon glyphicon-file">다운</span>
													</button>
													<button type="button" class="btn btn-default file-clear"
														id="fileClear" style="display: none">
														<span class="glyphicon glyphicon-remove">삭제</span>
													</button>
													<div class="btn btn-default file-input">
														<span class="glyphicon glyphicon-folder-open"></span> <span
															class="file-input-title">업로드</span> <input hidden=""
															name="modSup" value=""> <input type="file"
															name="sup"/>
													</div>
												</span>
											</c:when>
											<c:otherwise>
												<input type="text" class="form-control preview-filename viewer" data-fileseq="${fileList[i.index+1].fileseq}"
													value="${fileList[i.index+1].filenm}" readonly="readonly">
												<span class="input-group-btn">
													<button type="button"
														class="btn btn-default file-download"
														data-fileseq="${fileList[i.index+1].fileseq}"
														id="tblFileDownBtn">
														<span class="glyphicon glyphicon-file">다운</span>
													</button>
													<button type="button" class="btn btn-default file-clear"
														id="fileClear" style="display: none">
														<span class="glyphicon glyphicon-remove">삭제</span>
													</button>
													<div class="btn btn-default file-input">
														<span class="glyphicon glyphicon-folder-open"></span> <span
															class="file-input-title">변경</span> <input type="file"
															name="sup"/> <input
															hidden="" name="modSup"
															value="${fileList[i.index+1].fileseq}">
													</div>
												</span>
											</c:otherwise>
										</c:choose>
										</div>
									</td>
									<td>
										<div id="fileTableGroup" class="input-group file-preview">
										<c:choose>
											<c:when test="${list eq null}">
												<input type="text" class="form-control preview-filename"
													disabled="disabled">
												<span class="input-group-btn">
													<button type="button" class="btn btn-default file-download" id="tblFileDownBtn" style="display: none">
														<span class="glyphicon glyphicon-file">다운</span>
													</button>
													<button type="button" class="btn btn-default file-clear" id="fileClear" style="display: none">
														<span class="glyphicon glyphicon-remove">삭제</span>
													</button>
													<div class="btn btn-default file-input">
														<span class="glyphicon glyphicon-folder-open"></span>
														<span class="file-input-title">업로드</span>
														<input hidden="" name="modTax" value="">
														<input type="file" name="tax" />
													</div>
												</span>
											</c:when>
											<c:otherwise>
												<input type="text" class="form-control preview-filename viewer" data-fileseq="${list.fileseq}"
													value="${list.filenm}" readonly="readonly">
												<span class="input-group-btn">
													<button type="button"
														class="btn btn-default file-download" id="tblFileDownBtn"
														data-fileseq="${list.fileseq}">
														<span class="glyphicon glyphicon-file">다운</span>
													</button>
													<button type="button" class="btn btn-default file-clear"
														id="fileClear" style="display: none">
														<span class="glyphicon glyphicon-remove">삭제</span>
													</button>
													<div class="btn btn-default file-input">
														<span class="glyphicon glyphicon-folder-open"></span>
														<span class="file-input-title">변경</span>
														<input type="file" name="tax"/>
														<input hidden="" name="modTax" value="${list.fileseq}">
													</div>
												</span>
											</c:otherwise>
										</c:choose>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div id="saveBtn">
				<button type="submit" class="wrtInfoDetailBtn btn btn-primary btn-sm">수정</button>
			</div>
		</form>
		<hr id="wrtInfoDetailHR">
		</div>

		<div id="wrtInfoDetailSample" class="tab-pane smpNissueDiv">
		<h5 class="detailMenu"><span class="glyphicon glyphicon-plus-sign icn"></span> 구매확인서 견본
			<span id="stsChangeSpan">[ 잔여 건수 : ${cnfrmprchreq.rmncnt} ]
				<button type="button" class="btn btn-info btn-sm" id="stsChangeBtn" onclick="clickConfirmDeposit();">입금확인완료</button>
			</span>
		</h5>
		<div class="detailContents">	
			<form id="smpFileForm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="prtnum" value="${cnfrmprchreq.prtnum}">
			<input type="hidden" name="applnum" value="${cnfrmprchreq.applnum}">
			<input type="hidden" name="mgrphone" value="${cnfrmprchreq.mgrphone}">
			<input type="hidden" name="rmncnt" value="${cnfrmprchreq.rmncnt}">
			<input type="hidden" name="smsyn" value="${cnfrmprchreq.smsyn}">
			<input type="hidden" name="applditc" value="${cnfrmprchreq.applditc}">
			<table id="fileUploadTable">
				<tbody>
					<colgroup>
						<col style="width:160px">
						<col style="width:284px">
						<col style="width:130px">
						<col>
						<col style="width:90px">
					</colgroup>
					<tr>
						<td>견본 전자문서번호</td>
						<td>
							<input class="formCustom" type="text" name="smpldocid" id="smpldocid" maxlength="35" required>
						</td>
						<td>견본 파일 업로드</td>
						<td>
							<div class="input-group file-preview">
								<input type="text" class="form-control preview-filename" disabled="disabled">
								<span class="input-group-btn">
									<div class="btn btn-default file-input">
										<span class="glyphicon glyphicon-folder-open"></span>
										<span class="file-input-title">파일선택</span>
										<input type="file" id="smpFile" name="smpFile"/>
									</div>
								</span>
							</div>
						</td>
						<td>
							<div class="btn btn-primary btn-sm file-input" id="smpFileSubmit">
								<span class="file-input-title">등록</span>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			</form>
			
			<div id="smpTable" class="cnfrmPrchTable">
				<table class="table table-bordered table-hover table-condensed detailInfo2">
					<thead class='bg-primary'>
						<tr>
							<th>진행상태</th>
							<th>작성자</th>
							<th>작성일자</th>
							<th>견본 전자문서번호</th>
							<th>견본 파일명</th>
							<th>공급자상호</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${cnfrmprchreq.smplfileid eq null}">
						<tr>
							<td colspan="6" align="center">등록된 파일이 없습니다</td>
						</tr>
					</c:if>
					<c:if test="${cnfrmprchreq.smplfileid != null}">
						<tr>
							<td>견본완료</td>
							<td>${cnfrmprchreq.wrtrnm}</td>
							<td>${cnfrmprchreq.smpldt}</td>
							<td>${cnfrmprchreq.smpldocid}</td>
							<td>${cnfrmprchreq.smplfilenm}</td>
							<td>${cnfrmprchreq.splyorgnm}</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
		
		<h5 class="detailMenu"><span class="glyphicon glyphicon-plus-sign icn"></span> 구매확인서 견본 확인</h5>
		<div class="detailContents">
			<form id="smpCnfrmFileForm" method="post" action="${pageContext.request.contextPath}/admin/uploadSmpCnfrmFile" enctype="multipart/form-data">
				<input type="hidden" name="prtnum" value="${cnfrmprchreq.prtnum}">
				<input type="hidden" name="applnum" value="${cnfrmprchreq.applnum}">
				<input type="hidden" name="mgrphone" value="${cnfrmprchreq.mgrphone}">
				<input type="hidden" name="smsyn" value="${cnfrmprchreq.smsyn}">
					
				<table id="fileUploadTable">
					<colgroup>
						<col style="width:160px">
						<col>
						<col style="width:90px">
					</colgroup>
					<tbody>
						<tr>
							<td>견본 확인 파일 업로드</td>
							<td>
								<div class="input-group file-preview">
									<input type="text" class="form-control preview-filename" disabled="disabled">
									<span class="input-group-btn">
										<div class="btn btn-default file-input">
											<span class="glyphicon glyphicon-folder-open"></span>
											<span class="file-input-title">파일선택</span>
											<input type="file" id="smpCnfrmFile" name="smpCnfrmFile"/>
										</div>
									</span>
								</div>
							</td>
							<td>
								<div class="btn btn-primary btn-sm file-input" id="smpCnfrmFileSubmit">
									<span class="file-input-title">등록</span>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			
			<div id="smpCnfrmTable" class="cnfrmPrchTable">
				<table class="table table-bordered table-hover table-condensed detailInfo2">
					<thead class='bg-primary'>
						<tr>
							<th>진행상태</th>
							<th>확인 등록자ID</th>
							<th>확인일자</th>
							<th>견본 확인 파일명</th>
							<th>공급자상호</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${cnfrmprchreq.cnfrmdt eq null}">
						<tr>
							<td colspan="5" align="center">등록된 파일이 없습니다</td>
						</tr>
					</c:if>
					<c:if test="${cnfrmprchreq.cnfrmdt != null}">
						<tr>
							<td>견본확인</td>
							<td>${cnfrmprchreq.cnfrmid}</td>
							<td>${cnfrmprchreq.cnfrmdt}</td>
							<td>${cnfrmprchreq.cnfrmfilenm}</td>
							<td>${cnfrmprchreq.splyorgnm}</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
			
			<div id="smpMdfTable">
				<hr id="wrtInfoDetailHR">
				<table id="fileUploadTable">
					<tbody>
						<colgroup>
							<col style="width:220px">
							<col>
						</colgroup>
						<tr>
							<td>*&nbsp;수정 요청 사항</td>
							<td>${cnfrmprchreq.smplmdfreq}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		</div>

		<div id="wrtInfoDetailIssue" class="tab-pane">
		<div class="detailContents smpNissueDiv">
			<h5 class="detailMenu"><span class="glyphicon glyphicon-plus-sign icn"></span> 구매확인서 원본</h5>
	
			<form id="issueFileForm" action="${pageContext.request.contextPath}/admin/uploadIssueFile" method="post" enctype="multipart/form-data">
				<input type="hidden" name="applnum" value="${cnfrmprchreq.applnum}">
				<input type="hidden" name="prtnum" value="${cnfrmprchreq.prtnum}">
				<input type="hidden" name="mgrphone" value="${cnfrmprchreq.mgrphone}">
				<input type="hidden" name="smsyn" value="${cnfrmprchreq.smsyn}">
				<input type="hidden" name="docditc" id="docditc" value="">
				<input type="hidden" name="splyprtnum" value="${cnfrmprchreq.splyprtnum}">
				<input type="hidden" name="splyorgnm" value="${cnfrmprchreq.splyorgnm}">
				
				<table id="fileUploadTable">
				<tbody>
					<colgroup>
						<col style="width:150px">
						<col style="width:264px">
						<col style="width:200px">
						<col>
						<col style="width:90px">
					</colgroup>
					<tr>
						<td>구매확인서 번호</td>
						<td><input class="formCustom" type="text" name="issuenum" id="issueNum" maxlength="30" required></td>
						<td>구매학인서 원본 파일 업로드</td>
						<td>
							<div class="input-group file-preview" id="issueFileLine">
								<input type="text" class="form-control preview-filename" disabled="disabled">
								<span class="input-group-btn">
									<div class="btn btn-default file-input">
										<span class="glyphicon glyphicon-folder-open"></span>
										<span class="file-input-title">파일선택</span>
										<input type="file" id="issueFile" name="issueFile"/>
									</div>
								</span>
							</div>
						</td>
						<td></td>
					</tr>
					<tr>
						<td>비고</td>
						<td colspan="3">
							<input class="formCustom" type="text" name="notes" id="notes" maxlength="33">
						</td>
						<td>
							<div class="btn btn-primary btn-sm file-input" id="issueFileSubmit">
								<span class="file-input-title">등록</span>
							</div>
						</td>
					</tr>
				</tbody>
				</table>
			</form>
			
			<div id="issueTable" class="cnfrmPrchTable">
				<table class="table table-bordered table-hover table-condensed detailInfo2">
					<thead class='bg-primary'>
						<tr>
							<th>진행상태</th>
							<th>작성자</th>
							<th>발행구분</th>
							<th>구매확인서번호</th>
							<th>발급일자</th>
							<th>공급자상호</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${issueList eq null || fn:length(issueList) eq '0'}">
							<tr>
								<td colspan="7" align="center">등록된 파일이 없습니다</td>
							</tr>
						</c:if>
						<c:forEach var="issue" items="${issueList}">
							<tr>
								<td>발급완료</td>
								<td>${issue.rgstnm}</td>
								<td>
									<c:if test="${issue.docditc eq 'O'}">신규발행</c:if>
									<c:if test="${issue.docditc eq 'M'}">수정발행</c:if>
									<c:if test="${issue.docditc eq 'A'}">변경발행</c:if>
								</td>
								<td>
									<a href="/egume_upc/filedownload?fileseq=${issue.isuefileid}">${issue.issuenum}</a>
								</td>
								<td>${issue.rgsttm}</td>
								<td>${issue.splyorgnm}</td>
								<td>${issue.notes}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
	
			<div id="issueMdfTable">
				<hr id="wrtInfoDetailHR">
				<table id="fileUploadTable">
					<tbody>
						<colgroup>
							<col style="width:150px">
							<col>
						</colgroup>
						<tr>
							<td>*&nbsp;수정 요청 사항</td>
							<td>${cnfrmprchreq.issuemdfreq}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		</div>
	</div>
	<input type="button" id="goBackBtn" class="wrtInfoDetailBtn btn btn-default btn-sm" value="목록" onclick="location.href='wrtlist.do'">
	</div>
	<div class="push"></div>
	<footer>
		<c:import url="../footer.jsp" />
	</footer>
</body>

</html>