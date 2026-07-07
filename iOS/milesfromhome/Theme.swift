import SwiftUI

/// midnight-map navy with a beacon-gold accent
enum Theme {
    static let background = Color(red: 0.047, green: 0.09, blue: 0.133)
    static let accent = Color(red: 0.949, green: 0.722, blue: 0.02)
    static let ink = Color(red: 0.941, green: 0.961, blue: 0.98)
    static let cardBackground = Color(red: 0.118, green: 0.161, blue: 0.204)
    static let secondaryInk = Color(red: 0.784, green: 0.804, blue: 0.824)

    static let titleFont = Font.system(.largeTitle, design: .rounded).weight(.bold)
    static let headingFont = Font.system(.headline, design: .rounded).weight(.semibold)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 18
}

extension View {
    func themedBackground() -> some View {
        self.background(Theme.background.ignoresSafeArea())
    }
}
