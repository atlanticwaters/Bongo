//
// ThemeColorsPreview.swift
//
// Visual reference showing all theme colors in use
//

import SwiftUI

// MARK: - Theme Colors Preview View
/// A comprehensive visual reference for all theme colors
struct ThemeColorsPreview: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // MARK: - Brand Colors
                    colorSection(
                        title: "Brand Colors",
                        subtitle: "Primary accent colors used throughout the app",
                        colors: [
                            ColorInfo(
                                name: "Brand Primary",
                                color: AppTheme.brandColor,
                                token: "BrandBrand300",
                                hex: "#F96302",
                                usage: "Icons, buttons, tabs, links"
                            ),
                            ColorInfo(
                                name: "Brand Dark",
                                color: AppTheme.brandColorDark,
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
                                color: AppTheme.appBackground,
                                token: "GreigeGreige050",
                                hex: "#F8F5F2",
                                usage: "Main app background, empty space"
                            ),
                            ColorInfo(
                                name: "Card Background",
                                color: AppTheme.cardBackground,
                                token: "GreigeGreige200",
                                hex: "#BAB7B4",
                                usage: "Cards, sections, containers"
                            ),
                            ColorInfo(
                                name: "Container Background",
                                color: AppTheme.containerBackground,
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
                                color: AppTheme.textPrimary,
                                token: "TextOnSurfaceColorPrimary",
                                hex: "#252523",
                                usage: "Headlines, body text, primary content"
                            ),
                            ColorInfo(
                                name: "Text Secondary",
                                color: AppTheme.textSecondary,
                                token: "TextOnSurfaceColorSecondary",
                                hex: "#47453F",
                                usage: "Descriptions, supporting text"
                            ),
                            ColorInfo(
                                name: "Text Tertiary",
                                color: AppTheme.textTertiary,
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
                                color: AppTheme.iconAccent,
                                token: "IconOnSurfaceColorAccent",
                                hex: "#F96302",
                                usage: "Accent icons, featured symbols"
                            ),
                            ColorInfo(
                                name: "Icon Primary",
                                color: AppTheme.iconPrimary,
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
    }
    
    // MARK: - Color Section
    private func colorSection(title: String, subtitle: String, colors: [ColorInfo]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section header
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.textPrimary)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(Color.textSecondary)
            }
            
            // Color swatches
            VStack(spacing: 12) {
                ForEach(colors) { colorInfo in
                    colorCard(for: colorInfo)
                }
            }
        }
        .themedContainer()
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
                        .stroke(Color.borderDefault, lineWidth: 1)
                )
            
            // Color info
            VStack(alignment: .leading, spacing: 4) {
                Text(info.name)
                    .font(.headline)
                    .foregroundStyle(Color.textPrimary)
                
                Text(info.token)
                    .font(.caption)
                    .foregroundStyle(Color.textSecondary)
                    .fontDesign(.monospaced)
                
                Text(info.hex)
                    .font(.caption)
                    .foregroundStyle(Color.textTertiary)
                    .fontDesign(.monospaced)
                
                Text(info.usage)
                    .font(.caption2)
                    .foregroundStyle(Color.textTertiary)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.appBackground)
        .cornerRadius(8)
    }
    
    // MARK: - Usage Examples Section
    private var usageExamplesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Usage Examples")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.textPrimary)
                
                Text("See these colors in action")
                    .font(.caption)
                    .foregroundStyle(Color.textSecondary)
            }
            
            VStack(spacing: 16) {
                // Example 1: Tab bar style
                exampleCard(
                    title: "Tab Bar Icons",
                    example: HStack(spacing: 32) {
                        VStack(spacing: 4) {
                            Image(systemName: "house.fill")
                                .font(.title2)
                                .brandTinted()
                            Text("Home")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 4) {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundStyle(Color.textTertiary)
                            Text("Search")
                                .font(.caption)
                                .foregroundStyle(Color.textTertiary)
                        }
                        
                        VStack(spacing: 4) {
                            Image(systemName: "person")
                                .font(.title2)
                                .foregroundStyle(Color.textTertiary)
                            Text("Profile")
                                .font(.caption)
                                .foregroundStyle(Color.textTertiary)
                        }
                    }
                )
                
                // Example 2: Button style
                exampleCard(
                    title: "Buttons",
                    example: VStack(spacing: 8) {
                        Button {
                        } label: {
                            Text("Primary Button")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppTheme.brandColor)
                                .cornerRadius(8)
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                        } label: {
                            Text("Secondary Button")
                                .fontWeight(.semibold)
                                .foregroundStyle(AppTheme.brandColor)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.appBackground)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(AppTheme.brandColor, lineWidth: 2)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                )
                
                // Example 3: Text hierarchy
                exampleCard(
                    title: "Text Hierarchy",
                    example: VStack(alignment: .leading, spacing: 8) {
                        Text("Primary Headline")
                            .font(.headline)
                            .foregroundStyle(Color.textPrimary)
                        
                        Text("Secondary description text that provides additional context about the content")
                            .font(.body)
                            .foregroundStyle(Color.textSecondary)
                        
                        Text("Tertiary caption or label")
                            .font(.caption)
                            .foregroundStyle(Color.textTertiary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                )
            }
        }
        .themedContainer()
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
                .foregroundStyle(Color.textPrimary)
            
            example()
        }
        .padding()
        .background(Color.appBackground)
        .cornerRadius(8)
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
