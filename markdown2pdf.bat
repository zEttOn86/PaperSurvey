@ECHO OFF

::::::::::Parameter setting::::::::::
SET ROOT=%~dp0
SET HEADER=%ROOT%headers\h-luatexja.tex
SET INPUT_DIR=%ROOT%posts\
SET OUTPUT_DIR=%ROOT%pdf\

:: Get latest file name
:: https://code.i-harness.com/ja/q/17c5b
FOR /F "delims=|" %%I IN ('DIR "%INPUT_DIR%*.md" /B /O:D') DO SET NewestFile=%%I

CALL :SUB %NewestFile%

PAUSE
EXIT


:::::::::: RUN ::::::::::
:SUB
ECHO Start to generate pdf
CALL pandoc %INPUT_DIR%%~1 -o %OUTPUT_DIR%%~n1.pdf --pdf-engine=lualatex -H %HEADER%
ECHO Done
EXIT /B
