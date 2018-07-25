@ECHO OFF

::::::::::Parameter setting::::::::::
SET ROOT=%~dp0
SET INPUT_DIR=%ROOT%posts\
SET OUTPUT_PDF_DIR=%ROOT%pdf\
SET OUTPUT_HTML_DIR=%ROOT%html\
SET STYLE_CSS=%ROOT%css\style.css
SET FONT_CSS=%ROOT%css\import-font.css
SET DYNOLOAD=%ROOT%js\dynoload.js
SET CHROME="%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"

:: Get latest file name
:: https://code.i-harness.com/ja/q/17c5b
FOR /F "delims=|" %%I IN ('DIR "%INPUT_DIR%*.md" /B /O:D') DO SET NewestFile=%%I

PUSHD %INPUT_DIR%
CALL :SUB %NewestFile%
POPD

PAUSE
EXIT


:::::::::: RUN ::::::::::
:SUB

ECHO Start to generate " %~n1.html and %~n1.pdf "
CALL pandoc --self-contained -s --mathjax=%DYNOLOAD% %INPUT_DIR%%~1 -o %OUTPUT_HTML_DIR%%~n1.html -c %STYLE_CSS% -H %FONT_CSS%
ECHO Convert html to pdf using Google chrome
%CHROME% --headless --print-to-pdf=%OUTPUT_PDF_DIR%%~n1.pdf %OUTPUT_HTML_DIR%%~n1.html
ECHO Done

EXIT /B
