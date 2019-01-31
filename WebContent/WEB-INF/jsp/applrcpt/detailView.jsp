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

	eventListener();
	
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
	
}

function eventListener() {
	
	//다운로드 버튼 이벤트 등록
	[].forEach.call(document.querySelectorAll(".file-download"), function(btn){
		btn.addEventListener("click", downloadFile, false);
	});
	
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

//근거서류 다운로드
function downloadFile(){
	console.log("in down");
	
	var fileseq = $(this).data("fileseq");
	
	if( fileseq !== undefined ){
		var downloadUrl = "<%=request.getContextPath()%>/filedownload?fileseq="+fileseq;
		location.href = downloadUrl;
	}
}

</script>
</head>

<body>
	<div class="wrapper">
	<div class="container adminContainer">
		<div id="detailInfoTop">
			<div class="title">발급신청 상세정보</div>
			<input type="button" class="wrtInfoDetailBtn btn btn-default btn-sm" value="목록" onclick="history.go(-1)">
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
								<td>${cnfrmprchreq.prtnum}</td>
								<th>공급자사업자등록번호</th>
								<td>${cnfrmprchreq.splyprtnum}</td>
							</tr>
							<tr>
								<th>구매자상호</th>
								<td>${cnfrmprchreq.cmpnnm}</td>
								<th>공급자상호명</th>
								<td>${cnfrmprchreq.splyorgnm}</td>
							</tr>
							<tr>
								<th>대표자명</th>
								<td>${cnfrmprchreq.ceonm}</td>
								<th>공급자대표명</th>
								<td>${cnfrmprchreq.splyceonm}</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>${cnfrmprchreq.addr1}${cnfrmprchreq.addr2}</td>
								<th>공급자 주소</th>
								<td>${cnfrmprchreq.splyaddr1}
								</td>
							</tr>
							<tr>
								<th>담당자명</th>
								<td>${cnfrmprchreq.mgrname}</td>
								<th>공급자 상세주소</th>
								<td>${cnfrmprchreq.splyaddr2}</td>
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
								<td>${cnfrmprchreq.notes}</td>
							</tr>
					</tbody>
				</table>
			</div>
			</form>
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
									<div id="fileTableGroup" class="input-group file-preview">
									<c:choose>
										<c:when test="${fileList[i.index+1] eq null}">
											<input type="text" class="form-control preview-filename "
												disabled="disabled">
											<span class="input-group-btn">
												<button type="button"
													class="btn btn-default file-download" id="tblFileDownBtn">
													<span class="glyphicon glyphicon-file">다운</span>
												</button>
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
											</span>
										</c:otherwise>
									</c:choose>
									</div>
								</td>
								<td>
									<div class="input-group file-preview">
									<c:choose>
										<c:when test="${list eq null}">
											<input type="text" class="form-control preview-filename"
												disabled="disabled">
											<span class="input-group-btn">
												<button type="button"
													class="btn btn-default file-download" id="tblFileDownBtn">
													<span class="glyphicon glyphicon-file">다운</span>
												</button>
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
		</div>

			
		</div>
		
		<div id="wrtInfoDetailIssue" >
		<div class="detailContents">
			<h5 class="detailMenu"><span class="glyphicon glyphicon-plus-sign icn"></span> 구매확인서 원본</h5>
			<div id="issueTable" >
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
								<td><a href="/egume_upc/filedownload?fileseq=${issue.isuefileid}">${issue.issuenum}</td>
								<td>${issue.rgsttm}</td>
								<td>${issue.splyorgnm}</td>
								<td>${issue.notes}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		
		</div>
	
		<input id="listBtnDv" type="button" class="wrtInfoDetailBtn btn btn-default btn-sm" value="목록" onclick="history.go(-1)">

		</div>
    </div>

</div>
	
</body>
<div class="push"></div>
	<footer>
		<c:import url="../footer.jsp" />
	</footer>

</html>