# Simple Linux Certificate Installer

A lightweight Bash script to install `.cer`, `.crt`, or `.pem` certificates system-wide on Linux (tested on Arch Linux).  
Perfect for users who want to add custom or internal certificates without dealing with complex commands or GUI tools.

---

## 🔧 Features

- Asks for a certificate file path (drag-and-drop or paste)
- Supports `.crt`, `.cer`, and `.pem` formats
- Checks if a certificate with the same filename already exists
- Prompts before overwriting existing files
- Automatically updates the system's trust store

---

## 📦 Requirements

- Bash shell
- `trust` command (available on most Linux systems)
- `sudo` privileges

---

## 🚀 How to Use

1. Download or clone this repository.
2. Make the script executable:
   ```bash
   chmod +x cert_installer.sh
   ```
3. Run the script:
   ```bash
   ./cert_installer.sh
   ```
4. Drag and drop your certificate file into the terminal, or paste its full path.
5. Follow the on-screen instructions.

---

## 📁 Target Installation Path

Certificates are copied to:

```
/etc/ca-certificates/trust-source/anchors/
```

After installation, the script runs:

```bash
sudo trust extract-compat
```

to update the trusted certificate database.

---

## ✅ Supported File Types

- `.crt`
- `.cer`
- `.pem`

---

## 📄 License

This project is licensed under the GPL-3.0 license.
