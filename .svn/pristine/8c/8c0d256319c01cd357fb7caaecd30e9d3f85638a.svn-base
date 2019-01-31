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
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>구매확인서 발급 서비스</title>
    
		<link href="${pageContext.request.contextPath}/css/reqfrm/reqfrm.css" rel="stylesheet" type="text/css">
		<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,700&amp;subset=korean" rel="stylesheet">
    	<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&amp;subset=korean" rel="stylesheet">
    	<style>
    		.contents__box{
    			 box-shadow: 0 8px 1px rgba(133, 133, 133, 0.3), 0 5px 12px rgba(133, 133, 133,0.22);
    			 margin-bottom:10px;
    		}
    		.file-input{
			    position: relative;
			    overflow: hidden;
			  	margin: 0px;
			    color: #333;
			    cursor: pointer;
			    background-color: #fff;
			    border-color: #ccc;
			}
			.file-input input[type=file] {
				position: absolute;
				top: 0;
				right: 0;
				margin: 0;
				padding: 0;
				cursor: pointer;
				font-size: 20px;
				opacity: 0;
				filter: alpha(opacity=0);
			}
			.file-input-title {
			    margin-left:2px;
			}
			.files{
				margin-bottom:10px;
			}
			
			.user__header{
				margin-bottom:10px;
				border-bottom:1px solid black;
			}
    	</style>

    </head>
    <body>
      <c:import url="../header.jsp" />
        <div class="container .col-xs-12">
            <h5>KTNET 구매확인서 발급 서비스</h5>
            <br>
            <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/user/reqfrm/prchCnfrmApplCreate.do" role="button">웹에서 작성</a>
            <a class="btn btn-default btn-sm" href="#" role="button">신청서 업로드</a>
        </div>
         <br>
        <div class="container col-sm-4" style="float:none; margin:0 auto;">
            <form class="form-horizontal" method="post" enctype="multipart/form-data">
                
                
                <table class="table col-lg-6 contents__box">
                	<thead>
                    	<tr>
                    		<th scope="col"> 구매자 </th>
                        </tr>
                    </thead>
                    <tbody>
                    	<tr>
                    		<th scope="row" class="inputFile"><input type="text" class="form-control preview-filename" disabled="disabled"></th>
                    		<td><div class="btn btn-default file-input">
                                <span class="glyphicon glyphicon-folder-open"></span>
                                <span class="file-input-title">업로드</span>
                                <input type="file"  name="applfrm" id="applfrm" placeholder="신청서" onchange="fileCheck()" required/>
                                </div>
                                <small class="help-block fileValidation" style="color:#a94442;">올바른 확장자를 입력해주십시오.</small>
                            </td>
                        </tr>
 					</tbody>
 				</table>

				<table class="table col-lg-6 contents__box">
                	<thead>
                    	<tr>
                    		<th scope="col">세금계산서</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<tr>
                    		<th scope="row" class="inputFile"><input type="text" class="form-control preview-filename" disabled="disabled"></th>
                        	<td><div class="btn btn-default file-input">
                                <span class="glyphicon glyphicon-folder-open"></span>
                                <span class="file-input-title">업로드</span>
                                <input type="file"  name="tax"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<th scope="row" class="inputFile"><input type="text" class="form-control preview-filename"  disabled="disabled"></th>
                        	<td><div class="btn btn-default file-input">
                                <span class="glyphicon glyphicon-folder-open"></span>
                                <span class="file-input-title">업로드</span>
                                <input type="file"  name="tax"/>
                                </div>
                            </td>
                    	</tr>
                   		<tr>
                   			<th scope="row" class="inputFile"><input type="text" class="form-control preview-filename"  disabled="disabled"></th>
                   			<td><div class="btn btn-default file-input">
                                <span class="glyphicon glyphicon-folder-open"></span>
                                <span class="file-input-title">업로드</span>
                                <input type="file"  name="tax"/>
                                </div>
                            </td>
                    	</tr>
                    	<tr>
                    		<td> *사전발급: 구매일 기준 익월 10일 이전<br>
                        -외화획득용 원료/기재를 구매하려는 경우 세금계산서 없이 발급</td>
                    	</tr>
                    	<tr>
                    		<td>*사후발급: 구매일 기준 익월 10일 이후<br>
                        -외화획득용 원료/기재를 구매한 경우 세금계산서 정보 기재 후 발급
                    		</td>
                    	</tr>
 					</tbody>
                </table>
                
                <table class="table col-lg-6 contents__box">
                	<thead>
                    	<tr>
                    		<th scope="col">수출근거서류</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<tr>
                    		<th scope="row" class="inputFile"><input type="text" class="form-control preview-filename" disabled="disabled"></th>
                        	<td><div class="btn btn-default file-input">
                                <span class="glyphicon glyphicon-folder-open"></span>
                                <span class="file-input-title">업로드</span>
                                <input type="file"  name="sup"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<th scope="row" class="inputFile"><input type="text" class="form-control preview-filename"  disabled="disabled"></th>
                        	<td><div class="btn btn-default file-input">
                                <span class="glyphicon glyphicon-folder-open"></span>
                                <span class="file-input-title">업로드</span>
                                <input type="file"  name="sup"/>
                                </div>
                            </td>
                    	</tr>
                   		<tr>
                   			<th scope="row" class="inputFile"><input type="text" class="form-control preview-filename"  disabled="disabled"></th>
                   			<td><div class="btn btn-default file-input">
                                <span class="glyphicon glyphicon-folder-open"></span>
                                <span class="file-input-title">업로드</span>
                                <input type="file"  name="sup"/>
                                </div>
                            </td>
                    	</tr>
                    	<tr>
                    		<td>
                    		*수출신용장<br>
                        *수출계약서(품목, 수량, 가격 등에 합의하여 서명한 수출계약 입증서류)<br>
                        *외화매입서/예치증명서<br>
                        -외화획득이행 관련 대금임이 서류에 의해 확인되는 경우만 해당<br>
                    		</td>
                    		<td>
                    	</tr>
                    	<tr>
                    		<td>*내국신용장/구매확인서<br>
                        -N차 공급자의 경우에 해당<br>
                        *수출신고필증<br>
                        *대외무역법시행령 제 26조 각호에 따른<br>
                        외화획득에 제공되는 물품 등을 생산하기 위한 경우임을 입증할 수 있는 서류</td>
                    		<td></td>
                    	</tr>
                    	
 					</tbody>
                </table>
            
                <button type="text" class="btn btn-default" id="btnCancel">취소</button>
                <button type="submit" id="submitBtn" class="btn btn-primary">제출</button>
            
        </form>
    </div>
    <c:import url="../footer.jsp" />
    
    <script>
    
 // contextPath찾아오는 함수
	function getContextPath() {
		var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	};
	
    window.onload = function() {
		console.log("javascript start");
		
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
		
	    $(".fileValidation").hide();

		var cancelBtn = document.querySelector("#btnCancel");
		
		var url = getContextPath()+'/user/reqfrm/prchCnfrmApplList.do'
		
		cancelBtn.addEventListener("click", function(){
			$(location).attr('href', url);
		})
	}
    
    // 파일 확장자 체크
    function fileCheck() {
    	
    	var file = $("#applfrm").val();
    	
    	// 정규식으로 확장자 체크
    	if(!/\.(gif|jpg|jpeg|png|pdf|xlsx|docx|hwp|txt)$/i.test(file)) {	//file[0].name : 파일명
    	    $(".fileValidation").show();
    		return false;
    	}  else {
    	    $(".fileValidation").hide();
    	    return true;
    	}
    }
    </script>
    
  </body>
</html>