<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발급신청</title>
  <c:import url="../admin/header.jsp" />
<script type="text/javascript">
$(document).ready(function(){
	
	/** 선적기일 구매일자 달력 */
	$.datepicker.setDefaults({
		dateFormat: 'yymmdd'
	});
	$("#prchDt").datepicker({
		  beforeShow: function() {
		        setTimeout(function(){
		            $('.ui-datepicker').css('z-index', 99999999999999);
		        }, 0);
		    }
	});
	$("#shipDt").datepicker({
		beforeShow: function() {
	        setTimeout(function(){
	            $('.ui-datepicker').css('z-index', 99999999999999);
	        }, 0);
	    }
	});
	
	
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
         
         if(!/\.(gif|jpg|jpeg|png|pdf|xlsx|docx|hwp|txt)$/i.test(file.name)) {
     		alert("허용되지 않는 파일 형식입니다");
 			file.value = "";
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
    
	
	/**고객 정보조회*/
	$("#rgstVwPrtNum").on("keyup",function(){
		var prtNum = $("#rgstVwPrtNum").val();	
		if(prtNum.length == 10){
			$.ajax({
				type:"GET",
				url: "<%=request.getContextPath()%>/admin/applrcpt/usrInfo",
				contentType: 'application/json; charset=UTF-8',
				data : {"prtNum" : prtNum }, 
				success : function(serverResult){
					if(serverResult != ""){
						$("#usrPrtNum").val(serverResult.prtnum);
						$("#usrCmpnNm").val(serverResult.cmpnnm);
						$("#usrCeoNm").val(serverResult.ceonm);
						$("#usrMgrName").val(serverResult.mgrname);
						$("#usrMgrTel").val(serverResult.mgrtel);
						$("#usrEmail").val(serverResult.mgremail);
						$("#usrAddr1").val(serverResult.addr1);
						$("#usrAddr2").val(serverResult.addr2);
					}else{
						alert("조회된 정보가 없습니다.");
					}
				},
				
				error: function(xhr,status){
					 if(xhr.status==0){
						 alert('네트워크를 체크해주세요.');
					 }else if(status=='timeout'){
						 alert('시간을 초과하였습니다.');
					 }else {
						 alert('에러가 발생하였습니다');
					 }
				 }
			  });
		}else if(prtNum.length > 10){
			alert("10자리 이상 입력 할 수 없습니다.");
			$("#rgstVwPrtNum").val(prtNum.substring(0,10));
		}
		
	});
	
     /**파일 다운로드*/
	$(".file-download").on("click",function(){
		var fileseq = $(this).data("fileseq");		
		location.href="<%=request.getContextPath()%>/filedownload?fileseq="+fileseq;
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
    
    
    /**유효성 검사byte*/
    $("#splyPrtNum").on("keyup",function(){
    	var prtNum = $("#splyPrtNum").val();
    	
    	if(prtNum.length == 10){
    		if(!fn_prtnumCheckLogic(prtNum)){
    			alert("유효하지 않은 사업자번호 입니다.");
    			$("#splyPrtNum").val(prtNum.substring(0,9));
    		}
		}else if(prtNum.length > 10){
			alert("10자리 이상 입력 할 수 없습니다.");
			$("#splyPrtNum").val(prtNum.substring(0,10));
		}
    });
    
    $("#splyOrgNm").on("keyup",function(){
    	var text = $("#splyOrgNm").val();
    	if(getByte(text) > 34){
    		fn_valdAlert($(this),text);
    	}
    });
    
    $("#splyCeoNm").on("keyup",function(){
    	var text = $("#splyCeoNm").val();
    	if(getByte(text) > 34){
    		fn_valdAlert($(this),text);
    	}
    });
    
    $("#splyAddr1").on("keyup",function(){
    	var text = $("#splyAddr1").val();
    	if(getByte(text) > 99){
    		fn_valdAlert($(this),text);
    	}
    });
    
    $("#splyAddr2").on("keyup",function(){
    	var text = $("#splyAddr2").val();
    	if(getByte(text) > 99){
    		fn_valdAlert($(this),text);
    	}
    });
    
    $("#notes").on("keyup",function(){
    	var text = $("#notes").val();
    	if(getByte(text) > 99){
    		fn_valdAlert($(this),text);
    	}
    });
	
    /** end 유효성 검사byte*/
	
	/** 제출 전 체크 */
	$("#rgstFilesBtn").on("click",function(){
		var prtNum = $("#rgstVwPrtNum").val();
		var nullCheck = false;
		if(prtNum.length < 10){
			alert("구매자 사업자번호를 확인해주세요");
			return;
		}
		
		$(".sply > tbody > tr > td > input").each(function(i) {
			if(i < 4 && $(this).val() == ""){
				alert("필수 입력양식을 확인해주세요");
				nullCheck = true;
				return false;
			}	
		});
		
		if(nullCheck) return;
		
		$(".form-horizontal").submit();
	});
    
});


/** 유효성 검사byte Alert함수*/
function fn_valdAlert(tis,text){
	alert("더이상 입력할 수 없습니다");
	tis.val(text.substring(0,parseInt(text.length/2)));
}

/**사업자번호 유효성검사*/
function fn_prtnumCheckLogic(prtnum) {
	var sum = 0;
	var checknum = 0;
    var arrNumList = new Array();
	var arrCheckNum = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1); 
	
	for(var i = 0; i < 10; i++) {
		arrNumList[i] = parseInt(prtnum[i]);
	} 
	for(var i = 0; i < 9; i++) {
		sum += arrNumList[i] * arrCheckNum[i];
	}
	
	sum += parseInt((arrNumList[8] * 5) / 10);
	checknum = (10 - (sum % 10)) % 10;
	return (checknum == arrNumList[9]);
}

/**바이트 체크 함수*/
function getByte(str) {
    var strByte = 0;
    for (var i = 0; i < str.length; ++i) {
        (str.charCodeAt(i) > 127) ? strByte += 3 : strByte++;
    }
    return strByte;
}

/**도로명주소*/
function addrPopup() {
	new daum.Postcode({
		oncomplete:function(data) {
			var roadAddr = data.roadAddress; // 도로명 주소 변수
		
		    $("#splyAddr1").val(roadAddr);
		 }
	}).open();
}

</script>
</head>
<body>

  <div class="wrapper">
  <div class='container'>
      <h3 class="title">
      	 <c:choose>
		 	<c:when test="${param.appMthd eq 'ADMIN' and param.applNum eq null}">발급신청등록</c:when>
		 	<c:otherwise>발급신청정보</c:otherwise>	
	 	 </c:choose>    
      </h3>
   <form class="form-horizontal" method="post" enctype="multipart/form-data" onkeydown="if(event.keyCode==13){return false;}" action="<%=request.getContextPath()%>/admin/applrcpt/register">  
    <div class="col-sm-6">
      <h4><span class="glyphicon glyphicon-plus-sign icn"></span>&nbsp;구매자정보</h4>
          <table class="table table-bordered user-info">
	       		<tbody>
	       			<tr>
	       				<td>사업자번호<span class="text-danger">*</span></td>
	       				<td><input id="rgstVwPrtNum" type="text"  name="prtnum" class="formCustom user-info"  value="${usrInfVO.prtnum}" autocomplete="off"></td>
	       			</tr>
	       			<tr>
	       				<td>상호명</td>
	       				<td><input id="usrCmpnNm"  type="text"   class="formCustom user-info" value="${usrInfVO.cmpnnm}"  disabled></td>
	       			</tr>
	       			<tr>
	       				<td>대표자명</td>
	       				<td><input id="usrCeoNm"   type="text"   class="formCustom user-info" value="${usrInfVO.ceonm}"  disabled ></td>
	       			</tr>
	       			<tr>
	       				<td>담당자명</td>
	       				<td><input id="usrMgrName" type="text"   class="formCustom user-info" value="${usrInfVO.mgrname}" disabled ></td>
	       			</tr>
	       			<tr>
	       				<td>전화번호</td>
	       				<td><input id="usrMgrTel"  type="text"   class="formCustom user-info" value="${usrInfVO.mgrtel}"    disabled></td>
	       			</tr>
	       			<tr>
	       				<td>이메일</td>
	       				<td><input id="usrEmail"   type="text"   class="formCustom user-info" value="${usrInfVO.mgremail}"  disabled></td>
	       			</tr>
	       			<tr>
	       				<td>회사주소</td>
	       				<td><input id="usrAddr1" type="text" value="${usrInfVO.addr1}" class="formCustom user-info"  disabled ></td>
	       			</tr>
	       			<tr>
	       				<td>상세주소</td>
	       				<td><input id="usrAddr2" type="text" value="${usrInfVO.addr2}" class="formCustom user-info" disabled ></td>
	       			</tr>
	       		</tbody>
		   </table>
              
       </div> 
       
       <div class="col-sm-6">
       	<h4><span class="glyphicon glyphicon-plus-sign icn"></span>&nbsp;공급자정보</h4>
       	  <input name="appmthd" value="${param.appMthd}" hidden="">
       	  <input name="applnum" value="${param.applNum}" hidden="">
       	  
		 <table class="table table-bordered user-info sply">
		       		<tbody>
		       			<tr>
		       				<td>사업자번호<span class="text-danger">*</span></td>
		       				<td><input id="splyPrtNum" name="splyprtnum" autocomplete="off" class="formCustom user-info"  value="${applRcptOne.splyPrtNum}" type="text"  pattern="[0-9]{10}"></td>
		       			</tr>
		       			<tr>
		       				<td>상호명<span class="text-danger">*</span></td>
		       				<td><input id="splyOrgNm" name="splyorgnm" autocomplete="off" class="formCustom user-info" value="${applRcptOne.splyOrgNm}" type="text" ></td>
		       			</tr>
		       			<tr>
		       				<td>대표자명<span class="text-danger">*</span></td>
		       				<td><input id="splyCeoNm" name="splyceonm" autocomplete="off" class="formCustom user-info" value="${applRcptOne.splyCeoNm}" type="text" ></td>
		       			</tr>
		       			
		       			<tr>
		       				<td>회사주소<span class="text-danger">*</span></td>
		       				<td><input id="splyAddr1" name="splyaddr1" autocomplete="off" class="formCustom user-info add-btn" value="${applRcptOne.splyAddr1}"><button class="btn btn-default rgst-btn" type="button" onclick="addrPopup()" >검색</button></td>
		       			</tr>
		       			<tr>
		       				<td>상세주소</td>
		       				<td><input id="splyAddr2" name="splyaddr2" autocomplete="off" class="formCustom user-info" value="${applRcptOne.splyAddr2}" type="text" class="form-control"  ></td>
		       			</tr>
		       		</tbody>
		   </table>
		   <h4 id="rgstInfoTableHeader"><span class="glyphicon glyphicon-plus-sign icn"></span>&nbsp;신청정보</h4>
		   <table class="table table-bordered user-info">
		   		<tbody>
		   			<tr>
		       				<td style="width: 142px">신청방법</td>
		       				<td>
		       					<c:choose>
		       						<c:when test="${applRcptOne.appMthd eq null}">
		       							ADMIN
		       						</c:when>
		       						<c:otherwise>
		       							${applRcptOne.appMthd}
		       						</c:otherwise>
		       					</c:choose>
		       				</td>
		       			</tr>
		       			<tr>
		       				<td>발급신청서</td>
		       				<td>
		       					 <c:if test="${applRcptOne.appMthd eq 'FILE'}">
										<a class="file-download" id="fileDownBtn" data-fileseq="${applRcptOne.applFileId}">${applRcptOne.applFileId}</a>
									</c:if>
		       				</td>
		       			</tr>
		   		</tbody>
		   </table>
           </div>
     
       <div>
         <h4 class="col-sm-12"><span class="glyphicon glyphicon-plus-sign icn"></span>&nbsp;근거서류</h4>
         <div class = "col-sm-12">
           <table class="table table-bordered table-hover table-condensed">
             <thead class="bg-primary">
               <tr>
                 <th class="file-no-header" id="fileTableHeaderth1">번호</th>
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
                             <input type="text" class="form-control preview-filename" disabled="disabled">
                              <span class="input-group-btn">
                                <button type="button" class="btn btn-default file-download"  id="tblFileDownBtn" style="display:none">
                                    <span class="glyphicon glyphicon-file">다운</span> 
                                </button>
                                <button type="button" class="btn btn-default file-clear" id="fileClear" style="display:none">
                                    <span class="glyphicon glyphicon-remove">삭제</span> 
                                </button>
                                <div class="btn btn-default file-input">
                                    <span class="glyphicon glyphicon-folder-open"></span>
                                    <span class="file-input-title">업로드</span>
                                    <input hidden="" name="modSup" value="">
                                    <input type="file"  name="sup" accept=".docx,.pdf,.hwp,.jpg,.xlsx"/>
                                </div>
                              </span>
                              </c:when>
                              <c:otherwise>
                              <input type="text" class="form-control preview-filename viewer" data-fileseq="${fileList[i.index+1].fileseq}"  value="${fileList[i.index+1].filenm}" readonly="readonly">
                              <span class="input-group-btn">
                                <button type="button" class="btn btn-default file-download" data-fileseq="${fileList[i.index+1].fileseq}" id="tblFileDownBtn">
                                    <span class="glyphicon glyphicon-file">다운</span> 
                                </button>
                                <button type="button" class="btn btn-default file-clear" id="fileClear" style="display:none">
                                    <span class="glyphicon glyphicon-remove">삭제</span> 
                                </button>
                                <div class="btn btn-default file-input">
                                    <span class="glyphicon glyphicon-folder-open"></span>
                                    <span class="file-input-title">변경</span>
                                    <input type="file"  name="sup"  accept=".docx,.pdf,.hwp,.jpg,.xlsx"/>
                                     <input hidden="" name="modSup" value="${fileList[i.index+1].fileseq}">
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
                             <input type="text" class="form-control preview-filename" disabled="disabled">
                              <span class="input-group-btn">
                                <button type="button" class="btn btn-default file-download" id="tblFileDownBtn" style="display:none">
                                    <span class="glyphicon glyphicon-file">다운</span> 
                                </button>
                                <button type="button" class="btn btn-default file-clear" id="fileClear" style="display:none">
                                    <span class="glyphicon glyphicon-remove">삭제</span> 
                                </button>
                                <div class="btn btn-default file-input">
                                    <span class="glyphicon glyphicon-folder-open"></span>
                                    <span class="file-input-title">업로드</span>
                                    <input hidden="" name="modTax" value="">
                                    <input type="file"  name="tax" accept=".docx,.pdf,.hwp,.jpg,.xlsx"/>
                                </div>
                              </span>
                              </c:when>
                              <c:otherwise>
                                <input type="text" class="form-control preview-filename viewer" data-fileseq="${list.fileseq}" value="${list.filenm}" readonly="readonly" >
                              <span class="input-group-btn">
                                <button type="button" class="btn btn-default file-download" id="tblFileDownBtn" data-fileseq="${list.fileseq}">
                                    <span class="glyphicon glyphicon-file">다운</span> 
                                </button>
                                <button type="button" class="btn btn-default file-clear" id="fileClear" style="display:none">
                                    <span class="glyphicon glyphicon-remove">삭제</span> 
                                </button>
                                <div class="btn btn-default file-input">
                                    <span class="glyphicon glyphicon-folder-open"></span>
                                    <span class="file-input-title">변경</span>
                                    <input type="file"  name="tax" accept=".docx,.pdf,.hwp,.jpg,.xlsx" />
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

		<div class="col-sm-12">
    		  <h4><span class="glyphicon glyphicon-plus-sign icn"></span>&nbsp;등록정보</h4>
				 <table class="table table-bordered table-hover table-condensed detailInfo2">
					<thead class='bg-primary'>
						<tr>
							<th>진행상태</th>
							<th>접수자</th>
							<th>신청일자</th>
							<th>비고사항</th>
						</tr>
					</thead>
					<tbody>
							<tr>
								<td>${applRcptOne.codeNm}</td>
								<td><input hidden="" name="regid" value="${adminVO.admid}">${adminVO.name}</td>
								<td>${applRcptOne.applDt}</td>
								<td><input id="notes" name="notes" class="formCustom" value="${applRcptOne.notes}" /></td>
							</tr>
					</tbody>
				</table>
			</div>
			<div id="btns" class="col-sm-12" >
				<button type="button" class="btn btn-default btn-sm" onclick="history.go(-1)">목록</button>
				<button type="button" class="btn btn-info btn-sm" id="rgstFilesBtn">
				<c:choose>
					<c:when test="${param.appMthd eq 'ADMIN' and param.applNum eq null}">등록</c:when>
					<c:otherwise>수정</c:otherwise>	
				</c:choose>
				</button>
			</div>
		</div>
	 </form>
	</div>
 </div>
</body>
 <footer>
	<c:import url="../footer.jsp" />
      <div class="push"></div>
 </footer>
</html>