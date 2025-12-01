//
// ThemeColorsPreview.swift
//
// Visual reference showing all theme colors in use
//

import SwiftUI

// MARK: - Theme Colors Preview View
/// A comprehensive visual reference for all theme colors
struct ThemeColorsPreview: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedGreigeShade: GreigeShade = .greige050
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // MARK: - Background Color Selector
                    backgroundSelectorSection
                    
                    // MARK: - Brand Colors
                    colorSection(
                        title: "Brand Colors",
                        subtitle: "Primary accent colors used throughout the app",
                        colors: [
                            ColorInfo(
                                name: "Brand Primary",
                                color: AppTheme.brandColor(for: colorScheme),
                                token: "BrandBrand300",
                                hex: "#F96302",
                                usage: "Icons, buttons, tabs, links"
                            ),
                            ColorInfo(
                                name: "Brand Dark",
                                color: AppTheme.brandColorDark(for: colorScheme),
                                token: "BrandBrand400",
                                hex: "#E95C02",
                                usage: "Hover states, pressed states"
                            )
                        ]
                    )
                    
                    // MARK: - Background Colors
                    colorSection(
                        title: "Background Colors",
                        subtitle: "Surface and container backgrounds",
                        colors: [
                            ColorInfo(
                                name: "App Background",
                                color: AppTheme.appBackground(for: colorScheme),
                                token: "GreigeGreige050",
                                hex: "#F8F5F2",
                                usage: "Main app background, empty space"
                            ),
                            ColorInfo(
                                name: "Card Background",
                                color: AppTheme.cardBackground(for: colorScheme),
                                token: "GreigeGreige200",
                                hex: "#BAB7B4",
                                usage: "Cards, sections, containers"
                            ),
                            ColorInfo(
                                name: "Container Background",
                                color: AppTheme.containerBackground(for: colorScheme),
                                token: "BackgroundContainerColorGreige",
                                hex: "#F8F5F2",
                                usage: "Nested containers, alternative background"
                            )
                        ]
                    )
                    
                    // MARK: - Text Colors
                    colorSection(
                        title: "Text Colors",
                        subtitle: "Semantic text hierarchy",
                        colors: [
                            ColorInfo(
                                name: "Text Primary",
                                color: AppTheme.textPrimary(for: colorScheme),
                                token: "TextOnSurfaceColorPrimary",
                                hex: "#252523",
                                usage: "Headlines, body text, primary content"
                            ),
                            ColorInfo(
                                name: "Text Secondary",
                                color: AppTheme.textSecondary(for: colorScheme),
                                token: "TextOnSurfaceColorSecondary",
                                hex: "#47453F",
                                usage: "Descriptions, supporting text"
                            ),
                            ColorInfo(
                                name: "Text Tertiary",
                                color: AppTheme.textTertiary(for: colorScheme),
                                token: "TextOnSurfaceColorTertiary",
                                hex: "#6A6866",
                                usage: "Labels, hints, captions"
                            )
                        ]
                    )
                    
                    // MARK: - Icon Colors
                    colorSection(
                        title: "Icon Colors",
                        subtitle: "Icon and symbol styling",
                        colors: [
                            ColorInfo(
                                name: "Icon Accent",
                                color: AppTheme.iconAccent(for: colorScheme),
                                token: "IconOnSurfaceColorAccent",
                                hex: "#F96302",
                                usage: "Accent icons, featured symbols"
                            ),
                            ColorInfo(
                                name: "Icon Primary",
                                color: AppTheme.iconPrimary(for: colorScheme),
                                token: "IconOnSurfaceColorPrimary",
                                hex: "#252523",
                                usage: "Standard icons, navigation symbols"
                            )
                        ]
                    )
                    
                    // MARK: - Usage Examples
                    usageExamplesSection
                    
                }
                .padding()
            }
            .navigationTitle("Theme Colors")
            .themedAppBackground()
        }
        .tint(AppTheme.brandColor(for: colorScheme))
    }
    
    // MARK: - Background Selector Section
    private var backgroundSelectorSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            VStack(alignment: .leading, spacing: 4) {
                Text("Card Background Selector")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
                
                Text("Choose a Greige shade to see how colors look on different surfaces")
                    .font(.caption)
                    .foregroundStyle(Color.textSecondary(for: colorScheme))
            }
            
            // Currently selected
            HStack {
                Text("Current Background:")
                    .font(.subheadline)
                    .foregroundStyle(Color.textSecondary(for: colorScheme))
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(selectedGreigeShade.color)
                    .frame(width: 24, height: 24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.borderDefault(for: colorScheme), lineWidth: 1)
                    )
                
                Text(selectedGreigeShade.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
                
                Spacer()
            }
            
            // Greige selector grid
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 70), spacing: 8)
            ], spacing: 8) {
                ForEach(GreigeShade.allCases, id: \.self) { shade in
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedGreigeShade = shade
                        }
                    } label: {
                        VStack(spacing: 4) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(shade.color)
                                .frame(height: 44)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(
                                            selectedGreigeShade == shade 
                                                ? AppTheme.brandColor(for: colorScheme)
                                                : Color.borderDefault(for: colorScheme),
                                            lineWidth: selectedGreigeShade == shade ? 2 : 1
                                        )
                                )
                            
                            Text(shade.shortName)
                                .font(.caption2)
                                .fontWeight(selectedGreigeShade == shade ? .semibold : .regular)
                                .foregroundStyle(
                                    selectedGreigeShade == shade 
                                        ? AppTheme.brandColor(for: colorScheme)
                                        : Color.textSecondary(for: colorScheme)
                                )
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
        .background(selectedGreigeShade.color)
        .cornerRadius(AppTheme.cornerRadiusLarge)
    }
    
    // MARK: - Color Section
    private func colorSection(title: String, subtitle: String, colors: [ColorInfo]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section header
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(Color.textSecondary(for: colorScheme))
            }
            
            // Color swatches
            VStack(spacing: 12) {
                ForEach(colors) { colorInfo in
                    colorCard(for: colorInfo)
                }
            }
        }
        .padding()
        .background(selectedGreigeShade.color)
        .cornerRadius(AppTheme.cornerRadiusLarge)
    }
    
    // MARK: - Color Card
    private func colorCard(for info: ColorInfo) -> some View {
        HStack(spacing: 12) {
            // Color swatch
            RoundedRectangle(cornerRadius: 8)
                .fill(info.color)
                .frame(width: 60, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.borderDefault(for: colorScheme), lineWidth: 1)
                )
            
            // Color info
            VStack(alignment: .leading, spacing: 4) {
                Text(info.name)
                    .font(.headline)
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
                
                Text(info.token)
                    .font(.caption)
                    .foregroundStyle(Color.textSecondary(for: colorScheme))
                    .fontDesign(.monospaced)
                
                Text(info.hex)
                    .font(.caption)
                    .foregroundStyle(Color.textTertiary(for: colorScheme))
                    .fontDesign(.monospaced)
                
                Text(info.usage)
                    .font(.caption2)
                    .foregroundStyle(Color.textTertiary(for: colorScheme))
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(12)
        .background(AppTheme.appBackground(for: colorScheme))
        .cornerRadius(8)
    }
    
    // MARK: - Usage Examples Section
    private var usageExamplesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Usage Examples")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
                
                Text("See these colors in action")
                    .font(.caption)
                    .foregroundStyle(Color.textSecondary(for: colorScheme))
            }
            
            VStack(spacing: 16) {
                // Example 1: Tab bar style
                exampleCard(title: "Tab Bar Icons") {
                    HStack(spacing: 32) {
                        VStack(spacing: 4) {
                            Image(systemName: "house.fill")
                                .font(.title2)
                                .brandTinted()
                            Text("Home")
                                .font(.caption)
                                .foregroundStyle(Color.textPrimary(for: colorScheme))
                        }
                        
                        VStack(spacing: 4) {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundStyle(Color.textTertiary(for: colorScheme))
                            Text("Search")
                                .font(.caption)
                                .foregroundStyle(Color.textTertiary(for: colorScheme))
                        }
                        
                        VStack(spacing: 4) {
                            Image(systemName: "person")
                                .font(.title2)
                                .foregroundStyle(Color.textTertiary(for: colorScheme))
                            Text("Profile")
                                .font(.caption)
                                .foregroundStyle(Color.textTertiary(for: colorScheme))
                        }
                    }
                }
                
                // Example 2: Button style
                exampleCard(title: "Buttons") {
                    VStack(spacing: 8) {
                        Button {
                        } label: {
                            Text("Primary Button")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppTheme.brandColor(for: colorScheme))
                                .cornerRadius(8)
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                        } label: {
                            Text("Secondary Button")
                                .fontWeight(.semibold)
                                .foregroundStyle(AppTheme.brandColor(for: colorScheme))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppTheme.appBackground(for: colorScheme))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(AppTheme.brandColor(for: colorScheme), lineWidth: 2)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                // Example 3: Text hierarchy
                exampleCard(title: "Text Hierarchy") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Primary Headline")
                            .font(.headline)
                            .foregroundStyle(Color.textPrimary(for: colorScheme))
                        
                        Text("Secondary description text that provides additional context about the content")
                            .font(.body)
                            .foregroundStyle(Color.textSecondary(for: colorScheme))
                        
                        Text("Tertiary caption or label")
                            .font(.caption)
                            .foregroundStyle(Color.textTertiary(for: colorScheme))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
        .background(selectedGreigeShade.color)
        .cornerRadius(AppTheme.cornerRadiusLarge)
    }
    
    // MARK: - Example Card
    private func exampleCard<Content: View>(
        title: String,
        @ViewBuilder example: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.textPrimary(for: colorScheme))
            
            example()
        }
        .padding()
        .background(AppTheme.appBackground(for: colorScheme))
        .cornerRadius(8)
    }
}

// MARK: - Greige Shade Enum
enum GreigeShade: String, CaseIterable, Hashable {
    case greige025 = "025"
    case greige050 = "050"
    case greige100 = "100"
    case greige200 = "200"
    case greige300 = "300"
    case greige400 = "400"
    case greige500 = "500"
    case greige600 = "600"
    case greige700 = "700"
    case greige800 = "800"
    case greige900 = "900"
    case greige950 = "950"
    
    var color: Color {
        switch self {
        case .greige025: return DesignSystemGlobal.GreigeGreige025
        case .greige050: return DesignSystemGlobal.GreigeGreige050
        case .greige100: return DesignSystemGlobal.GreigeGreige100
        case .greige200: return DesignSystemGlobal.GreigeGreige200
        case .greige300: return DesignSystemGlobal.GreigeGreige300
        case .greige400: return DesignSystemGlobal.GreigeGreige400
        case .greige500: return DesignSystemGlobal.GreigeGreige500
        case .greige600: return DesignSystemGlobal.GreigeGreige600
        case .greige700: return DesignSystemGlobal.GreigeGreige700
        case .greige800: return DesignSystemGlobal.GreigeGreige800
        case .greige900: return DesignSystemGlobal.GreigeGreige900
        case .greige950: return DesignSystemGlobal.GreigeGreige950
        }
    }
    
    var name: String {
        "Greige \(rawValue)"
    }
    
    var shortName: String {
        rawValue
    }
}

// MARK: - Color Info Model
struct ColorInfo: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let token: String
    let hex: String
    let usage: String
}

// MARK: - Preview
#Preview {
    ThemeColorsPreview()
}
