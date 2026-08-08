@echo off
chcp 65001 >nul
title CBR to CBZ Converter (Universal & Safe)
color 0A

:: ==============================================================================
:: Nome Script : CBR to CBZ Batch Converter (Universal)
:: Requisiti   : Windows 10/11 + WinRAR oppure 7-Zip
:: Uso         : 1. Copia il file .bat nella cartella dei .cbr ed eseguilo.
::               2. Oppure trascina (Drag & Drop) una cartella o file .cbr sul .bat.
:: Caratteristiche:
::   - Rilevamento automatico WinRAR e 7-Zip
::   - Supporta percorsi di rete (UNC)
::   - Supporta nomi di file con spazi, accenti e punti esclamativi (!)
::   - Protezione dati: elimina il .cbr solo se il .cbz viene creato correttamente
::   - Non crea sottocartelle annidate dentro il .cbz
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

:: Pulizia di eventuali residui da esecuzioni interrotte in precedenza
for /d %%D in ("temp_cbz_*") do rmdir /s /q "%%D" >nul 2>&1

:: Rilevamento strumenti (Priorita: WinRAR -> 7-Zip)
set "ARCHIVER="
set "MODE="

:: 1. Cerca WinRAR nel Registro di Sistema
for /f "tokens=2*" %%A in ('reg query "HKLM\SOFTWARE\WinRAR" /v "exe64" 2^>nul') do set "ARCHIVER=%%B"
if not defined ARCHIVER for /f "tokens=2*" %%A in ('reg query "HKLM\SOFTWARE\WinRAR" /v "exe" 2^>nul') do set "ARCHIVER=%%B"
if not defined ARCHIVER if exist "C:\Program Files\WinRAR\WinRAR.exe" set "ARCHIVER=C:\Program Files\WinRAR\WinRAR.exe"
if defined ARCHIVER set "MODE=WINRAR"

:: 2. Fallback su 7-Zip
if not defined ARCHIVER (
    for /f "tokens=2*" %%A in ('reg query "HKLM\SOFTWARE\7-Zip" /v "Path" 2^>nul') do set "ARCHIVER=%%B7z.exe"
    if exist "C:\Program Files\7-Zip\7z.exe" set "ARCHIVER=C:\Program Files\7-Zip\7z.exe"
    if exist "C:\Program Files (x86)\7-Zip\7z.exe" set "ARCHIVER=C:\Program Files (x86)\7-Zip\7z.exe"
    if defined ARCHIVER set "MODE=7ZIP"
)

:: Errore se nessun archiviatore e presente
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
echo ==============================================================================
echo.

set /a TOTAL=0
set /a SUCCESS=0
set /a FAILED=0

for %%F in ("*.cbr") do set /a TOTAL+=1

echo Trovati %TOTAL% file .cbr da elaborare.
echo Premere un tasto per avviare...
pause >nul
echo.

:: Loop di conversione principale
setlocal disabledelayedexpansion
for %%F in ("*.cbr") do (
    set "FILE_PATH=%%F"
    set "FILE_NAME=%%~nF"
    
    setlocal enabledelayedexpansion
    set "TEMP_DIR=temp_cbz_!RANDOM!"

    echo ------------------------------------------------------------------------------
    echo [IN ELABORAZIONE] "!FILE_NAME!.cbr"

    mkdir "!TEMP_DIR!" >nul 2>&1

    if "!MODE!"=="WINRAR" (
        "%ARCHIVER%" x -ibck -y "%%F" "!TEMP_DIR!\" >nul 2>&1
        if not errorlevel 1 (
            "%ARCHIVER%" a -afzip -ibck -r -ep1 "!FILE_NAME!.cbz" ".\!TEMP_DIR!\*" >nul 2>&1
        )
    ) else (
        "%ARCHIVER%" x -y -o"!TEMP_DIR!" "%%F" >nul 2>&1
        if not errorlevel 1 (
            pushd "!TEMP_DIR!"
            "%ARCHIVER%" a -tzip -r "..\!FILE_NAME!.cbz" "*" >nul 2>&1
            popd
        )
    )

    :: Controllo integrita: Il file CBZ esiste ED e maggiore di 0 Byte?
    set "VALID=0"
    if exist "!FILE_NAME!.cbz" (
        for %%Z in ("!FILE_NAME!.cbz") do (
            if %%~zZ GTR 0 set "VALID=1"
        )
    )

    if "!VALID!"=="1" (
        rmdir /s /q "!TEMP_DIR!" >nul 2>&1
        del "%%F" >nul 2>&1
        color 0A
        echo  [OK] Convertito con successo in "!FILE_NAME!.cbz"
        endlocal
        set /a SUCCESS+=1
    ) else (
        color 0C
        echo  [X] ERRORE durante la conversione. Il file originale non e stato eliminato.
        if exist "!FILE_NAME!.cbz" del "!FILE_NAME!.cbz" >nul 2>&1
        rmdir /s /q "!TEMP_DIR!" >nul 2>&1
        endlocal
        set /a FAILED+=1
    )
)
setlocal enabledelayedexpansion

:: Pulizia finale di eventuali cartelle vuote residue
for /d %%D in ("temp_cbz_*") do rmdir /s /q "%%D" >nul 2>&1

echo.
echo ==============================================================================
echo                              RIEPILOGO FINALE
echo ==============================================================================
echo  File Totali  : %TOTAL%
echo  Convertiti   : %SUCCESS%
echo  Falliti      : %FAILED%
echo ==============================================================================
echo.

popd
pause
