import SwiftUI

// MARK: - Adaptive UI View
// Showcases responsive layouts that adapt to device orientation and screen size
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
                                Text("Tap to view details")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 8)
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
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                        .background(.gray.opacity(0.05))
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
                            Text("Adaptive layout example")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .navigationTitle("Adaptive Layouts")
            }
        }
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
            VStack(spacing: 20) {
                // MARK: Header with Icon
                VStack(spacing: 12) {
                    // Icon changes based on which item is selected
                    Image(systemName: getIconName(for: itemIndex))
                        .font(.system(size: 48))
                        .foregroundColor(.blue)

                    // Title based on item index
                    Text("Feature \(itemIndex + 1)")
                        .font(.system(size: 28, weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .padding(24)
                .glassEffect(in: .rect(cornerRadius: 16))  // Liquid Glass effect
                .padding()

                // MARK: Content Description
                // Shows different text based on the selected feature
                VStack(spacing: 12) {
                    Text("Adaptive Layout Details")
                        .font(.headline)

                    Text(getDescription(for: itemIndex))
                        .font(.body)
                        .lineLimit(nil)  // Allow unlimited lines
                        .foregroundColor(.gray)
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(12)
                .padding()

                // MARK: Interactive Example
                // Demonstrates responsive design with state changes
                VStack(spacing: 12) {
                    Text("Responsive Grid Example")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Grid of items that adapts to available space
                    VStack(spacing: 8) {
                        HStack(spacing: 8) {
                            ForEach(0..<2, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.regularMaterial)
                                    .frame(height: 80)
                            }
                        }

                        HStack(spacing: 8) {
                            ForEach(0..<2, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.regularMaterial)
                                    .frame(height: 80)
                            }
                        }
                    }
                }
                .padding()
                .background(.gray.opacity(0.05))
                .cornerRadius(12)
                .padding()
            }
            .padding(.vertical)
        }
        .navigationTitle("Feature Details")
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
