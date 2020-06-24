/**
 * 
 */
function getMyPost(){
	$.ajax({
		dataType:"JSON",
		url:"../info/getUserPost?&nick="+nick,
        type : "POST",
        success: function(data){
        	if(data.length==0){
        		$("#myPostList").html("작성한 글이 없습니다.");
        		return;
        	}
        	$("#myPostList").html("");
        	for(i=0; i<data.length; i++){
        		s="<div class='linkList' onclick='location.href=\"../post?"
        			+"&name="+encodeURI(data[i]['b_name'])
        			+"&postId="+data[i]['p_id']
	        		+"\"'><p style='font-size:0.7em; color:#606060'>Date : 20"
	        		+data[i]['p_date']
	        		+"</p><p style='white-space:nowrap; overflow:hidden; text-overflow:ellipsis'>"
	        		+data[i]['p_title']
	        		+"</p><p style='font-size:0.7em; color:#606060'>View : "
	        		+data[i]['p_view']
        			+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Like : "
        			+data[i]['p_like']
        			+"</p></div>";
        		$("#myPostList").html($("#myPostList").html()+s);
        	}
        },
        error:function(err){
        	console.log(err);
        }
	});
}

function getMyReply(){
	$.ajax({
		dataType:"JSON",
		url:"../info/getUserReply?&nick="+nick,
        type : "POST",
        success: function(data){
        	console.log(data);
        	if(data.length==0){
        		$("#myReplyList").html("작성한  댓글이 없습니다.");
        		return;
        	}
        	$("#myReplyList").html("");
        	for(i=0; i<data.length; i++){
        		s="<div class='linkList' onclick='location.href=\"../post?"
        			+"&name="+encodeURI(data[i]['b_name'])
        			+"&postId="+data[i]['p_id']
	        		+"&hl="
	        		+data[i]['r_index']
	        		+"\"'><p style='font-size:0.7em; color:#606060'>Date : 20"
	        		+data[i]['r_date']
	        		+"</p><p style='white-space:nowrap; overflow:hidden; text-overflow:ellipsis'>"
	        		+data[i]['contents']
	        		+"</p><p style='font-size:0.7em; color:#606060'>Like : "
        			+data[i]['r_like']
        			+"</p></div>";
        		$("#myReplyList").html($("#myReplyList").html()+s);
        	}
        },
        error:function(err){
        	console.log(err);
        }
	});
}


