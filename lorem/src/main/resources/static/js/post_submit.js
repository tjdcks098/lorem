




$(document).on('click','.delImgBtn', function(){
	const i_index= $(this).parent().index();
	imageBuffer.splice(i_index, 1);
	$('#imageName>.fileList:nth-child('+(i_index+1)+')').remove();

	if(imageBuffer.length==0){
		$('#imageName').html('선택된 파일이 없습니다.');
	}
	
	

});
$(document).on('click','.delFileBtn', function(){
	const f_index= $(this).parent().index();
	fileBuffer.splice(f_index, 1);
	$('#fileName>.nameList:nth-child('+(f_index+1)+')').remove();
	if(fileBuffer.length==0){
		$('#fileName').html('선택된 파일이 없습니다.');
	}
});

$(document).ready(function(){
	
	var file=$('#file');
	var image=$('#image');
	imageBuffer=[];
	fileBuffer=[];


	$('#frm').ajaxForm({
		dataType:'text',
		contentType : false,
		processData : false,
		enctype: "multipart/form-data",
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

    		var board={name:"board", value:$("#board").val()};
    		data.push(board);
    		
            
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
		$('#fileName').html('');
		$.each(file[0].files, function(index, file){
			if(fileBuffer.length==0){
				fileBuffer.push(file);
			}else{
				dupleCnt=0;
				$.each(fileBuffer, function(index2, bufferFile){
					if(bufferFile.name==file.name){
						dupleCnt++;
					}
				});
				if(dupleCnt==0)fileBuffer.push(file);
				else{
					alert("이름이 같은 파일은 동시에 업로드 할 수 없습니다.");
				}
			}
		});
		if(fileBuffer.length==0){
			$('#fileName').html('선택된 파일이 없습니다.');
		}else{
			$.each(fileBuffer, function(index3, file){
				$('#fileName').html(
					$('#fileName').html()
					+'<div class="nameList">'
					+file.name
					+'<div class="delFileBtn"></div></div>'
				);
			});
		}
	});
	
	
	image.on('change',function(){
		$('#imageName').html('');
		$.each(image[0].files, function(index, file){
			if(imageBuffer.length==0){
				imageBuffer.push(file);
			}else{
				dupleCnt=0;
				$.each(imageBuffer, function(index2, bufferFile){
					if(bufferFile.name==file.name){
						dupleCnt++;
					}
				});
				if(dupleCnt==0)imageBuffer.push(file);
				else{
					alert("이름이 같은 파일은 동시에 업로드 할 수 없습니다.");
				}
			}
		});
		if(imageBuffer.length==0){
			$('#imageName').html('선택된 파일이 없습니다.');
		}else{
			$.each(imageBuffer, function(index3, image){
				var no=$('#imageName>.fileList').length+1;
				$('#imageName').html(
					$('#imageName').html()
					+'<div class="fileList">'
					+'<div class="image_pre_container"><img src="'
					+URL.createObjectURL(image)
					+'" class="image_pre"></div><p class="image_pre_name"><span class="image_pre_id">&lt;Image'
					+no
					+'&gt;</span><br>'
					+image.name
					+'</p><div class="delImgBtn"></div></div>'
				);
			});
		}
	});
	
	
	
});
