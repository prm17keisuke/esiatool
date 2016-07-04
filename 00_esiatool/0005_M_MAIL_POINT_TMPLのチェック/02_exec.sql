conn &1./&1.@&2
column log_date new_value log_date_text noprint
select to_char(sysdate,'yyyymmdd') log_date from dual;
spool log/02_select_&1._&log_date_text..log;
show user
set linesize 2000
set pagesize 50

select * from M_MAIL_POINT_TMPL;

--rollback;
--commit;
spool off
exit
