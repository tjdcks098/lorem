		let 	rain_target = 30;
		let 	rain_num = 0;// 빗방울 갯수
		const 	rain_max = 250;// 빗방울 최대치
		var 	rain_speed = 120;// 1/60초당 픽셀 움직임(x+y)
		var 	fps=60;
		var 	fCount=0;
		const	delay_max = 60;// 딜레이 최대 (최대 .5초)
		let     defaultRandRange=1000;
		let 	rain_extra=1;
		let		cx = new Array(rain_max);// x좌표
		let		cy = new Array(rain_max);// y좌표
		let		dx = new Array(rain_max);// x변화량
		let		dy = new Array(rain_max);// y변화량
		let		rt= new Array(rain_max);// 랜덤 토큰
		let		ps=new Array(rain_max);// 개인 속도
		let		distance=new Array(rain_max);// 거리
		let		end_line = new Array(rain_max);// 떨어질 y 좌표
		let		end_line_max;// y좌표 최대치
		let		delay = new Array(rain_max);// 생성 텀
		let		delay_count=new Array(rain_max);
		let		wave = new Array(rain_max);// 파장 프레임
		let		wave_size = new Array(rain_max);// 회면 너비에 따른 파장 크기
		let		win_width;// 창 너비
		let		canvas;// 캔버스
		let		step=new Array(rain_max);// 현 단계
		let		tilt_curr=(Math.random()-0.5)*0.3;// 기울기
		let		tilt_target=0.5;
		var 	tilt_change=0;
		let		tilt_acceleration=0.000025;
		let 	tilt_change_term=300;
		let 	tilt_count=0;
		const 	tilt_dist=0.4;
		let 	work=true;
		let 	ellipde_err=false;
		let 	debugCount=0;
		let 	c=new Array(6);
		let 	debugBool=false;
		var animation;
		var isStop=false;
		var isAuto=true;
		var draw=true;
		
		function img_preload(img_arr){
			let len=img_arr.length;
			for(let i=0; i<len; i++){
				let img=new Image();
				img.src=img_arr[i];
			}
		}
		img_preload([
			"source/rain_floor_water_wet_drops-1351257.jpg"
		])
		function fpss(obj){
			let t=Number(obj.value);
			let mx=Number($('#fps').attr('max'));
			let mn=Number($('#fps').attr('min'));
			if(t>mx){
				$('#fps').val(mx);
				$('#fpstx').val(mx);
				fps=mx;
			}else if(t<mn){
				$('#fps').val(mn);
				$('#fpstx').val(mn);
				fps=mn;
			}else{
				$('#fps').val(t);
				$('#fpstx').val(t);
				fps=t;
			}
		}
		
		function ndc(obj){
			let t=Number(obj.value);
			let mx=Number($('#numDrop').attr('max'));
			let mn=Number($('#numDrop').attr('min'));
			if(t>mx){
				$('#numDrop').val(mx);
				$('#numDroptx').val(mx);
			}else if(t<mn){
				$('#numDrop').val(mn);
				$('#numDroptx').val(mn);
			}else{
				$('#numDrop').val(t);
				$('#numDroptx').val(t);
			}
		}
		function dac(obj){
			let t=Number(obj.value);
			let mx=Number($('#dropAngle').attr('max'));
			let mn=Number($('#dropAngle').attr('min'));
			if(t>mx){
				$('#dropAngle').val(mx);
				$('#dropAngletx').val(mx);
			}else if(t<mn){
				$('#dropAngle').val(mn);
				$('#dropAngletx').val(mn);
			}else{
				$('#dropAngle').val(t);
				$('#dropAngletx').val(t);
			}
		}
		function init(){
			for(let i=0; i<rain_max; i++)step[i]=0;
			for(let i=0; i<6; i++)c[i]=0;
			canvas= document.getElementById('rain').getContext('2d');
			canvas.strokeStyle = "rgb(255,255,255)";
			canvas.lineWidth=5;
			if(sessionStorage.getItem("rain")=="false"){
				document.getElementById('toggleRain').checked=true;
				isStop=true;
			}else{
				animation=setInterval(cycle,1000/120);
			}
		}
		function debugtg(){
			debugBool=$('#debug').is(":checked");
		}
		function autotg(){
			isAuto=$('#ro_auto').is(":checked");
			$("#numDrop").attr("disabled",isAuto);
			$("#randRange").attr("disabled",isAuto);
			$("#dropAngle").attr("disabled",isAuto);
			$("#dropSpeed").attr("disabled",isAuto);
			$("#numDroptx").attr("disabled",isAuto);
			$("#randRangetx").attr("disabled",isAuto);
			$("#dropAngletx").attr("disabled",isAuto);
			$("#dropSpeedtx").attr("disabled",isAuto);
		}
		
		function tgRain(ck){
			if(ck.checked){
				work=false;
				for(let i=0; i<rain_max;i++){
					if(step[i] ==0||step[i] ==1) step[i]=4;
				}
				sessionStorage.setItem("rain", false);
			}
			else {
				work=true;
				if(isStop){
					animation=setInterval(cycle,1000/120);
					isStop=false;
				}
				sessionStorage.setItem("rain", true);
			}
		}
		function adapt(){
			fCount++;
			if(fCount>720000)fCount=0;
			win_width=Math.floor(window.innerWidth+5);
			end_line_max=Math.floor(document.getElementById('gra').clientHeight-150);
			draw=fCount%(120/fps)<1?true:false;
			if(draw)canvas.clearRect(0,0,win_width, document.getElementById('gra').clientHeight);
			if(work&&isAuto){
				if(tilt_count<tilt_change_term){
					lt= tilt_change_term - tilt_count;
					gap= tilt_target- tilt_curr;
					n= gap/Math.abs(gap);
					aps= n*tilt_acceleration;
					if(Math.abs(gap)<=tilt_acceleration*120){
						tilt_change=0;
						tilt_curr= tilt_target;
					}
					else{
						if(Math.abs(tilt_change*120) > Math.abs(gap)){
							tilt_change-=aps;
						}else{
							tilt_change+=aps;
						}
					}
					if(tilt_change>0.005)tilt_change=0.005;
					if(tilt_change<-0.005)tilt_change=-0.005;
					tilt_curr+= tilt_change;
					if(tilt_curr<-0.5){
						tilt_curr=-0.5;
						tilt_change=0;
					}
					if(tilt_curr>0.5){
						tilt_curr=0.5;
						tilt_change=0;
					}
					if(Math.abs(rain_num-rain_target)>0.01)rain_num=(rain_num>rain_target)?rain_num-0.11:rain_num+0.11;
					
				}
				else{
					tilt_target=Math.floor((Math.random()-0.5)*10000)/10000;
					tilt_count=0;
					tilt_change_term=900+Math.floor(1200*Math.random());
					rain_extra=(0.5+Math.random()*2.5);

				}
				tilt_count++;
				rain_speed=60*(1+Math.abs(tilt_curr));
				rain_target=Math.floor((win_width/30)*rain_extra);
				rain_num=Math.floor(rain_num*10)/10;
				rain_num=(rain_num>rain_max)?rain_max:rain_num;
			}
			let tn=Math.floor(rain_num);
			let tt=Math.floor(tilt_curr*1000);
			let ts=Math.floor(rain_speed*100);
			if(isAuto){
			$("#numDrop").val(tn);
			$("#dropAngle").val(tt);
			
			$("#numDroptx").val(tn);
			$("#dropAngletx").val(tt);
			}else{
				tilt_curr=$("#dropAngle").val()/1000;
				rain_num=$("#numDrop").val();
			}
		}
		function newrand(){
			let re=[300,250,180,135,90,45];
			let sw=0;
			sw=Math.random()*defaultRandRange;
			if(sw<re[0]){
				return (sw/re[0])*(1/6);
			}
			else{ 
				sw-=re[0];
			}
			if(sw<re[1]){
				return (sw/re[1])*(1/6)+1/6;
			}
			else{
				sw-=re[1];
			}
			if(sw<re[2]){
				return (sw/re[2])*(1/6)+2/6;
			}
			else {
				sw-=re[2];
			}
			if(sw<re[3]){
				return (sw/re[3])*(1/6)+3/6;
			}
			else {
				sw-=re[3];
			}
			if(sw<re[4]){
				return (sw/re[4])*(1/6)+4/6;
			}
			else{
				sw-=re[4];
				return (sw/re[5])*(1/6)+5/6;
			}
		}

		function reset(a){
			rt[a]=newrand();
			distance[a]=rt[a]*0.75+0.25;
			cx[a]=Math.floor((win_width*1.2+end_line_max *Math.abs(tilt_curr))*Math.random() - win_width*0.1 - end_line_max * tilt_curr*0.8);
			cy[a]=0;

			ps[a]=rain_speed*distance[a];
			dx[a]=ps[a]*((Math.random()-0.5)*tilt_curr*tilt_dist+tilt_curr);

			dy[a]=ps[a]- Math.abs(dx[a]);
			end_line[a]=30+end_line_max*rt[a];
			delay[a]=delay_max*Math.random();
			delay_count[a]=0;
			wave[a]=1;
			wave_size[a]=10*Math.pow(distance[a],1.2);
			step[a]=1;
			c[Math.floor((end_line[a]-30)/(end_line_max/6))]++;
			
		}

		function fdelay(a){
			delay_count[a]++;
			if(delay[a]<delay_count[a])step[a]=2;
			if(tilt_count==0)step[a]=0;
		}

		function debugcolor(a){
			if(end_line[a]<30+end_line_max/6){
				return "255,100,100";
			}
			if(end_line[a]<30+end_line_max*2/6){
				return "100,255,100";
			}				
			if(end_line[a]<30+end_line_max*3/6){
				return "100,100,255";
			}				
			if(end_line[a]<30+end_line_max*4/6){
				return "255,255,100";
			}				
			if(end_line[a]<30+end_line_max*5/6){
				return "255,100,255";
			}
			return "100,255,255";
		}

		function drop(a){
			if(step[a]==2){
				if(draw){
					canvas.save();
					if(debugBool)canvas.strokeStyle="rgb("+debugcolor(a)+")";
					canvas.lineWidth=Math.floor(4*distance[a])+1;
					canvas.beginPath();
					canvas.moveTo(cx[a],cy[a]);
				}
				cx[a]+=dx[a];
				cy[a]+=dy[a];
				if(cy[a]>=end_line[a])
				{
					step[a]=3;
					
					cx[a]-=dx[a]*(cy[a]-end_line[a])/dy[a];
					cy[a]=end_line[a];
				}
				if(draw){
					if(cy[a]+ dy[a]>end_line[a])
						canvas.lineTo(cx[a]+ dx[a]*(end_line[a]-cy[a])/dy[a], end_line[a]);
					else{
						canvas.lineTo(cx[a]+ dx[a], cy[a]+ dy[a]);
					}
					canvas.stroke();
					canvas.restore();
				}
			}
			if(cy[a]+ dy[a]>end_line[a]||step[a]==3)
			fwave(cx[a]+ dx[a]*(end_line[a]-cy[a])/dy[a], end_line[a], a);
		}
		
		function fwave(x,y,a){
			let w2=wave[a]-3;
			let w3=w2-5;
			let ex=Math.pow(wave_size[a]*wave[a],0.8)*2;
			let ex2=Math.pow(wave_size[a]*w2,0.8)*2;
			let ex3=Math.pow(wave_size[a]*w3,0.8)*2;
			if(draw){
				if(wave[a]<31){
					canvas.save();
					
					if(debugBool)canvas.strokeStyle= "rgba("+debugcolor(a)+","+Math.pow((30-wave[a])/30,2)+")";
					else canvas.strokeStyle= "rgba(255,255,255,"+Math.pow((30-wave[a])/30,2)+")";
					canvas.lineWidth=Math.floor(distance[a]*(10/wave[a]))+1;
						canvas.scale(1,0.26);
						canvas.beginPath();
						canvas.arc(x,y*3.84,ex,0,2*Math.PI);
						canvas.stroke();
						canvas.restore();
				}
				if(w2>0&&w2<31){
					canvas.save();
					if(debugBool)canvas.strokeStyle= "rgba("+debugcolor(a)+","+Math.pow((30-w2)/30,2)+")";
					else canvas.strokeStyle= "rgba(255,255,255,"+Math.pow((30-w2)/30,2)+")";
					canvas.lineWidth=Math.floor(distance[a]*(10/w2))+1;
					canvas.scale(1,0.26);
					canvas.beginPath();
					canvas.arc(x,(y-(5/w2)*distance[a]*distance[a])*3.84,ex2,0,2*Math.PI,true);
					canvas.stroke();
					canvas.restore();
				}
				if(w3>0){
					canvas.save();
					if(debugBool)canvas.strokeStyle= "rgba("+debugcolor(a)+","+Math.pow((30-w3)/35,2)+")";
					else canvas.strokeStyle= "rgba(255,255,255,"+Math.pow((30-w3)/35,2)+")";
					canvas.lineWidth=Math.floor(distance[a]*(3/w3))+1;
					canvas.scale(1,0.26);
					canvas.beginPath();
					canvas.arc(x,y*3.84,ex3,0,2*Math.PI,true);
					canvas.stroke();
					canvas.restore();
				}
			}
			if(w3>31)step[a]=4;
			wave[a]+=0.5;
		}
		function stop(a){
			if(work)step[a]=0;
		}
		function debug(){
			canvas.save();
			canvas.strokeStyle="rgb(255,10,10)";
			canvas.lineWidth=4;
			canvas.beginPath();
			canvas.arc(win_width*0.4,200,70,70,0,2*Math.PI,true);
			canvas.stroke();
			canvas.closePath();
			canvas.beginPath();
			canvas.moveTo(win_width*0.4-60*tilt_curr,140);
			canvas.lineTo(win_width*0.4+60*tilt_curr,260);
			canvas.stroke();
			canvas.closePath();
			canvas.lineWidth=2;
			canvas.font="30px serif";
			canvas.strokeText("DEBUG",win_width*0.4+100,100);
			canvas.strokeText("change_time:		"+Math.round((tilt_change_term-tilt_count)/12)/10,win_width*0.4+100,140);
			canvas.strokeText("tilt:		"+Math.round(tilt_curr*1000)/10,win_width*0.4+100,170);
			canvas.strokeText("target:		"+Math.round(tilt_target*1000)/10,win_width*0.4+100,200);
			canvas.strokeText("rain_num:		"+rain_num,win_width*0.4+100,230);
			canvas.strokeText("rain_speed:		"+Math.round(rain_speed),win_width*0.4+100,290);
			canvas.strokeText("rain_target:		"+rain_target,win_width*0.4+100,260);
			let dh=end_line_max/6;
			let ct=0;
			for(let i=0;i<6;i++)ct+=c[i];
			canvas.strokeText(Math.floor(c[0]*1000/ct)/10+"%   		"+c[0],20,140);
			canvas.strokeStyle="rgb(100,255,100)";
			canvas.strokeText(Math.floor(c[1]*1000/ct)/10+"%   		"+c[1],20,170);
			canvas.strokeStyle="rgb(100,100,255)";
			canvas.strokeText(Math.floor(c[2]*1000/ct)/10+"%   		"+c[2],20,200);
			canvas.strokeStyle="rgb(255,255,100)";
			canvas.strokeText(Math.floor(c[3]*1000/ct)/10+"%   		"+c[3],20,230);
			canvas.strokeStyle="rgb(255,100,255)";
			canvas.strokeText(Math.floor(c[4]*1000/ct)/10+"%   		"+c[4],20,260);
			canvas.strokeStyle="rgb(100,255,255)";
			canvas.strokeText(Math.floor(c[5]*1000/ct)/10+"%   		"+c[5],20,290);
			canvas.restore();
		}
		function cycle(){
			adapt();
			
			if(debugBool&&draw)debug();
			let count=0;
				for(let i=0; i<rain_max; i++){
				switch(step[i]){
					case 0:// 초기화
					if(i>rain_num)break;
					reset(i);
					break;
					case 1:// 딜레이
					fdelay(i);
					break;
					case 2:// 내리기
					case 3:// 파장
					drop(i);
					break;
					case 4:// 멈춤
					stop(i);
					count++;
					break;
				}
			}

			if(!work&&count==rain_max){
				clearInterval(animation);
				isStop=true;
			}
		}