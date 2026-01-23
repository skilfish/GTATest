# FiveM ESX Resource

Eine strukturierte FiveM-Ressource basierend auf dem ESX Framework.

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
```

2. Fügen Sie die Ressource zu Ihrer `server.cfg` hinzu:
```
ensure [resource-name]
```

3. Starten Sie den Server neu oder führen Sie aus:
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
├── client/              # Client-seitiger Code
│   └── main.lua        # Haupt-Client-Datei
├── server/             # Server-seitiger Code
│   └── main.lua        # Haupt-Server-Datei
├── shared/             # Geteilter Code
│   └── functions.lua   # Gemeinsame Funktionen
├── config.lua          # Konfigurationsdatei
├── fxmanifest.lua      # FiveM Manifest
├── README.md           # Diese Datei
└── CHANGELOG.md        # Versionshistorie
```

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
