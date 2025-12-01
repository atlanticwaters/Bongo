import SwiftUI

// MARK: - Font Test View
// Use this view to test if custom fonts are loading correctly
struct FontTestView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Header
                Text("Font Loading Test")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom)
                
                // Font Status
                fontStatusSection
                
                Divider()
                
                // Display Font Tests
                displayFontSection
                
                Divider()
                
                // Informational Font Tests
                informationalFontSection
                
                Divider()
                
                // Full Typography Scale
                typographyScaleSection
            }
            .padding()
        }
    }
    
    // MARK: - Font Status Section
    private var fontStatusSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Font Status")
                .font(.system(size: 20, weight: .semibold))
            
            let fontsAvailable = CustomFontRegistration.areCustomFontsAvailable()
            
            HStack {
                Image(systemName: fontsAvailable ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(fontsAvailable ? .green : .red)
                
                Text(fontsAvailable ? "Custom fonts loaded successfully" : "Custom fonts not available (using fallback)")
                    .font(.system(size: 16))
            }
            
            Text("Check console for detailed font registration logs")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
    }
    
    // MARK: - Display Font Section
    private var displayFontSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Display Font Family (THD LgVar Beta)")
                .font(.system(size: 20, weight: .semibold))
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Hero 1 - 64pt")
                    .font(.thdHero1)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                
                Text("Hero 2 - 56pt")
                    .font(.thdHero2)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                
                Text("Hero 3 - 48pt")
                    .font(.thdHero3)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                
                Text("Heading 1 - 32pt")
                    .font(.thdH1)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                
                Text("Heading 2 - 28pt")
                    .font(.thdH2)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                
                Text("Heading 3 - 24pt")
                    .font(.thdH3)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
            }
        }
    }
    
    // MARK: - Informational Font Section
    private var informationalFontSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Informational Font Family (THD SmVar Beta)")
                .font(.system(size: 20, weight: .semibold))
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Body XL - 20pt")
                    .font(.thdBodyXL)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                
                Text("Body Large - 18pt")
                    .font(.thdBodyLg)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                
                Text("Body Medium - 16pt")
                    .font(.thdBodyMd)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                
                Text("Body Small - 14pt")
                    .font(.thdBodySm)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                
                Text("Body XS - 12pt")
                    .font(.thdBodyXs)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                
                Text("Caption - 11pt")
                    .font(.thdCaption)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
            }
        }
    }
    
    // MARK: - Typography Scale Section
    private var typographyScaleSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Complete Typography Scale")
                .font(.system(size: 20, weight: .semibold))
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(TypographyExample.allExamples) { example in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(example.label)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        
                        Text(example.sampleText)
                            .thdFont(example.style)
                            .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                    }
                }
            }
        }
    }
}

// MARK: - Typography Example Model
private struct TypographyExample: Identifiable {
    let id = UUID()
    let label: String
    let style: CustomFontModifier.TextStyle
    let sampleText: String
    
    static let allExamples: [TypographyExample] = [
        TypographyExample(label: "Hero 1 (64pt)", style: .hero1, sampleText: "The Quick Brown Fox"),
        TypographyExample(label: "Hero 2 (56pt)", style: .hero2, sampleText: "The Quick Brown Fox"),
        TypographyExample(label: "Hero 3 (48pt)", style: .hero3, sampleText: "The Quick Brown Fox"),
        TypographyExample(label: "Hero 4 (40pt)", style: .hero4, sampleText: "The Quick Brown Fox"),
        TypographyExample(label: "Hero 5 (36pt)", style: .hero5, sampleText: "The Quick Brown Fox"),
        TypographyExample(label: "H1 (32pt)", style: .h1, sampleText: "The Quick Brown Fox Jumps"),
        TypographyExample(label: "H2 (28pt)", style: .h2, sampleText: "The Quick Brown Fox Jumps"),
        TypographyExample(label: "H3 (24pt)", style: .h3, sampleText: "The Quick Brown Fox Jumps Over"),
        TypographyExample(label: "H4 (20pt)", style: .h4, sampleText: "The Quick Brown Fox Jumps Over"),
        TypographyExample(label: "H5 (18pt)", style: .h5, sampleText: "The Quick Brown Fox Jumps Over The Lazy Dog"),
        TypographyExample(label: "H6 (16pt)", style: .h6, sampleText: "The Quick Brown Fox Jumps Over The Lazy Dog"),
        TypographyExample(label: "Body XL (20pt)", style: .bodyXL, sampleText: "The quick brown fox jumps over the lazy dog"),
        TypographyExample(label: "Body Lg (18pt)", style: .bodyLg, sampleText: "The quick brown fox jumps over the lazy dog"),
        TypographyExample(label: "Body Md (16pt)", style: .bodyMd, sampleText: "The quick brown fox jumps over the lazy dog"),
        TypographyExample(label: "Body Sm (14pt)", style: .bodySm, sampleText: "The quick brown fox jumps over the lazy dog"),
        TypographyExample(label: "Body Xs (12pt)", style: .bodyXs, sampleText: "The quick brown fox jumps over the lazy dog"),
        TypographyExample(label: "Caption (11pt)", style: .caption, sampleText: "The quick brown fox jumps over the lazy dog")
    ]
}

// MARK: - Preview
#Preview("Font Test") {
    FontTestView()
}

#Preview("Font Test - Dark") {
    FontTestView()
        .preferredColorScheme(.dark)
}
