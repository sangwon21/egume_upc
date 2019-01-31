<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<script type="text/javascript">
	window.onload = function() {
	
		$.datepicker.setDefaults({
			dateFormat: 'yymmdd'
		});
		$("#dateFrom").datepicker();
		$("#dateTo").datepicker();
	}
	
	// 조회기간 라디오 버튼 클릭시 조회기간 업데이트
	function changeDate(searchPeriod) {
		var today = new Date();
		if(searchPeriod == 'ALL'){
			$("#dateTo").datepicker('setDate', 'today');
			$("#dateFrom").datepicker('setDate', '20130101');
		}    
		else if (searchPeriod =='1W'){
			$("#dateTo").datepicker('setDate', 'today');
			$("#dateFrom").datepicker('setDate', '-7D');
		}
		else if (searchPeriod =='3M'){
			$("#dateTo").datepicker('setDate', 'today');
			$("#dateFrom").datepicker('setDate', '-3M');
		}
		else if (searchPeriod =='6M'){
			$("#dateTo").datepicker('setDate', 'today');
			$("#dateFrom").datepicker('setDate', '-6M');
		}
	}
	
	// 삭제 버튼 클릭시 선택한 회원정보 삭제
	function userDel(){
		var depChk = document.getElementsByName("RowCheck");
		var indexid = false;
		for(i=0; i < depChk.length; i++){
			if(depChk[i].checked){
			    indexid = true;
			    break;
		    }
		}
		if(!indexid){
			alert("삭제할 회원정보를 체크해 주세요");
		    return;
		}
		var agree=confirm("★★★주의★★★ 영구적으로 삭제됩니다. 삭제하시겠습니까?"); 
		if (agree){
	    	document.userDelForm.submit();
	    }  
	}
	
	// 페이징 버튼 
	function prev() {
		//document.getElementById("pageIndex").value='${searchVO.pageIndex-1}';
		//document.getElementById("searchForm").submit();
		window.location.href=encodeURI("/egume_upc/admin/userList.do?dateFrom=${searchVO.dateFrom}&dateTo=${searchVO.dateTo}&searchPeriod=${searchVO.searchPeriod}&searchCondi=${searchVO.searchCondi}&searchVal=${searchVO.searchVal}&pageIndex=${searchVO.pageIndex-1}");
	}
	
	function pagingNum(pageIndex){
		//document.getElementById("pageIndex").value=num;
		//document.getElementById("searchForm").submit();
		window.location.href=encodeURI("/egume_upc/admin/userList.do?dateFrom=${searchVO.dateFrom}&dateTo=${searchVO.dateTo}&searchPeriod=${searchVO.searchPeriod}&searchCondi=${searchVO.searchCondi}&searchVal=${searchVO.searchVal}&pageIndex="+pageIndex);
	}
	
	function next(){
		//document.getElementById("pageIndex").value='${searchVO.pageIndex+1}';
		//document.getElementById("searchForm").submit();
		window.location.href=encodeURI("/egume_upc/admin/userList.do?dateFrom=${searchVO.dateFrom}&dateTo=${searchVO.dateTo}&searchPeriod=${searchVO.searchPeriod}&searchCondi=${searchVO.searchCondi}&searchVal=${searchVO.searchVal}&pageIndex=${searchVO.pageIndex+1}");
	}
	
	// 조회버튼 클릭 시 페이징 인덱스 초기화
	function setPageIndex(){
		document.getElementById("pageIndex").value=1;
		document.getElementById("searchForm").submit();
	}
	
</script>
<head>
	<meta charset=utf-8>
	<title>회원정보조회</title>
</head>
<body>
	<div class="wrapper">
		<c:import url="header.jsp" />
		<div class='container adminContainer'>
			<div class="title">회원정보조회</div>
			<div class="well" id="wellDiv">
				<div id="search_container">
					<form class="form-horizontal" name="option_form" role="form" action="${pageContext.request.contextPath}/admin/userList.do" method="GET" id="searchForm"
						accept-charset="utf-8" onsubmit="return optionSubmit();">
						<table id="searchContainerTable">
							<colgroup>
								<col style="width:85px">
								<col style="width:366px">
								<col style="width:85px">
								<col style="width:174px">
								<col style="width:85px">
								<col style="width:264px">
							</colgroup>
							<tbody>
								<tr>
									<th>조회기간</th>
									<td colspan="5">
										<input type="text" class="form-control" name="dateFrom" id="dateFrom" value="${searchVO.dateFrom}" style="margin-right:10px;" autocomplete="off"/>
										<input type="text" class="form-control" name="dateTo" id="dateTo" value="${searchVO.dateTo}" autocomplete="off"/>
										<label class="radio-inline"> 
											<input type="radio" name="searchPeriod" value="ALL" onClick="changeDate(this.value)"<c:if test="${searchVO.searchPeriod eq 'ALL'}">checked</c:if> /> 전체
										</label> 
										<label class="radio-inline"> 
											<input type="radio" name="searchPeriod" value="1W" onClick="changeDate(this.value)" <c:if test="${searchVO.searchPeriod eq '1W'}">checked</c:if> /> 1주일
										</label> 
										<label class="radio-inline"> 
											<input type="radio" name="searchPeriod" value="3M" onClick="changeDate(this.value)" <c:if test="${searchVO.searchPeriod eq '3M'}">checked</c:if> /> 3개월
										</label>
											<label class="radio-inline"> 
											<input type="radio" name="searchPeriod" value="6M" onClick="changeDate(this.value)" <c:if test="${searchVO.searchPeriod eq '6M'}">checked</c:if> /> 6개월
										</label>
									</td>
								</tr>
								<tr>
									<th>조회조건</th>
									<td>
										<select class="form-control" id="searchCondi" name="searchCondi" style="margin-right:10px;width:150px">
											<option value="ALL"
												<c:if test="${searchVO.searchCondi eq 'ALL'}">selected</c:if>>전체</option>
											<option value="PRTNUM"
												<c:if test="${searchVO.searchCondi eq 'PRTNUM'}">selected</c:if>>사업자등록번호</option>
											<option value="CMPNNM"
												<c:if test="${searchVO.searchCondi eq 'CMPNNM'}">selected</c:if>>상호명</option>
											<option value="CEONM"
												<c:if test="${searchVO.searchCondi eq 'CEONM'}">selected</c:if>>대표자명</option>
											<option value="ADDR"
												<c:if test="${searchVO.searchCondi eq 'ADDR'}">selected</c:if>>주소</option>
											<option value="MGRTEL"
												<c:if test="${searchVO.searchCondi eq 'MGRTEL'}">selected</c:if>>담당자전화번호</option>
										</select> 
										<input type="text" class="form-control" name="searchVal" value="${searchVO.searchVal}" style="width:150px;"/> 
									</td>
									<th></th>
									<td></td>
									<th></th>
									<td>
										<button type=submit class="btn btn-primary" id="searchBtn" onclick="setPageIndex()">
											<span class="glyphicon glyphicon-search" aria-hidden="true">조회</span>
										</button>
									</td>
								</tr>
							</tbody>
						</table>
						<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}">
					</form>
				</div>
			</div>
	
			<div id="btns">
				 <a href="userRgst.do">
				 	<button type="button" class="btn btn-info btn-sm">사용자등록</button>
				 </a>
				<button type="button" id="deleteBtn" class="btn btn-default btn-sm" onclick="userDel()">선택삭제</button>
			</div>
			
			<div><strong>Page</strong> ${searchVO.pageIndex} / ${searchVO.totPage}
				<strong>Total</strong> ${searchVO.boardTotUnit}건 
			</div>
			
			<div id='grid'>
				<form name="userDelForm" role="form" action="userDel" method="GET" id="userDelForm">
					<table class='table table-bordered table-hover table-condensed' id="wrtListTable">
						<colgroup>
							<col width="35px">
							<col width="46px">
							<col width="114px">
							<col width="180px">
							<col width="80px">
							<col width="320px">
							<col width="114px">
							<col width="70px">
							<col width="70px">
							<col width="100px">   
						</colgroup> 
						<thead class='bg-primary'>
							<tr>
								<th></th>
								<th>번호</th>
								<th>사업자등록번호</th>
								<th>상호명</th>
								<th>대표자명</th>
								<th>주소</th>
								<th>담당자전화번호</th>
								<th>잔여건수</th>
								<th>상태</th> 
								<th>가입일</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${searchVO.boardTotUnit eq 0}">
								<tr>
								<td colspan="10" align="center">검색 결과가 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach var="list" items="${userList}" varStatus="status">
								<tr>
									<td><input type='checkbox' name="RowCheck" value="${list.prtnum}"></td>
									<td>${(searchVO.pageIndex-1)*searchVO.pageUnit + status.index + 1}</td>
									<td><a href="/egume_upc/admin/userMdf.do?prtnum=${list.prtnum}">${list.prtnum}</a></td>
									<td class="wrtListTableTd">${list.cmpnnm}</td>
									<td class="wrtListTableTd">${list.ceonm}</td>
									<td class="wrtListTableTd">${list.addr1} <c:if test="${list.addr1 != null}">,</c:if> ${list.addr2}</td>
									<td>${list.mgrtel}</td>
									<td>${list.rmncnt}</td>
									<td><c:choose>
											<c:when test="${list.sts == 'Y'}">사용중</c:when>
											<c:when test="${list.sts == 'N'}">사용안함</c:when>
											<c:when test="${list.sts == 'P' }">승인중</c:when>
										</c:choose>									
									</td>
									<td>${list.rgsttm}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>	
			</div>
	
			<div id='paging'>
				<ul class="pagination align-right">
					<c:if test="${searchVO.pageIndex != 1}">
						<li class="previous"> 
							<%-- <a href="/egume_upc/admin/userList.do?dateFrom=${searchVO.dateFrom}&dateTo=${searchVO.dateTo}&searchPeriod=${searchVO.searchPeriod}&searchCondi=${searchVO.searchCondi}&searchVal=${searchVO.searchVal}&pageIndex=${searchVO.pageIndex-1}">이전</a> --%>
							<a href="#" onclick="prev()">이전</a>
						</li>
					</c:if>
					<c:forEach var="item" begin="${searchVO.firstIndex}" end="${searchVO.lastIndex}" varStatus="status">
						<li <c:if test="${searchVO.pageIndex eq status.index}">class="active"</c:if>>
							<%-- <a href="/egume_upc/admin/userList.do?dateFrom=${searchVO.dateFrom}&dateTo=${searchVO.dateTo}&searchPeriod=${searchVO.searchPeriod}&searchCondi=${searchVO.searchCondi}&searchVal=${searchVO.searchVal}&pageIndex=${status.index}">${status.index}</a> --%>
							<a href="#" onclick="pagingNum(${status.index})">${status.index}</a>
						</li>
					</c:forEach>
					<c:if test="${searchVO.totPage > searchVO.pageIndex}">
						<li class="previous">
							<%-- <a href="/egume_upc/admin/userList.do?dateFrom=${searchVO.dateFrom}&dateTo=${searchVO.dateTo}&searchPeriod=${searchVO.searchPeriod}&searchCondi=${searchVO.searchCondi}&searchVal=${searchVO.searchVal}&pageIndex=${searchVO.pageIndex+1}">다음</a> --%>
							<a href="#" onclick="next()">다음</a>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
		<div class="push"></div>
	</div>
</body>
	<footer>
		<c:import url="../footer.jsp"/>
	</footer>
</html>