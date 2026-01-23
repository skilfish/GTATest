# FiveM ESX Resource

Eine strukturierte FiveM-Ressource basierend auf dem ESX Framework.

**Dieses Projekt enthält:**
- Eine eigene ESX-Ressource-Struktur (client/, server/, shared/)
- Das offizielle ESX Legacy Framework (`esx_core`) als Git-Submodule

## 📋 Inhaltsverzeichnis

- [Voraussetzungen](#voraussetzungen)
- [Installation](#installation)
- [Konfiguration](#konfiguration)
- [Verwendung](#verwendung)
- [Struktur](#struktur)
- [Versionierung](#versionierung)
- [Entwicklung](#entwicklung)
- [Lizenz](#lizenz)

## 🔧 Voraussetzungen

- FiveM Server
- ESX Framework installiert und konfiguriert
- Lua-Kenntnisse empfohlen

## 📦 Installation

1. Klonen Sie dieses Repository in Ihren `resources` Ordner:
```bash
git clone <repository-url> [resource-name]
cd [resource-name]
```

2. Initialisieren Sie die Git-Submodules (für ESX Core):
```bash
git submodule update --init --recursive
```

3. **ESX Core Installation:**
   - Kopieren Sie den Inhalt von `esx_core/[core]/` in Ihren `resources` Ordner
   - Importieren Sie die SQL-Datei aus `esx_core/[SQL]/legacy.sql` in Ihre Datenbank
   - Folgen Sie der [offiziellen ESX-Dokumentation](https://documentation.esx-framework.org/)

4. Fügen Sie Ihre Ressource zu Ihrer `server.cfg` hinzu:
```
ensure [resource-name]
```

5. Starten Sie den Server neu oder führen Sie aus:
```
restart [resource-name]
```

## ⚙️ Konfiguration

Die Konfiguration erfolgt in der `config.lua` Datei. Passen Sie die Werte nach Ihren Bedürfnissen an.

### Verfügbare Konfigurationsoptionen

- `Config.Locale`: Spracheinstellung (Standard: 'de')
- `Config.Debug`: Debug-Modus aktivieren/deaktivieren (Standard: false)

## 🚀 Verwendung

### Client-seitige Befehle

- `/test` - Beispiel-Befehl

### Server-seitige Events

- `example:event` - Beispiel-Event

### Server-seitige Callbacks

- `example:callback` - Beispiel-Callback

## 📁 Struktur

```
.
├── client/              # Client-seitiger Code (Ihre Ressource)
│   └── main.lua        # Haupt-Client-Datei
├── server/             # Server-seitiger Code (Ihre Ressource)
│   └── main.lua        # Haupt-Server-Datei
├── shared/             # Geteilter Code (Ihre Ressource)
│   └── functions.lua   # Gemeinsame Funktionen
├── esx_core/           # ESX Legacy Framework (Git-Submodule)
│   ├── [core]/         # ESX Core-Ressourcen
│   │   ├── es_extended/
│   │   ├── esx_menu_dialog/
│   │   ├── esx_skin/
│   │   └── ...
│   └── [SQL]/          # Datenbank-Skripte
│       └── legacy.sql
├── config.lua          # Konfigurationsdatei
├── fxmanifest.lua      # FiveM Manifest
├── README.md           # Diese Datei
└── CHANGELOG.md        # Versionshistorie
```

### Was wurde erstellt?

**Eigene Ressource-Struktur:**
- `client/` - Client-seitiger Lua-Code für Ihre Ressource
- `server/` - Server-seitiger Lua-Code für Ihre Ressource  
- `shared/` - Geteilter Code zwischen Client und Server
- `config.lua` - Konfigurationsdatei für Ihre Ressource
- `fxmanifest.lua` - FiveM Manifest mit ESX-Integration

**ESX Framework:**
- `esx_core/` - Offizielles ESX Legacy Framework als Git-Submodule
  - Enthält alle Core-Ressourcen (es_extended, esx_menu_dialog, esx_skin, etc.)
  - Enthält SQL-Skripte für die Datenbank-Installation

## 📝 Versionierung

Dieses Projekt verwendet [Semantic Versioning](https://semver.org/).

Die Versionshistorie finden Sie in der [CHANGELOG.md](CHANGELOG.md) Datei.

### Aktuelle Version: 1.0.0

## 🛠️ Entwicklung

### Code-Standards

- Verwenden Sie aussagekräftige Variablennamen
- Kommentieren Sie komplexe Logik
- Folgen Sie den ESX-Konventionen
- Testen Sie Ihre Änderungen gründlich

### Debugging

Aktivieren Sie den Debug-Modus in der `config.lua`:
```lua
Config.Debug = true
```

## 📄 Lizenz

[Ihre Lizenz hier]

## 👥 Mitwirkende

- [Ihr Name]

## 📞 Support

Bei Fragen oder Problemen erstellen Sie bitte ein Issue im Repository.

---

**Hinweis:** Dies ist eine Basis-Struktur. Passen Sie den Code an Ihre spezifischen Anforderungen an.
