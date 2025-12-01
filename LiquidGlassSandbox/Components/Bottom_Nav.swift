import SwiftUI

// MARK: - Design System Type Alias
private typealias DS = DesignSystemGlobal

// MARK: - Tab Item Model
/// Represents each tab in the navigation bar
struct TabItem: Identifiable, Equatable {
    let id: Int
    let icon: String
    let label: String
}

// MARK: - Main Tab Bar View
/// A tab bar with a morphing background indicator that animates between selected tabs.
/// Uses matchedGeometryEffect for smooth transitions.
struct MorphingTabBar: View {
    
    // MARK: - State
    @State private var selectedTab: Int = 0
    @State private var isProfileActive: Bool = false
    
    // Namespace for matched geometry effect - enables the morph animation
    @Namespace private var tabNamespace
    
    // MARK: - Tab Data
    private let tabs: [TabItem] = [
        TabItem(id: 0, icon: "house", label: "Home"),
        TabItem(id: 1, icon: "tag", label: "Deals"),
        TabItem(id: 2, icon: "list.bullet", label: "Label"),
        TabItem(id: 3, icon: "plus", label: "Label")
    ]
    
    // MARK: - Colors from Design System
    private let activeColor = DS.BackgroundButtonColorBrandFilledDefault   // Orange primary
    private let inactiveColor = DS.TextOnSurfaceColorTertiary              // Gray for inactive icons
    private let backgroundColor = DS.TransparentBlackTransparentBlack050          // White for indicator
    private let pillBackground = DS.GreigeGreige100                         // Warm gray for pill container
    
    // MARK: - Spacing from Design System
    private let tabHeight = DS.Spacing14           // 56pt - tab container height
    private let profileButtonSize = DS.Spacing12   // 48pt - profile button size
    private let iconSize = DS.FontFontSizeBodyXl   // 20pt - icon size
    private let labelSize = DS.FontFontSizeCaption // 11pt - label text size
    private let indicatorPadding = DS.Spacing1     // 4pt - padding inside pill (using 1 which is 4pt based on comment)
    private let tabWidth = DS.Spacing18            // 60pt - individual tab width
    private let horizontalPadding = DS.Spacing5    // 16pt - outer horizontal padding
    private let verticalPadding = DS.Spacing3      // 12pt - outer vertical padding
    private let containerSpacing = DS.Spacing1     // 12pt - space between pill and profile button
    private let labelSpacing = DS.Spacing2px       // 2pt - space between icon and label
    
    // MARK: - Elevation from Design System
    private let shadowColor = DS.Shadow100         // 10% black shadow
    private let shadowRadius = DS.ElevationBlurRadiusBlur2  // 8pt blur
    private let shadowY = DS.ElevationPositionY2   // 3pt y offset
    
    var body: some View {
        HStack(spacing: containerSpacing) {
            // Main tab pill container
            tabPillContainer
            
            Spacer()
            
            // Separate profile button
            profileButton
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.top, verticalPadding)
        .padding(.bottom, DS.Spacing0) // Content sits above safe area
        //.background(
            //DS.BackgroundSurfaceColorGreige
                //.ignoresSafeArea(edges: .bottom) // Background extends into safe area
    }
    
    // MARK: - Tab Pill Container
    /// The rounded pill containing the 4 main navigation tabs
    private var tabPillContainer: some View {
        HStack(spacing: DS.Spacing0) {
            ForEach(tabs) { tab in
                tabButton(for: tab)
            }
        }
        .padding(indicatorPadding)
        .background(
            Capsule()
                .fill(pillBackground)
        )
    }
    
    // MARK: - Individual Tab Button
    /// A single tab with icon, label, and optional background indicator
    private func tabButton(for tab: TabItem) -> some View {
        let isSelected = selectedTab == tab.id && !isProfileActive
        
        return Button(action: {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                selectedTab = tab.id
                isProfileActive = false
            }
        }) {
            VStack(spacing: labelSpacing) {
                Image(systemName: tab.icon)
                    .font(.system(size: iconSize, weight: .medium))
                
                Text(tab.label)
                    .font(.system(size: labelSize, weight: .medium))
            }
            .foregroundStyle(isSelected ? activeColor : inactiveColor)
            .frame(width: tabWidth, height: tabHeight - (indicatorPadding * 2))
            .background {
                if isSelected {
                    // Morphing background indicator
                    Capsule()
                        .fill(backgroundColor)
                        .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: shadowY)
                        .matchedGeometryEffect(id: "tabIndicator", in: tabNamespace)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Profile Button
    /// Separate circular profile button outside the main tab container
    private var profileButton: some View {
        Button(action: {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                isProfileActive = true
            }
        }) {
            Image(systemName: "person")
                .font(.system(size: iconSize, weight: .medium))
                .foregroundStyle(isProfileActive ? activeColor : inactiveColor)
                .frame(width: profileButtonSize, height: profileButtonSize)
                .background(
                    Circle()
                        .fill(pillBackground)
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview("Tab Bar") {
    VStack(spacing: 0) {
        Spacer()
        MorphingTabBar()
    }
   // .background(DS.BackgroundSurfaceColorGreige)
}

// MARK: - Preview with Full Screen Context
#Preview("Full Screen") {
    ZStack {
        //DS.BackgroundSurfaceColorGreige
            //.ignoresSafeArea()
        
        VStack(spacing: 0) {
            // Header at top
            MorphingNavHeader()
            
            Spacer()
            
            // Tab bar at bottom
            MorphingTabBar()
        }
    }
}
