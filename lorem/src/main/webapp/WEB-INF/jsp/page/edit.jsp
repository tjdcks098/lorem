
<%@page import="com.lorem.ipsum.model.post.PostFileModel"%>
<%@page import="com.lorem.ipsum.commons"%>
<%@page import="com.lorem.ipsum.model.logon.UserModel"%>
<%@page import="com.lorem.ipsum.model.BoardModel"%>
<%@page import="javax.tools.DocumentationTool.Location"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
String board = (String) request.getParameter("name");
String postId=(String)request.getParameter("postId");
ArrayList<BoardModel> boardList = null;
boardList = (ArrayList<BoardModel>) request.getAttribute("boardList");
String title=(String)request.getAttribute("title");
String contents=(String)request.getAttribute("contents");
ArrayList<PostFileModel> clip=(ArrayList<PostFileModel>)request.getAttribute("files");
ArrayList<PostFileModel> refImage=new ArrayList<PostFileModel>();
ArrayList<PostFileModel> refFile=new ArrayList<PostFileModel>();
for(PostFileModel c:clip){
	if(c.getF_type().equals("file"))refFile.add(c);
	else refImage.add(c);
}

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=no,initial-scale=1, maximum-scale=1">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="shortcut icon" href="../source/favi/favicon.ico">
<script src="../js/jquery-3.5.0.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script>



$(document).on('click','.delImgBtn', function(){
	const i_index= $(this).parent().index();
	if(i_index>=ci){
	imageBuffer.splice(i_index-ci, 1);
	}else{
		delImage.push(refImage[i_index]);
		refImage.splice(i_index, 1);
		ci--;
	}
	$('#imageName>.fileList:nth-child('+(i_index+1)+')').remove();
	if((imageBuffer.length+ci)==0){
		$('#imageName').html('선택된 파일이 없습니다.');
	}
	$.each($('#imageName>.fileList'), function(index, list){
		if(index>=i_index)
			$('#imageName>.fileList:nth-child('+(index+1)+') .image_pre_id').html('&lt;Image'+(index+1)+'&gt;');

		});
	

});
$(document).on('click','.delFileBtn', function(){
	const f_index= $(this).parent().index();
	if(f_index>=cf){
	fileBuffer.splice(f_index-cf, 1);
	}else{
		delFile.push(refFile[f_index]);
		refFile.splice(f_index, 1);
		cf--;
	}
	$('#fileName>.nameList:nth-child('+(f_index+1)+')').remove();
	
	if((fileBuffer.length+cf)==0){
		$('#fileName').html('선택된 파일이 없습니다.');
	}
});

function warnImgDuple(){
	alert("동일한 이름을 갖는 사진을 동시에 사용 할 수 없습니다.");
}
function warnFileDuple(){
	alert("동일한 이름을 갖는 파일을 동시에 첨부 할 수 없습니다.");
}

$(document).ready(function(){
	
	var file=$('#file');
	var image=$('#image');
	delImage=[];
	delFile=[];
	refImage=[];
	refFile=[];
	ci=<%=refImage.size()%>;
	cf=<%=refFile.size()%>;
	imageBuffer=[];
	fileBuffer=[];
	if(ci!=0)$('#imageName').html("");
	if(cf!=0)$('#fileName').html("");
	<%
	for(PostFileModel f:refFile){
	%>
		$('#fileName').html(
			$('#fileName').html()
			+'<div class="nameList">'
			+'<%=f.getF_name()%>'
			+'<div class="delFileBtn"></div></div>'
		);
		refFile.push('<%=f.getF_name()%>');
	<%
	}
	for(PostFileModel i:refImage){
	%>
		$('#imageName').html(
			$('#imageName').html()
			+'<div class="fileList">'
			+'<div class="image_pre_container"><img src="../postUpload/view/'
			+'<%=i.getF_url().substring(i.getF_url().lastIndexOf('\\'))%>'
			+'" class="image_pre"></div><p class="image_pre_name"><span class="image_pre_id">&lt;Image'
			+($('#imageName>.fileList').length+1)
			+'&gt;</span><br>'
			+'<%=i.getF_name()%>'
			+'</p><div class="delImgBtn"></div></div>'
		);
		refImage.push('<%=i.getF_name()%>');
	<%}%>

	$('#frm').ajaxForm({
		dataType:'text',
		contentType : false,
		processData : false,
		enctype: "multipart/form-data",
		url:"../edit.do",
        type : "POST",
        beforeSubmit: function(data, form, option) {

    		if($('#title').val()==null||$('#title').val()==''){
    			alert('제목을 입력해 주세요.');
    			$('#title').focus();
    			return false;
    		}
    		if($('textarea#contents').val()==null||$('textarea#contents').val()==''){
    			alert('내용을 입력해 주세요.');
    			$('#contents').focus();
    			return false;
    		}	

    		var board={name:"board", value:"<%=board%>"};
    		data.push(board);
			var postId={name:"postId",value:"<%=postId%>"};
    		data.push(postId);
    		
        	var delImageList=[];
    		if(delImage.length>0){
				for(var i=0; i<delImage.length; i++){
					delImageList.push(delImage[i]);
				}
            }
			data.push({name:"delImage",value:delImageList});
			var delFileList=[];
    		if(delFile.length>0){
				for(var i=0; i<delFile.length; i++){
					delFileList.push(delFile[i]);
				}
            }
			data.push({name:"delFile", value:delFileList});
			
    		if(imageBuffer.length>0){
    			for(var i=0; i<imageBuffer.length; i++){
    				var image= {
    						name : "images",
    						value : imageBuffer[i],
    						type:'file'
    				};
                    data.push(image);
    			}
    		}else{
				var image= {
						name : "images",
						value : null,
						type:'file'
				};
                data.push(image);
    		}
    		
    		
            if (fileBuffer.length>0){
                for(var i=0; i<fileBuffer.length; i++){
                    var obj = {
                            name : "files",
                            value : fileBuffer[i],
    						type:'file'
                    };
                    data.push(obj);
                }    
            }else{
                var obj = {
                        name : "files",
                        value : null,
						type:'file'
                };
                data.push(obj);
            }
            console.log(data);
        },
        success: function(returnData) {
        	alert(returnData.split(':')[0]);
        	location.href=returnData.split(':')[1];
        },
        error: function(x,e){
        	alert("게시글 업로드에 실패했습니다.");
              console.log("[AF]ajax status : "+x.status);
              console.log(e);
          }
    });
	
//	
	
	
	
	file.on('change',function(){
		var addCount=0;
		var isDuple=false;
		$.each(file[0].files, function(index, file){
			var isRefDuple=false;
			$.each(refFile, function(rindex, rfile){
				if(rfile==file.name){
					isRefDuple=true;
					isDuple=true;
					}
			});
			if(!isRefDuple){
			if(fileBuffer.length==0){
				fileBuffer.push(file);
				addCount++;
			}else{
				dupleCnt=0;
				$.each(fileBuffer, function(index2, bufferFile){
					if(bufferFile.name==file.name){
						dupleCnt++;
					}
				});
				if(dupleCnt==0){
					fileBuffer.push(file);
					addCount++;
				}
				else{
					isDuple=true;
				}
			}}
		});
		if((fileBuffer.length+cf)==0){
			$('#fileName').html('선택된 파일이 없습니다.');
		}else{
			for(var i=fileBuffer.length-addCount; i<fileBuffer.length; i++){
				$('#fileName').html(
					$('#fileName').html()
					+'<div class="nameList">'
					+fileBuffer[i].name
					+'<div class="delFileBtn"></div></div>'
				);
			}
		}
		if(isDuple)warnFileDuple();
	});
	
	
	image.on('change',function(){
		var addCount=0;
		var isDuple=false;
		$.each(image[0].files, function(index, file){

			var isRefDuple=false;
			$.each(refImage, function(rindex, rimage){
				if(rimage==file.name){
					isRefDuple=true;
					isDuple=true;
					}
			});
			if(!isRefDuple){
			
			if(imageBuffer.length==0){
				imageBuffer.push(file);
				addCount++;
			}else{
				dupleCnt=0;
				$.each(imageBuffer, function(index2, bufferFile){
					if(bufferFile.name==file.name){
						dupleCnt++;
					}
				});
				if(dupleCnt==0){
					imageBuffer.push(file);
					addCount++;
				}
				else{
					isDuple=true;
				}
			}}
		});
		if((imageBuffer.length+ci)==0){
			$('#imageName').html('선택된 파일이 없습니다.');
		}else{
			for(var i=imageBuffer.length-addCount; i<imageBuffer.length; i++){
				var no=$('#imageName>.fileList').length+1;
				$('#imageName').html(
					$('#imageName').html()
					+'<div class="fileList">'
					+'<div class="image_pre_container"><img src="'
					+URL.createObjectURL(imageBuffer[i])
					+'" class="image_pre"></div><p class="image_pre_name"><span class="image_pre_id">&lt;Image'
					+no
					+'&gt;</span><br>'
					+imageBuffer[i].name
					+'</p><div class="delImgBtn"></div></div>'
				);
			}
		}

		if(isDuple)warnImgDuple();
	});
	
	
	
});


</script>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/board.css">
<link rel="stylesheet" href="css/post_submit.css">
<title>Lorem Ipsum:Write</title>

</head>
<body>
	<div id="top"></div>
	<%@include file="../part/topMenu.jspf"%>
	<%@include file="../part/sideMenu.jspf"%>
<div class="main">
	<div id="contents">
		<div class="topspace"></div>
		<div id="main_contents">
			<div id="boardList">

				<p>
					<b>게시판 목록</b>
				</p>
				<%
					for (BoardModel b : boardList) {
					String tstr = b.getB_name().equals(board) ? "style='font-weight:bold;'" : "";
				%>
				<p>
					<a
						href="<%=commons.baseUrl%>/board?&name=<%=URLEncoder.encode(b.getB_name(), "utf-8")%>"
						<%=tstr%>><%=b.getB_name()%></a>
				</p>
				<%
					}
				%>

			</div>
			<div id="boardInfo">
				<h3><%=board%></h3>
			</div>
			<div id="con">
				<form id="frm" method="post" enctype="multipart/form-data"
					action="<%=commons.baseUrl%>edit.do">
					<div id="setTitle">
						<h3
							style="text-align: center; margin-bottom: 10px; border-bottom: 2px solid #808080">게시글 수정</h3>
						<p>
							제목<input type="text" name="title" id="title" value='<%=title%>'>
						</p>
					</div>
					<div id="setContents">
						<p>내용</p>
						<textarea id="contents" name="contents"><%=contents%></textarea>
					</div>
					<div id="setFile">
						<div id="imageName">선택된 파일이 없습니다.</div>
						<p>
							<label for="image">사진 추가</label>
						</p>
						<br>
						<div id="fileName">선택된 파일이 없습니다.</div>
						<p>
							<label for="file">파일 첨부</label>
						</p>
					</div>
					<div style="text-align: center; height: 80px; margin-top: 20px;">
						<input class="writeBtn" type="button" value="취소"
							onclick="history.back();"> <input
							class="writeBtn" type="submit" value="수정하기">
					</div> 
					<div id='submitList' style='display: none;'></div>
				</form>

				<input type="file" accept="image/*" multiple="multiple" id="image">
				<input type="file" multiple="multiple" id="file">
			</div>
		</div>
	</div>
</div>
	<div id="bot"></div>
</body>
