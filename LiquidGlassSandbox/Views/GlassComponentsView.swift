import SwiftUI

// MARK: - Glass Components View
// Showcases all available glass materials and morphism effects in iOS 18
// ✅ Updated to use design system theme tokens throughout
struct GlassComponentsView: View {

    // MARK: - View Body
    var body: some View {
        // NavigationStack provides the navigation structure for this tab
        NavigationStack {
            ScrollView {
                VStack(spacing: AppTheme.spacingLoose) {  // Use design system spacing (24pt)

                    // MARK: Header
                    // Creates visual hierarchy and context for the user
                    Text("Materials")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color.textPrimary)  // Design system text color
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(AppTheme.spacingStandard)  // Design system spacing (16pt)

                    // MARK: Ultra Thin Material
                    // Demonstrates the most transparent glass option
                    VStack(spacing: AppTheme.spacingCompact) {  // Design system spacing (12pt)
                        Text("Ultra Thin Material")
                            .font(.headline)
                            .foregroundStyle(Color.textPrimary)  // Design system text color
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, AppTheme.spacingCompact)

                        // ZStack layers views on top of each other
                        // Background image shows through the glass
                        ZStack {
                            // Background: gradient to simulate depth
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.brandPrimary.opacity(0.4),
                                    Color.brandDark.opacity(7)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )

                            // Foreground: glass overlay
                            // .ultraThinMaterial creates a subtle frosted glass effect
                            VStack {
                                Text("Maximum Transparency")
                                    .font(.body)
                                    .foregroundColor(Color.textPrimary)  // White text for visibility
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 120)
                            .background(.ultraThinMaterial)  // Apply glass effect
                            .cornerRadius(AppTheme.cornerRadiusLarge)  // Design system corner radius (12pt)
                            .padding(.horizontal, AppTheme.spacingLoose)
                        }
                        .frame(height: 180)
                        .cornerRadius(AppTheme.cornerRadiusLarge)  // Design system corner radius (12pt)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, AppTheme.spacingLoose)  // Design system spacing (24pt)
                    .themedContainer()  // Use themed card background (Griege 200)

                    // MARK: Thin Material
                    // Medium transparency glass option
                    VStack(spacing: AppTheme.spacingCompact) {  // Design system spacing (12pt)
                        Text("Thin Material")
                            .font(.headline)
                            .foregroundStyle(Color.textPrimary)  // Design system text color
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, AppTheme.spacingCompact)
                        
                        ZStack {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.brandPrimary.opacity(0.4),
                                    Color.brandDark.opacity(7)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )

                            VStack {
                                Text("Balanced Blur & Clarity")
                                    .font(.body)
                                    .foregroundColor(Color.textPrimary)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 120)
                            .background(.thinMaterial)  // Slightly more blur than ultraThin
                            .cornerRadius(AppTheme.cornerRadiusLarge)  // Design system corner radius (12pt)
                            .padding(.horizontal, AppTheme.spacingLoose)
                        }
                        .frame(height: 180)
                        .cornerRadius(AppTheme.cornerRadiusLarge)  // Design system corner radius (12pt)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, AppTheme.spacingLoose)  // Design system spacing (24pt)
                    .themedContainer()  // Use themed card background (Griege 200)

                    // MARK: Regular Material
                    // Strong glass effect with visible blur
                    VStack(spacing: AppTheme.spacingCompact) {  // Design system spacing (12pt)
                        Text("Regular Material")
                            .font(.headline)
                            .foregroundStyle(Color.textPrimary)  // Design system text color
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ZStack {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.brandPrimary.opacity(0.4),
                                    Color.brandDark.opacity(7)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )

                            VStack {
                                Text("Strong Blur Effect")
                                    .font(.body)
                                    .foregroundColor(Color.textPrimary)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 120)
                            .background(.regularMaterial)  // Noticeable blur intensity
                            .cornerRadius(AppTheme.cornerRadiusLarge)  // Design system corner radius (12pt)
                            .padding(.horizontal, AppTheme.spacingLoose)
                        }
                        .frame(height: 180)
                        .cornerRadius(AppTheme.cornerRadiusLarge)  // Design system corner radius (12pt)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, AppTheme.spacingLoose)  // Design system spacing (24pt)
                    .themedContainer()  // Use themed card background (Griege 200)

                    // MARK: Thick Material
                    // Maximum opacity and blur for glass effect
                    VStack(spacing: AppTheme.spacingCompact) {  // Design system spacing (12pt)
                        Text("Thick Material")
                            .font(.headline)
                            .foregroundStyle(Color.textPrimary)  // Design system text color
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, AppTheme.spacingLoose)

                        ZStack {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.brandPrimary.opacity(0.4),
                                    Color.brandDark.opacity(7)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )

                            VStack {
                                Text("Maximum Opacity")
                                    .font(.body)
                                    .foregroundColor(Color.textPrimary)
                            }
                            .padding(.horizontal, AppTheme.spacingLoose)
                            .frame(height: 120)
                            .padding(.horizontal, AppTheme.spacingLoose)
                            .background(.thickMaterial)  // Strongest blur, most opaque
                            .cornerRadius(AppTheme.cornerRadiusLarge)  // Design system corner radius (12pt)
                        }
                        .frame(height: 180)
                        .cornerRadius(AppTheme.cornerRadiusLarge)  // Design system corner radius (12pt)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, AppTheme.spacingLoose)  // Design system spacing (24pt)
                    .themedContainer()  // Use themed card background (Griege 200)

                }
            }
            .navigationTitle("Glass Components")  // Title in navigation bar
            .themedAppBackground()  // Apply design system background (Griege 050)
        }
        .tint(DesignSystemGlobal.BrandBrand300)  // Brand orange for tappable elements
    }
}

// MARK: - Preview
#Preview {
    GlassComponentsView()
}
