import SwiftUI

// MARK: - Dynamic Blur View
// Showcases blur effects that respond to user interaction and scroll position
struct DynamicBlurView: View {

    // MARK: - Environment
    @Environment(\.colorScheme) var colorScheme

    // MARK: - State Properties
    // Tracks scroll offset to calculate blur intensity
    @State private var scrollOffset: CGFloat = 0

    // Tracks user interaction for interactive blur demo
    @State private var isDragging = false
    @State private var dragAmount: CGFloat = 0

    // MARK: - View Body
    var body: some View {
        NavigationStack {
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack(spacing: 24) {
                        headerView
                        scrollBasedBlurDemo
                        interactiveBlurDemo
                        materialComparisonDemo
                    }
                    .padding()
                }
            }
            .navigationTitle("Dynamic Blur")
            .themedAppBackground()
        }
        .tint(DesignSystemGlobal.BrandBrand300)  // Brand orange for tappable elements
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Dynamic Blur Effects")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary(for: colorScheme))
            
            Text("Experience how blur effects adapt to light and dark modes")
                .font(.subheadline)
                .foregroundStyle(AppTheme.textSecondary(for: colorScheme))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .themedContainer()
    }
    
    private var scrollBasedBlurDemo: some View {
        VStack(spacing: 12) {
            Text("Scroll-Responsive Blur")
                .font(.headline)
                .foregroundStyle(AppTheme.textPrimary(for: colorScheme))
                .frame(maxWidth: .infinity, alignment: .leading)

            // Description of how blur changes with scroll
            Text("Scroll this area to see blur intensity change")
                .font(.caption)
                .foregroundStyle(AppTheme.textSecondary(for: colorScheme))
                .frame(maxWidth: .infinity, alignment: .leading)

            // Visualization of scrollable content
            ZStack {
                // Background with gradient using theme colors
                LinearGradient(
                    gradient: Gradient(colors: [
                        AppTheme.brandColor(for: colorScheme).opacity(0.3),
                        AppTheme.iconAccent(for: colorScheme).opacity(0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                // Scrollable inner content
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 12) {
                        // Generate 5 cards that can be scrolled
                        ForEach(0..<5, id: \.self) { index in
                            VStack {
                                Text("Card \(index + 1)")
                                    .font(.headline)
                                    .foregroundStyle(AppTheme.textPrimary(for: colorScheme))
                            }
                            .frame(width: 120, height: 100)
                            // Blur intensity changes based on scroll: calculated as opacity
                            .background(.regularMaterial)
                            .cornerRadius(12)
                        }
                    }
                    .padding(12)
                }
            }
            .frame(height: 140)
            .cornerRadius(AppTheme.cornerRadiusStandard)
        }
        .padding()
        .background(AppTheme.cardBackground(for: colorScheme).opacity(0.5))
        .cornerRadius(AppTheme.cornerRadiusLarge)
    }
    
    private var interactiveBlurDemo: some View {
        VStack(spacing: 12) {
            Text("Interactive Gesture Blur")
                .font(.headline)
                .foregroundStyle(AppTheme.textPrimary(for: colorScheme))
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Drag horizontally to change blur")
                .font(.caption)
                .foregroundStyle(AppTheme.textSecondary(for: colorScheme))
                .frame(maxWidth: .infinity, alignment: .leading)

            // Interactive element that responds to drag
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        AppTheme.brandColor(for: colorScheme).opacity(0.4),
                        AppTheme.brandColorDark(for: colorScheme).opacity(0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                VStack(spacing: 12) {
                    Image(systemName: "hand.raised.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(AppTheme.textPrimary(for: colorScheme))

                    Text("Drag Me")
                        .font(.headline)
                        .foregroundStyle(AppTheme.textPrimary(for: colorScheme))

                    // Show current blur level
                    Text("Blur: \(String(format: "%.1f", abs(dragAmount / 100)))")
                        .font(.caption)
                        .foregroundStyle(AppTheme.textSecondary(for: colorScheme))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 150)

                // Apply blur overlay based on drag amount
                // More drag = more blur
                (colorScheme == .dark ? Color.white : Color.black)
                    .opacity(min(abs(dragAmount) / 300.0, 0.4))  // Cap blur at 0.4
            }
            .frame(height: 200)
            .cornerRadius(AppTheme.cornerRadiusStandard)
            // DragGesture detects horizontal movement
            .gesture(
                DragGesture()
                    .onChanged { value in
                        isDragging = true
                        // Update drag amount as user moves
                        dragAmount = value.translation.width
                    }
                    .onEnded { _ in
                        isDragging = false
                        // Animate drag amount back to zero
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            dragAmount = 0
                        }
                    }
            )
        }
        .padding()
        .background(AppTheme.cardBackground(for: colorScheme).opacity(0.5))
        .cornerRadius(AppTheme.cornerRadiusLarge)
    }
    
    private var materialComparisonDemo: some View {
        VStack(spacing: 12) {
            Text("Material Blur Intensities")
                .font(.headline)
                .foregroundStyle(AppTheme.textPrimary(for: colorScheme))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("These materials automatically adapt to light and dark mode")
                .font(.caption)
                .foregroundStyle(AppTheme.textSecondary(for: colorScheme))
                .frame(maxWidth: .infinity, alignment: .leading)

            // Show each material with consistent background for comparison
            ForEach(
                [
                    ("Ultra Thin", Material.ultraThin),
                    ("Thin", Material.thin),
                    ("Regular", Material.regular),
                    ("Thick", Material.thick),
                    ("Ultra Thick", Material.ultraThick)
                ] as [(String, Material)],
                id: \.0
            ) { name, material in
                materialComparisonRow(name: name, material: material)
            }
        }
        .padding()
        .background(AppTheme.cardBackground(for: colorScheme).opacity(0.5))
        .cornerRadius(AppTheme.cornerRadiusLarge)
    }
    
    private func materialComparisonRow(name: String, material: Material) -> some View {
        HStack {
            // Label describing the material
            Text(name)
                .font(.body)
                .foregroundStyle(AppTheme.textPrimary(for: colorScheme))
                .frame(width: 100, alignment: .leading)

            // Visual comparison box
            ZStack {
                // Colorful background to see blur effect using theme colors
                LinearGradient(
                    gradient: Gradient(colors: [
                        AppTheme.brandColor(for: colorScheme).opacity(0.5),
                        AppTheme.brandColorDark(for: colorScheme).opacity(0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                // Apply the specific material as an overlay
                Color.clear
                    .background(material)
                
                // Add icon to show material effect
                Image(systemName: "sparkles")
                    .font(.title2)
                    .foregroundStyle(AppTheme.textPrimary(for: colorScheme))
            }
            .frame(height: 60)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppTheme.borderDefault(for: colorScheme), lineWidth: 1)
            )
        }
    }
}

// MARK: - Preview
#Preview("Light Mode") {
    DynamicBlurView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    DynamicBlurView()
        .preferredColorScheme(.dark)
}
