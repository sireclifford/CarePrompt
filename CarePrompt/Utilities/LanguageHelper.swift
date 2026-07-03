import AVFoundation
import Foundation

struct LanguageHelper {
    
    struct LanguageOption: Identifiable, Hashable {
        let id: String
        let displayName: String
    }
    
    static var availableLanguages: [LanguageOption] {
        let voices = AVSpeechSynthesisVoice.speechVoices()
        
        var languageMap: [String: String] = [:]
        
        for voice in voices {
            let locale = Locale(identifier: voice.language)
            guard let languageName = locale.localizedString(forLanguageCode: locale.languageCode ?? "") else { continue }
            
            if languageMap[languageName] == nil || voice.language .contains("-CA") {
                languageMap[languageName] = voice.language
            }
        }
        
        return languageMap
            .map { LanguageOption(id: $1, displayName: $0.prefix(1).uppercased() + $0.dropFirst())}
            .sorted { $0.displayName < $1.displayName }
    }
}
