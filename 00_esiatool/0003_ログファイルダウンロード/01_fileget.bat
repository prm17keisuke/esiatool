@echo off
rem ���ݒ�(START) ==============================

rem WinSCP���s�t�@�C���p�X
set WINSCP_EXE="C:\Users\izumi\application\WinSCP\winscp.exe"

rem AP�T�[�o�ڑ����
set AP1_INFO="weblogic:**********@999.999.999.999"
set AP2_INFO="weblogic:**********@999.999.999.999"

rem WEB�T�[�o�ڑ����
set WEB_INFO="esadmin:**********@999.999.999.999"

rem �t�@�C����
set AP_LOGFILE_NAME=CustomLog.log
set WEB_LOGFILE_NAME=error_log

rem AP ���O�t�@�C���f�B���N�g��
set AP_LOG_DIR=/home/weblogic/anesta/webAppLogs/
set WEB_LOG_DIR=/usr/local/apache2/logs/

rem ���ݒ�(END) ================================

rem �J�����g�p�X
set CURRENT_PATH=%~p0\

rem �����uYYYYMMDDHHMMSS�v
set time_tmp=%time: =0%
set DATE_STR=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%

rem �ۑ��p�t�H���_
set SAVE_FOLDER=log\%DATE_STR%\org\
mkdir %SAVE_FOLDER%

rem WINSCP���O�t�H���_
set LOG_FOLDER=log\%DATE_STR%\log\


rem AP1���O�t�@�C���擾���s
%WINSCP_EXE% /console /command "option batch on" "option confirm off" "open %AP1_INFO%" "option transfer binary" "get %AP_LOG_DIR%%AP_LOGFILE_NAME% %CURRENT_PATH%%SAVE_FOLDER%AP1_%AP_LOGFILE_NAME%" "get %AP_LOG_DIR%%AP_LOGFILE_NAME%.1 %CURRENT_PATH%%SAVE_FOLDER%AP1_%AP_LOGFILE_NAME%.1" "close" "exit"
copy %CURRENT_PATH%%SAVE_FOLDER%AP1_%AP_LOGFILE_NAME%.1+%CURRENT_PATH%%SAVE_FOLDER%AP1_%AP_LOGFILE_NAME% %CURRENT_PATH%%SAVE_FOLDER%..\AP1_%AP_LOGFILE_NAME%

rem AP2���O�t�@�C���擾���s
%WINSCP_EXE% /console /command "option batch on" "option confirm off" "open %AP2_INFO%" "option transfer binary" "get %AP_LOG_DIR%%AP_LOGFILE_NAME% %CURRENT_PATH%%SAVE_FOLDER%AP2_%AP_LOGFILE_NAME%" "get %AP_LOG_DIR%%AP_LOGFILE_NAME%.1 %CURRENT_PATH%%SAVE_FOLDER%AP2_%AP_LOGFILE_NAME%.1" "close" "exit"
copy %CURRENT_PATH%%SAVE_FOLDER%AP2_%AP_LOGFILE_NAME%.1+%CURRENT_PATH%%SAVE_FOLDER%AP2_%AP_LOGFILE_NAME% %CURRENT_PATH%%SAVE_FOLDER%..\AP2_%AP_LOGFILE_NAME%

rem WEB(Apache)���O�t�@�C���擾���s
%WINSCP_EXE% /console /command "option batch on" "option confirm off" "open %WEB_INFO%" "option transfer binary" "get %WEB_LOG_DIR%%WEB_LOGFILE_NAME% %CURRENT_PATH%%SAVE_FOLDER%WEB_%WEB_LOGFILE_NAME%" "get %WEB_LOG_DIR%%WEB_LOGFILE_NAME%.1 %CURRENT_PATH%%SAVE_FOLDER%WEB_%WEB_LOGFILE_NAME%.1" "close" "exit"
copy %CURRENT_PATH%%SAVE_FOLDER%WEB_%WEB_LOGFILE_NAME%.1+%CURRENT_PATH%%SAVE_FOLDER%WEB_%WEB_LOGFILE_NAME% %CURRENT_PATH%%SAVE_FOLDER%..\WEB_%WEB_LOGFILE_NAME%

echo "�������܂����B"
pause

