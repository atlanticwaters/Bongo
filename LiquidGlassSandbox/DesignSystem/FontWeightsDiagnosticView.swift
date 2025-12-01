import SwiftUI
import UIKit

// MARK: - Font Weights Diagnostic View
// This view helps you understand how font weights are structured in your app
struct FontWeightsDiagnosticView: View {
    @State private var fontFamilies: [FontFamily] = []
    @State private var variableFontInfo: [String: Any] = [:]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                Text("Font Weights Diagnostic")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom)
                
                // Font Families Section
                fontFamiliesSection
                
                Divider()
                
                // Variable Font Check
                variableFontSection
                
                Divider()
                
                // Design System Weights
                designSystemWeightsSection
                
                Divider()
                
                // Weight Comparison
                weightComparisonSection
                
                Divider()
                
                // Recommendations
                recommendationsSection
            }
            .padding()
        }
        .onAppear {
            analyzeFonts()
        }
    }
    
    // MARK: - Font Families Section
    private var fontFamiliesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Available THD Fonts")
                .font(.system(size: 20, weight: .semibold))
            
            if fontFamilies.isEmpty {
                Text("No THD fonts found")
                    .foregroundColor(.orange)
            } else {
                ForEach(fontFamilies) { family in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(family.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.blue)
                        
                        ForEach(family.fonts, id: \.self) { fontName in
                            HStack {
                                Image(systemName: "doc.text")
                                    .foregroundColor(.secondary)
                                Text(fontName)
                                    .font(.system(size: 14, design: .monospaced))
                            }
                            .padding(.leading)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            
            Text("Total THD font variations found: \(fontFamilies.reduce(0) { $0 + $1.fonts.count })")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .padding(.top, 4)
        }
    }
    
    // MARK: - Variable Font Section
    private var variableFontSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Variable Font Analysis")
                .font(.system(size: 20, weight: .semibold))
            
            Text("Checking if 'THD LgVar Beta' supports variable weights...")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            if let font = UIFont(name: "THD LgVar Beta", size: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    infoRow(label: "Font loaded", value: "✅ Yes", color: .green)
                    infoRow(label: "Family", value: font.familyName, color: .primary)
                    infoRow(label: "PostScript name", value: font.fontName, color: .primary)
                    infoRow(label: "Point size", value: "\(font.pointSize)", color: .primary)
                    
                    // Check for variable font axes
                    if let traits = font.fontDescriptor.fontAttributes[.traits] as? [String: Any] {
                        Text("Font Traits:")
                            .font(.system(size: 14, weight: .medium))
                            .padding(.top, 4)
                        
                        ForEach(Array(traits.keys.sorted()), id: \.self) { key in
                            infoRow(label: key, value: "\(traits[key] ?? "nil")", color: .secondary)
                        }
                    }
                    
                    // Check for variation axes (variable fonts)
                    if let variation = font.fontDescriptor.fontAttributes[.init(rawValue: "NSCTFontVariationAttribute")] {
                        Text("✅ Variable Font Detected!")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.green)
                            .padding(.top, 4)
                        
                        Text("Variation axes: \(String(describing: variation))")
                            .font(.system(size: 12, design: .monospaced))
                            .foregroundColor(.secondary)
                    } else {
                        Text("❌ Not a variable font")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)
                            .padding(.top, 4)
                    }
                }
            } else {
                Text("❌ Could not load 'THD LgVar Beta'")
                    .foregroundColor(.red)
            }
        }
    }
    
    // MARK: - Design System Weights Section
    private var designSystemWeightsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Design System Weight Definitions")
                .font(.system(size: 20, weight: .semibold))
            
            Text("From DesignSystemGlobal.swift:")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            Group {
                weightDefinition("Body Light", DesignSystemGlobal.FontFontWeightBodyLight)
                weightDefinition("Body Regular", DesignSystemGlobal.FontFontWeightBodyRegular)
                weightDefinition("Body Medium", DesignSystemGlobal.FontFontWeightBodyMedium)
                weightDefinition("Body Semibold", DesignSystemGlobal.FontFontWeightBodySemibold)
                weightDefinition("Body Bold", DesignSystemGlobal.FontFontWeightBodyBold)
                weightDefinition("Heading Semibold", DesignSystemGlobal.FontFontWeightHeadingSemibold)
                weightDefinition("Heading Bold", DesignSystemGlobal.FontFontWeightHeadingBold)
                weightDefinition("Heading Extrabold", DesignSystemGlobal.FontFontWeightHeadingExtrabold)
            }
            
            Text("⚠️ These weights are currently not being applied to custom fonts")
                .font(.system(size: 14))
                .foregroundColor(.orange)
                .padding(.top, 4)
        }
    }
    
    // MARK: - Weight Comparison Section
    private var weightComparisonSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Font Weight Comparison")
                .font(.system(size: 20, weight: .semibold))
            
            Text("How different weights should look:")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 8) {
                weightExample("Light", .light, 300)
                weightExample("Regular", .regular, 400)
                weightExample("Medium", .medium, 500)
                weightExample("Semibold", .semibold, 600)
                weightExample("Bold", .bold, 700)
                weightExample("Heavy", .heavy, 800)
                weightExample("Black", .black, 900)
            }
        }
    }
    
    // MARK: - Recommendations Section
    private var recommendationsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recommendations")
                .font(.system(size: 20, weight: .semibold))
            
            let fontCount = fontFamilies.reduce(0) { $0 + $1.fonts.count }
            
            VStack(alignment: .leading, spacing: 16) {
                if fontCount == 0 {
                    recommendation(
                        icon: "exclamationmark.triangle.fill",
                        color: .red,
                        title: "No THD Fonts Found",
                        description: "Add font files to your Resources folder and configure Info.plist"
                    )
                } else if fontCount == 1 || fontCount == 2 {
                    recommendation(
                        icon: "info.circle.fill",
                        color: .blue,
                        title: "Single Weight Fonts",
                        description: "You have \(fontCount) font file(s). If you need multiple weights, you'll need additional font files or variable font support."
                    )
                } else if fontCount > 2 {
                    recommendation(
                        icon: "checkmark.circle.fill",
                        color: .green,
                        title: "Multiple Weight Support Available",
                        description: "You have \(fontCount) font variations. Update CustomFonts.swift to map weights to specific font names."
                    )
                }
                
                // Variable font recommendation
                if let font = UIFont(name: "THD LgVar Beta", size: 16),
                   font.fontDescriptor.fontAttributes[.init(rawValue: "NSCTFontVariationAttribute")] != nil {
                    recommendation(
                        icon: "star.fill",
                        color: .purple,
                        title: "Variable Font Support",
                        description: "Your font supports variable weights! Update CustomFonts.swift to use variable font APIs."
                    )
                }
            }
        }
    }
    
    // MARK: - Helper Views
    private func infoRow(label: String, value: String, color: Color) -> some View {
        HStack {
            Text(label + ":")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            Text(value)
                .font(.system(size: 14, design: .monospaced))
                .foregroundColor(color)
        }
    }
    
    private func weightDefinition(_ name: String, _ value: String) -> some View {
        HStack {
            Text(name)
                .font(.system(size: 14))
                .frame(width: 140, alignment: .leading)
            Text(value)
                .font(.system(size: 14, design: .monospaced))
                .foregroundColor(.blue)
        }
    }
    
    private func weightExample(_ name: String, _ weight: Font.Weight, _ numeric: Int) -> some View {
        HStack {
            Text("\(name) (\(numeric))")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .frame(width: 140, alignment: .leading)
            
            Text("The quick brown fox")
                .font(.system(size: 16, weight: weight))
        }
    }
    
    private func recommendation(icon: String, color: Color, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 24))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
    }
    
    // MARK: - Font Analysis
    private func analyzeFonts() {
        var families: [FontFamily] = []
        
        // Find all font families containing "THD"
        for familyName in UIFont.familyNames.sorted() {
            if familyName.lowercased().contains("thd") {
                let fonts = UIFont.fontNames(forFamilyName: familyName).sorted()
                families.append(FontFamily(name: familyName, fonts: fonts))
            }
        }
        
        // Also check for the specific font names from design system
        let expectedNames = [
            "THD LgVar Beta",
            "THD SmVar Beta",
            "THDLgVarBeta",
            "THDSmVarBeta",
            "THD-LgVar-Beta",
            "THD-SmVar-Beta"
        ]
        
        for fontName in expectedNames {
            if UIFont(name: fontName, size: 12) != nil {
                // Font exists but might not be in a family yet
                if !families.contains(where: { $0.fonts.contains(fontName) }) {
                    families.append(FontFamily(name: "Individual Font", fonts: [fontName]))
                }
            }
        }
        
        self.fontFamilies = families
    }
}

// MARK: - Supporting Types
private struct FontFamily: Identifiable {
    let id = UUID()
    let name: String
    let fonts: [String]
}

// MARK: - Preview
#Preview("Font Weights Diagnostic") {
    FontWeightsDiagnosticView()
}
