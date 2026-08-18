# 📚 CBR to CBZ Batch Converter (Universal, Fast & Safe) by Nicola theVot Selenu

An ultra-fast, robust, and safe Windows Batch script to batch convert comic book archives from **.CBR** (RAR) to **.CBZ** (ZIP). Optimized for high performance on both local drives and network shares (NAS).

Uno script Batch per Windows ultra-veloce, robusto e sicuro per convertire collezioni di fumetti da **.CBR** (RAR) a **.CBZ** (ZIP). Ottimizzato per massime prestazioni sia su dischi locali che su percorsi di rete (NAS).

---

## 🇮🇹 Italiano

### 🌟 Caratteristiche Principali
* **Ottimizzato per NAS e Rete:** Utilizza l'SSD locale (`%TEMP%`) come buffer di estrazione, riducendo drasticamente il traffico I/O di rete e velocizzando la conversione fino al 500% su cartelle condivise (UNC).
* **Compressione Ultra-Veloce:** Applica profili di compressione ottimizzati (`-m1` per WinRAR / `-mx1` per 7-Zip), ideali per file composti da immagini già compresse (JPG, PNG, WebP).
* **Pulizia File Nascosti/Spazzatura:** Rimuove automaticamente file indesiderati come `Thumbs.db` e `.DS_Store` prima di creare il file `.cbz`.
* **Protezione Sovrascrittura:** Salta automaticamente i file già convertiti per evitare duplicati o corruzioni di archivio.
* **Sicurezza dei Dati:** Elimina il file `.cbr` originale **solamente se** il file `.cbz` di destinazione viene generato correttamente ed è superiore a 0 Byte.
* **Rilevamento Automatico:** Individua in autonomia l'installazione di **WinRAR** o **7-Zip** interrogando il Registro di Windows.
* **Supporto Drag & Drop:** Trascina direttamente singoli file `.cbr` o intere cartelle sopra l'icona del file `.bat`.
* **Piena Compatibilità Nomi:** Gestisce caratteri speciali, spazi, parentesi e punti esclamativi (`!`) senza errori.

---

### 📋 Requisiti
* **Sistema Operativo:** Windows 10 / 11
* **Software di compressione (almeno uno dei due):**
  * [WinRAR](https://www.win-rar.com/)
  * [7-Zip](https://www.7-zip.org/)

---

### 🚀 Come Usarlo

#### Metodo 1: Esecuzione in Cartella
1. Scarica o copia il file `Converti_CBR_CBZ.bat`.
2. Posizionalo nella cartella contenente i file `.cbr` (funziona anche su percorsi di rete tipo `\\Server\Comics`).
3. Fai doppio clic sul file `.bat` e premi un tasto per avviare la conversione.

#### Metodo 2: Drag & Drop
1. Trascina una cartella o un gruppo di file `.cbr` direttamente sopra l'icona di `Converti_CBR_CBZ.bat`.

---

## 🇬🇧 English

### 🌟 Key Features
* **NAS & Network Optimized:** Uses local system storage (`%TEMP%`) as an extraction buffer, minimizing network I/O traffic and boosting conversion speeds up to 500% on network shares (UNC paths).
* **High-Speed Compression:** Uses optimized fast compression flags (`-m1` for WinRAR / `-mx1` for 7-Zip) tailored for pre-compressed comic images (JPG, PNG, WebP).
* **Junk File Sanitization:** Automatically purges OS metadata and thumbnail files (e.g., `Thumbs.db`, `.DS_Store`) before building the `.cbz` archive.
* **Duplicate Protection:** Automatically skips files if a `.cbz` archive already exists, preventing accidental file corruption.
* **Data Safety Guarantee:** Source `.cbr` files are deleted **only if** the target `.cbz` archive is validated and strictly larger than 0 bytes.
* **Smart Auto-Detection:** Automatically discovers installed **WinRAR** or **7-Zip** binaries via Windows Registry.
* **Drag & Drop Ready:** Drop folders or individual `.cbr` files directly onto the `.bat` file to convert on the fly.
* **Special Characters Safe:** Fully compatible with spaces, brackets, accented characters, and exclamation marks (`!`).

---

### 📋 Requirements
* **Operating System:** Windows 10 / 11
* **Required Archiver (at least one):**
  * [WinRAR](https://www.win-rar.com/)
  * [7-Zip](https://www.7-zip.org/)

---

### 🚀 How to Use

#### Method 1: In-Folder Execution
1. Download or copy `Converti_CBR_CBZ.bat`.
2. Place it inside the directory containing your `.cbr` files (works seamlessly on network paths like `\\Server\Comics`).
3. Double-click `Converti_CBR_CBZ.bat` and press any key to start.

#### Method 2: Drag & Drop
1. Drag and drop any folder or `.cbr` file directly onto the `Converti_CBR_CBZ.bat` icon.

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).
