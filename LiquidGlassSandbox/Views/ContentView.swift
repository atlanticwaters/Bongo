import SwiftUI

// MARK: - Main Content View
// This is the root view that organizes all sandbox demonstrations
struct ContentView: View {
    
    // Note: This view requires the following files to be added to your target:
    // - ThemeExtensions.swift (defines AppTheme and .themedAppBackground())
    // - DesignSystemGlobal.swift (contains design system tokens)
    // - DesignSystemDemoView.swift (the demo view for design tokens)
    // - All other view files referenced below

    // MARK: - State Properties
    // Tracks which tab/section the user is currently viewing
    @State private var selectedTab: TabSelection = .glassComponents
    
    // Theme manager for light/dark/auto mode
    @State private var themeManager = ThemeManager()

    // MARK: - Enum for Tab Navigation
    // Using an enum ensures type-safe navigation - prevents invalid states
    enum TabSelection {
        case glassComponents
        case adaptiveUI
        case dynamicBlur
        case interactive
        case colorSystem
        case themeColors
        case designSystem
        case designSystemDemo
    }

    // MARK: - View Body
    var body: some View {
        ZStack(alignment: .topTrailing) {
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
                
                // MARK: Theme Colors Tab
                // Sixth tab: Interactive theme color reference with background selector
                ThemeColorsPreview()
                    .tag(TabSelection.themeColors)
                    .tabItem {
                        Label("Theme", systemImage: "paintbrush.fill")
                    }

                // MARK: Design System Tab
                // Seventh tab: showcases generated design system tokens in context
                DesignSystemShowcaseView()
                    .tag(TabSelection.designSystem)
                    .tabItem {
                        Label("Design", systemImage: "circle.grid.2x2.fill")
                    }
                
                // MARK: Design System Demo Tab
                // Eighth tab: demonstrates design system token integration
                DesignSystemDemoView()
                    .tag(TabSelection.designSystemDemo)
                    .tabItem {
                        Label("Tokens", systemImage: "doc.text.fill")
                    }
            }
            .environment(themeManager)
            .preferredColorScheme(themeManager.preferredColorScheme)
            .tint(DesignSystemGlobal.BrandBrand300)  // Apply brand color to all tintable elements
            .themedAppBackground()  // Apply theme-aware background
            
            // Theme mode selector in top-right corner
            // Using ZStack instead of overlay to keep it in the SwiftUI hierarchy
            ThemeModeSelector(themeManager: themeManager)
                .padding()
                .padding(.top, 8) // Extra padding to avoid status bar
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
