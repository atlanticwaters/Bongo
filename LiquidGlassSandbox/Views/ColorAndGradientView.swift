import SwiftUI

// MARK: - Color and Gradient View
// Demonstrates the Liquid Glass color system and how colors adapt to light/dark modes
struct ColorAndGradientView: View {

    // MARK: - Environment Property
    @Environment(\.colorScheme) var colorScheme  // Reads current light/dark mode

    // MARK: - View Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // MARK: Header
                    Text("Liquid Glass Colors")
                        .font(.system(size: 28, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()

                    // MARK: Semantic Colors Section
                    VStack(spacing: 12) {
                        Text("Semantic Colors")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Colors that automatically adapt to light and dark modes")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // Grid of semantic color swatches
                        VStack(spacing: 8) {
                            // Primary color
                            HStack {
                                Text("Primary")
                                    .font(.body)
                                Spacer()
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.blue)
                                    .frame(width: 60, height: 40)
                            }
                            .padding(12)
                            .background(.thinMaterial)
                            .cornerRadius(8)

                            // Secondary color
                            HStack {
                                Text("Secondary")
                                    .font(.body)
                                Spacer()
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.gray)
                                    .frame(width: 60, height: 40)
                            }
                            .padding(12)
                            .background(.thinMaterial)
                            .cornerRadius(8)

                            // Success color
                            HStack {
                                Text("Success")
                                    .font(.body)
                                Spacer()
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.green)
                                    .frame(width: 60, height: 40)
                            }
                            .padding(12)
                            .background(.thinMaterial)
                            .cornerRadius(8)

                            // Warning color
                            HStack {
                                Text("Warning")
                                    .font(.body)
                                Spacer()
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.orange)
                                    .frame(width: 60, height: 40)
                            }
                            .padding(12)
                            .background(.thinMaterial)
                            .cornerRadius(8)

                            // Destructive color
                            HStack {
                                Text("Destructive")
                                    .font(.body)
                                Spacer()
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.red)
                                    .frame(width: 60, height: 40)
                            }
                            .padding(12)
                            .background(.thinMaterial)
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(.gray.opacity(0.05))
                    .cornerRadius(12)

                    // MARK: Gradient Examples
                    VStack(spacing: 12) {
                        Text("Gradient Systems")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // Linear gradient
                        VStack(spacing: 8) {
                            Text("Linear Gradient")
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            .blue.opacity(0.8),
                                            .purple.opacity(0.8),
                                            .pink.opacity(0.8)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(height: 100)
                        }

                        // Radial gradient
                        VStack(spacing: 8) {
                            Text("Radial Gradient")
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    RadialGradient(
                                        gradient: Gradient(colors: [
                                            .yellow.opacity(0.8),
                                            .orange.opacity(0.8)
                                        ]),
                                        center: .center,
                                        startRadius: 5,
                                        endRadius: 100
                                    )
                                )
                                .frame(height: 100)
                        }

                        // Angular gradient (iOS 18)
                        VStack(spacing: 8) {
                            Text("Angular Gradient")
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    AngularGradient(
                                        gradient: Gradient(colors: [
                                            .red, .yellow, .green, .blue, .purple, .red
                                        ]),
                                        center: .center
                                    )
                                )
                                .frame(height: 100)
                        }
                    }
                    .padding()
                    .background(.gray.opacity(0.05))
                    .cornerRadius(12)

                    // MARK: Opacity and Transparency
                    VStack(spacing: 12) {
                        Text("Opacity Variations")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // Show same color at different opacity levels
                        ForEach([1.0, 0.8, 0.6, 0.4, 0.2], id: \.self) { opacity in
                            HStack {
                                Text("Opacity: \(String(format: "%.0f%%", opacity * 100))")
                                    .font(.body)
                                Spacer()
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.blue.opacity(opacity))
                                    .frame(width: 60, height: 40)
                            }
                            .padding(12)
                            .background(.thinMaterial)
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(.gray.opacity(0.05))
                    .cornerRadius(12)

                    // MARK: Color Mode Indicator
                    VStack(spacing: 12) {
                        Text("Current Color Mode")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack {
                            Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill")
                                .font(.system(size: 24))

                            Text(colorScheme == .dark ? "Dark Mode" : "Light Mode")
                                .font(.headline)

                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(.regularMaterial)
                        .cornerRadius(12)
                    }
                    .padding()
                    .background(.gray.opacity(0.05))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle("Colors & Gradients")
        }
    }
}

// MARK: - Preview
#Preview {
    ColorAndGradientView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    ColorAndGradientView()
        .preferredColorScheme(.dark)
}
