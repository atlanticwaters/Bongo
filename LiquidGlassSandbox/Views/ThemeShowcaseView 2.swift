import SwiftUI

// MARK: - Theme Showcase View
// Demonstrates the design system tokens in context
struct ThemeShowcaseView: View {
    
    // MARK: - State Properties
    @State private var selectedTheme: ThemeSelection = .global
    
    // MARK: - Theme Selection Enum
    enum ThemeSelection: String, CaseIterable {
        case global = "Global"
        case lightMedium = "Light Medium"
        case darkMedium = "Dark Medium"
        case darkLarge = "Dark Large"
        
        // Helper computed property to get the appropriate design system
        var brandColors: [Color] {
            switch self {
            case .global:
                return [DesignSystemGlobal.BrandBrand300, DesignSystemGlobal.BrandBrand400, 
                        DesignSystemGlobal.BrandBrand500, DesignSystemGlobal.BrandBrand600, 
                        DesignSystemGlobal.BrandBrand700, DesignSystemGlobal.BrandBrand800]
            case .lightMedium:
                return [DesignSystemLightMedium.BrandBrand300, DesignSystemLightMedium.BrandBrand400,
                        DesignSystemLightMedium.BrandBrand500, DesignSystemLightMedium.BrandBrand600,
                        DesignSystemLightMedium.BrandBrand700, DesignSystemLightMedium.BrandBrand800]
            case .darkMedium:
                return [DesignSystemDarkMedium.BrandBrand300, DesignSystemDarkMedium.BrandBrand400,
                        DesignSystemDarkMedium.BrandBrand500, DesignSystemDarkMedium.BrandBrand600,
                        DesignSystemDarkMedium.BrandBrand700, DesignSystemDarkMedium.BrandBrand800]
            case .darkLarge:
                return [DesignSystemDarkLarge.BrandBrand300, DesignSystemDarkLarge.BrandBrand400,
                        DesignSystemDarkLarge.BrandBrand500, DesignSystemDarkLarge.BrandBrand600,
                        DesignSystemDarkLarge.BrandBrand700, DesignSystemDarkLarge.BrandBrand800]
            }
        }
        
        var accentColors: [Color] {
            switch self {
            case .global:
                return [DesignSystemGlobal.BackgroundAccentColorBlue, DesignSystemGlobal.BackgroundAccentColorGreen,
                        DesignSystemGlobal.BackgroundAccentColorYellow, DesignSystemGlobal.BackgroundAccentColorRed]
            case .lightMedium:
                return [DesignSystemLightMedium.BackgroundAccentColorBlue, DesignSystemLightMedium.BackgroundAccentColorGreen,
                        DesignSystemLightMedium.BackgroundAccentColorYellow, DesignSystemLightMedium.BackgroundAccentColorRed]
            case .darkMedium:
                return [DesignSystemDarkMedium.BackgroundAccentColorBlue, DesignSystemDarkMedium.BackgroundAccentColorGreen,
                        DesignSystemDarkMedium.BackgroundAccentColorYellow, DesignSystemDarkMedium.BackgroundAccentColorRed]
            case .darkLarge:
                return [DesignSystemDarkLarge.BackgroundAccentColorBlue, DesignSystemDarkLarge.BackgroundAccentColorGreen,
                        DesignSystemDarkLarge.BackgroundAccentColorYellow, DesignSystemDarkLarge.BackgroundAccentColorRed]
            }
        }
        
        var greigeColors: [Color] {
            switch self {
            case .global:
                return [DesignSystemGlobal.GreigeGreige050, DesignSystemGlobal.GreigeGreige100,
                        DesignSystemGlobal.GreigeGreige200, DesignSystemGlobal.GreigeGreige300,
                        DesignSystemGlobal.GreigeGreige400, DesignSystemGlobal.GreigeGreige500,
                        DesignSystemGlobal.GreigeGreige600, DesignSystemGlobal.GreigeGreige700,
                        DesignSystemGlobal.GreigeGreige800, DesignSystemGlobal.GreigeGreige900]
            case .lightMedium:
                return [DesignSystemLightMedium.GreigeGreige050, DesignSystemLightMedium.GreigeGreige100,
                        DesignSystemLightMedium.GreigeGreige200, DesignSystemLightMedium.GreigeGreige300,
                        DesignSystemLightMedium.GreigeGreige400, DesignSystemLightMedium.GreigeGreige500,
                        DesignSystemLightMedium.GreigeGreige600, DesignSystemLightMedium.GreigeGreige700,
                        DesignSystemLightMedium.GreigeGreige800, DesignSystemLightMedium.GreigeGreige900]
            case .darkMedium:
                return [DesignSystemDarkMedium.GreigeGreige050, DesignSystemDarkMedium.GreigeGreige100,
                        DesignSystemDarkMedium.GreigeGreige200, DesignSystemDarkMedium.GreigeGreige300,
                        DesignSystemDarkMedium.GreigeGreige400, DesignSystemDarkMedium.GreigeGreige500,
                        DesignSystemDarkMedium.GreigeGreige600, DesignSystemDarkMedium.GreigeGreige700,
                        DesignSystemDarkMedium.GreigeGreige800, DesignSystemDarkMedium.GreigeGreige900]
            case .darkLarge:
                return [DesignSystemDarkLarge.GreigeGreige050, DesignSystemDarkLarge.GreigeGreige100,
                        DesignSystemDarkLarge.GreigeGreige200, DesignSystemDarkLarge.GreigeGreige300,
                        DesignSystemDarkLarge.GreigeGreige400, DesignSystemDarkLarge.GreigeGreige500,
                        DesignSystemDarkLarge.GreigeGreige600, DesignSystemDarkLarge.GreigeGreige700,
                        DesignSystemDarkLarge.GreigeGreige800, DesignSystemDarkLarge.GreigeGreige900]
            }
        }
        
        var buttonColors: [(Color, Color)] {
            switch self {
            case .global:
                return [(DesignSystemGlobal.BackgroundButtonColorBrandFilledDefault, DesignSystemGlobal.TextButtonColorOrangeFilledDefault),
                        (DesignSystemGlobal.BackgroundButtonColorWhiteFilledDefault, DesignSystemGlobal.TextButtonColorWhiteFilledDefault),
                        (DesignSystemGlobal.BackgroundButtonColorTransparent10Default, DesignSystemGlobal.TextButtonColorTransparent10FilledDefault)]
            case .lightMedium:
                return [(DesignSystemLightMedium.BackgroundButtonColorBrandFilledDefault, DesignSystemLightMedium.TextButtonColorOrangeFilledDefault),
                        (DesignSystemLightMedium.BackgroundButtonColorWhiteFilledDefault, DesignSystemLightMedium.TextButtonColorWhiteFilledDefault),
                        (DesignSystemLightMedium.BackgroundButtonColorTransparent10Default, DesignSystemLightMedium.TextButtonColorTransparent10FilledDefault)]
            case .darkMedium:
                return [(DesignSystemDarkMedium.BackgroundButtonColorBrandFilledDefault, DesignSystemDarkMedium.TextButtonColorOrangeFilledDefault),
                        (DesignSystemDarkMedium.BackgroundButtonColorWhiteFilledDefault, DesignSystemDarkMedium.TextButtonColorWhiteFilledDefault),
                        (DesignSystemDarkMedium.BackgroundButtonColorTransparent10Default, DesignSystemDarkMedium.TextButtonColorTransparent10FilledDefault)]
            case .darkLarge:
                return [(DesignSystemDarkLarge.BackgroundButtonColorBrandFilledDefault, DesignSystemDarkLarge.TextButtonColorOrangeFilledDefault),
                        (DesignSystemDarkLarge.BackgroundButtonColorWhiteFilledDefault, DesignSystemDarkLarge.TextButtonColorWhiteFilledDefault),
                        (DesignSystemDarkLarge.BackgroundButtonColorTransparent10Default, DesignSystemDarkLarge.TextButtonColorTransparent10FilledDefault)]
            }
        }
        
        var backgroundGradient: [Color] {
            switch self {
            case .global:
                return [DesignSystemGlobal.MoonlightMoonlight700, DesignSystemGlobal.MoonlightMoonlight900]
            case .lightMedium:
                return [DesignSystemLightMedium.MoonlightMoonlight700, DesignSystemLightMedium.MoonlightMoonlight900]
            case .darkMedium:
                return [DesignSystemDarkMedium.MoonlightMoonlight700, DesignSystemDarkMedium.MoonlightMoonlight900]
            case .darkLarge:
                return [DesignSystemDarkLarge.MoonlightMoonlight700, DesignSystemDarkLarge.MoonlightMoonlight900]
            }
        }
    }
    
    // MARK: - View Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: DesignSystemGlobal.Spacing6) {
                    
                    // MARK: Theme Picker
                    Picker("Theme", selection: $selectedTheme) {
                        ForEach(ThemeSelection.allCases, id: \.self) { theme in
                            Text(theme.rawValue).tag(theme)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, DesignSystemGlobal.Spacing4)
                    
                    // MARK: Brand Colors
                    VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing4) {
                        Text("Brand Colors")
                            .font(.thdH5)
                            .padding(.horizontal, DesignSystemGlobal.Spacing4)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: DesignSystemGlobal.Spacing3) {
                            ForEach(Array(zip(selectedTheme.brandColors.indices, selectedTheme.brandColors)), id: \.0) { index, color in
                                ColorSwatch(name: "Brand \(300 + index * 100)", color: color)
                            }
                        }
                        .padding(DesignSystemGlobal.Spacing4)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadius3xl))
                        .padding(.horizontal, DesignSystemGlobal.Spacing4)
                    }
                    
                    // MARK: Accent Colors
                    VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing4) {
                        Text("Accent Colors")
                            .font(.thdH5)
                            .padding(.horizontal, DesignSystemGlobal.Spacing4)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: DesignSystemGlobal.Spacing3) {
                            let names = ["Blue", "Green", "Yellow", "Red"]
                            ForEach(Array(zip(names.indices, names)), id: \.0) { index, name in
                                ColorSwatch(name: name, color: selectedTheme.accentColors[index])
                            }
                        }
                        .padding(DesignSystemGlobal.Spacing4)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadius3xl))
                        .padding(.horizontal, DesignSystemGlobal.Spacing4)
                    }
                    
                    // MARK: Greige Palette
                    VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing4) {
                        Text("Greige Neutrals")
                            .font(.thdH5)
                            .padding(.horizontal, DesignSystemGlobal.Spacing4)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: DesignSystemGlobal.Spacing2) {
                            let labels = ["050", "100", "200", "300", "400", "500", "600", "700", "800", "900"]
                            ForEach(Array(zip(labels.indices, labels)), id: \.0) { index, label in
                                ColorSwatch(name: label, color: selectedTheme.greigeColors[index])
                            }
                        }
                        .padding(DesignSystemGlobal.Spacing4)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadius3xl))
                        .padding(.horizontal, DesignSystemGlobal.Spacing4)
                    }
                    
                    // MARK: Typography Sizes
                    VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing4) {
                        Text("Typography Scale")
                            .font(.thdH5)
                            .padding(.horizontal, DesignSystemGlobal.Spacing4)
                        
                        VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing2) {
                            TypographySample(label: "Hero 1", size: DesignSystemGlobal.FontFontSizeHero1)
                            TypographySample(label: "Hero 2", size: DesignSystemGlobal.FontFontSizeHero2)
                            TypographySample(label: "H1", size: DesignSystemGlobal.FontFontSizeH1)
                            TypographySample(label: "H2", size: DesignSystemGlobal.FontFontSizeH2)
                            TypographySample(label: "H3", size: DesignSystemGlobal.FontFontSizeH3)
                            TypographySample(label: "Body XL", size: DesignSystemGlobal.FontFontSizeBodyXl)
                            TypographySample(label: "Body Lg", size: DesignSystemGlobal.FontFontSizeBodyLg)
                            TypographySample(label: "Body Md", size: DesignSystemGlobal.FontFontSizeBodyMd)
                            TypographySample(label: "Body Sm", size: DesignSystemGlobal.FontFontSizeBodySm)
                            TypographySample(label: "Caption", size: DesignSystemGlobal.FontFontSizeCaption)
                        }
                        .padding(DesignSystemGlobal.Spacing4)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadius3xl))
                        .padding(.horizontal, DesignSystemGlobal.Spacing4)
                    }
                    
                    // MARK: Spacing Scale
                    VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing4) {
                        Text("Spacing Scale")
                            .font(.thdH5)
                            .padding(.horizontal, DesignSystemGlobal.Spacing4)
                        
                        VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing2) {
                            SpacingSample(label: "Spacing 1", spacing: DesignSystemGlobal.Spacing1)
                            SpacingSample(label: "Spacing 2", spacing: DesignSystemGlobal.Spacing2)
                            SpacingSample(label: "Spacing 3", spacing: DesignSystemGlobal.Spacing3)
                            SpacingSample(label: "Spacing 4", spacing: DesignSystemGlobal.Spacing4)
                            SpacingSample(label: "Spacing 5", spacing: DesignSystemGlobal.Spacing5)
                            SpacingSample(label: "Spacing 6", spacing: DesignSystemGlobal.Spacing6)
                            SpacingSample(label: "Spacing 8", spacing: DesignSystemGlobal.Spacing8)
                        }
                        .padding(DesignSystemGlobal.Spacing4)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadius3xl))
                        .padding(.horizontal, DesignSystemGlobal.Spacing4)
                    }
                    
                    // MARK: Border Radius
                    VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing4) {
                        Text("Border Radius")
                            .font(.thdH5)
                            .padding(.horizontal, DesignSystemGlobal.Spacing4)
                        
                        VStack(spacing: DesignSystemGlobal.Spacing2) {
                            RadiusSample(label: "Xs", radius: DesignSystemGlobal.BorderRadiusXs)
                            RadiusSample(label: "Sm", radius: DesignSystemGlobal.BorderRadiusSm)
                            RadiusSample(label: "Md", radius: DesignSystemGlobal.BorderRadiusMd)
                            RadiusSample(label: "Lg", radius: DesignSystemGlobal.BorderRadiusLg)
                            RadiusSample(label: "Xl", radius: DesignSystemGlobal.BorderRadiusXl)
                            RadiusSample(label: "2xl", radius: DesignSystemGlobal.BorderRadius2xl)
                            RadiusSample(label: "3xl", radius: DesignSystemGlobal.BorderRadius3xl)
                        }
                        .padding(DesignSystemGlobal.Spacing4)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadius3xl))
                        .padding(.horizontal, DesignSystemGlobal.Spacing4)
                    }
                    
                    // MARK: Button Colors
                    VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing4) {
                        Text("Button States")
                            .font(.thdH5)
                            .padding(.horizontal, DesignSystemGlobal.Spacing4)
                        
                        VStack(spacing: DesignSystemGlobal.Spacing3) {
                            let labels = ["Brand Filled", "White Filled", "Transparent 10"]
                            ForEach(Array(zip(labels.indices, labels)), id: \.0) { index, label in
                                ButtonColorSample(
                                    label: label,
                                    backgroundColor: selectedTheme.buttonColors[index].0,
                                    textColor: selectedTheme.buttonColors[index].1
                                )
                            }
                        }
                        .padding(DesignSystemGlobal.Spacing4)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadius3xl))
                        .padding(.horizontal, DesignSystemGlobal.Spacing4)
                    }
                    
                    // MARK: Shadow Elevation
                    VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing4) {
                        Text("Elevation Shadows")
                            .font(.thdH5)
                            .padding(.horizontal, DesignSystemGlobal.Spacing4)
                        
                        VStack(spacing: DesignSystemGlobal.Spacing3) {
                            ShadowSample(label: "Lowest", shadowColor: DesignSystemGlobal.ElevationLowest, blurRadius: DesignSystemGlobal.ElevationBlurRadiusBlur1)
                            ShadowSample(label: "Low", shadowColor: DesignSystemGlobal.ElevationLow, blurRadius: DesignSystemGlobal.ElevationBlurRadiusBlur2)
                            ShadowSample(label: "Med", shadowColor: DesignSystemGlobal.ElevationMed, blurRadius: DesignSystemGlobal.ElevationBlurRadiusBlur3)
                            ShadowSample(label: "High", shadowColor: DesignSystemGlobal.ElevationHigh, blurRadius: DesignSystemGlobal.ElevationBlurRadiusBlur4)
                            ShadowSample(label: "Highest", shadowColor: DesignSystemGlobal.ElevationHighest, blurRadius: DesignSystemGlobal.ElevationBlurRadiusBlur5)
                        }
                        .padding(DesignSystemGlobal.Spacing4)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadius3xl))
                        .padding(.horizontal, DesignSystemGlobal.Spacing4)
                    }
                }
                .padding(.vertical, DesignSystemGlobal.Spacing4)
            }
            .navigationTitle("Design System")
            .background(
                LinearGradient(
                    colors: selectedTheme.backgroundGradient,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
        }
    }
}

// MARK: - Color Swatch Component
struct ColorSwatch: View {
    let name: String
    let color: Color
    
    var body: some View {
        VStack(spacing: DesignSystemGlobal.Spacing2) {
            RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadiusLg)
                .fill(color.gradient)
                .frame(height: 60)
                .shadow(color: color.opacity(0.3), radius: 4, y: 2)
            
            Text(name)
                .font(.thdCaption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Typography Sample Component
struct TypographySample: View {
    let label: String
    let size: CGFloat
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(label)
                .font(.thdBodySm)
                .foregroundStyle(.secondary)
                .frame(width: 80, alignment: .leading)
            
            Text("Aa")
                .font(.thdInformational(size: size))
            
            Spacer()
            
            Text("\(Int(size))pt")
                .font(.thdCaption)
                .foregroundStyle(.tertiary)
        }
    }
}

// MARK: - Spacing Sample Component
struct SpacingSample: View {
    let label: String
    let spacing: CGFloat
    
    var body: some View {
        HStack {
            Text(label)
                .font(.thdBodySm)
                .frame(width: 100, alignment: .leading)
            
            Rectangle()
                .fill(DesignSystemGlobal.BrandBrand400)
                .frame(width: spacing, height: 20)
            
            Spacer()
            
            Text("\(Int(spacing))px")
                .font(.thdCaption)
                .foregroundStyle(.tertiary)
        }
    }
}

// MARK: - Radius Sample Component
struct RadiusSample: View {
    let label: String
    let radius: CGFloat
    
    var body: some View {
        HStack {
            Text(label)
                .font(.thdBodySm)
                .frame(width: 60, alignment: .leading)
            
            RoundedRectangle(cornerRadius: radius)
                .fill(DesignSystemGlobal.BrandBrand300.gradient)
                .frame(width: 80, height: 40)
            
            Spacer()
            
            Text("\(Int(radius))px")
                .font(.thdCaption)
                .foregroundStyle(.tertiary)
        }
    }
}

// MARK: - Button Color Sample Component
struct ButtonColorSample: View {
    let label: String
    let backgroundColor: Color
    let textColor: Color
    
    var body: some View {
        HStack {
            Text(label)
                .font(.thdBodySm)
                .frame(width: 120, alignment: .leading)
            
            Spacer()
            
            Text("Button")
                .font(.thdBodyMd)
                .foregroundColor(textColor)
                .padding(.horizontal, DesignSystemGlobal.Spacing4)
                .padding(.vertical, DesignSystemGlobal.Spacing2)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadiusLg))
        }
    }
}

// MARK: - Shadow Sample Component
struct ShadowSample: View {
    let label: String
    let shadowColor: Color
    let blurRadius: CGFloat
    
    var body: some View {
        HStack {
            Text(label)
                .font(.thdBodySm)
                .frame(width: 80, alignment: .leading)
            
            RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadiusLg)
                .fill(DesignSystemGlobal.BackgroundContainerColorWhite)
                .frame(width: 100, height: 40)
                .shadow(color: shadowColor, radius: blurRadius, y: 2)
            
            Spacer()
            
            Text("blur: \(Int(blurRadius))")
                .font(.thdCaption)
                .foregroundStyle(.tertiary)
        }
    }
}

// MARK: - Preview
#Preview {
    ThemeShowcaseView()
}
