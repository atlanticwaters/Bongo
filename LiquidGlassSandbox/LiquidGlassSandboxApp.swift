import SwiftUI

// MARK: - App Entry Point
// The @main attribute tells SwiftUI this is the app's starting point
@main
struct LiquidGlassSandboxApp: App {

    // MARK: - App Body
    // This closure returns the root view hierarchy
    // 'some Scene' means this returns one or more scenes
    var body: some Scene {
        // WindowGroup creates the main app window and handles lifecycle
        WindowGroup {
            // ContentView is our root view container
            ContentView()
        }
    }
}
