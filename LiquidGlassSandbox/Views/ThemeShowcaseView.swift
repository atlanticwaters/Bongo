import SwiftUI

// MARK: - Design System Theme Showcase
// Presents generated design system tokens in context so they can be demoed in-app.
struct DesignSystemShowcaseView: View {

    // MARK: - Theme Variant
    enum ThemeVariant: String, CaseIterable, Identifiable {
        case lightLarge = "Light · Large"
        case lightMedium = "Light · Medium"
        case darkLarge = "Dark · Large"
        case darkMedium = "Dark · Medium"

        var id: String { rawValue }
    }

    @State private var selectedVariant: ThemeVariant = .lightLarge

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    variantPicker
                    colorSwatches
                    buttonsSection
                    cardSection
                }
                .padding()
            }
            .navigationTitle("Design System")
        }
        .tint(DesignSystemGlobal.BrandBrand300)
    }

    // MARK: - Sections
    private var variantPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Theme Variant")
                .font(.headline)
            Picker("Theme Variant", selection: $selectedVariant) {
                ForEach(ThemeVariant.allCases) { variant in
                    Text(variant.rawValue).tag(variant)
                }
            }
            .pickerStyle(.segmented)
        }
    }

    private var colorSwatches: some View {
        let theme = ThemeTokens(variant: selectedVariant)
        return VStack(alignment: .leading, spacing: 12) {
            Text("Core Colors")
                .font(.headline)
            VStack(spacing: 10) {
                ThemeSwatch(title: "Brand", color: theme.brand, textColor: theme.textOnContainerPrimary)
                ThemeSwatch(title: "Accent", color: theme.accent, textColor: theme.textOnContainerPrimary)
                ThemeSwatch(title: "Success", color: theme.success, textColor: theme.textOnContainerPrimary)
                ThemeSwatch(title: "Warning", color: theme.warning, textColor: theme.textOnContainerPrimary)
                ThemeSwatch(title: "Error", color: theme.error, textColor: theme.textOnContainerPrimary)
            }
            .padding()
            .background(.thinMaterial)
            .cornerRadius(theme.cornerRadius)
        }
    }

    private var buttonsSection: some View {
        let theme = ThemeTokens(variant: selectedVariant)
        return VStack(alignment: .leading, spacing: 12) {
            Text("Buttons")
                .font(.headline)
            VStack(spacing: 12) {
                Button {
                } label: {
                    Text("Primary Filled")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(theme.brand)
                        .foregroundStyle(theme.textOnContainerInverse)
                        .cornerRadius(theme.cornerRadius)
                }

                Button {
                } label: {
                    Text("Ghost / Outline")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: theme.cornerRadius)
                                .stroke(theme.borderOnContainer, lineWidth: 1.5)
                        )
                        .foregroundStyle(theme.textOnContainerPrimary)
                }
                .background(theme.container)
                .cornerRadius(theme.cornerRadius)
            }
            .padding()
            .background(.thinMaterial)
            .cornerRadius(theme.cornerRadius)
        }
    }

    private var cardSection: some View {
        let theme = ThemeTokens(variant: selectedVariant)
        return VStack(alignment: .leading, spacing: 12) {
            Text("Card / List Row")
                .font(.headline)
            VStack(alignment: .leading, spacing: 8) {
                Text("Container background, text, and supporting icon colors pulled from the theme.")
                    .font(.caption)
                    .foregroundColor(theme.textOnContainerSecondary)

                HStack(spacing: 12) {
                    Circle()
                        .fill(theme.accent)
                        .frame(width: 32, height: 32)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Title")
                            .foregroundColor(theme.textOnContainerPrimary)
                            .font(.headline)
                        Text("Subtitle or helper text")
                            .foregroundColor(theme.textOnContainerSecondary)
                            .font(.subheadline)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(theme.textOnContainerSecondary)
                }
                .padding()
                .background(theme.container)
                .cornerRadius(theme.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: theme.cornerRadius)
                        .stroke(theme.borderOnContainer, lineWidth: 1)
                )
            }
            .padding()
            .background(.thinMaterial)
            .cornerRadius(theme.cornerRadius)
        }
    }
}

// MARK: - Theme Tokens
private struct ThemeTokens {
    let brand: Color
    let accent: Color
    let success: Color
    let warning: Color
    let error: Color
    let container: Color
    let borderOnContainer: Color
    let textOnContainerPrimary: Color
    let textOnContainerSecondary: Color
    let textOnContainerInverse: Color
    let cornerRadius: CGFloat

    init(variant: DesignSystemShowcaseView.ThemeVariant) {
        switch variant {
        case .lightLarge:
            brand = DesignSystemLightLarge.BackgroundContainerColorBrand
            accent = DesignSystemLightLarge.BackgroundAccentColorBlue
            success = DesignSystemLightLarge.BackgroundFeedbackColorSuccessAccent2
            warning = DesignSystemLightLarge.BackgroundFeedbackColorWarningAccent2
            error = DesignSystemLightLarge.BackgroundFeedbackColorErrorAccent2
            container = DesignSystemLightLarge.BackgroundContainerColorGreige
            borderOnContainer = DesignSystemLightLarge.BorderOnContainerDefault
            textOnContainerPrimary = DesignSystemLightLarge.TextOnContainerColorPrimary
            textOnContainerSecondary = DesignSystemLightLarge.TextOnContainerColorSecondary
            textOnContainerInverse = DesignSystemLightLarge.TextOnContainerColorInverse
            cornerRadius = DesignSystemLightLarge.BorderRadius3xl
        case .lightMedium:
            brand = DesignSystemLightMedium.BackgroundContainerColorBrand
            accent = DesignSystemLightMedium.BackgroundAccentColorBlue
            success = DesignSystemLightMedium.BackgroundFeedbackColorSuccessAccent2
            warning = DesignSystemLightMedium.BackgroundFeedbackColorWarningAccent2
            error = DesignSystemLightMedium.BackgroundFeedbackColorErrorAccent2
            container = DesignSystemLightMedium.BackgroundContainerColorGreige
            borderOnContainer = DesignSystemLightMedium.BorderOnContainerDefault
            textOnContainerPrimary = DesignSystemLightMedium.TextOnContainerColorPrimary
            textOnContainerSecondary = DesignSystemLightMedium.TextOnContainerColorSecondary
            textOnContainerInverse = DesignSystemLightMedium.TextOnContainerColorInverse
            cornerRadius = DesignSystemLightMedium.BorderRadius3xl
        case .darkLarge:
            brand = DesignSystemDarkLarge.BackgroundContainerColorBrand
            accent = DesignSystemDarkLarge.BackgroundAccentColorBlue
            success = DesignSystemDarkLarge.BackgroundFeedbackColorSuccessAccent2
            warning = DesignSystemDarkLarge.BackgroundFeedbackColorWarningAccent2
            error = DesignSystemDarkLarge.BackgroundFeedbackColorErrorAccent2
            container = DesignSystemDarkLarge.BackgroundSurfaceColorInverse
            borderOnContainer = DesignSystemDarkLarge.BorderOnContainerInverse
            textOnContainerPrimary = DesignSystemDarkLarge.TextOnContainerColorInverse
            textOnContainerSecondary = DesignSystemDarkLarge.TextOnContainerColorInactive
            textOnContainerInverse = DesignSystemDarkLarge.TextOnContainerColorPrimary
            cornerRadius = DesignSystemDarkLarge.BorderRadius3xl
        case .darkMedium:
            brand = DesignSystemDarkMedium.BackgroundContainerColorBrand
            accent = DesignSystemDarkMedium.BackgroundAccentColorBlue
            success = DesignSystemDarkMedium.BackgroundFeedbackColorSuccessAccent2
            warning = DesignSystemDarkMedium.BackgroundFeedbackColorWarningAccent2
            error = DesignSystemDarkMedium.BackgroundFeedbackColorErrorAccent2
            container = DesignSystemDarkMedium.BackgroundSurfaceColorInverse
            borderOnContainer = DesignSystemDarkMedium.BorderOnContainerInverse
            textOnContainerPrimary = DesignSystemDarkMedium.TextOnContainerColorInverse
            textOnContainerSecondary = DesignSystemDarkMedium.TextOnContainerColorInactive
            textOnContainerInverse = DesignSystemDarkMedium.TextOnContainerColorPrimary
            cornerRadius = DesignSystemDarkMedium.BorderRadius3xl
        }
    }
}

// MARK: - Swatch Component
private struct ThemeSwatch: View {
    let title: String
    let color: Color
    let textColor: Color

    var body: some View {
        HStack {
            Text(title)
                .font(.body)
            Spacer()
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 80, height: 48)
                .overlay(
                    Text(title.prefix(1))
                        .font(.headline)
                        .foregroundStyle(textColor)
                )
        }
        .padding(12)
        .background(.thinMaterial)
        .cornerRadius(10)
    }
}

// MARK: - Preview
#Preview {
    DesignSystemShowcaseView()
}
