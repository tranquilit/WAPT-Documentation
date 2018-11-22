REM c:\python27\scripts\pip.exe install sphinx sphinx-intl sphinx-rtd-theme sphinxcontrib-googleanalytics sphinxcontrib-websupport sphinxcontrib.napoleon
REM set path=%path%;c:\python27\scripts\

rem make.bat clean 
del /s /q build
rmdir /s /q build
make.bat gettext
c:\python27\Scripts\sphinx-intl.exe update -p build/locale -l en
make.bat clean
make.bat htmlfr
make.bat htmlen
