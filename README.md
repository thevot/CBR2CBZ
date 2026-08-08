# 📚 CBR to CBZ Batch Converter (Universal & Safe) by Nicola theVot Selenu

An ultra-robust, fast, and safe Windows Batch script to convert comic archives from **.CBR** (RAR format) to **.CBZ** (ZIP format). It automatically detects installed compression tools (WinRAR or 7-Zip) and protects your original files against corruption.

Uno script Batch per Windows ultra-robusto, veloce e sicuro per convertire gli archivi di fumetti da **.CBR** (formato RAR) a **.CBZ** (formato ZIP). Rileva automaticamente i software installati (WinRAR o 7-Zip) e protegge i file originali da eventuali corruzioni.

---

## 🇮🇹 Italiano

### 🌟 Caratteristiche Principali
* **Rilevamento Automatico:** Cerca autonomamente **WinRAR** o **7-Zip** tramite Registro di Sistema e percorsi standard.
* **Supporto Drag & Drop:** Puoi trascinare un file o una cartella direttamente sopra lo script `.bat`.
* **Supporto Percorsi di Rete (UNC):** Funziona senza problemi anche su cartelle di rete (es. NAS `\\Server\Share`).
* **Massima Compatibilità Nomi:** Gestisce correttamente caratteri speciali, spazi, parentesi e punti esclamativi (`!`).
* **Protezione Dati:** Il file `.cbr` originale viene eliminato **solo se** il nuovo file `.cbz` viene creato con successo ed è maggiore di 0 byte.
* **Struttura Pulita:** Pulisce automaticamente la struttura delle sottocartelle, garantendo che i lettori di fumetti (CDisplayEx, YACReader, Komga, Tachiyomi, ecc.) leggano subito le pagine.

### 📋 Requisiti
* **Sistema Operativo:** Windows 10 / 11
* **Software richiesto (almeno uno dei due):**
  * [WinRAR](https://www.win-rar.com/)
  * [7-Zip](https://www.7-zip.org/)

### 🚀 Come Usarlo

#### Metodo 1: Nella stessa cartella
1. Scarica o copia il file `Converti_CBR_CBZ.bat`.
2. Posizionalo nella cartella contenente i file `.cbr`.
3. Fai doppio clic su `Converti_CBR_CBZ.bat` e premi un tasto per avviare.

#### Metodo 2: Drag & Drop
1. Trascina una cartella (o un file `.cbr`) direttamente sopra l'icona dello script `Converti_CBR_CBZ.bat`.

---

## 🇬🇧 English

### 🌟 Key Features
* **Auto-Detection:** Automatically locates **WinRAR** or **7-Zip** via Windows Registry and standard paths.
* **Drag & Drop Support:** Drop any folder or `.cbr` file directly onto the `.bat` file.
* **Network Drives Support (UNC):** Native support for network shares (e.g., NAS `\\Server\Share`).
* **Special Characters Safe:** Perfectly handles spaces, brackets, accented letters, and exclamation marks (`!`).
* **Data Safety First:** Original `.cbr` files are deleted **only if** the new `.cbz` is created successfully and is larger than 0 bytes.
* **Clean Archive Structure:** Strips unnecessary nested temporary folders so comic book readers (CDisplayEx, YACReader, Komga, Tachiyomi, etc.) can display pages immediately.

### 📋 Requirements
* **OS:** Windows 10 / 11
* **Required Software (at least one):**
  * [WinRAR](https://www.win-rar.com/)
  * [7-Zip](https://www.7-zip.org/)

### 🚀 How to Use

#### Method 1: Inside the same directory
1. Download or copy `Converti_CBR_CBZ.bat`.
2. Place it in the directory containing your `.cbr` files.
3. Double-click `Converti_CBR_CBZ.bat` and press any key to start.

#### Method 2: Drag & Drop
1. Drag and drop any folder (or `.cbr` file) directly onto the `Converti_CBR_CBZ.bat` icon.

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).
