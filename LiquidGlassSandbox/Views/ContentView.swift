import SwiftUI

// MARK: - Main Content View
// This is the root view that organizes all sandbox demonstrations
struct ContentView: View {

    // MARK: - State Properties
    // Tracks which tab/section the user is currently viewing
    @State private var selectedTab: TabSelection = .glassComponents

    // MARK: - Enum for Tab Navigation
    // Using an enum ensures type-safe navigation - prevents invalid states
    enum TabSelection {
        case glassComponents
        case adaptiveUI
        case dynamicBlur
        case interactive
        case colorSystem
    }

    // MARK: - View Body
    var body: some View {
        // TabView creates a tab-based navigation interface
        TabView(selection: $selectedTab) {

            // MARK: Glass Components Tab
            // First tab: displays various glass morphism examples
            GlassComponentsView()
                .tag(TabSelection.glassComponents)  // Links this view to the tab
                .tabItem {
                    Label("Glass", systemImage: "square.and.pencil")  // Icon + label for tab
                }

            // MARK: Adaptive UI Tab
            // Second tab: shows responsive layout demonstrations
            AdaptiveUIView()
                .tag(TabSelection.adaptiveUI)
                .tabItem {
                    Label("Adaptive", systemImage: "rectangle.expand.vertical")
                }

            // MARK: Dynamic Blur Tab
            // Third tab: blur effect variations
            DynamicBlurView()
                .tag(TabSelection.dynamicBlur)
                .tabItem {
                    Label("Blur", systemImage: "drop.fill")
                }

            // MARK: Interactive Components Tab
            // Fourth tab: interactive glass elements with state changes
            InteractiveGlassView()
                .tag(TabSelection.interactive)
                .tabItem {
                    Label("Interactive", systemImage: "hand.tap")
                }

            // MARK: Color System Tab
            // Fifth tab: Liquid Glass color palette and semantic colors
            ColorAndGradientView()
                .tag(TabSelection.colorSystem)
                .tabItem {
                    Label("Colors", systemImage: "paintpalette")
                }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
