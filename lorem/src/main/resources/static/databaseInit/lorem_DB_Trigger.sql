--------------------------------------------------------
--  파일이 생성됨 - 월요일-6월-29-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger LIKE_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."LIKE_TRIGGER" 
BEFORE INSERT ON LIKE_POST 
for each row
BEGIN
select
to_char(sysdate, 'YY/MM/DD')||
to_char(sysdate,' HH24:')||
to_char(sysdate,'MI:')||
to_char(sysdate,'ss')
into :new.l_date from dual;



END;
/
ALTER TRIGGER "ADMIN"."LIKE_TRIGGER" ENABLE;
--------------------------------------------------------
--  DDL for Trigger POST_CONTENTS_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."POST_CONTENTS_TRIGGER" 
AFTER INSERT ON POST_INFO 
FOR EACH ROW
BEGIN
insert into post_contents values(null, :new.p_id, :new.b_name);
END;
/
ALTER TRIGGER "ADMIN"."POST_CONTENTS_TRIGGER" ENABLE;
--------------------------------------------------------
--  DDL for Trigger POST_DELETE_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."POST_DELETE_TRIGGER" 
before DELETE ON POST_INFO 
for each row
BEGIN
delete post_contents
where :old.p_id=p_id and :old.b_name= b_name;
delete post_clip
where :old.p_id=p_id and :old.b_name= b_name;
delete reply
where :old.p_id=p_id and :old.b_name= b_name;
delete like_post
where :old.p_id=p_id and :old.b_name= b_name;
delete like_reply
where :old.p_id=p_id and :old.b_name= b_name;
END;
/
ALTER TRIGGER "ADMIN"."POST_DELETE_TRIGGER" ENABLE;
--------------------------------------------------------
--  DDL for Trigger REPLY_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."REPLY_TRIGGER" 
BEFORE INSERT ON REPLY 
FOR EACH ROW

DECLARE cnt NUMBER;

BEGIN
select count(*) into cnt from reply where p_id=:new.p_id;
select
to_char(sysdate, 'YY/MM/DD')||
to_char(sysdate,' HH24:')||
to_char(sysdate,'MI:')||
to_char(sysdate,'ss')
into :new.r_date from dual;
select 0 into :new.r_like from dual;
if cnt=0 then
select 0 into :new.r_index from dual;
else
select max(r_index)+1 into :new.r_index from reply where :new.p_id=p_id;
end if;
if :new.r_lock is null then
select 'n' into :new.r_lock from dual;
end if;
END;
/
ALTER TRIGGER "ADMIN"."REPLY_TRIGGER" ENABLE;
--------------------------------------------------------
--  DDL for Trigger RLIKE_TRIG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."RLIKE_TRIG" 
before INSERT ON LIKE_REPLY 
for each row
BEGIN
    select
to_char(sysdate, 'YY/MM/DD')||
to_char(sysdate,' HH24:')||
to_char(sysdate,'MI:')||
to_char(sysdate,'ss')
into :new.l_date from dual;

update reply
set r_like=r_like+1
where b_name=:new.b_name
and p_id=:new.p_id
and r_index=:new.r_index;
END;
/
ALTER TRIGGER "ADMIN"."RLIKE_TRIG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger RUNLIKE_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN"."RUNLIKE_TRIGGER" 
BEFORE DELETE ON LIKE_REPLY 
for each row
BEGIN
update reply
set r_like=r_like-1
where b_name=:old.b_name
and p_id=:old.p_id
and r_index=:old.r_index;
END;
/
ALTER TRIGGER "ADMIN"."RUNLIKE_TRIGGER" ENABLE;
