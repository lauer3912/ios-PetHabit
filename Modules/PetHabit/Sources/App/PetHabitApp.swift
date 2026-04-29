import SwiftUI

@main
struct PetHabitApp: App {
    @StateObject private var petStore = PetStore()
    @StateObject private var themeService = ThemeService()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(petStore)
                .environmentObject(themeService)
        }
    }
}
