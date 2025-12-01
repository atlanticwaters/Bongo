import SwiftUI

// MARK: - App Background Modifier
// Applies consistent Griege 050 background to all views in the app
struct AppBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(DesignSystemGlobal.TransparentBlackTransparentBlack050.ignoresSafeArea())
    }
}

// MARK: - View Extension
// Convenient extension to apply the background modifier
extension View {
    func appBackground() -> some View {
        modifier(AppBackgroundModifier())
    }
}
