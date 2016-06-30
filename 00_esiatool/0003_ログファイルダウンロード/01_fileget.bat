rem @echo off
rem 環境設定(START) ==============================

rem WinSCP実行ファイルパス
set WINSCP_EXE="C:\Program Files\WinSCP/winscp.exe"

rem APサーバ接続情報
set AP1_INFO="weblogic:anesta-ap@172.16.1.20"
set AP2_INFO="weblogic:anesta-ap@172.16.1.30"

rem WEBサーバ接続情報
set WEB_INFO="esadmin:2HQVxDT4@172.16.1.10"

rem 環境設定(END) ================================

rem カレントパス
set CURRENT_PATH=%~p0

rem ファイル名
set AP_LOGFILE_NAME=CustomLog.log
set WEB_LOGFILE_NAME=error_log

rem AP ログファイルディレクトリ
set AP_LOG_DIR=/home/weblogic/anesta/webAppLogs
set WEB_LOG_DIR=/usr/local/apache2/logs

rem 日時「YYYYMMDDHHMMSS」
set time_tmp=%time: =0%
set DATE_STR=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%

rem 保存用フォルダ
set SAVE_FOLDER=log\%DATE_STR%
mkdir %SAVE_FOLDER%

rem AP1ログファイル取得実行
%WINSCP_EXE% /console /script=winscp_src\log_get.txt /parameter %AP1_INFO% %AP_LOG_DIR% %AP_LOGFILE_NAME% %AP_LOGFILE_NAME%.1
move C:\%AP_LOGFILE_NAME% %CURRENT_PATH%\%SAVE_FOLDER%\AP1_%AP_LOGFILE_NAME%
move C:\%AP_LOGFILE_NAME%.1 %CURRENT_PATH%\%SAVE_FOLDER%\AP1_%AP_LOGFILE_NAME%.1

rem AP2ログファイル取得実行
%WINSCP_EXE% /console /script=winscp_src\log_get.txt /parameter %AP2_INFO% %AP_LOG_DIR% %AP_LOGFILE_NAME% %AP_LOGFILE_NAME%.1
move C:\%AP_LOGFILE_NAME% %CURRENT_PATH%\%SAVE_FOLDER%\AP2_%AP_LOGFILE_NAME%
move C:\%AP_LOGFILE_NAME%.1 %CURRENT_PATH%\%SAVE_FOLDER%\AP2_%AP_LOGFILE_NAME%.1

rem Webログファイル取得実行
%WINSCP_EXE% /console /script=winscp_src\log_get.txt /parameter %WEB_INFO% %WEB_LOG_DIR% %WEB_LOGFILE_NAME% %WEB_LOGFILE_NAME%.1
move C:\%WEB_LOGFILE_NAME% %CURRENT_PATH%\%SAVE_FOLDER%\WEB_%WEB_LOGFILE_NAME%
move C:\%WEB_LOGFILE_NAME%.1 %CURRENT_PATH%\%SAVE_FOLDER%\WEB_%WEB_LOGFILE_NAME%.1

pause
