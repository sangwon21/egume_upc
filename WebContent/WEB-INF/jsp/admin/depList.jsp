<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		$("#depdt").datepicker();
	}
	
	// 조회기간 라디오 버튼 클릭시 조회기간 업데이트
	function changeDate(searchPeriod) {
		var today = new Date();
		if (searchPeriod =='3D'){
			$("#dateTo").datepicker('setDate', 'today');
			$("#dateFrom").datepicker('setDate', '-3D');
		}
		else if (searchPeriod =='1M'){
			$("#dateTo").datepicker('setDate', 'today');
			$("#dateFrom").datepicker('setDate', '-1M');
		}
		else if (searchPeriod =='3M'){
			$("#dateTo").datepicker('setDate', 'today');
			$("#dateFrom").datepicker('setDate', '-3M');
		}
	}
	
	// 삭제 버튼 클릭시 선택한 입금정보 삭제
	function depDel(){
		var checkArr=[];
		if ($("input[name=RowCheck]").is(':checked') == false) {
			alert("삭제할 항목을 체크해주세요.");
		} else {
			var condCtrl = true;
			$("input:checkbox[name=RowCheck]:checked").each(function (index) {
				checkArr.push($(this).val());
			});
			
			if(confirm("★★★주의★★★ 해당 건수가 차감됩니다. 삭제하시겠습니까?")){
				 document.depDelForm.submit();
			}
		}
	}
	
	// 등록버튼 클릭시 팝업(모달) 폼을 초기화
	function resetForm(){
		document.getElementById("depRgstForm").reset();
		$('#cmpnnm').text("상호명");
		$('#ceonm').text("대표자명");
		$("#depdt").datepicker('setDate',new Date());
	}
	
	// 입금정보 등록 팝업(모달)에서 사업자 등록번호 검색버튼을 눌렀을 때, 상호명과 대표자명 업데이트
	function searchCmpnCeoNm(){
		
		var prtnum=$('#prtnum').val();
		$.ajax({
			type: "POST", 
			url: "/egume_upc/admin/depSearchCmpnCeoNmAjax", 
			data: prtnum,
			dataType : "json", 
			contentType: "application/json",
			success: function(data) {
				$('#cmpnnm').text(data.Cmpnnm);
				$('#ceonm').text(data.Ceonm);
			}, 
			error: function(request, status, error) {
				alert("검색 결과가 존재하지 않습니다.");
				console.log("code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
			}
		});
	}
	
	// 입금정보 등록 버튼 클릭 시 유효성 체크 후 등록
	function depRgst(){
		if ($("#prtnum").val() == "" || $("#cmpnnm").val() == "상호명" || $("#ceonm").val() == "대표자명"){
			alert("사업자 등록번호 및 상호명/대표자명이 올바르지 않습니다.");
			return false;
		}
		else if($("#depamt").val() == "" || $("#depamt").val() <= 0){
			alert("입금액이 올바르지 않습니다.");
			return false;
		}
		else if($("#deprnm").val() == ""){
			alert("입금자가 올바르지 않습니다.");
			return false;
		}
		else if($("#depcnt").val() == "" || $("#depcnt").val() <= 0){
			alert("적립건수가 올바르지 않습니다.");
			return false;
		}
		else{
			return true;
		}
	}
	

	// 페이징 버튼 
	function prev() {
		//document.getElementById("pageIndex").value='${searchVO.pageIndex-1}';
		//document.getElementById("searchForm").submit();
		window.location.href=encodeURI("/egume_upc/admin/depList.do?dateFrom=${searchVO.dateFrom}&dateTo=${searchVO.dateTo}&searchPeriod=${searchVO.searchPeriod}&searchCondi=${searchVO.searchCondi}&searchVal=${searchVO.searchVal}&pageIndex=${searchVO.pageIndex-1}");
	}
	
	function pagingNum(pageIndex){
		//document.getElementById("pageIndex").value=num;
		//document.getElementById("searchForm").submit();
		window.location.href=encodeURI("/egume_upc/admin/depList.do?dateFrom=${searchVO.dateFrom}&dateTo=${searchVO.dateTo}&searchPeriod=${searchVO.searchPeriod}&searchCondi=${searchVO.searchCondi}&searchVal=${searchVO.searchVal}&pageIndex="+pageIndex);
	}
	
	function next(){
		//document.getElementById("pageIndex").value='${searchVO.pageIndex+1}';
		//document.getElementById("searchForm").submit();
		window.location.href=encodeURI("/egume_upc/admin/depList.do?dateFrom=${searchVO.dateFrom}&dateTo=${searchVO.dateTo}&searchPeriod=${searchVO.searchPeriod}&searchCondi=${searchVO.searchCondi}&searchVal=${searchVO.searchVal}&pageIndex=${searchVO.pageIndex+1}");
		
	}
	
	// 조회버튼 클릭 시페이징 인덱스 초기화
	function setPageIndex(){
		document.getElementById("pageIndex").value=1;
		document.getElementById("searchForm").submit();
	}
	
</script>
<head>
	<meta charset=utf-8>
	<title>입금내역 관리</title>
</head>
<body>
	<div class="wrapper">
	<c:import url="header.jsp" />
	<div class='container adminContainer'>
		<div class="title">입금내역 관리</div>
		<div class="well" id="wellDiv">
			<div id="search_container">
				<form class="form-horizontal" name="option_form" role="form" action="${pageContext.request.contextPath}/admin/depList.do" method="GET" id="searchForm"
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
										<input type="radio" name="searchPeriod" value="3D" onClick="changeDate(this.value)" <c:if test="${SearchVO.searchPeriod eq '3D'}">checked</c:if> /> 3일
									</label>
									<label class="radio-inline"> 
										<input type="radio" name="searchPeriod" value="1M" onClick="changeDate(this.value)" <c:if test="${SearchVO.searchPeriod eq '1M'}">checked</c:if> /> 1개월
									</label> 
									<label class="radio-inline"> 
										<input type="radio" name="searchPeriod" value="3M" onClick="changeDate(this.value)" <c:if test="${SearchVO.searchPeriod eq '3M'}">checked</c:if> /> 3개월
									</label>
								</td>
							</tr>
							<tr>
								<th>조회조건</th>
								<td>
									<select class="form-control" id="searchCondi" name="searchCondi" style="margin-right:10px;width:150px">
										<option value="ALL" <c:if test="${SearchVO.searchCondi eq 'ALL'}">selected</c:if>>전체</option>
										<option value="PRTNUM" <c:if test="${SearchVO.searchCondi eq 'PRTNUM'}">selected</c:if>>사업자등록번호</option>
										<option value="CMPNNM" <c:if test="${SearchVO.searchCondi eq 'CMPNNM'}">selected</c:if>>상호명</option>
										<option value="DEPRNM" <c:if test="${SearchVO.searchCondi eq 'DEPRNM'}">selected</c:if>>입금자</option>
									</select> 
									<input type="text" class="form-control" name="searchVal" value="${SearchVO.searchVal}" style="width:150px;"/> 
								</td>
								<th></th>
								<td></td>
								<th></th>
								<td>
									<button type="button" class="btn btn-primary" id="searchBtn" onclick="setPageIndex()">
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
			 <a href="#">
			 	<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal" onClick="resetForm()">등록</button>
			 </a>
			 <!-- Modal -->
			<div id="myModal" class="modal fade" role="dialog">
			  <div class="modal-dialog">
			    <!-- Modal content-->
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal">&times;</button>
			        <h4 class="modal-title" style="text-align:center">입금정보 등록</h4>
			      </div>
			      <form class="form-horizontal" name="depRgstForm" role="form" action="${pageContext.request.contextPath}/admin/depRgst" 
			        method="GET" id="depRgstForm" accept-charset="utf-8" >
			      <div class="modal-body" style="text-align:left;background-color:#EAEAEA;">
			        <div class="row" style="margin:10px;" >
			        	<div class="row" style="margin:5px;padding:5px;">
					    	<div class="col-md-3" align="left">
								<label>사업자 등록번호</label>
					        </div>
					        <div class="col-md-6" align="center">
					        	<input type="text" class="form-control" name="prtnum" id="prtnum" value=""/>
					       	</div>
					       	<div class="col-md-3" align="center">
					       		<button type="button" class="btn btn-primary" id="reqCmpnCeoNm" name="reqCmpnCeoNm" onClick="searchCmpnCeoNm()">검색</button>
					       	</div>
				       	</div>
				       <div class="row" style="margin:5px;padding:5px;">
					    	<div class="col-md-3" align="left">
								<label>상호명</label>
					        </div>
					        <div class="col-md-6" align="left">
					        	<label id="cmpnnm">상호명</label>
					       	</div>
				       	</div>
				       	<div class="row" style="margin:5px;padding:5px;">
					    	<div class="col-md-3" align="left">
								<label>대표자명</label>
					        </div>
					        <div class="col-md-6" align="left">
					        	<label id="ceonm">대표자명</label>
					       	</div>
				       	</div>
				        <div class="row" style="margin:5px;padding:5px;">
					    	<div class="col-md-3" align="left">
								<label>입금일</label>
					        </div>
					        <div class="col-md-6" align="left">
					        	<input type="text" class="form-control" name="depdt" id="depdt"/>
					       	</div>
				       	</div>
				       	<div class="row" style="margin:5px;padding:5px;">
					    	<div class="col-md-3" align="left">
								<label>입금액</label>
					        </div>
					        <div class="col-md-6" align="left">
					        	<input type="number" class="form-control" name="depamt" id="depamt"/>
					       	</div>
				       	</div>
				       	<div class="row" style="margin:5px;padding:5px;">
					    	<div class="col-md-3" align="left">
								<label>입금자</label>
					        </div>
					        <div class="col-md-6" align="left">
					        	<input type="text" class="form-control" name="deprnm" id="deprnm"/>
					       	</div>
				       	</div>
				       	<div class="row" style="margin:5px;padding:5px;">
					    	<div class="col-md-3" align="left">
								<label>적립건수</label>
					        </div>
					        <div class="col-md-6" align="left">
					        	<input type="number" class="form-control" name="depcnt" id="depcnt"/>
					       	</div>
				       	</div>
				 	</div>
			      </div>
			      <div class="modal-footer" style="text-align:center;">
			        <button type="submit" class="btn btn-info btn-sm" onclick="return depRgst()">등록</button>
			      </div>
			      </form>
			    </div>
			  </div>
			</div>
			
			<button type="button" id="deleteBtn" class="btn btn-default btn-sm" onclick="depDel()">선택삭제</button>
		</div>
		
		<div><strong>Page</strong> ${searchVO.pageIndex} / ${searchVO.totPage}
			<strong>Total</strong> ${searchVO.boardTotUnit}건 
		</div>

		<div id='grid'>
			<form name="depDelForm" role="form" action="depDel" method="GET" id="depDelForm">
				<table class='table table-bordered table-hover table-condensed' id="wrtListTable">
					<colgroup>
						<col width="35px">
						<col width="46px">
						<col width="114px">
						<col width="80px">
						<col width="80px">
						<col width="136px">
						<col width="114px">
						<col width="90px">
						<col width="80px">
						<col width="106px">
						<col width="70px">
						<col width="90px">
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
							<th>입금일</th>
							<th>입금액</th>
							<th>입금자</th>
							<th>적립건수</th>
							<th>담당어드민</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${searchVO.boardTotUnit eq 0}">
							<tr>
							<td colspan="13" align="center">검색 결과가 없습니다.</td>
							</tr>
						</c:if>
						<c:forEach var="list" items="${depList}" varStatus="status">
							<tr>
								<td><input type='checkbox' name="RowCheck" value="${list.depseq}"></td>
								<td>${(searchVO.pageIndex-1)*searchVO.pageUnit + status.index + 1}</td>
								<td>${list.prtnum}</td>
								<td class="wrtListTableTd">${list.cmpnnm}</td>
								<td class="wrtListTableTd">${list.ceonm}</td>
								<td class="wrtListTableTd">${list.addr1},${list.addr2}</td>
								<td>${list.mgrtel}</td>
								<td>${list.depdt}</td>
								<td>${list.depamt}</td>
								<td class="wrtListTableTd">${list.deprnm}</td>
								<td>${list.depcnt}</td>
								<td class="wrtListTableTd">${list.rgstid}</td>  
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
						<%-- <a href="/egume_upc/admin/depList.do?dateFrom=${searchVO.dateFrom}&dateTo=${searchVO.dateTo}&searchPeriod=${searchVO.searchPeriod}&searchCondi=${searchVO.searchCondi}&searchVal=${searchVO.searchVal}&pageIndex=${searchVO.pageIndex-1}">이전</a> --%>
						<a href="#" onclick="prev()">이전</a>
					</li>
				</c:if>
				<c:forEach var="item" begin="${searchVO.firstIndex}" end="${searchVO.lastIndex}" varStatus="status">
					<li <c:if test="${searchVO.pageIndex eq status.index}">class="active"</c:if>>
						<%-- <a href="/egume_upc/admin/depList.do?dateFrom=${searchVO.dateFrom}&dateTo=${searchVO.dateTo}&searchPeriod=${searchVO.searchPeriod}&searchCondi=${searchVO.searchCondi}&searchVal=${searchVO.searchVal}&pageIndex=${status.index}">${status.index}</a> --%>
						<a href="#" onclick="pagingNum(${status.index})">${status.index}</a>
					</li>
				</c:forEach>
				<c:if test="${searchVO.totPage > searchVO.pageIndex}">
					<li class="previous">
						<%-- <a href="/egume_upc/admin/depList.do?dateFrom=${searchVO.dateFrom}&dateTo=${searchVO.dateTo}&searchPeriod=${searchVO.searchPeriod}&searchCondi=${searchVO.searchCondi}&searchVal=${searchVO.searchVal}&pageIndex=${searchVO.pageIndex+1}">다음</a> --%>
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