# CarePrompt

A non-verbal communication aid for residents in long-term care and dementia facilities, built for iOS and iPadOS.

## Why this exists

Communication is one of the first things dementia takes. Residents who can no longer speak reliably still have needs — water, pain, cold, hunger — and expressing them becomes increasingly difficult as the condition progresses.

CarePrompt was built by an iOS developer working as a care aide in a long-term care facility in Northern Canada. Every design decision reflects direct, daily experience with residents and the staff who care for them.

## Features

- **Resident profiles** — each resident has their own communication board with a personalised set of symbols, photo, unit, and room number
- **Symbol board** — large, tap-friendly symbol cards with SF Symbols icons and text labels
- **Text-to-speech** — tapping a symbol speaks the word or phrase aloud using AVSpeechSynthesizer, with support for the resident's preferred language
- **Stage-aware layout** — three dementia stage modes (Early, Middle, Late) that adjust card size, column count, and text label visibility to match the resident's cognitive needs
- **Caregiver Mode** — searchable resident list with avatars, unit, and room number. Add and delete residents with photo and language support
- **Symbol editor** — caregivers can add symbols with a searchable SF Symbols icon picker and delete symbols from a resident's board
- **Caregiver Edit Mode** — global toggle in Settings that shows/hides editing controls, keeping the board clean and distraction-free during resident use
- **Settings** — global stage switcher, edit mode toggle, app info, and data reset with confirmation
- **CloudKit sync** — resident and symbol data syncs automatically across all devices signed into the same iCloud account
- **Offline-first** — fully functional without internet access; CloudKit syncs when connectivity is restored
- **Empty states** — clear, informative empty states for both the resident list and symbol board

## Tech Stack

- SwiftUI
- SwiftData (local persistence)
- CloudKit (multi-device sync via private database)
- AVFoundation (text-to-speech with audio session management)
- PhotosUI (resident photo picker)
- AppStorage (global preferences)

## Architecture

```
CarePrompt/
├── Models/
│   ├── Resident.swift         # SwiftData model — profile, language, photo, CloudKit compatible
│   └── Symbol.swift           # SwiftData model — text, icon, sort order, CloudKit compatible
├── Enums/
│   └── DementiaStage.swift    # Stage-aware UI configuration (symbolsPerRow, cardSize, showsTextLabel)
├── Services/
│   └── SpeechService.swift    # Singleton AVSpeechSynthesizer wrapper with audio session config
├── Utilities/
│   ├── LanguageHelper.swift   # Dynamic language list from AVSpeechSynthesisVoice
│   └── SFSymbolsLibrary.swift # Curated care-relevant SF Symbol names for icon picker
└── Views/
├── CaregiverMode/
│   ├── ResidentListView.swift     # Searchable resident list with add/delete
│   ├── ResidentRowView.swift      # Individual resident row
│   ├── ResidentAvatarView.swift   # Photo or initial fallback avatar
│   ├── AddResidentView.swift      # Form to create a new resident
│   ├── EmptyResidentListView.swift
│   ├── AddSymbolView.swift        # Form to add a symbol to a resident's board
│   └── IconPickerView.swift       # Searchable SF Symbols grid picker
├── ResidentMode/
│   ├── ResidentBoardView.swift    # Stage-aware symbol grid with edit mode support
│   ├── SymbolCardView.swift       # Tappable symbol card with TTS and animation
│   └── EmptyBoardView.swift
└── Settings/
└── SettingsView.swift         # Stage picker, edit mode toggle, data reset
```

## CloudKit Setup

CarePrompt uses CloudKit's private database tied to the signed-in iCloud account. For use across multiple devices in a care facility, all devices should be signed into a shared facility iCloud account. Data syncs automatically when connectivity is available and works fully offline otherwise.

## Known Limitations

- Indigenous Canadian languages (Inuktitut, Cree, Dene, etc.) are not supported by iOS's AVSpeechSynthesizer. The preferred language field is stored and passed correctly — iOS falls back to default voice behaviour for unsupported locales. This is a platform limitation, not a bug.
- Symbol sort order is append-only in v1 — new symbols are added to the end of the board. Drag-to-reorder is planned for v1.1.

## Status

✅ v1 complete — full communication loop, CloudKit sync, caregiver tools
🚧 Drag-to-reorder symbols — planned for v1.1
🚧 Session logging — planned for v1.1
🚧 Edit resident profile — planned for v1.1
