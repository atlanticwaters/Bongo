//
// ThemeExtensions.swift
//

import SwiftUI

// MARK: - Theme Mode
/// Represents the current theme mode (light, dark, or automatic)
public enum ThemeMode: String, CaseIterable, Identifiable {
    case light = "Light"
    case dark = "Dark"
    case auto = "Auto"
    
    public var id: String { rawValue }
    
    public var icon: String {
        switch self {
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        case .auto: return "circle.lefthalf.filled"
        }
    }
}

// MARK: - Theme Manager
/// Observable class that manages the app's theme mode
@Observable
public class ThemeManager {
    public var currentMode: ThemeMode = .auto
    
    public init() {}
    
    /// Returns the appropriate color scheme based on the current mode
    public var preferredColorScheme: ColorScheme? {
        switch currentMode {
        case .light: return .light
        case .dark: return .dark
        case .auto: return nil
        }
    }
}

// MARK: - App Theme Configuration
/// Provides centralized theme configuration using the design system tokens
/// Automatically adapts to light/dark mode
public struct AppTheme {
    
    // MARK: - Brand Colors (same in both modes)
    /// Primary brand color used for icons, buttons, and accent elements
    public static func brandColor(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark 
            ? DesignSystemDarkLarge.BrandBrand300
            : DesignSystemLightLarge.BrandBrand300
    }
    
    /// Secondary brand color for subtle accents
    public static func brandColorDark(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? DesignSystemDarkLarge.BrandBrand400
            : DesignSystemLightLarge.BrandBrand400
    }
    
    // MARK: - Background Colors (adapt to mode)
    /// Main app background color - Light in light mode, dark in dark mode
    public static func appBackground(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? DesignSystemDarkLarge.GreigeGreige900 // Dark background
            : DesignSystemLightLarge.GreigeGreige050 // Light background
    }
    
    /// Card and container background color
    public static func cardBackground(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? DesignSystemDarkLarge.GreigeGreige800 // Lighter than app background
            : DesignSystemLightLarge.GreigeGreige200 // Darker than app background
    }
    
    /// Alternative container background for nested elements
    public static func containerBackground(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? DesignSystemDarkLarge.BackgroundContainerColorGreige
            : DesignSystemLightLarge.BackgroundContainerColorGreige
    }
    
    // MARK: - Text Colors (adapt to mode)
    /// Primary text color from design system
    public static func textPrimary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? DesignSystemDarkLarge.TextOnSurfaceColorInverse // Light text on dark
            : DesignSystemLightLarge.TextOnSurfaceColorPrimary // Dark text on light
    }
    
    /// Secondary text color for less prominent text
    public static func textSecondary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? DesignSystemDarkLarge.TextOnSurfaceColorTertiary
            : DesignSystemLightLarge.TextOnSurfaceColorSecondary
    }
    
    /// Tertiary text color for hints and labels
    public static func textTertiary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? DesignSystemDarkLarge.TextOnSurfaceColorQuatrenary
            : DesignSystemLightLarge.TextOnSurfaceColorTertiary
    }
    
    // MARK: - Icon Colors
    /// Primary icon color - uses brand color
    public static func iconAccent(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? DesignSystemDarkLarge.IconOnSurfaceColorAccent
            : DesignSystemLightLarge.IconOnSurfaceColorAccent
    }
    
    /// Standard icon color for non-accent icons
    public static func iconPrimary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? DesignSystemDarkLarge.IconOnSurfaceColorPrimary
            : DesignSystemLightLarge.IconOnSurfaceColorPrimary
    }
    
    // MARK: - Border and Divider Colors
    /// Default border color for cards and containers
    public static func borderDefault(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? DesignSystemDarkLarge.BorderOnContainerDefault
            : DesignSystemLightLarge.BorderOnContainerDefault
    }
    
    // MARK: - Spacing (same in both modes)
    /// Compact spacing (12pt)
    public static let spacingCompact = DesignSystemGlobal.Spacing3
    
    /// Standard spacing (16pt)
    public static let spacingStandard = DesignSystemGlobal.Spacing4
    
    /// Loose spacing (24pt)
    public static let spacingLoose = DesignSystemGlobal.Spacing6
    
    // MARK: - Corner Radius (same in both modes)
    /// Standard corner radius (12pt)
    public static let cornerRadiusStandard = DesignSystemGlobal.BorderRadiusXl
    
    /// Large corner radius (16pt)
    public static let cornerRadiusLarge = DesignSystemGlobal.BorderRadius2xl
}

// MARK: - View Extension for Themed Cards
extension View {
    
    /// Applies consistent card styling with theme-aware background
    /// - Parameter cornerRadius: The corner radius for the card (default: 12)
    /// - Returns: A view with card styling applied
    func themedCard(cornerRadius: CGFloat = 12) -> some View {
        modifier(ThemedCardModifier(cornerRadius: cornerRadius))
    }
    
    /// Applies consistent container styling with padding and theme-aware background
    /// - Parameters:
    ///   - padding: The padding amount (default: 16)
    ///   - cornerRadius: The corner radius (default: 12)
    /// - Returns: A view with container styling applied
    func themedContainer(padding: CGFloat = 16, cornerRadius: CGFloat = 12) -> some View {
        modifier(ThemedContainerModifier(padding: padding, cornerRadius: cornerRadius))
    }
    
    /// Applies the app's main theme-aware background color
    /// - Returns: A view with the app background applied
    func themedAppBackground() -> some View {
        modifier(ThemedAppBackgroundModifier())
    }
}

// MARK: - Theme-Aware Modifiers
private struct ThemedCardModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(AppTheme.cardBackground(for: colorScheme))
            .cornerRadius(cornerRadius)
    }
}

private struct ThemedContainerModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    let padding: CGFloat
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(AppTheme.cardBackground(for: colorScheme))
            .cornerRadius(cornerRadius)
    }
}

private struct ThemedAppBackgroundModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .background(AppTheme.appBackground(for: colorScheme).ignoresSafeArea())
    }
}

// MARK: - View Extension for Themed Icons
extension View {
    
    /// Applies the brand color tint to icons and symbols
    /// - Returns: A view with brand color tint applied
    func brandTinted() -> some View {
        modifier(BrandTintedModifier())
    }
    
    /// Applies accent icon styling
    /// - Returns: A view with accent icon color applied
    func accentIconStyle() -> some View {
        modifier(AccentIconModifier())
    }
}

private struct BrandTintedModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(AppTheme.brandColor(for: colorScheme))
    }
}

private struct AccentIconModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(AppTheme.iconAccent(for: colorScheme))
    }
}

// MARK: - Color Extensions for Semantic Access
extension Color {
    
    // MARK: - Brand Colors
    /// Primary brand color (orange) - use for primary actions and accents
    static func brandPrimary(for colorScheme: ColorScheme) -> Color {
        AppTheme.brandColor(for: colorScheme)
    }
    
    /// Darker brand color - use for hover states and pressed states
    static func brandDark(for colorScheme: ColorScheme) -> Color {
        AppTheme.brandColorDark(for: colorScheme)
    }
    
    // MARK: - Background Colors
    /// Main app background - adapts to light/dark mode
    static func appBackground(for colorScheme: ColorScheme) -> Color {
        AppTheme.appBackground(for: colorScheme)
    }
    
    /// Card background - adapts to light/dark mode
    static func cardBackground(for colorScheme: ColorScheme) -> Color {
        AppTheme.cardBackground(for: colorScheme)
    }
    
    /// Container background - for nested elements
    static func containerBackground(for colorScheme: ColorScheme) -> Color {
        AppTheme.containerBackground(for: colorScheme)
    }
    
    // MARK: - Text Colors
    /// Primary text color - adapts to light/dark mode
    static func textPrimary(for colorScheme: ColorScheme) -> Color {
        AppTheme.textPrimary(for: colorScheme)
    }
    
    /// Secondary text color - adapts to light/dark mode
    static func textSecondary(for colorScheme: ColorScheme) -> Color {
        AppTheme.textSecondary(for: colorScheme)
    }
    
    /// Tertiary text color - adapts to light/dark mode
    static func textTertiary(for colorScheme: ColorScheme) -> Color {
        AppTheme.textTertiary(for: colorScheme)
    }
    
    // MARK: - Border Colors
    /// Default border color - adapts to light/dark mode
    static func borderDefault(for colorScheme: ColorScheme) -> Color {
        AppTheme.borderDefault(for: colorScheme)
    }
    
    // MARK: - Convenience Properties (use current color scheme)
    // These provide backward compatibility with existing code
    static let brandPrimary = DesignSystemGlobal.BrandBrand300
    static let brandDark = DesignSystemGlobal.BrandBrand400
    static let appBackground = DesignSystemGlobal.GreigeGreige050
    static let cardBackground = DesignSystemGlobal.GreigeGreige200
    static let containerBackground = DesignSystemGlobal.BackgroundContainerColorGreige
    static let textPrimary = DesignSystemGlobal.TextOnSurfaceColorPrimary
    static let textSecondary = DesignSystemGlobal.TextOnSurfaceColorSecondary
    static let textTertiary = DesignSystemGlobal.TextOnSurfaceColorTertiary
    static let borderDefault = DesignSystemGlobal.BorderOnContainerDefault
}

// MARK: - Theme Mode Selector View
/// A button that displays the current theme mode and allows changing it
public struct ThemeModeSelector: View {
    @Bindable var themeManager: ThemeManager
    @Environment(\.colorScheme) var colorScheme
    
    public init(themeManager: ThemeManager) {
        self.themeManager = themeManager
    }
    
    public var body: some View {
        Menu {
            ForEach(ThemeMode.allCases) { mode in
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        themeManager.currentMode = mode
                    }
                } label: {
                    Label {
                        Text(mode.rawValue)
                    } icon: {
                        Image(systemName: mode.icon)
                        if themeManager.currentMode == mode {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack(spacing: 8) {
                Image(systemName: themeManager.currentMode.icon)
                    .foregroundStyle(AppTheme.iconAccent(for: colorScheme))
                Text(themeManager.currentMode.rawValue)
                    .foregroundStyle(Color.textPrimary(for: colorScheme))
            }
            .font(.subheadline)
            .fontWeight(.medium)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
        }
        .tint(AppTheme.brandColor(for: colorScheme))
    }
}

