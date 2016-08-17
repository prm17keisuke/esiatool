@echo off
rem 環境設定(START) ==============================

rem WinSCP実行ファイルパス
set WINSCP_EXE="C:\Users\izumi\application\WinSCP\winscp.exe"

rem APサーバ接続情報
set AP1_INFO="weblogic:**********@999.999.999.999"
set AP2_INFO="weblogic:**********@999.999.999.999"

rem WEBサーバ接続情報
set WEB_INFO="esadmin:**********@999.999.999.999"

rem ファイル名
set AP_LOGFILE_NAME=CustomLog.log
set WEB_LOGFILE_NAME=error_log

rem AP ログファイルディレクトリ
set AP_LOG_DIR=/home/weblogic/anesta/webAppLogs/
set WEB_LOG_DIR=/usr/local/apache2/logs/

rem 環境設定(END) ================================

rem カレントパス
set CURRENT_PATH=%~p0\

rem 日時「YYYYMMDDHHMMSS」
set time_tmp=%time: =0%
set DATE_STR=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%

rem 保存用フォルダ
set SAVE_FOLDER=log\%DATE_STR%\org\
mkdir %SAVE_FOLDER%

rem WINSCPログフォルダ
set LOG_FOLDER=log\%DATE_STR%\log\


rem AP1ログファイル取得実行
%WINSCP_EXE% /console /command "option batch on" "option confirm off" "open %AP1_INFO%" "option transfer binary" "get %AP_LOG_DIR%%AP_LOGFILE_NAME% %CURRENT_PATH%%SAVE_FOLDER%AP1_%AP_LOGFILE_NAME%" "get %AP_LOG_DIR%%AP_LOGFILE_NAME%.1 %CURRENT_PATH%%SAVE_FOLDER%AP1_%AP_LOGFILE_NAME%.1" "close" "exit"
copy %CURRENT_PATH%%SAVE_FOLDER%AP1_%AP_LOGFILE_NAME%.1+%CURRENT_PATH%%SAVE_FOLDER%AP1_%AP_LOGFILE_NAME% %CURRENT_PATH%%SAVE_FOLDER%..\AP1_%AP_LOGFILE_NAME%

rem AP2ログファイル取得実行
%WINSCP_EXE% /console /command "option batch on" "option confirm off" "open %AP2_INFO%" "option transfer binary" "get %AP_LOG_DIR%%AP_LOGFILE_NAME% %CURRENT_PATH%%SAVE_FOLDER%AP2_%AP_LOGFILE_NAME%" "get %AP_LOG_DIR%%AP_LOGFILE_NAME%.1 %CURRENT_PATH%%SAVE_FOLDER%AP2_%AP_LOGFILE_NAME%.1" "close" "exit"
copy %CURRENT_PATH%%SAVE_FOLDER%AP2_%AP_LOGFILE_NAME%.1+%CURRENT_PATH%%SAVE_FOLDER%AP2_%AP_LOGFILE_NAME% %CURRENT_PATH%%SAVE_FOLDER%..\AP2_%AP_LOGFILE_NAME%

rem WEB(Apache)ログファイル取得実行
%WINSCP_EXE% /console /command "option batch on" "option confirm off" "open %WEB_INFO%" "option transfer binary" "get %WEB_LOG_DIR%%WEB_LOGFILE_NAME% %CURRENT_PATH%%SAVE_FOLDER%WEB_%WEB_LOGFILE_NAME%" "get %WEB_LOG_DIR%%WEB_LOGFILE_NAME%.1 %CURRENT_PATH%%SAVE_FOLDER%WEB_%WEB_LOGFILE_NAME%.1" "close" "exit"
copy %CURRENT_PATH%%SAVE_FOLDER%WEB_%WEB_LOGFILE_NAME%.1+%CURRENT_PATH%%SAVE_FOLDER%WEB_%WEB_LOGFILE_NAME% %CURRENT_PATH%%SAVE_FOLDER%..\WEB_%WEB_LOGFILE_NAME%

echo "完了しました。"
pause

