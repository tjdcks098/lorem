--------------------------------------------------------
--  파일이 생성됨 - 월요일-6월-29-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure CON_CHECK
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."CON_CHECK" 
(
  IDIN IN VARCHAR2
, session_id in varchar2
, msg_out OUT varchar2
) is
fid varchar2(20);
fss varchar2(20);
fdt varchar2(20);
BEGIN
    select max(u_id) into fid
    from acc_pub
    where u_id=idin;
    select max(u_id) into fss
    from acc_con
    where u_id=idin and u_session=session_id;    
    select u_discontime into fdt
    from acc_con
    where u_id=idin and u_session=session_id;
    
    if fid is null then
        msg_out:='INVALID:허용되지 않은 접근';
    elsif fss is null then 
        msg_out:='INVALID:알 수 없는 연결';
    elsif fdt is not null then 
        msg_out:='INVALID:세션 만료';
    else 
        msg_out:='VALID';
    end if;
END CON_CHECK;

/
--------------------------------------------------------
--  DDL for Procedure DEL_POST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."DEL_POST" (
uid in varchar2
, pid in number
,bname in varchar2
) AS 
idck varchar2(5);
BEGIN
select 
    case when count(*)=0 then 'f'
    else 't'
    end into idck
from post_info
where u_id=uid and b_name=bname and p_id=pid;

delete like_post where b_name=bname and p_id=pid;
delete post_clip where b_name=bname and p_id=pid;
delete post_contents where b_name=bname and p_id=pid;
delete post_info where b_name=bname and p_id=pid;
delete reply where b_name=bname and p_id=pid;

END DEL_POST;

/
--------------------------------------------------------
--  DDL for Procedure DELFILE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."DELFILE" (
pid in number,
bname in varchar2,
furl in varchar2
)AS 
tg varchar2(10);
BEGIN
    select f_type into tg
    from post_clip
    where f_url=furl;
    
    update post_clip
    set f_type = 'img'||(TO_NUMBER(substr(f_type,4))-1)
    where pid=p_id and bname=b_name and f_type>tg;
    
    delete from post_clip
    where f_url=furl;
END DELFILE;

/
--------------------------------------------------------
--  DDL for Procedure EDITCONTENTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."EDITCONTENTS" (
pid in number
,bname in varchar2
,pcontents in varchar2
) AS 
BEGIN
update post_contents
set
    p_contents=pcontents
where b_name=bname and p_id=pid;

END EDITCONTENTS;

/
--------------------------------------------------------
--  DDL for Procedure EDITPOST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."EDITPOST" (
pid in number
,bname in varchar2
,title in varchar2
)AS 
BEGIN
update post_info
set
    p_title = title,
    p_date = to_char(sysdate, 'YY/MM/DD')||
        to_char(sysdate,' HH24:')||
        to_char(sysdate,'MI:')||
        to_char(sysdate,'ss'),
    p_update='true'
where p_id=pid and b_name=bname;

END EDITPOST;

/
--------------------------------------------------------
--  DDL for Procedure FINDID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."FINDID" (
uname in varchar2,
uemail in varchar2,
uid out varchar2
) AS 
BEGIN
   select  max(u_id) into uid
   from acc_pri
   where u_name=uname and u_email=uemail;
END FINDID;

/
--------------------------------------------------------
--  DDL for Procedure FINDPW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."FINDPW" (
uid in varchar2,
 uname in varchar2,
uemail in varchar2,
upw out varchar2,
uhint out varchar2
) AS 
BEGIN
   select  max(u_pw) into upw
   from acc_pri
   where u_name=uname and u_email=uemail and u_id=uid;
   select  max(find_hint) into uhint
   from acc_inf
   where u_id=uid;
END FINDPW;

/
--------------------------------------------------------
--  DDL for Procedure GETPOSTINFO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."GETPOSTINFO" 
(
  pTITLE OUT VARCHAR2 
, pview OUT VARCHAR2 
, uid OUT VARCHAR2 
, unick OUT VARCHAR2 
, pdate OUT VARCHAR2 
, pid in NUMBER 
, pupdate OUT VARCHAR2 
, plike OUT VARCHAR2 
, bname IN VARCHAR2 
, hasprev OUT VARCHAR2 
, HASNEXT OUT VARCHAR2 
) AS


BEGIN
select p_title, p_view, u_id, p_date, p_update, p_like
into ptitle, pview, uid, pdate, pupdate, plike 
from post_info
where p_id=pid and b_name=bname;
select u_nick into unick from acc_pub where u_id= uid;


select 
case
    when count(*) > 0 then 'true'
    else 'false'
end as bool into hasprev
    from post_info
where b_name=bname and p_id<pid;

select 
case
    when count(*) > 0 then 'true'
    else 'false'
end as bool into hasnext
    from post_info
where b_name=bname and p_id>pid;


END GETPOSTINFO;

/
--------------------------------------------------------
--  DDL for Procedure JOIN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."JOIN" 
(
  IDIN IN VARCHAR2 
, PWIN IN VARCHAR2 
, NICIN IN VARCHAR2 
, namein in varchar2
, HINTIN IN VARCHAR2 
, emailin in varchar2
, PHIN IN VARCHAR2 
, BIRTHIN IN VARCHAR2 
,reval out varchar2
) AS 
BEGIN
select 'false' into reval from dual;
insert into acc_pub VALUES(idin, nicin, null, null, to_char(sysdate, 'YY/MM/DD')||
to_char(sysdate,' HH24:')||
to_char(sysdate,'MI:')||
to_char(sysdate,'ss'),9 );

insert into acc_pri VALUES(idin, null, null, phin, emailin, pwin, birthin, namein);
insert into acc_inf VALUES('y','y',hintin,null, idin);

select 'true' into reval from dual;
END JOIN;

/
--------------------------------------------------------
--  DDL for Procedure LIKE_PROC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."LIKE_PROC" 
(
  UID IN VARCHAR2 
, PID IN numeric
, bname in varchar2
) is
BEGIN

insert into like_post VALUES(uid, pid, null, bname);

update post_info set
p_like=(select count(*) from like_post l where l.p_id=pid and l.b_name=bname)
where p_id=pid and b_name=bname;

commit;
END LIKE_PROC;

/
--------------------------------------------------------
--  DDL for Procedure LOGIN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."LOGIN" 
(
PWIN IN VARCHAR2 
, idin IN VARCHAR2 
, nick out VARCHAR2 
, sessionid out VARCHAR2
, ulevel out numeric 
) is
id_exist varchar2(10);
isConnected varchar2(10);
isDuple number(3);
BEGIN
select 
    case 
    when count(*) = 0 then 'false'
    else 'true'
    end into id_exist
from acc_pri
where u_id=idin and pwin=u_pw;

select 
    case 
    when count(*) = 0 then 'false'
    else 'true'
    end into isConnected
from acc_con a
where u_id=a.u_id and u_discontime is null;


if id_exist='false' then 
select 'FAIL:ID_NOT_EXIST' into sessionid from dual;
return;
end if;

if isConnected ='true' then
update acc_con 
set
u_discontime = 
    to_char(sysdate, 'YY/MM/DD')||to_char(sysdate,' HH24:')||
    to_char(sysdate,'MI:')||to_char(sysdate,'ss')
,msg = 'LOGIN_OTHER_PLACE'
where u_id=idin and u_discontime is null;

end if;

isduple:=1;
while isduple != 0
loop
select to_char(TRUNC(dbms_random.value(100000000000000,999999999999999))) into sessionid from dual;
select count(*) into isduple from acc_con where u_session=sessionid and u_id=idin and u_discontime is null;
end loop;



insert into acc_con values(
to_char(sysdate, 'YY/MM/DD')||
to_char(sysdate,' HH24:')||
to_char(sysdate,'MI:')||
to_char(sysdate,'ss'), idin, sessionid, null, null);
commit;

select u_nick, u_level into nick,ulevel from acc_pub where u_id=idin;

END login;

/
--------------------------------------------------------
--  DDL for Procedure LOGOUT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."LOGOUT" 
(
  IDIN IN VARCHAR2 
, SESSION_ID IN VARCHAR2 
) is
BEGIN
update acc_con
set 
    u_discontime = 
        to_char(sysdate, 'YY/MM/DD')||
        to_char(sysdate,' HH24:')||
        to_char(sysdate,'MI:')||
        to_char(sysdate,'ss')
where
u_id = idin and u_session = session_id;

END LOGOUT;

/
--------------------------------------------------------
--  DDL for Procedure NEWPOST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."NEWPOST" (
np_title in varchar2,
nu_id in varchar2,
nb_name in varchar2,
np_id in out number
) AS 
np_date varchar2(20);
np_lock VARCHAR2(10);
np_like number(38);
np_view number(38);
BEGIN

np_date :=
    to_char(sysdate, 'YY/MM/DD')||
    to_char(sysdate,' HH24:')||
    to_char(sysdate,'MI:')||
    to_char(sysdate,'ss');

np_view:=0;
np_like:=0;

select max(p_id) into np_id 
from post_info
where b_name=nb_name;

if np_id is null then np_id:=0;
end if;

np_id:=np_id+1;

if  np_lock is null then
np_lock:='n';
end if;


insert into post_info values(
    np_title,
    np_view,
    np_lock,
    nu_id,
    np_date,
    nb_name,
    np_id,
    null,
    np_like
);

END NEWPOST;

/
--------------------------------------------------------
--  DDL for Procedure UNLIKE_PROC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."UNLIKE_PROC" 
(
  dU_ID IN VARCHAR2 
, dP_ID IN NUMBER 
, db_name in varchar2
) AS 
BEGIN
delete from like_post where p_id=dp_id and u_id=du_id;
update post_info  set
p_like=(select count(*) from like_post l where l.p_id=dp_id)
where p_id= dp_id and b_name=db_name;
commit;
END UNLIKE_PROC;

/
--------------------------------------------------------
--  DDL for Procedure VIEW_COUNT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."VIEW_COUNT" 
(
  nP_ID IN number
  ,nb_name in varchar2
) AS 
BEGIN
  update post_info SET p_view=p_view+1
  where p_id = np_id and b_name=nb_name;
  commit;
END VIEW_COUNT;

/
--------------------------------------------------------
--  DDL for Procedure WITHDRAW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ADMIN"."WITHDRAW" 
(
  IDIN IN VARCHAR2
) AS 

b number(38);
BEGIN
select count(*) into b from acc_con where idin=u_id;
if b>-1 then
delete from acc_con where idin= u_id;
delete from acc_inf where idin=u_id;
delete from acc_pri where idin=u_id;
delete from acc_pub where idin = u_id;
delete from reply where idin=u_id;
delete from post_contents where p_id in (select p_id from post_info where u_id=idin);
delete from post_info where u_id=idin;
delete from like_post where u_id=idin;
end if;
commit;
END WITHDRAW;

/
