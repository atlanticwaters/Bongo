import SwiftUI

// MARK: - Design System Type Alias
/// Using a typealias for cleaner access to design tokens
private typealias DS = DesignSystemGlobal

// MARK: - Main Header View
/// A navigation header that morphs between action buttons and a search bar.
/// Uses matchedGeometryEffect to create smooth transitions between states.
struct MorphingNavHeader: View {
    
    // MARK: - State
    @State private var isSearching = false
    @State private var searchText = ""
    
    // Namespace for matched geometry effect - this is what enables the morph
    @Namespace private var morphNamespace
    
    // MARK: - Sizing from Design System
    private let buttonSize = DS.Spacing11          // 44pt - button dimensions
    private let iconSize = DS.FontFontSizeBodyXl   // 20pt - icon size
    private let searchIconSize = DS.Spacing4       // 16pt - smaller search bar icons
    private let closeIconSize = DS.FontFontSizeBodyLg // 18pt - close button icon
    
    // MARK: - Spacing from Design System
    private let buttonSpacing = DS.Spacing2        // 8pt - space between action buttons
    private let containerSpacing = DS.Spacing3     // 12pt - space between back button and content
    private let horizontalPadding = DS.Spacing4    // 16pt - outer horizontal padding
    private let verticalPadding = DS.Spacing3      // 12pt - outer vertical padding
    private let searchBarPadding = DS.Spacing4     // 16pt - internal search bar padding
    private let searchBarSpacing = DS.Spacing3     // 12pt - space between search bar elements
    
    // MARK: - Colors from Design System
    private let iconColor = DS.TextOnSurfaceColorPrimary
    private let iconColorSecondary = DS.TextOnSurfaceColorTertiary
    private let backgroundColor = DS.BackgroundContainerColorWhite
    
    // MARK: - Elevation from Design System
    private let shadowColor = DS.Shadow100         // 10% black shadow
    private let shadowRadius = DS.ElevationBlurRadiusBlur2  // 8pt blur
    private let shadowY = DS.ElevationPositionY2   // 3pt y offset
    
    var body: some View {
        HStack(spacing: containerSpacing) {
            // Back button - always visible, doesn't participate in morph
            backButton
            
            if isSearching {
                // Search bar state
                searchBar
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
            } else {
                Spacer()
                
                // Action buttons state
                actionButtons
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isSearching)
    }
    
    // MARK: - Back Button
    private var backButton: some View {
        Button(action: {
            // Handle back navigation
            print("Back tapped")
        }) {
            Image(systemName: "chevron.left")
                .font(.system(size: iconSize, weight: .medium))
                .foregroundStyle(iconColor)
                .frame(width: buttonSize, height: buttonSize)
                .background(
                    Circle()
                        .fill(.clear)
                        .glassEffect(.regular, in: .circle)
                        .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: shadowY)
                )
        }
    }
    
    // MARK: - Action Buttons (Default State)
    private var actionButtons: some View {
        HStack(spacing: buttonSpacing) {
            // Favorite button
            CircleButton(
                icon: "heart",
                iconColor: iconColor,
                backgroundColor: backgroundColor,
                buttonSize: buttonSize,
                iconSize: closeIconSize,
                shadowColor: shadowColor,
                shadowRadius: shadowRadius,
                shadowY: shadowY,
                namespace: morphNamespace,
                id: "favorite"
            ) {
                print("Favorite tapped")
            }
            
            // Share button
            CircleButton(
                icon: "square.and.arrow.up",
                iconColor: iconColor,
                backgroundColor: backgroundColor,
                buttonSize: buttonSize,
                iconSize: closeIconSize,
                shadowColor: shadowColor,
                shadowRadius: shadowRadius,
                shadowY: shadowY,
                namespace: morphNamespace,
                id: "share"
            ) {
                print("Share tapped")
            }
            
            // Search button - this morphs into the search bar
            CircleButton(
                icon: "magnifyingglass",
                iconColor: iconColor,
                backgroundColor: backgroundColor,
                buttonSize: buttonSize,
                iconSize: closeIconSize,
                shadowColor: shadowColor,
                shadowRadius: shadowRadius,
                shadowY: shadowY,
                namespace: morphNamespace,
                id: "searchContainer"
            ) {
                isSearching = true
            }
        }
    }
    
    // MARK: - Search Bar (Search State)
    private var searchBar: some View {
        HStack(spacing: searchBarSpacing) {
            // Search icon
            Image(systemName: "magnifyingglass")
                .font(.system(size: searchIconSize, weight: .medium))
                .foregroundStyle(iconColorSecondary)
            
            // Text field
            TextField("Search", text: $searchText)
                .textFieldStyle(.plain)
                .font(.body)
                .foregroundStyle(iconColor)
            
            // Close button
            Button(action: {
                searchText = ""
                isSearching = false
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: closeIconSize))
                    .foregroundStyle(iconColorSecondary)
            }
        }
        .padding(.horizontal, searchBarPadding)
        .frame(height: buttonSize)
        .background(
            Capsule()
                .fill(.clear)
                .glassEffect(.regular, in: .capsule)
                .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: shadowY)
        )
        // This matches with the search button's geometry
        .matchedGeometryEffect(id: "searchContainer", in: morphNamespace)
    }
}

// MARK: - Circle Button Component
/// A reusable circular button with shadow and optional matched geometry.
struct CircleButton: View {
    let icon: String
    let iconColor: Color
    let backgroundColor: Color
    let buttonSize: CGFloat
    let iconSize: CGFloat
    let shadowColor: Color
    let shadowRadius: CGFloat
    let shadowY: CGFloat
    let namespace: Namespace.ID
    let id: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: iconSize, weight: .medium))
                .foregroundStyle(iconColor)
                .frame(width: buttonSize, height: buttonSize)
                .background(
                    Circle()
                        .fill(.clear)
                        .glassEffect(.regular, in: .circle)
                        .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: shadowY)
                )
        }
        .matchedGeometryEffect(id: id, in: namespace)
    }
}

// MARK: - Preview
#Preview {
    VStack {
        MorphingNavHeader()
        Spacer()
    }
   // .background(DesignSystemGlobal.BackgroundSurfaceColorGreige)
}
