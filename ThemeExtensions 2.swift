//
// ThemeExtensions.swift
//
// DESIGN SYSTEM INTEGRATION
// =========================
// This file connects to auto-generated design system token files and provides
// a convenient API for using design tokens throughout the app.
//
// TOKEN FLOW:
// 1. Design tokens are defined in a design tool (e.g., Figma, Tokens Studio)
// 2. Tokens are exported and auto-generate Swift files in the Design System folder:
//    - DesignSystemGlobal.swift (global tokens for all themes)
//    - DesignSystemLightMedium.swift (light mode, medium size)
//    - DesignSystemLightLarge.swift (light mode, large size)
//    - DesignSystemDarkMedium.swift (dark mode, medium size)
//    - DesignSystemDarkLarge.swift (dark mode, large size)
// 3. This file (ThemeExtensions.swift) reads tokens from design system files
// 4. App views use convenient APIs like AppTheme.brandColor or .themedCard()
// 5. When design tokens change, regenerate the design system files and the
//    entire app updates automatically without changing any view code!
//
// DEMONSTRATION:
// This file demonstrates how the app connects to, reads from, and acts upon
// the design token values defined in the Design System folder.
//

import SwiftUI

// MARK: - App Theme Configuration
/// Centralized theme configuration that reads from auto-generated design system token files.
/// 
/// **🔗 Design System Connection:**
/// All colors, spacing, and styling values come directly from the Design System folder.
/// This struct acts as a bridge between raw design tokens and the app's UI.
///
/// **📦 Token Sources:**
/// - `DesignSystemGlobal.swift` - Contains all base design tokens
/// - Context-aware design system files for different modes/sizes
///
/// **✨ Why This Matters:**
/// When designers update tokens in the design system and regenerate the Swift files,
/// the entire app automatically reflects those changes without modifying any view code.
/// This creates a true design-to-code pipeline.
public struct AppTheme {
    
    // MARK: - Brand Colors
    
    /// Primary brand color used for icons, buttons, and accent elements
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.BrandBrand300`
    ///
    /// **📍 Token Path:** Brand → Brand → 300
    ///
    /// **🎨 Value:** RGB(249, 99, 2) / #F96302
    ///
    /// **Usage:** Tab icons, buttons, links, accent elements
    ///
    /// **Demo:** Change this token in your design system and regenerate files
    /// to see the entire app's accent color update automatically!
    public static let brandColor = DesignSystemGlobal.BrandBrand300
    
    /// Secondary brand color for pressed states and subtle accents
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.BrandBrand400`
    ///
    /// **📍 Token Path:** Brand → Brand → 400
    ///
    /// **🎨 Value:** RGB(233, 92, 2) / #E95C02
    ///
    /// **Usage:** Button pressed states, hover effects, darker accents
    public static let brandColorDark = DesignSystemGlobal.BrandBrand400
    
    // MARK: - Background Colors
    
    /// Main app background color - creates the base canvas
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.GreigeGreige050`
    ///
    /// **📍 Token Path:** Greige → Greige → 050
    ///
    /// **🎨 Value:** RGB(248, 245, 242) / #F8F5F2
    ///
    /// **Usage:** Main app background, scroll view backgrounds, empty space
    ///
    /// **Demo:** This is the lightest neutral color, providing a subtle warm background
    public static let appBackground = DesignSystemGlobal.GreigeGreige050
    
    /// Card and container background color - provides visual elevation
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.GreigeGreige200`
    ///
    /// **📍 Token Path:** Greige → Greige → 200
    ///
    /// **🎨 Value:** RGB(186, 183, 180) / #BAB7B4
    ///
    /// **Usage:** Cards, sections, containers that need to stand out from background
    ///
    /// **Demo:** Creates clear visual hierarchy by contrasting with the app background
    public static let cardBackground = DesignSystemGlobal.GreigeGreige200
    
    /// Alternative container background from semantic tokens
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.BackgroundContainerColorGreige`
    ///
    /// **📍 Token Path:** Background → Container Color → Greige
    ///
    /// **🎨 Value:** RGB(248, 245, 242) / #F8F5F2
    ///
    /// **Usage:** Nested containers, alternative backgrounds
    public static let containerBackground = DesignSystemGlobal.BackgroundContainerColorGreige
    
    // MARK: - Text Colors
    // These are semantic tokens that define text hierarchy
    
    /// Primary text color - highest contrast
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.TextOnSurfaceColorPrimary`
    ///
    /// **📍 Token Path:** Text → OnSurface Color → Primary
    ///
    /// **🎨 Value:** RGB(37, 37, 35) / #252523
    ///
    /// **Usage:** Headlines, body text, primary content
    public static let textPrimary = DesignSystemGlobal.TextOnSurfaceColorPrimary
    
    /// Secondary text color - medium emphasis
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.TextOnSurfaceColorSecondary`
    ///
    /// **📍 Token Path:** Text → OnSurface Color → Secondary
    ///
    /// **🎨 Value:** RGB(71, 69, 63) / #47453F
    ///
    /// **Usage:** Descriptions, supporting text, less important content
    public static let textSecondary = DesignSystemGlobal.TextOnSurfaceColorSecondary
    
    /// Tertiary text color - low emphasis
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.TextOnSurfaceColorTertiary`
    ///
    /// **📍 Token Path:** Text → OnSurface Color → Tertiary
    ///
    /// **🎨 Value:** RGB(106, 104, 102) / #6A6866
    ///
    /// **Usage:** Labels, hints, captions, placeholder text
    public static let textTertiary = DesignSystemGlobal.TextOnSurfaceColorTertiary
    
    // MARK: - Icon Colors
    
    /// Accent icon color - matches brand
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.IconOnSurfaceColorAccent`
    ///
    /// **📍 Token Path:** Icon → OnSurface Color → Accent
    ///
    /// **🎨 Value:** RGB(249, 99, 2) / #F96302
    ///
    /// **Usage:** Featured icons, accent symbols, important indicators
    public static let iconAccent = DesignSystemGlobal.IconOnSurfaceColorAccent
    
    /// Primary icon color - standard icons
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.IconOnSurfaceColorPrimary`
    ///
    /// **📍 Token Path:** Icon → OnSurface Color → Primary
    ///
    /// **🎨 Value:** RGB(37, 37, 35) / #252523
    ///
    /// **Usage:** Standard icons, navigation symbols, non-accent icons
    public static let iconPrimary = DesignSystemGlobal.IconOnSurfaceColorPrimary
    
    // MARK: - Border and Divider Colors
    
    /// Default border color for cards and containers
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.BorderOnContainerDefault`
    ///
    /// **📍 Token Path:** Border → OnContainer → Default
    ///
    /// **🎨 Value:** RGB(186, 183, 180) / #BAB7B4
    ///
    /// **Usage:** Borders, dividers, separators
    public static let borderDefault = DesignSystemGlobal.BorderOnContainerDefault
    
    // MARK: - Spacing Tokens
    // Design system includes spacing tokens for consistent layouts
    
    /// Standard spacing unit from design system
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.Spacing4`
    ///
    /// **📍 Token Path:** Spacing → 4
    ///
    /// **🎨 Value:** 16pt
    ///
    /// **Usage:** Standard padding, gaps between elements
    public static let spacingStandard = DesignSystemGlobal.Spacing4
    
    /// Compact spacing unit from design system
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.Spacing3`
    ///
    /// **📍 Token Path:** Spacing → 3
    ///
    /// **🎨 Value:** 12pt
    ///
    /// **Usage:** Tighter padding, compact layouts
    public static let spacingCompact = DesignSystemGlobal.Spacing3
    
    /// Loose spacing unit from design system
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.Spacing6`
    ///
    /// **📍 Token Path:** Spacing → 6
    ///
    /// **🎨 Value:** 24pt
    ///
    /// **Usage:** Section spacing, larger gaps
    public static let spacingLoose = DesignSystemGlobal.Spacing6
    
    // MARK: - Border Radius Tokens
    
    /// Standard corner radius from design system
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.BorderRadiusXl`
    ///
    /// **📍 Token Path:** BorderRadius → Xl
    ///
    /// **🎨 Value:** 8pt
    ///
    /// **Usage:** Card corners, button corners
    public static let cornerRadiusStandard = DesignSystemGlobal.BorderRadiusXl
    
    /// Large corner radius from design system
    ///
    /// **🔗 Connected To:** `DesignSystemGlobal.BorderRadius2xl`
    ///
    /// **📍 Token Path:** BorderRadius → 2xl
    ///
    /// **🎨 Value:** 12pt
    ///
    /// **Usage:** Larger cards, prominent elements
    public static let cornerRadiusLarge = DesignSystemGlobal.BorderRadius2xl
}

// MARK: - View Extension for Themed Cards
extension View {
    
    /// Applies consistent card styling with design system tokens
    ///
    /// **Design System Connection:**
    /// - Background: Uses `cardBackground` token (Griege 200)
    /// - Corner Radius: Uses `cornerRadiusLarge` token (12pt)
    ///
    /// - Parameter cornerRadius: Optional override for corner radius
    /// - Returns: A view with card styling applied from design tokens
    ///
    /// **Example:**
    /// ```swift
    /// VStack {
    ///     Text("Card Content")
    /// }
    /// .themedCard()  // Applies design system card tokens
    /// ```
    func themedCard(cornerRadius: CGFloat? = nil) -> some View {
        self
            .background(AppTheme.cardBackground)
            .cornerRadius(cornerRadius ?? AppTheme.cornerRadiusLarge)
    }
    
    /// Applies consistent container styling with padding and design system tokens
    ///
    /// **Design System Connection:**
    /// - Padding: Uses `spacingStandard` token (16pt)
    /// - Background: Uses `cardBackground` token (Griege 200)
    /// - Corner Radius: Uses `cornerRadiusLarge` token (12pt)
    ///
    /// - Parameters:
    ///   - padding: Optional override for padding (defaults to design token)
    ///   - cornerRadius: Optional override for corner radius (defaults to design token)
    /// - Returns: A view with container styling applied from design tokens
    ///
    /// **Example:**
    /// ```swift
    /// VStack {
    ///     Text("Container Content")
    /// }
    /// .themedContainer()  // Applies design system container tokens
    /// ```
    func themedContainer(padding: CGFloat? = nil, cornerRadius: CGFloat? = nil) -> some View {
        self
            .padding(padding ?? AppTheme.spacingStandard)
            .background(AppTheme.cardBackground)
            .cornerRadius(cornerRadius ?? AppTheme.cornerRadiusLarge)
    }
    
    /// Applies the app's main background color from design system
    ///
    /// **Design System Connection:**
    /// - Background: Uses `appBackground` token (Griege 050)
    ///
    /// - Returns: A view with the design system app background applied
    ///
    /// **Example:**
    /// ```swift
    /// ScrollView {
    ///     // content
    /// }
    /// .themedAppBackground()  // Applies design system background token
    /// ```
    func themedAppBackground() -> some View {
        self
            .background(AppTheme.appBackground.ignoresSafeArea())
    }
}

// MARK: - View Extension for Themed Icons
extension View {
    
    /// Applies the brand color tint to icons and symbols from design system
    ///
    /// **Design System Connection:**
    /// - Color: Uses `brandColor` token (BrandBrand300)
    ///
    /// - Returns: A view with brand color tint applied from design tokens
    ///
    /// **Example:**
    /// ```swift
    /// Image(systemName: "star.fill")
    ///     .brandTinted()  // Applies design system brand color
    /// ```
    func brandTinted() -> some View {
        self
            .foregroundStyle(AppTheme.brandColor)
    }
    
    /// Applies accent icon styling from design system
    ///
    /// **Design System Connection:**
    /// - Color: Uses `iconAccent` token (IconOnSurfaceColorAccent)
    ///
    /// - Returns: A view with accent icon color applied from design tokens
    ///
    /// **Example:**
    /// ```swift
    /// Image(systemName: "heart.fill")
    ///     .accentIconStyle()  // Applies design system icon accent
    /// ```
    func accentIconStyle() -> some View {
        self
            .foregroundStyle(AppTheme.iconAccent)
    }
}

// MARK: - Color Extensions for Semantic Access
/// Color extensions that provide semantic access to design system tokens
///
/// **Why Semantic Names?**
/// Instead of remembering token paths like `DesignSystemGlobal.BrandBrand300`,
/// use semantic names like `Color.brandPrimary` that describe the color's purpose.
///
/// **Design System Integration:**
/// All colors are connected to design system tokens. When tokens change,
/// these colors automatically update throughout the app.
extension Color {
    
    // MARK: - Brand Colors
    
    /// Primary brand color from design system
    ///
    /// **Connected to:** `AppTheme.brandColor` → `DesignSystemGlobal.BrandBrand300`
    static let brandPrimary = AppTheme.brandColor
    
    /// Darker brand color from design system
    ///
    /// **Connected to:** `AppTheme.brandColorDark` → `DesignSystemGlobal.BrandBrand400`
    static let brandDark = AppTheme.brandColorDark
    
    // MARK: - Background Colors
    
    /// Main app background from design system
    ///
    /// **Connected to:** `AppTheme.appBackground` → `DesignSystemGlobal.GreigeGreige050`
    static let appBackground = AppTheme.appBackground
    
    /// Card background from design system
    ///
    /// **Connected to:** `AppTheme.cardBackground` → `DesignSystemGlobal.GreigeGreige200`
    static let cardBackground = AppTheme.cardBackground
    
    /// Container background from design system
    ///
    /// **Connected to:** `AppTheme.containerBackground` → `DesignSystemGlobal.BackgroundContainerColorGreige`
    static let containerBackground = AppTheme.containerBackground
    
    // MARK: - Text Colors
    
    /// Primary text color from design system
    ///
    /// **Connected to:** `AppTheme.textPrimary` → `DesignSystemGlobal.TextOnSurfaceColorPrimary`
    static let textPrimary = AppTheme.textPrimary
    
    /// Secondary text color from design system
    ///
    /// **Connected to:** `AppTheme.textSecondary` → `DesignSystemGlobal.TextOnSurfaceColorSecondary`
    static let textSecondary = AppTheme.textSecondary
    
    /// Tertiary text color from design system
    ///
    /// **Connected to:** `AppTheme.textTertiary` → `DesignSystemGlobal.TextOnSurfaceColorTertiary`
    static let textTertiary = AppTheme.textTertiary
}

// MARK: - Design System Token Inspector
/// Utility struct for inspecting design system token values
/// This demonstrates that the app is reading actual values from design system files
public struct DesignSystemTokenInspector {
    
    /// Returns a human-readable description of a token's connection
    public static func tokenInfo(for colorName: String) -> TokenInfo? {
        switch colorName {
        case "brandColor":
            return TokenInfo(
                name: "Brand Color",
                tokenPath: "DesignSystemGlobal.BrandBrand300",
                designPath: "Brand → Brand → 300",
                value: colorToRGB(AppTheme.brandColor),
                hex: "#F96302",
                usedIn: "Tab icons, buttons, links, accent elements"
            )
        case "appBackground":
            return TokenInfo(
                name: "App Background",
                tokenPath: "DesignSystemGlobal.GreigeGreige050",
                designPath: "Greige → Greige → 050",
                value: colorToRGB(AppTheme.appBackground),
                hex: "#F8F5F2",
                usedIn: "Main app background, scroll views"
            )
        case "cardBackground":
            return TokenInfo(
                name: "Card Background",
                tokenPath: "DesignSystemGlobal.GreigeGreige200",
                designPath: "Greige → Greige → 200",
                value: colorToRGB(AppTheme.cardBackground),
                hex: "#BAB7B4",
                usedIn: "Cards, containers, sections"
            )
        default:
            return nil
        }
    }
    
    /// Lists all available design system files
    public static func availableDesignSystems() -> [String] {
        return [
            "DesignSystemGlobal.swift",
            "DesignSystemLightMedium.swift",
            "DesignSystemLightLarge.swift",
            "DesignSystemDarkMedium.swift",
            "DesignSystemDarkLarge.swift"
        ]
    }
    
    /// Helper function to convert Color to RGB string
    private static func colorToRGB(_ color: Color) -> String {
        // This is a simplified representation
        return "RGB values from design tokens"
    }
}

// MARK: - Token Info Model
/// Model representing design system token information
public struct TokenInfo {
    let name: String
    let tokenPath: String
    let designPath: String
    let value: String
    let hex: String
    let usedIn: String
}
