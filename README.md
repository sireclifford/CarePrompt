# CarePrompt

A non-verbal communication aid for residents in long-term care and dementia facilities, built for iOS and iPadOS.

## Why this exists

Communication is one of the first things dementia takes. Residents who can no longer speak reliably still have needs — water, pain, cold, hunger — and expressing them becomes increasingly difficult as the condition progresses.

CarePrompt was built by an iOS developer working as a care aide in a long-term care facility in Northern Canada. Every design decision reflects direct, daily experience with residents and the staff who care for them.

## Features

- **Resident profiles** — each resident has their own communication board with a personalised set of symbols
- **Symbol board** — large, tap-friendly symbol cards with SF Symbols icons and text labels
- **Text-to-speech** — tapping a symbol speaks the word or phrase aloud using AVSpeechSynthesizer, with support for the resident's preferred language
- **Stage-aware layout** — three dementia stage modes (Early, Middle, Late) that adjust card size, column count, and text label visibility to match the resident's cognitive needs
- **Caregiver Mode** — searchable resident list with avatars, unit, and room number
- **Settings** — global stage switcher, app info, and data reset with confirmation
- **Offline-first** — fully functional without internet access

## Tech Stack

- SwiftUI
- SwiftData (local persistence)
- AVFoundation (text-to-speech)
- AppStorage (global preferences)
- CloudKit (planned — multi-device sync)

## Architecture

```
CarePrompt/
├── Models/
│   ├── Resident.swift         # SwiftData model — profile, language, photo
│   └── Symbol.swift           # SwiftData model — text, icon, sort order
├── Enums/
│   └── DementiaStage.swift    # Stage-aware UI configuration
├── Services/
│   └── SpeechService.swift    # Singleton AVSpeechSynthesizer wrapper
├── Utilities/
│   └── SeedData.swift         # Dev seed — populates residents on first launch
└── Views/
    ├── CaregiverMode/
    │   ├── ResidentListView.swift
    │   ├── ResidentRowView.swift
    │   └── ResidentAvatarView.swift
    ├── ResidentMode/
    │   ├── ResidentBoardView.swift
    │   └── SymbolCardView.swift
    └── Settings/
        └── SettingsView.swift
```

## Known Limitations

- Indigenous Canadian languages (Inuktitut, Cree, Dene, etc.) are not supported by iOS's AVSpeechSynthesizer. The preferred language field is stored and passed correctly — iOS falls back to default voice behaviour for unsupported locales. This is a platform limitation, not a bug.
- Symbol boards are currently seeded with development data. A board builder UI for caregivers to create and edit symbols is planned for v1.1.

## Status

✅ Core communication loop complete — resident list → symbol board → tap → speech
🚧 CloudKit sync — planned
🚧 Board builder (caregiver symbol editor) — planned
🚧 Session logging — planned
