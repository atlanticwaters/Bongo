import SwiftUI

// MARK: - Adaptive UI View
// Showcases responsive layouts that adapt to device orientation and screen size
// ✅ Updated to use design system theme tokens throughout
struct AdaptiveUIView: View {

    // MARK: - Environment Properties
    // @Environment reads system-wide values without manually passing them
    @Environment(\.horizontalSizeClass) var horizontalSizeClass  // Compact or Regular width
    @Environment(\.verticalSizeClass) var verticalSizeClass      // Compact or Regular height

    // MARK: - State Property
    // Tracks whether we're in detail view or list view (for iPad/Mac navigation)
    @State private var selectedItem: Int?

    // MARK: - View Body
    var body: some View {
        NavigationStack {
            // Check if we have regular (wide) horizontal space
            // This is true on iPad landscape, Mac, or modern larger devices
            if horizontalSizeClass == .regular {
                // MARK: iPad/Wide Layout - Side-by-side navigation
                // Creates a split view: list on left, detail on right
                HStack(spacing: 0) {
                    // Left: Master list of items
                    List(0..<6, id: \.self) { index in
                        NavigationLink(value: index) {
                            // Each list item displays information
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Feature \(index + 1)")
                                    .font(.headline)
                                    .foregroundStyle(Color.textPrimary)  // Design system text color
                                Text("Tap to view details")
                                    .font(.caption)
                                    .foregroundStyle(Color.textSecondary)  // Design system text color
                            }
                            .padding(.vertical, AppTheme.spacingCompact)  // Design system spacing (12pt)
                        }
                    }
                    .frame(maxWidth: 300)  // Fixed width for master list

                    // Divider between list and detail
                    Divider()

                    // Right: Detail view for selected item
                    if let selectedItem = selectedItem {
                        DetailPanel(itemIndex: selectedItem)
                            .frame(maxWidth: .infinity)  // Take remaining space
                    } else {
                        // Placeholder when nothing is selected
                        VStack {
                            Text("Select an item")
                                .font(.headline)
                                .foregroundStyle(Color.textSecondary)  // Design system text color
                        }
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                        .background(Color.appBackground)  // Design system background
                    }
                }
                .navigationDestination(
                    isPresented: Binding(
                        get: { selectedItem != nil },
                        set: { if !$0 { selectedItem = nil } }
                    )
                ) {
                    if let selectedItem = selectedItem {
                        DetailPanel(itemIndex: selectedItem)
                    }
                }
                .navigationTitle("Adaptive Layouts")
            } else {
                // MARK: iPhone/Compact Layout - Stacked navigation
                // On smaller screens, items stack vertically
                List(0..<6, id: \.self) { index in
                    NavigationLink(destination: DetailPanel(itemIndex: index)) {
                        // Each list item
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Feature \(index + 1)")
                                .font(.headline)
                                .foregroundStyle(Color.textPrimary)  // Design system text color
                            Text("Adaptive layout example")
                                .font(.caption)
                                .foregroundStyle(Color.textSecondary)  // Design system text color
                        }
                        .padding(.vertical, AppTheme.spacingCompact)  // Design system spacing (12pt)
                    }
                }
                .navigationTitle("Adaptive Layouts")
            }
        }
        .themedAppBackground()  // Apply design system background (Griege 050)
        .tint(DesignSystemGlobal.BrandBrand300)  // Brand orange for tappable elements
    }
}

// MARK: - Detail Panel Component
// Reusable view that displays detailed information about a selected item
struct DetailPanel: View {

    // MARK: - Properties
    let itemIndex: Int

    // MARK: - View Body
    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.spacingLoose) {  // Design system spacing (24pt)
                // MARK: Header with Icon
                VStack(spacing: AppTheme.spacingCompact) {  // Design system spacing (12pt)
                    // Icon changes based on which item is selected
                    Image(systemName: getIconName(for: itemIndex))
                        .font(.system(size: 48))
                        .brandTinted()  // Apply brand color to icon

                    // Title based on item index
                    Text("Feature \(itemIndex + 1)")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color.textPrimary)  // Design system text color
                }
                .frame(maxWidth: .infinity)
                .padding(AppTheme.spacingLoose)  // Design system spacing (24pt)
                .glassEffect(in: .rect(cornerRadius: AppTheme.cornerRadiusLarge))  // Liquid Glass with design system corner radius
                .padding(AppTheme.spacingStandard)  // Design system spacing (16pt)

                // MARK: Content Description
                // Shows different text based on the selected feature
                VStack(spacing: AppTheme.spacingCompact) {  // Design system spacing (12pt)
                    Text("Adaptive Layout Details")
                        .font(.headline)
                        .foregroundStyle(Color.textPrimary)  // Design system text color

                    Text(getDescription(for: itemIndex))
                        .font(.body)
                        .lineLimit(nil)  // Allow unlimited lines
                        .foregroundStyle(Color.textSecondary)  // Design system text color
                }
                .padding(AppTheme.spacingStandard)  // Design system spacing (16pt)
                .themedCard()  // Use themed card background (Griege 200)
                .padding(AppTheme.spacingStandard)  // Design system spacing (16pt)

                // MARK: Interactive Example
                // Demonstrates responsive design with state changes
                VStack(spacing: AppTheme.spacingCompact) {  // Design system spacing (12pt)
                    Text("Responsive Grid Example")
                        .font(.headline)
                        .foregroundStyle(Color.textPrimary)  // Design system text color
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Grid of items that adapts to available space
                    VStack(spacing: AppTheme.spacingCompact) {  // Design system spacing (12pt)
                        HStack(spacing: AppTheme.spacingCompact) {  // Design system spacing (12pt)
                            ForEach(0..<2, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: AppTheme.cornerRadiusStandard)  // Design system corner radius (8pt)
                                    .fill(.regularMaterial)
                                    .frame(height: 80)
                            }
                        }

                        HStack(spacing: AppTheme.spacingCompact) {  // Design system spacing (12pt)
                            ForEach(0..<2, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: AppTheme.cornerRadiusStandard)  // Design system corner radius (8pt)
                                    .fill(.regularMaterial)
                                    .frame(height: 80)
                            }
                        }
                    }
                }
                .themedContainer()  // Use themed card background (Griege 200)
                .padding(AppTheme.spacingStandard)  // Design system spacing (16pt)
            }
            .padding(.vertical)
        }
        .navigationTitle("Feature Details")
        .tint(DesignSystemGlobal.BrandBrand300)  // Brand orange for tappable elements
    }

    // MARK: - Helper Methods
    // Provides different content based on the selected item

    func getIconName(for index: Int) -> String {
        let icons = ["square.and.pencil", "rectangle.expand.vertical", "drop.fill",
                     "hand.tap", "paintpalette", "sparkles"]
        return icons[index % icons.count]
    }

    func getDescription(for index: Int) -> String {
        let descriptions = [
            "This feature demonstrates glass morphism with adaptive layouts.",
            "Responsive design that changes based on available space.",
            "Dynamic content that adapts to different screen orientations.",
            "Interactive elements with smooth animations.",
            "Color system that responds to light and dark modes.",
            "Modern iOS 18 design patterns and best practices."
        ]
        return descriptions[index]
    }
}

// MARK: - Preview
#Preview {
    AdaptiveUIView()
}
