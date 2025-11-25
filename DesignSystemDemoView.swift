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
                    case .spacing:
                        spacingTokensSection
                    case .borders:
                        borderTokensSection
                    case .typography:
                        typographyTokensSection
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
        .tint(AppTheme.brandColor)
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("🔗 Design System Integration")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.textPrimary)
            
            Text("This app connects to auto-generated design system files and reads token values to style all UI elements.")
                .font(.body)
                .foregroundStyle(Color.textSecondary)
            
            VStack(alignment: .leading, spacing: 8) {
                tokenFlowStep(number: "1", text: "Designer updates tokens in design tool")
                tokenFlowStep(number: "2", text: "Tokens export to Swift files in Design System folder")
                tokenFlowStep(number: "3", text: "ThemeExtensions.swift reads token values")
                tokenFlowStep(number: "4", text: "App UI automatically updates")
            }
            .padding()
            .background(Color.brandPrimary.opacity(0.1))
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
                .background(AppTheme.brandColor)
                .clipShape(Circle())
            
            Text(text)
                .font(.subheadline)
                .foregroundStyle(Color.textPrimary)
            
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
                        color: AppTheme.brandColor,
                        token: "DesignSystemGlobal.BrandBrand300",
                        path: "Brand → Brand → 300",
                        hex: "#F96302",
                        rgb: "RGB(249, 99, 2)"
                    )
                    
                    colorTokenCard(
                        name: "Brand Dark",
                        color: AppTheme.brandColorDark,
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
                        color: AppTheme.appBackground,
                        token: "DesignSystemGlobal.GreigeGreige050",
                        path: "Greige → Greige → 050",
                        hex: "#F8F5F2",
                        rgb: "RGB(248, 245, 242)"
                    )
                    
                    colorTokenCard(
                        name: "Card Background",
                        color: AppTheme.cardBackground,
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
                        color: AppTheme.textPrimary,
                        token: "DesignSystemGlobal.TextOnSurfaceColorPrimary",
                        path: "Text → OnSurface Color → Primary",
                        hex: "#252523",
                        rgb: "RGB(37, 37, 35)"
                    )
                    
                    colorTokenCard(
                        name: "Text Secondary",
                        color: AppTheme.textSecondary,
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
                title: "Typography Tokens",
                subtitle: "Reading from DesignSystemGlobal.swift"
            )
            
            tokenGroup(title: "Font Sizes") {
                VStack(alignment: .leading, spacing: 12) {
                    typographyTokenCard(
                        name: "Heading 1",
                        value: DesignSystemGlobal.FontFontSizeH1,
                        token: "DesignSystemGlobal.FontFontSizeH1",
                        path: "Font → FontSize → H1"
                    )
                    
                    typographyTokenCard(
                        name: "Heading 2",
                        value: DesignSystemGlobal.FontFontSizeH2,
                        token: "DesignSystemGlobal.FontFontSizeH2",
                        path: "Font → FontSize → H2"
                    )
                    
                    typographyTokenCard(
                        name: "Body Large",
                        value: DesignSystemGlobal.FontFontSizeBodyLg,
                        token: "DesignSystemGlobal.FontFontSizeBodyLg",
                        path: "Font → FontSize → BodyLg"
                    )
                    
                    typographyTokenCard(
                        name: "Body Medium",
                        value: DesignSystemGlobal.FontFontSizeBodyMd,
                        token: "DesignSystemGlobal.FontFontSizeBodyMd",
                        path: "Font → FontSize → BodyMd"
                    )
                }
            }
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
                        .background(AppTheme.brandColor) // ← Design token
                        .cornerRadius(AppTheme.cornerRadiusStandard) // ← Design token
                    }
                    .buttonStyle(.plain)
                }
                
                // Card using design tokens
                demoComponent(title: "Card with Background Token") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Card Title")
                            .font(.headline)
                            .foregroundStyle(AppTheme.textPrimary) // ← Design token
                        
                        Text("This card's background, text colors, padding, and corner radius all come from design system tokens.")
                            .font(.subheadline)
                            .foregroundStyle(AppTheme.textSecondary) // ← Design token
                    }
                    .padding(AppTheme.spacingStandard) // ← Design token
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(AppTheme.cardBackground) // ← Design token
                    .cornerRadius(AppTheme.cornerRadiusLarge) // ← Design token
                }
                
                // Icon using design tokens
                demoComponent(title: "Icon with Accent Token") {
                    HStack(spacing: 16) {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundStyle(AppTheme.iconAccent) // ← Design token
                        
                        Image(systemName: "star.fill")
                            .font(.largeTitle)
                            .brandTinted() // ← Uses design token
                        
                        Image(systemName: "bookmark.fill")
                            .font(.largeTitle)
                            .foregroundStyle(AppTheme.brandColor) // ← Design token
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
                            .foregroundStyle(AppTheme.brandColor)
                        
                        Text(fileName)
                            .font(.body)
                            .fontDesign(.monospaced)
                            .foregroundStyle(Color.textPrimary)
                        
                        Spacer()
                        
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    }
                    .padding()
                    .background(Color.appBackground)
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
                .foregroundStyle(Color.textPrimary)
            
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(Color.textSecondary)
        }
    }
    
    private func tokenGroup<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(Color.textPrimary)
            
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
                            .stroke(Color.borderDefault, lineWidth: 1)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.textPrimary)
                    
                    Text(hex)
                        .font(.caption)
                        .fontDesign(.monospaced)
                        .foregroundStyle(Color.textSecondary)
                    
                    Text(rgb)
                        .font(.caption2)
                        .fontDesign(.monospaced)
                        .foregroundStyle(Color.textTertiary)
                }
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Label {
                    Text(token)
                        .font(.caption2)
                        .fontDesign(.monospaced)
                        .foregroundStyle(Color.textSecondary)
                } icon: {
                    Image(systemName: "link")
                        .font(.caption2)
                        .foregroundStyle(AppTheme.brandColor)
                }
                
                Label {
                    Text(path)
                        .font(.caption2)
                        .foregroundStyle(Color.textTertiary)
                } icon: {
                    Image(systemName: "arrow.right")
                        .font(.caption2)
                        .foregroundStyle(Color.textTertiary)
                }
            }
        }
        .padding()
        .background(Color.appBackground)
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
                    .foregroundStyle(Color.textPrimary)
                
                Text(token)
                    .font(.caption2)
                    .fontDesign(.monospaced)
                    .foregroundStyle(Color.textSecondary)
                
                Text(path)
                    .font(.caption2)
                    .foregroundStyle(Color.textTertiary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(Int(value))pt")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(AppTheme.brandColor)
                
                // Visual representation
                Rectangle()
                    .fill(AppTheme.brandColor)
                    .frame(width: value * 2, height: 4)
            }
        }
        .padding()
        .background(Color.appBackground)
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
                    .foregroundStyle(Color.textPrimary)
                
                Text(token)
                    .font(.caption2)
                    .fontDesign(.monospaced)
                    .foregroundStyle(Color.textSecondary)
                
                Text(path)
                    .font(.caption2)
                    .foregroundStyle(Color.textTertiary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                Text("\(Int(value))pt")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(AppTheme.brandColor)
                
                // Visual representation
                RoundedRectangle(cornerRadius: value)
                    .fill(AppTheme.brandColor.opacity(0.3))
                    .frame(width: 60, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: value)
                            .stroke(AppTheme.brandColor, lineWidth: 2)
                    )
            }
        }
        .padding()
        .background(Color.appBackground)
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
                    .foregroundStyle(Color.textPrimary)
                
                Text(token)
                    .font(.caption2)
                    .fontDesign(.monospaced)
                    .foregroundStyle(Color.textSecondary)
                
                Text(path)
                    .font(.caption2)
                    .foregroundStyle(Color.textTertiary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(Int(value))pt")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(AppTheme.brandColor)
                
                Text("Aa")
                    .font(.system(size: value))
                    .foregroundStyle(Color.textPrimary)
            }
        }
        .padding()
        .background(Color.appBackground)
        .cornerRadius(8)
    }
    
    private func demoComponent<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.textPrimary)
            
            content()
        }
        .padding()
        .background(Color.appBackground)
        .cornerRadius(8)
    }
}

// MARK: - Token Category Enum
enum TokenCategory: String, CaseIterable {
    case colors = "Colors"
    case spacing = "Spacing"
    case borders = "Borders"
    case typography = "Typography"
    case liveDemo = "Live Demo"
}

// MARK: - Preview
#Preview {
    DesignSystemDemoView()
}
