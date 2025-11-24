import SwiftUI

// MARK: - App Background Modifier
// Applies consistent Greige100 background to all views in the app
struct AppBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(DesignSystemGlobal.GreigeGreige100.ignoresSafeArea())
    }
}

// MARK: - View Extension
// Convenient extension to apply the background modifier
extension View {
    func appBackground() -> some View {
        modifier(AppBackgroundModifier())
    }
}
