import SwiftUI
import SwiftData

@main
struct CarePromptApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Resident.self,
            Symbol.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    do {
                        try seedDataIfNeeded(context: sharedModelContainer.mainContext)
                    } catch {
                        print("Seed error: \(error)")
                    }
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
