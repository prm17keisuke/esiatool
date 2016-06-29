@echo off

rem tns設定
set tns=mmc_nst
rem ターゲットスキーマリスト
set filename=01_target.list

rem 実行確認
set /p check="処理を実行します。よろしいですか？(y/n)"
if not %check% == y goto end

for /f "eol=# tokens=1" %%i in (%filename%) do (
  echo %%i の処理開始
  sqlplus -s /nolog @02_update.sql %%i %tns%
)

:end
pause