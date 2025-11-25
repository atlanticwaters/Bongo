//
// DesignSystemDemoView.swift
//
// DESIGN SYSTEM INTEGRATION DEMO
// This view demonstrates how the app connects to, reads from, and displays
// values from the design system token files in the Design System folder.
//

import SwiftUI

// MARK: - Design System Demo View
/// Comprehensive demonstration of design system token integration
/// Shows the complete flow from design tokens to UI components
struct DesignSystemDemoView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTokenCategory: TokenCategory = .colors
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // MARK: - Header Section
                    headerSection
                    
                    // MARK: - Token Category Picker
                    categoryPicker
                    
                    // MARK: - Token Display
                    switch selectedTokenCategory {
                    case .colors:
                        colorTokensSection
                    case .typography:
                        typographyTokensSection
                    case .surfaces:
                        surfacesSection
                    case .greigePalette:
                        greigePaletteSection
                    case .spacing:
                        spacingTokensSection
                    case .borders:
                        borderTokensSection
                    case .liveDemo:
                        liveDemoSection
                    }
                    
                    // MARK: - Design System Files
                    designSystemFilesSection
                    
                }
                .padding()
            }
            .navigationTitle("Design System Demo")
            .themedAppBackground()
        }
        .tint(AppTheme.brandColor(for: colorScheme))
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("🔗 Design System Integration")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.textPrimary(for: colorScheme))
            
            Text("This app connects to auto-generated design system files and reads token values to style all UI elements.")
                .font(.body)
                .foregroundStyle(Color.textSecondary(for: colorScheme))
            
            VStack(alignment: .leading, spacing: 8) {
                tokenFlowStep(number: "1", text: "Designer updates tokens in design tool")
                tokenFlowStep(number: "2", text: "Tokens export to Swift files in Design System folder")
                tokenFlowStep(number: "3", text: "ThemeExtensions.swift reads token values")
                tokenFlowStep(number: "4", text: "App UI automatically updates")
            }
            .padding()
            .background(Color.brandPrimary(for: colorScheme).opacity(0.1))
            .cornerRadius(12)
        }
        .themedContainer()
    }
    
    // MARK: - Token Flow Step
    private func tokenFlowStep(number: String, text: String) -> some View {
        HStack(spacing: 12) {
            Text(number)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 28, height: 28)
                .background(AppTheme.brandColor(for: colorScheme))
                .clipShape(Circle())
            
            Text(text)
                .font(.subheadline)
                .foregroundStyle(Color.textPrimary(for: colorScheme))
            
            Spacer()
        }
    }
    
    // MARK: - Category Picker
    private var categoryPicker: some View {
        Picker("Token Category", selection: $selectedTokenCategory) {
            ForEach(TokenCategory.allCases, id: \.self) { category in
                Text(category.rawValue).tag(category)
            }
        }
        .pickerStyle(.segmented)
        .themedContainer()
    }
    
    // MARK: - Color Tokens Section
    private var colorTokensSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader(
                title: "Color Tokens",
                subtitle: "Reading from DesignSystemGlobal.swift"
            )
            
            // Brand Colors
            tokenGroup(title: "Brand Colors") {
                VStack(spacing: 12) {
                    colorTokenCard(
                        name: "Brand Primary",
                        color: AppTheme.brandColor(for: colorScheme),
                        token: "DesignSystemGlobal.BrandBrand300",
                        path: "Brand → Brand → 300",
                        hex: "#F96302",
                        rgb: "RGB(249, 99, 2)"
                    )
                    
                    colorTokenCard(
                        name: "Brand Dark",
                        color: AppTheme.brandColorDark(for: colorScheme),
                        token: "DesignSystemGlobal.BrandBrand400",
                        path: "Brand → Brand → 400",
                        hex: "#E95C02",
                        rgb: "RGB(233, 92, 2)"
                    )
                }
            }
            
            // Background Colors
            tokenGroup(title: "Background Colors") {
                VStack(spacing: 12) {
                    colorTokenCard(
                        name: "App Background",
                        color: AppTheme.appBackground(for: colorScheme),
                        token: "DesignSystemGlobal.GreigeGreige050",
                        path: "Greige → Greige → 050",
                        hex: "#F8F5F2",
                        rgb: "RGB(248, 245, 242)"
                    )
                    
                    colorTokenCard(
                        name: "Card Background",
                        color: AppTheme.cardBackground(for: colorScheme),
                        token: "DesignSystemGlobal.GreigeGreige200",
                        path: "Greige → Greige → 200",
                        hex: "#BAB7B4",
                        rgb: "RGB(186, 183, 180)"
                    )
                }
            }
            
            // Text Colors
            tokenGroup(title: "Text Colors") {
                VStack(spacing: 12) {
                    colorTokenCard(
                        name: "Text Primary",
                        color: AppTheme.textPrimary(for: colorScheme),
                        token: "DesignSystemGlobal.TextOnSurfaceColorPrimary",
                        path: "Text → OnSurface Color → Primary",
                        hex: "#252523",
                        rgb: "RGB(37, 37, 35)"
                    )
                    
                    colorTokenCard(
                        name: "Text Secondary",
                        color: AppTheme.textSecondary(for: colorScheme),
                        token: "DesignSystemGlobal.TextOnSurfaceColorSecondary",
                        path: "Text → OnSurface Color → Secondary",
                        hex: "#47453F",
                        rgb: "RGB(71, 69, 63)"
                    )
                }
            }
        }
        .themedContainer()
    }
    
    // MARK: - Spacing Tokens Section
    private var spacingTokensSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader(
                title: "Spacing Tokens",
                subtitle: "Reading from DesignSystemGlobal.swift"
            )
            
            tokenGroup(title: "Layout Spacing") {
                VStack(spacing: 12) {
                    spacingTokenCard(
                        name: "Compact",
                        value: AppTheme.spacingCompact,
                        token: "DesignSystemGlobal.Spacing3",
                        path: "Spacing → 3"
                    )
                    
                    spacingTokenCard(
                        name: "Standard",
                        value: AppTheme.spacingStandard,
                        token: "DesignSystemGlobal.Spacing4",
                        path: "Spacing → 4"
                    )
                    
                    spacingTokenCard(
                        name: "Loose",
                        value: AppTheme.spacingLoose,
                        token: "DesignSystemGlobal.Spacing6",
                        path: "Spacing → 6"
                    )
                }
            }
        }
        .themedContainer()
    }
    
    // MARK: - Border Tokens Section
    private var borderTokensSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader(
                title: "Border Radius Tokens",
                subtitle: "Reading from DesignSystemGlobal.swift"
            )
            
            tokenGroup(title: "Corner Radius") {
                VStack(spacing: 12) {
                    borderTokenCard(
                        name: "Standard",
                        value: AppTheme.cornerRadiusStandard,
                        token: "DesignSystemGlobal.BorderRadiusXl",
                        path: "BorderRadius → Xl"
                    )
                    
                    borderTokenCard(
                        name: "Large",
                        value: AppTheme.cornerRadiusLarge,
                        token: "DesignSystemGlobal.BorderRadius2xl",
                        path: "BorderRadius → 2xl"
                    )
                }
            }
        }
        .themedContainer()
    }
    
    // MARK: - Typography Tokens Section
    private var typographyTokensSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader(
                title: "Typography Colors",
                subtitle: "Text colors adapting to light/dark mode"
            )
            
            // Typography Colors - Primary, Secondary, Tertiary, Quaternary
            tokenGroup(title: "Text Hierarchy") {
                VStack(spacing: 12) {
                    typographyColorCard(
                        name: "Primary",
                        lightColor: DesignSystemLightLarge.TextOnSurfaceColorPrimary,
                        darkColor: DesignSystemDarkLarge.TextOnSurfaceColorInverse,
                        token: "TextOnSurfaceColorPrimary / Inverse",
                        usage: "Main headings and body text"
                    )
                    
                    typographyColorCard(
                        name: "Secondary",
                        lightColor: DesignSystemLightLarge.TextOnSurfaceColorSecondary,
                        darkColor: DesignSystemDarkLarge.TextOnSurfaceColorTertiary,
                        token: "TextOnSurfaceColorSecondary / Tertiary",
                        usage: "Supporting text and descriptions"
                    )
                    
                    typographyColorCard(
                        name: "Tertiary",
                        lightColor: DesignSystemLightLarge.TextOnSurfaceColorTertiary,
                        darkColor: DesignSystemDarkLarge.TextOnSurfaceColorQuatrenary,
                        token: "TextOnSurfaceColorTertiary / Quaternary",
                        usage: "Subtle labels and hints"
                    )
                    
                    typographyColorCard(
                        name: "Quaternary",
                        lightColor: DesignSystemLightLarge.TextOnSurfaceColorQuatrenary,
                        darkColor: DesignSystemDarkLarge.TextOnSurfaceColorQuatrenary,
                        token: "TextOnSurfaceColorQuatrenary",
                        usage: "Disabled or very subtle text"
                    )
                }
            }
            
            // Semantic Text Colors
            tokenGroup(title: "Semantic Text Colors") {
                VStack(spacing: 12) {
                    typographyColorCard(
                        name: "Accent",
                        lightColor: DesignSystemLightLarge.TextOnSurfaceColorAccent,
                        darkColor: DesignSystemDarkLarge.TextOnSurfaceColorAccent,
                        token: "TextOnSurfaceColorAccent",
                        usage: "Brand-colored text and links"
                    )
                    
                    typographyColorCard(
                        name: "Success",
                        lightColor: DesignSystemLightLarge.TextOnSurfaceColorSuccess,
                        darkColor: DesignSystemDarkLarge.TextOnSurfaceColorSuccess,
                        token: "TextOnSurfaceColorSuccess",
                        usage: "Success messages"
                    )
                    
                    typographyColorCard(
                        name: "Error",
                        lightColor: DesignSystemLightLarge.TextOnSurfaceColorError,
                        darkColor: DesignSystemDarkLarge.TextOnSurfaceColorError,
                        token: "TextOnSurfaceColorError",
                        usage: "Error messages and alerts"
                    )
                    
                    typographyColorCard(
                        name: "Warning",
                        lightColor: DesignSystemLightLarge.TextOnSurfaceColorWarning,
                        darkColor: DesignSystemDarkLarge.TextOnSurfaceColorWarning,
                        token: "TextOnSurfaceColorWarning",
                        usage: "Warning messages"
                    )
                }
            }
            
            // Font Sizes
            tokenGroup(title: "Font Sizes") {
                VStack(alignment: .leading, spacing: 12) {
                    fontSizeCard(
                        name: "Heading 1",
                        value: DesignSystemGlobal.FontFontSizeH1,
                        token: "FontFontSizeH1"
                    )
                    
                    fontSizeCard(
                        name: "Heading 2",
                        value: DesignSystemGlobal.FontFontSizeH2,
                        token: "FontFontSizeH2"
                    )
                    
                    fontSizeCard(
                        name: "Body Large",
                        value: DesignSystemGlobal.FontFontSizeBodyLg,
                        token: "FontFontSizeBodyLg"
                    )
                    
                    fontSizeCard(
                        name: "Body Medium",
                        value: DesignSystemGlobal.FontFontSizeBodyMd,
                        token: "FontFontSizeBodyMd"
                    )
                    
                    fontSizeCard(
                        name: "Body Small",
                        value: DesignSystemGlobal.FontFontSizeBodySm,
                        token: "FontFontSizeBodySm"
                    )
                }
            }
        }
        .themedContainer()
    }
    
    // MARK: - Surfaces Section
    private var surfacesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader(
                title: "Surface Colors",
                subtitle: "Background colors on main surfaces with opacity variations"
            )
            
            // Main Surfaces
            tokenGroup(title: "Main Surfaces") {
                VStack(spacing: 16) {
                    surfaceColorCard(
                        name: "App Background",
                        lightColor: DesignSystemLightLarge.GreigeGreige050,
                        darkColor: DesignSystemDarkLarge.GreigeGreige900,
                        token: "GreigeGreige050 / 900"
                    )
                    
                    surfaceColorCard(
                        name: "Card Background",
                        lightColor: DesignSystemLightLarge.GreigeGreige200,
                        darkColor: DesignSystemDarkLarge.GreigeGreige800,
                        token: "GreigeGreige200 / 800"
                    )
                    
                    surfaceColorCard(
                        name: "Container Background",
                        lightColor: DesignSystemLightLarge.BackgroundContainerColorGreige,
                        darkColor: DesignSystemDarkLarge.BackgroundContainerColorGreige,
                        token: "BackgroundContainerColorGreige"
                    )
                }
            }
            
            // Transparent Overlays
            tokenGroup(title: "Transparent Overlays") {
                VStack(spacing: 12) {
                    transparentOverlayCard(
                        name: "5% Opacity",
                        color: DesignSystemGlobal.BackgroundContainerColorTransparent05,
                        token: "BackgroundContainerColorTransparent05",
                        usage: "Subtle backgrounds"
                    )
                    
                    transparentOverlayCard(
                        name: "10% Opacity",
                        color: DesignSystemGlobal.BackgroundContainerColorTransparent10,
                        token: "BackgroundContainerColorTransparent10",
                        usage: "Light backgrounds"
                    )
                    
                    transparentOverlayCard(
                        name: "20% Opacity",
                        color: DesignSystemGlobal.BackgroundContainerColorTransparent20,
                        token: "BackgroundContainerColorTransparent20",
                        usage: "Medium backgrounds"
                    )
                }
            }
        }
        .themedContainer()
    }
    
    // MARK: - Greige Palette Section
    private var greigePaletteSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader(
                title: "Greige Palette",
                subtitle: "Complete neutral color scale from light to dark"
            )
            
            VStack(spacing: 8) {
                greigePaletteRow(name: "025", color: DesignSystemGlobal.GreigeGreige025)
                greigePaletteRow(name: "050", color: DesignSystemGlobal.GreigeGreige050)
                greigePaletteRow(name: "100", color: DesignSystemGlobal.GreigeGreige100)
                greigePaletteRow(name: "200", color: DesignSystemGlobal.GreigeGreige200)
                greigePaletteRow(name: "300", color: DesignSystemGlobal.GreigeGreige300)
                greigePaletteRow(name: "400", color: DesignSystemGlobal.GreigeGreige400)
                greigePaletteRow(name: "500", color: DesignSystemGlobal.GreigeGreige500)
                greigePaletteRow(name: "600", color: DesignSystemGlobal.GreigeGreige600)
                greigePaletteRow(name: "700", color: DesignSystemGlobal.GreigeGreige700)
                greigePaletteRow(name: "800", color: DesignSystemGlobal.GreigeGreige800)
                greigePaletteRow(name: "900", color: DesignSystemGlobal.GreigeGreige900)
                greigePaletteRow(name: "950", color: DesignSystemGlobal.GreigeGreige950)
            }
            
            Text("💡 Tip: Light mode uses lighter shades (025-300), dark mode uses darker shades (700-950)")
                .font(.caption)
                .foregroundStyle(Color.textSecondary(for: colorScheme))
                .padding(.top, 8)
        }
        .themedContainer()
    }
    
    // MARK: - Live Demo Section
    private var liveDemoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader(
                title: "Live Component Demo",
                subtitle: "See design tokens in action"
            )
            
            VStack(spacing: 16) {
                // Button using design tokens
                demoComponent(title: "Button with Brand Token") {
                    Button {
                        // Action
                    } label: {
                        HStack {
                            Image(systemName: "star.fill")
                            Text("Brand Button")
                        }
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(AppTheme.brandColor(for: colorScheme)) // ← Design token
                        .cornerRadius(AppTheme.cornerRadiusStandard) // ← Design token
                    }
                    .buttonStyle(.plain)
                }
                
                // Card using design tokens
                demoComponent(title: "Card with Background Token") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Card Title")
                            .font(.headline)
                            .foregroundStyle(AppTheme.textPrimary(for: colorScheme)) // ← Design token
                        
                        Text("This card's background, text colors, padding, and corner radius all come from design system tokens.")
                            .font(.subheadline)
                            .foregroundStyle(AppTheme.textSecondary(for: colorScheme)) // ← Design token
                    }
                    .padding(AppTheme.spacingStandard) // ← Design token
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(AppTheme.cardBackground(for: colorScheme)) // ← Design token
                    .cornerRadius(AppTheme.cornerRadiusLarge) // ← Design token
                }
                
                // Icon using design tokens
                demoComponent(title: "Icon with Accent Token") {
                    HStack(spacing: 16) {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundStyle(AppTheme.iconAccent(for: colorScheme)) // ← Design token
                        
                        Image(systemName: "star.fill")
                            .font(.largeTitle)
                            .brandTinted() // ← Uses design token
                        
                        Image(systemName: "bookmark.fill")
                            .font(.largeTitle)
                            .foregroundStyle(AppTheme.brandColor(for: colorScheme)) // ← Design token
                    }
                }
            }
        }
        .themedContainer()
    }
    
    // MARK: - Design System Files Section
    private var designSystemFilesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader(
                title: "Design System Files",
                subtitle: "Auto-generated token files in Design System folder"
            )
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(DesignSystemTokenInspector.availableDesignSystems(), id: \.self) { fileName in
                    HStack {
                        Image(systemName: "doc.text.fill")
                            .foregroundStyle(AppTheme.brandColor(for: colorScheme))
                        
                        Text(fileName)
                            .font(.body)
                            .fontDesign(.monospaced)
                            .foregroundStyle(Color.textPrimary(for: colorScheme))
                        
                        Spacer()
                        
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    }
                    .padding()
                    .background(Color.appBackground(for: colorScheme))
                    .cornerRadius(8)
                }
            }
            
            Text("✅ All files are connected and readable by the app")
                .font(.caption)
                .foregroundStyle(.green)
                .padding(.top, 8)
        }
        .themedContainer()
    }
    
    // MARK: - Helper Views
    
    private func sectionHeader(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(Color.textPrimary(for: colorScheme))
            
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(Color.textSecondary(for: colorScheme))
        }
    }
    
    private func tokenGroup<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(Color.textPrimary(for: colorScheme))
            
            content()
        }
    }
    
    private func colorTokenCard(
        name: String,
        color: Color,
        token: String,
        path: String,
        hex: String,
        rgb: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                // Color swatch
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: 60, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.borderDefault(for: colorScheme), lineWidth: 1)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.textPrimary(for: colorScheme))
                    
                    Text(hex)
                        .font(.caption)
                        .fontDesign(.monospaced)
                        .foregroundStyle(Color.textSecondary(for: colorScheme))
                    
                    Text(rgb)
                        .font(.caption2)
                        .fontDesign(.monospaced)
                        .foregroundStyle(Color.textTertiary(for: colorScheme))
                }
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Label {
                    Text(token)
                        .font(.caption2)
                        .fontDesign(.monospaced)
                        .foregroundStyle(Color.textSecondary(for: colorScheme))
                } icon: {
                    Image(systemName: "link")
                        .font(.caption2)
                        .foregroundStyle(AppTheme.brandColor(for: colorScheme))
                }
                
                Label {
                    Text(path)
                        .font(.caption2)
                        .foregroundStyle(Color.textTertiary(for: colorScheme))
                } icon: {
                    Image(systemName: "arrow.right")
                        .font(.caption2)
                        .foregroundStyle(Color.textTertiary(for: colorScheme))
                }
            }
        }
        .padding()
        .background(Color.appBackground(for: colorScheme))
        .cornerRadius(8)
    }
    
    private func spacingTokenCard(
        name: String,
        value: CGFloat,
        token: String,
        path: String
    ) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
                
                Text(token)
                    .font(.caption2)
                    .fontDesign(.monospaced)
                    .foregroundStyle(Color.textSecondary(for: colorScheme))
                
                Text(path)
                    .font(.caption2)
                    .foregroundStyle(Color.textTertiary(for: colorScheme))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(Int(value))pt")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(AppTheme.brandColor(for: colorScheme))
                
                // Visual representation
                Rectangle()
                    .fill(AppTheme.brandColor(for: colorScheme))
                    .frame(width: value * 2, height: 4)
            }
        }
        .padding()
        .background(Color.appBackground(for: colorScheme))
        .cornerRadius(8)
    }
    
    private func borderTokenCard(
        name: String,
        value: CGFloat,
        token: String,
        path: String
    ) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
                
                Text(token)
                    .font(.caption2)
                    .fontDesign(.monospaced)
                    .foregroundStyle(Color.textSecondary(for: colorScheme))
                
                Text(path)
                    .font(.caption2)
                    .foregroundStyle(Color.textTertiary(for: colorScheme))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                Text("\(Int(value))pt")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(AppTheme.brandColor(for: colorScheme))
                
                // Visual representation
                RoundedRectangle(cornerRadius: value)
                    .fill(AppTheme.brandColor(for: colorScheme).opacity(0.3))
                    .frame(width: 60, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: value)
                            .stroke(AppTheme.brandColor(for: colorScheme), lineWidth: 2)
                    )
            }
        }
        .padding()
        .background(Color.appBackground(for: colorScheme))
        .cornerRadius(8)
    }
    
    private func typographyTokenCard(
        name: String,
        value: CGFloat,
        token: String,
        path: String
    ) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
                
                Text(token)
                    .font(.caption2)
                    .fontDesign(.monospaced)
                    .foregroundStyle(Color.textSecondary(for: colorScheme))
                
                Text(path)
                    .font(.caption2)
                    .foregroundStyle(Color.textTertiary(for: colorScheme))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(Int(value))pt")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(AppTheme.brandColor(for: colorScheme))
                
                Text("Aa")
                    .font(.system(size: value))
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
            }
        }
        .padding()
        .background(Color.appBackground(for: colorScheme))
        .cornerRadius(8)
    }
    
    // MARK: - New Typography Helper Views
    
    private func typographyColorCard(
        name: String,
        lightColor: Color,
        darkColor: Color,
        token: String,
        usage: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title and token
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
                
                Text(token)
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .foregroundStyle(Color.textSecondary(for: colorScheme))
                
                Text(usage)
                    .font(.caption2)
                    .foregroundStyle(Color.textTertiary(for: colorScheme))
            }
            
            // Color swatches showing light and dark
            HStack(spacing: 12) {
                // Light mode preview
                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(DesignSystemGlobal.GreigeGreige050)
                        .frame(height: 60)
                        .overlay(
                            Text("The quick brown fox")
                                .font(.body)
                                .foregroundStyle(lightColor)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.borderDefault(for: colorScheme), lineWidth: 1)
                        )
                    
                    Text("Light")
                        .font(.caption2)
                        .foregroundStyle(Color.textTertiary(for: colorScheme))
                }
                
                // Dark mode preview
                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(DesignSystemGlobal.GreigeGreige900)
                        .frame(height: 60)
                        .overlay(
                            Text("The quick brown fox")
                                .font(.body)
                                .foregroundStyle(darkColor)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.borderDefault(for: colorScheme), lineWidth: 1)
                        )
                    
                    Text("Dark")
                        .font(.caption2)
                        .foregroundStyle(Color.textTertiary(for: colorScheme))
                }
            }
        }
        .padding()
        .background(Color.appBackground(for: colorScheme))
        .cornerRadius(8)
    }
    
    private func fontSizeCard(
        name: String,
        value: CGFloat,
        token: String
    ) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
                
                Text(token)
                    .font(.caption2)
                    .fontDesign(.monospaced)
                    .foregroundStyle(Color.textSecondary(for: colorScheme))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(Int(value))pt")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(AppTheme.brandColor(for: colorScheme))
                
                Text("Aa")
                    .font(.system(size: value))
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
            }
        }
        .padding()
        .background(Color.appBackground(for: colorScheme))
        .cornerRadius(8)
    }
    
    private func surfaceColorCard(
        name: String,
        lightColor: Color,
        darkColor: Color,
        token: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
                
                Text(token)
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .foregroundStyle(Color.textSecondary(for: colorScheme))
            }
            
            // Color comparison
            HStack(spacing: 12) {
                // Light mode
                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(lightColor)
                        .frame(height: 80)
                        .overlay(
                            VStack {
                                Image(systemName: "sun.max.fill")
                                    .font(.title2)
                                Text("Sample Text")
                                    .font(.caption)
                            }
                            .foregroundStyle(DesignSystemGlobal.GreigeGreige900)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.borderDefault(for: colorScheme), lineWidth: 1)
                        )
                    
                    Text("Light Mode")
                        .font(.caption2)
                        .foregroundStyle(Color.textTertiary(for: colorScheme))
                }
                
                // Dark mode
                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(darkColor)
                        .frame(height: 80)
                        .overlay(
                            VStack {
                                Image(systemName: "moon.fill")
                                    .font(.title2)
                                Text("Sample Text")
                                    .font(.caption)
                            }
                            .foregroundStyle(DesignSystemGlobal.GreigeGreige050)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.borderDefault(for: colorScheme), lineWidth: 1)
                        )
                    
                    Text("Dark Mode")
                        .font(.caption2)
                        .foregroundStyle(Color.textTertiary(for: colorScheme))
                }
            }
        }
        .padding()
        .background(Color.appBackground(for: colorScheme))
        .cornerRadius(8)
    }
    
    private func transparentOverlayCard(
        name: String,
        color: Color,
        token: String,
        usage: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                // Overlay demonstration
                ZStack {
                    // Base layer with pattern
                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppTheme.brandColor(for: colorScheme),
                                    AppTheme.brandColor(for: colorScheme).opacity(0.6)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 60, height: 60)
                    
                    // Overlay layer
                    RoundedRectangle(cornerRadius: 6)
                        .fill(color)
                        .frame(width: 60, height: 60)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.borderDefault(for: colorScheme), lineWidth: 1)
                )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.textPrimary(for: colorScheme))
                    
                    Text(token)
                        .font(.caption2)
                        .fontDesign(.monospaced)
                        .foregroundStyle(Color.textSecondary(for: colorScheme))
                    
                    Text(usage)
                        .font(.caption2)
                        .foregroundStyle(Color.textTertiary(for: colorScheme))
                }
                
                Spacer()
            }
        }
        .padding()
        .background(Color.appBackground(for: colorScheme))
        .cornerRadius(8)
    }
    
    private func greigePaletteRow(name: String, color: Color) -> some View {
        HStack(spacing: 12) {
            // Color swatch
            RoundedRectangle(cornerRadius: 6)
                .fill(color)
                .frame(width: 60, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.borderDefault(for: colorScheme), lineWidth: 0.5)
                )
            
            // Name
            Text("Greige \(name)")
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(Color.textPrimary(for: colorScheme))
            
            Spacer()
            
            // Usage indicator
            if name == "050" || name == "900" {
                Text("App BG")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(AppTheme.brandColor(for: colorScheme))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(AppTheme.brandColor(for: colorScheme).opacity(0.1))
                    .cornerRadius(4)
            } else if name == "200" || name == "800" {
                Text("Card BG")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(AppTheme.brandColor(for: colorScheme))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(AppTheme.brandColor(for: colorScheme).opacity(0.1))
                    .cornerRadius(4)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.appBackground(for: colorScheme))
        .cornerRadius(6)
    }
    
    private func demoComponent<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.textPrimary(for: colorScheme))
            
            content()
        }
        .padding()
        .background(Color.appBackground(for: colorScheme))
        .cornerRadius(8)
    }
}

// MARK: - Token Category Enum
enum TokenCategory: String, CaseIterable {
    case colors = "Colors"
    case typography = "Typography"
    case surfaces = "Surfaces"
    case greigePalette = "Greige Palette"
    case spacing = "Spacing"
    case borders = "Borders"
    case liveDemo = "Live Demo"
}

// MARK: - Preview
#Preview {
    DesignSystemDemoView()
}
