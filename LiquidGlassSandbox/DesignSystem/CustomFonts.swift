import SwiftUI
import UIKit

// MARK: - Custom Font Extension
// Provides easy access to the custom THD font family from the design system
extension Font {
    
    // MARK: - Display Font Family (THD LgVar Beta)
    // Used for large, attention-grabbing text like heroes and headers
    static func thdDisplay(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        // Try multiple possible font names
        let possibleNames = [
            "THD LgVar Beta",
            "THDLgVarBeta",
            "THD-LgVar-Beta",
            "THD_LgVar_Beta"
        ]
        
        // Check which font is actually available
        for fontName in possibleNames {
            if UIFont(name: fontName, size: size) != nil {
                return .custom(fontName, size: size)
            }
        }
        
        // Fallback to system font with appropriate weight
        print("⚠️ THD Display font not found, using system font")
        return .system(size: size, weight: weight, design: .default)
    }
    
    // MARK: - Informational Font Family (THD SmVar Beta)
    // Used for body text, captions, and informational content
    static func thdInformational(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        // Try multiple possible font names
        let possibleNames = [
            "THD SmVar Beta",
            "THDSmVarBeta",
            "THD-SmVar-Beta",
            "THD_SmVar_Beta"
        ]
        
        // Check which font is actually available
        for fontName in possibleNames {
            if UIFont(name: fontName, size: size) != nil {
                return .custom(fontName, size: size)
            }
        }
        
        // Fallback to system font with appropriate weight
        print("⚠️ THD Informational font not found, using system font")
        return .system(size: size, weight: weight, design: .default)
    }
    
    // MARK: - Design System Typography Scale
    // These match the token sizes from the design system files
    
    // Hero sizes (largest)
    static var thdHero1: Font {
        .thdDisplay(size: DesignSystemGlobal.FontFontSizeHero1)
    }
    
    static var thdHero2: Font {
        .thdDisplay(size: DesignSystemGlobal.FontFontSizeHero2)
    }
    
    static var thdHero3: Font {
        .thdDisplay(size: DesignSystemGlobal.FontFontSizeHero3)
    }
    
    static var thdHero4: Font {
        .thdDisplay(size: DesignSystemGlobal.FontFontSizeHero4)
    }
    
    static var thdHero5: Font {
        .thdDisplay(size: DesignSystemGlobal.FontFontSizeHero5)
    }
    
    // Heading sizes
    static var thdH1: Font {
        .thdDisplay(size: DesignSystemGlobal.FontFontSizeH1)
    }
    
    static var thdH2: Font {
        .thdDisplay(size: DesignSystemGlobal.FontFontSizeH2)
    }
    
    static var thdH3: Font {
        .thdDisplay(size: DesignSystemGlobal.FontFontSizeH3)
    }
    
    static var thdH4: Font {
        .thdDisplay(size: DesignSystemGlobal.FontFontSizeH4)
    }
    
    static var thdH5: Font {
        .thdDisplay(size: DesignSystemGlobal.FontFontSizeH5)
    }
    
    static var thdH6: Font {
        .thdDisplay(size: DesignSystemGlobal.FontFontSizeH6)
    }
    
    // Body text sizes
    static var thdBodyXL: Font {
        .thdInformational(size: DesignSystemGlobal.FontFontSizeBodyXl)
    }
    
    static var thdBodyLg: Font {
        .thdInformational(size: DesignSystemGlobal.FontFontSizeBodyLg)
    }
    
    static var thdBodyMd: Font {
        .thdInformational(size: DesignSystemGlobal.FontFontSizeBodyMd)
    }
    
    static var thdBodySm: Font {
        .thdInformational(size: DesignSystemGlobal.FontFontSizeBodySm)
    }
    
    static var thdBodyXs: Font {
        .thdInformational(size: DesignSystemGlobal.FontFontSizeBodyXs)
    }
    
    static var thdCaption: Font {
        .thdInformational(size: DesignSystemGlobal.FontFontSizeCaption)
    }
}

// MARK: - Font Registration Helper
// Call this early in your app lifecycle to register custom fonts
struct CustomFontRegistration {
    static func registerFonts() {
        // Possible font file names to try
        let fontFileNames = [
            "THD-LgVar-Beta",
            "THD-SmVar-Beta",
            "THDLgVarBeta",
            "THDSmVarBeta",
            "THD_LgVar_Beta",
            "THD_SmVar_Beta"
        ]
        
        let extensions = ["ttf", "otf"]
        
        for fontFileName in fontFileNames {
            for ext in extensions {
                if let fontURL = Bundle.main.url(forResource: fontFileName, withExtension: ext) {
                    var errorRef: Unmanaged<CFError>?
                    let success = CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &errorRef)
                    
                    if success {
                        print("✅ Successfully registered font: \(fontFileName).\(ext)")
                    } else if let error = errorRef?.takeRetainedValue() {
                        print("⚠️ Failed to register font \(fontFileName).\(ext): \(error)")
                    }
                }
            }
        }
        
        // List all available fonts for debugging
        print("\n📝 All available fonts in the system:")
        for family in UIFont.familyNames.sorted() {
            print("  Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("    - \(name)")
            }
        }
        print("\n")
    }
    
    // Helper to check if custom fonts are available
    static func areCustomFontsAvailable() -> Bool {
        let lgVarAvailable = UIFont(name: "THD LgVar Beta", size: 12) != nil ||
                            UIFont(name: "THDLgVarBeta", size: 12) != nil ||
                            UIFont(name: "THD-LgVar-Beta", size: 12) != nil
        
        let smVarAvailable = UIFont(name: "THD SmVar Beta", size: 12) != nil ||
                            UIFont(name: "THDSmVarBeta", size: 12) != nil ||
                            UIFont(name: "THD-SmVar-Beta", size: 12) != nil
        
        return lgVarAvailable && smVarAvailable
    }
}

// MARK: - View Modifier for Custom Fonts
// Applies the appropriate custom font based on text style
struct CustomFontModifier: ViewModifier {
    let textStyle: TextStyle
    
    enum TextStyle {
        case hero1, hero2, hero3, hero4, hero5
        case h1, h2, h3, h4, h5, h6
        case bodyXL, bodyLg, bodyMd, bodySm, bodyXs
        case caption
        
        var font: Font {
            switch self {
            case .hero1: return .thdHero1
            case .hero2: return .thdHero2
            case .hero3: return .thdHero3
            case .hero4: return .thdHero4
            case .hero5: return .thdHero5
            case .h1: return .thdH1
            case .h2: return .thdH2
            case .h3: return .thdH3
            case .h4: return .thdH4
            case .h5: return .thdH5
            case .h6: return .thdH6
            case .bodyXL: return .thdBodyXL
            case .bodyLg: return .thdBodyLg
            case .bodyMd: return .thdBodyMd
            case .bodySm: return .thdBodySm
            case .bodyXs: return .thdBodyXs
            case .caption: return .thdCaption
            }
        }
    }
    
    func body(content: Content) -> some View {
        content.font(textStyle.font)
    }
}

// MARK: - View Extension
extension View {
    func thdFont(_ style: CustomFontModifier.TextStyle) -> some View {
        modifier(CustomFontModifier(textStyle: style))
    }
}
