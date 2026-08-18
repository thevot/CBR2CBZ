@echo off
chcp 65001 >nul
title CBR to CBZ Converter (Universal, Fast & Safe)
color 0A

:: ==============================================================================
:: Nome Script : CBR to CBZ Batch Converter (Universal, Fast & Safe)
:: Requisiti   : Windows 10/11 + WinRAR oppure 7-Zip
:: ==============================================================================

:: Gestione directory (supporta Drag & Drop e percorsi di rete UNC)
if "%~1"=="" (
    pushd "%~dp0"
) else (
    if exist "%~1\" (
        pushd "%~1"
    ) else (
        pushd "%~dp1"
    )
)

:: Pulizia preventiva su %TEMP% locale
for /d %%D in ("%TEMP%\cbz_conv_*") do rmdir /s /q "%%D" >nul 2>&1

:: Rilevamento strumenti (Priorita: WinRAR -> 7-Zip)
set "ARCHIVER="
set "MODE="

for /f "tokens=2*" %%A in ('reg query "HKLM\SOFTWARE\WinRAR" /v "exe64" 2^>nul') do set "ARCHIVER=%%B"
if not defined ARCHIVER for /f "tokens=2*" %%A in ('reg query "HKLM\SOFTWARE\WinRAR" /v "exe" 2^>nul') do set "ARCHIVER=%%B"
if not defined ARCHIVER if exist "C:\Program Files\WinRAR\WinRAR.exe" set "ARCHIVER=C:\Program Files\WinRAR\WinRAR.exe"
if defined ARCHIVER set "MODE=WINRAR"

if not defined ARCHIVER (
    for /f "tokens=2*" %%A in ('reg query "HKLM\SOFTWARE\7-Zip" /v "Path" 2^>nul') do set "ARCHIVER=%%B7z.exe"
    if exist "C:\Program Files\7-Zip\7z.exe" set "ARCHIVER=C:\Program Files\7-Zip\7z.exe"
    if exist "C:\Program Files (x86)\7-Zip\7z.exe" set "ARCHIVER=C:\Program Files (x86)\7-Zip\7z.exe"
    if defined ARCHIVER set "MODE=7ZIP"
)

if not defined ARCHIVER (
    color 0C
    echo ==============================================================================
    echo  [ERRORE CRITICO] Nessun software di compressione trovato!
    echo ==============================================================================
    echo  Installa WinRAR o 7-Zip sul sistema per utilizzare questo script.
    echo.
    popd
    pause
    exit /b
)

:: Verifica presenza file .cbr
dir /b /a-d "*.cbr" >nul 2>&1
if errorlevel 1 (
    color 0E
    echo ==============================================================================
    echo  [AVVISO] Nessun file .cbr trovato nella cartella target.
    echo ==============================================================================
    echo  Directory: "%CD%"
    echo.
    popd
    pause
    exit /b
)

cls
echo ==============================================================================
echo                      CONVERTITORE DA CBR A CBZ
echo ==============================================================================
echo  Motore rilevato : %MODE% ("%ARCHIVER%")
echo  Cartella target : "%CD%"
echo  Buffer temporaneo: "%TEMP%" (Locale)
echo ==============================================================================
echo.

set /a TOTAL=0
set /a SUCCESS=0
set /a FAILED=0
set /a SKIPPED=0

for %%F in ("*.cbr") do set /a TOTAL+=1

echo Trovati %TOTAL% file .cbr da elaborare.
echo Premere un tasto per avviare...
pause >nul
echo.

setlocal disabledelayedexpansion
for %%F in ("*.cbr") do (
    set "FILE_PATH=%%F"
    set "FILE_NAME=%%~nF"
    
    setlocal enabledelayedexpansion
    set "DEST_FILE=!FILE_NAME!.cbz"
    set "TEMP_DIR=%TEMP%\cbz_conv_!RANDOM!"

    echo ------------------------------------------------------------------------------
    echo [IN ELABORAZIONE] "!FILE_NAME!.cbr"

    :: Evita duplicati se il CBZ e gia presente
    if exist "!DEST_FILE!" (
        echo  [SALTO] Il file "!DEST_FILE!" esiste gia.
        endlocal
        set /a SKIPPED+=1
    ) else (
        mkdir "!TEMP_DIR!" >nul 2>&1

        if "!MODE!"=="WINRAR" (
            "%ARCHIVER%" x -ibck -y "%%F" "!TEMP_DIR!\" >nul 2>&1
            if not errorlevel 1 (
                :: Pulizia file spazzatura
                del /s /q /f /a "!TEMP_DIR!\Thumbs.db" "!TEMP_DIR!\.DS_Store" >nul 2>&1
                :: -m1 attiva la compressione piu veloce (ottimale per immagini)
                "%ARCHIVER%" a -afzip -m1 -ibck -r -ep1 "!DEST_FILE!" "!TEMP_DIR!\*" >nul 2>&1
            )
        ) else (
            "%ARCHIVER%" x -y -o"!TEMP_DIR!" "%%F" >nul 2>&1
            if not errorlevel 1 (
                :: Pulizia file spazzatura
                del /s /q /f /a "!TEMP_DIR!\Thumbs.db" "!TEMP_DIR!\.DS_Store" >nul 2>&1
                pushd "!TEMP_DIR!"
                :: -mx1 imposta la compressione piu veloce in 7-Zip
                "%ARCHIVER%" a -tzip -mx1 -r "..\!DEST_FILE!" "*" >nul 2>&1
                popd
                move "%TEMP%\!DEST_FILE!" ".\!DEST_FILE!" >nul 2>&1
            )
        )

        :: Verifica integrita file di output
        set "VALID=0"
        if exist "!DEST_FILE!" (
            for %%Z in ("!DEST_FILE!") do (
                if %%~zZ GTR 0 set "VALID=1"
            )
        )

        if "!VALID!"=="1" (
            rmdir /s /q "!TEMP_DIR!" >nul 2>&1
            del "%%F" >nul 2>&1
            color 0A
            echo  [OK] Convertito con successo in "!DEST_FILE!"
            endlocal
            set /a SUCCESS+=1
        ) else (
            color 0C
            echo  [X] ERRORE durante la conversione. Il file originale e stato preservato.
            if exist "!DEST_FILE!" del "!DEST_FILE!" >nul 2>&1
            rmdir /s /q "!TEMP_DIR!" >nul 2>&1
            endlocal
            set /a FAILED+=1
        )
    )
)
setlocal enabledelayedexpansion

:: Pulizia finale cartelle orfane su %TEMP%
for /d %%D in ("%TEMP%\cbz_conv_*") do rmdir /s /q "%%D" >nul 2>&1

echo.
echo ==============================================================================
echo                              RIEPILOGO FINALE
echo ==============================================================================
echo  File Totali  : %TOTAL%
echo  Convertiti   : %SUCCESS%
echo  Saltati      : %SKIPPED%
echo  Falliti      : %FAILED%
echo ==============================================================================
echo.

popd
pause
