import SwiftUI

// MARK: - Glass Components View
// Showcases all available glass materials and morphism effects in iOS 18
struct GlassComponentsView: View {

    // MARK: - View Body
    var body: some View {
        // NavigationStack provides the navigation structure for this tab
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    // MARK: Header
                    // Creates visual hierarchy and context for the user
                    Text("Glass Morphism Materials")
                        .font(.system(size: 28, weight: .bold))  // Large, bold text
                        .frame(maxWidth: .infinity, alignment: .leading)  // Align to left
                        .padding()

                    // MARK: Ultra Thin Material
                    // Demonstrates the most transparent glass option
                    VStack(spacing: 8) {
                        Text("Ultra Thin Material")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // ZStack layers views on top of each other
                        // Background image shows through the glass
                        ZStack {
                            // Background: gradient to simulate depth
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.blue.opacity(0.3),
                                    Color.purple.opacity(0.2)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )

                            // Foreground: glass overlay
                            // .ultraThinMaterial creates a subtle frosted glass effect
                            VStack {
                                Text("Maximum Transparency")
                                    .font(.body)
                                    .foregroundColor(.white)  // White text for visibility
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 120)
                            .background(.ultraThinMaterial)  // Apply glass effect
                            .cornerRadius(16)  // Rounded corners for modern look
                        }
                        .frame(height: 180)
                        .cornerRadius(16)
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(12)

                    // MARK: Thin Material
                    // Medium transparency glass option
                    VStack(spacing: 8) {
                        Text("Thin Material")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ZStack {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.green.opacity(0.3),
                                    Color.cyan.opacity(0.2)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )

                            VStack {
                                Text("Balanced Blur & Clarity")
                                    .font(.body)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 120)
                            .background(.thinMaterial)  // Slightly more blur than ultraThin
                            .cornerRadius(16)
                        }
                        .frame(height: 180)
                        .cornerRadius(16)
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(12)

                    // MARK: Regular Material
                    // Strong glass effect with visible blur
                    VStack(spacing: 8) {
                        Text("Regular Material")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ZStack {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.red.opacity(0.3),
                                    Color.orange.opacity(0.2)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )

                            VStack {
                                Text("Strong Blur Effect")
                                    .font(.body)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 120)
                            .background(.regularMaterial)  // Noticeable blur intensity
                            .cornerRadius(16)
                        }
                        .frame(height: 180)
                        .cornerRadius(16)
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(12)

                    // MARK: Thick Material
                    // Maximum opacity and blur for glass effect
                    VStack(spacing: 8) {
                        Text("Thick Material")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ZStack {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.yellow.opacity(0.3),
                                    Color.pink.opacity(0.2)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )

                            VStack {
                                Text("Maximum Opacity")
                                    .font(.body)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 120)
                            .background(.thickMaterial)  // Strongest blur, most opaque
                            .cornerRadius(16)
                        }
                        .frame(height: 180)
                        .cornerRadius(16)
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(12)

                    // MARK: Liquid Glass Material
                    // iOS 18 specific glass effect optimized for modern design
                    VStack(spacing: 8) {
                        Text("Liquid Glass (iOS 18)")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ZStack {
                            // Complex gradient for visual richness
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.blue.opacity(0.4),
                                    Color.purple.opacity(0.3)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )

                            VStack(spacing: 12) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 32))
                                    .foregroundColor(.white)

                                Text("Modern Glass Design")
                                    .font(.body)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 120)
                            .background(.regularMaterial)  // Using regularMaterial for compatibility
                            .cornerRadius(16)
                        }
                        .frame(height: 180)
                        .cornerRadius(16)
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle("Glass Components")  // Title in navigation bar
        }
    }
}

// MARK: - Preview
#Preview {
    GlassComponentsView()
}
