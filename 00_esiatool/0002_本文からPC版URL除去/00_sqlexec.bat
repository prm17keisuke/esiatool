@echo off

rem tns�ݒ�
set tns=mmc_nst
rem �^�[�Q�b�g�X�L�[�}���X�g
set filename=01_target.list

rem ���s�m�F
set /p check="���������s���܂��B��낵���ł����H(y/n)"
if not %check% == y goto end

for /f "eol=# tokens=1" %%i in (%filename%) do (
  echo %%i �̏����J�n
  sqlplus -s /nolog @02_update.sql %%i %tns%
)

:end
pause