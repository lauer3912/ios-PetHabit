import SwiftUI
import Combine

class ThemeService: ObservableObject {
    @Published var isDarkMode: Bool = false

    var backgroundColor: Color {
        isDarkMode ? Color(hex: "1A1A2E") : Color(hex: "FFF8F0")
    }

    var cardBackground: Color {
        isDarkMode ? Color(hex: "2D2D44") : .white
    }

    var primaryColor: Color {
        Color(hex: "FF8C00")
    }

    var secondaryColor: Color {
        Color(hex: "FF6B6B")
    }

    var textPrimary: Color {
        isDarkMode ? .white : Color(hex: "2D3436")
    }

    var textSecondary: Color {
        isDarkMode ? .gray : Color(hex: "636E72")
    }

    func toggleDarkMode() {
        isDarkMode.toggle()
    }
}
