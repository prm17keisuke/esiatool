conn &1./&1.@&2
column log_date new_value log_date_text noprint
select to_char(sysdate,'yyyymmdd') log_date from dual;
spool log/02_update_&1._&log_date_text..log;
show user
set linesize 2000
set pagesize 50

select pd.PORTABLE_DOCUMENT_NO
  , pd.DOCUMENT_TITLE 
  , to_char(pd.DOCUMENT_HEADER) as DOCUMENT_HEADER
  , pd.PORTABLE_DOCUMENT_DIV
  , pd.ENTERPRISE_CD
  , pd.DISPLAY_NO
  , pd.DISPLAY_SIGN
  , pd.TIMESTAMP
  , pd.UPDATER
  , pd.DELETE_SIGN
  from M_PORTABLE_DOCUMENT pd where pd.DOCUMENT_HEADER like '%‚o‚b[P_LOGIN_URL]%' and pd.PORTABLE_DOCUMENT_DIV = '23';

update M_PORTABLE_DOCUMENT 
  set UPDATER = 'esia'||to_char(sysdate,'yymmdd')
    , DOCUMENT_HEADER = replace(DOCUMENT_HEADER, '‚o‚b[P_LOGIN_URL]', '')
  where DOCUMENT_HEADER like '%‚o‚b[P_LOGIN_URL]%' and PORTABLE_DOCUMENT_DIV = '23';

select pd.PORTABLE_DOCUMENT_NO
  , pd.DOCUMENT_TITLE 
  , to_char(pd.DOCUMENT_HEADER) as DOCUMENT_HEADER
  , pd.PORTABLE_DOCUMENT_DIV
  , pd.ENTERPRISE_CD
  , pd.DISPLAY_NO
  , pd.DISPLAY_SIGN
  , pd.TIMESTAMP
  , pd.UPDATER
  , pd.DELETE_SIGN
  from M_PORTABLE_DOCUMENT pd where pd.PORTABLE_DOCUMENT_DIV = '23';

--rollback;
commit;
spool off
exit
