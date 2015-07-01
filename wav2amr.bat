@echo off

SET PATH_FFMPEG=D:\ffmpeg-20150402-git-d759844-win32-static

if _%1 == _C goto CONVERT

setlocal EnableDelayedExpansion

if not exist "AMR" mkdir AMR

FOR %%G IN (*.wav) DO call "%0" C %%G


goto :EOF

:CONVERT

SET WAV=%2
SET AMR=AMR\%WAV:.wav=.amr%

echo Convert %WAV% to %AMR%
%PATH_FFMPEG%\bin\ffmpeg -i %WAV% -acodec libopencore_amrnb -ab 12.2k -ac 1 -ar 8k -y %AMR%
rem ..\bin\ffmpeg -i %WAV% -acodec libopencore_amrnb -ab 12.2k -ac 1 -ar 8k -y %AMR%
