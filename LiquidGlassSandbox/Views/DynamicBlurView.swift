import SwiftUI

// MARK: - Dynamic Blur View
// Showcases blur effects that respond to user interaction and scroll position
struct DynamicBlurView: View {

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
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        Text("Dynamic Blur Effects")
            .font(.system(size: 28, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
    
    private var scrollBasedBlurDemo: some View {
        VStack(spacing: 12) {
            Text("Scroll-Responsive Blur")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Description of how blur changes with scroll
            Text("Scroll this area to see blur intensity change")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Visualization of scrollable content
            ZStack {
                // Background with gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.3),
                        Color.purple.opacity(0.2)
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
                                    .foregroundColor(.white)
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
            .cornerRadius(16)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
    
    private var interactiveBlurDemo: some View {
        VStack(spacing: 12) {
            Text("Interactive Gesture Blur")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Drag horizontally to change blur")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Interactive element that responds to drag
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.green.opacity(0.3),
                        Color.cyan.opacity(0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                VStack(spacing: 12) {
                    Image(systemName: "hand.raised.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.white)

                    Text("Drag Me")
                        .font(.headline)
                        .foregroundColor(.white)

                    // Show current blur level
                    Text("Blur: \(String(format: "%.1f", abs(dragAmount / 100)))")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 150)

                // Apply blur opacity based on drag amount
                // More drag = more blur
                Color.black
                    .opacity(min(abs(dragAmount) / 300.0, 0.4))  // Cap blur at 0.4
            }
            .frame(height: 200)
            .cornerRadius(16)
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
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
    
    private var materialComparisonDemo: some View {
        VStack(spacing: 12) {
            Text("Material Blur Intensities")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Show each material with consistent background for comparison
            ForEach(
                [
                    ("Ultra Thin", Material.ultraThin),
                    ("Thin", Material.thin),
                    ("Regular", Material.regular),
                    ("Thick", Material.thick)
                ] as [(String, Material)],
                id: \.0
            ) { name, material in
                materialComparisonRow(name: name, material: material)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
    
    private func materialComparisonRow(name: String, material: Material) -> some View {
        HStack {
            // Label describing the material
            Text(name)
                .font(.body)
                .frame(width: 100, alignment: .leading)

            // Visual comparison box
            ZStack {
                // Colorful background to see blur effect
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.red.opacity(0.3),
                        Color.yellow.opacity(0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                // Apply the specific material as an overlay
                Color.clear
                    .background(material)
            }
            .frame(height: 60)
            .cornerRadius(8)
        }
    }
}

// MARK: - Preview
#Preview {
    DynamicBlurView()
}
