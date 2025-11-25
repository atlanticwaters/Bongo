//
// ThemeExtensions.swift
//

import SwiftUI

// MARK: - App Theme Configuration
/// Provides centralized theme configuration using the design system tokens
/// This ensures consistent color usage throughout the app
public struct AppTheme {
    
    // MARK: - Brand Colors
    /// Primary brand color used for icons, buttons, and accent elements
    public static let brandColor = DesignSystemGlobal.BrandBrand300
    
    /// Secondary brand color for subtle accents
    public static let brandColorDark = DesignSystemGlobal.BrandBrand400
    
    // MARK: - Background Colors
    /// Main app background color - Griege 050 (light neutral)
    public static let appBackground = DesignSystemGlobal.GreigeGreige050
    
    /// Card and container background color - Griege 200 (slightly darker than app background)
    public static let cardBackground = DesignSystemGlobal.GreigeGreige200
    
    /// Alternative container background for nested elements
    public static let containerBackground = DesignSystemGlobal.BackgroundContainerColorGreige
    
    // MARK: - Text Colors
    /// Primary text color from design system
    public static let textPrimary = DesignSystemGlobal.TextOnSurfaceColorPrimary
    
    /// Secondary text color for less prominent text
    public static let textSecondary = DesignSystemGlobal.TextOnSurfaceColorSecondary
    
    /// Tertiary text color for hints and labels
    public static let textTertiary = DesignSystemGlobal.TextOnSurfaceColorTertiary
    
    // MARK: - Icon Colors
    /// Primary icon color - uses brand color
    public static let iconAccent = DesignSystemGlobal.IconOnSurfaceColorAccent
    
    /// Standard icon color for non-accent icons
    public static let iconPrimary = DesignSystemGlobal.IconOnSurfaceColorPrimary
    
    // MARK: - Border and Divider Colors
    /// Default border color for cards and containers
    public static let borderDefault = DesignSystemGlobal.BorderOnContainerDefault
}

// MARK: - View Extension for Themed Cards
extension View {
    
    /// Applies consistent card styling with Griege 200 background
    /// - Parameter cornerRadius: The corner radius for the card (default: 12)
    /// - Returns: A view with card styling applied
    func themedCard(cornerRadius: CGFloat = 12) -> some View {
        self
            .background(AppTheme.cardBackground)
            .cornerRadius(cornerRadius)
    }
    
    /// Applies consistent container styling with padding and background
    /// - Parameters:
    ///   - padding: The padding amount (default: 16)
    ///   - cornerRadius: The corner radius (default: 12)
    /// - Returns: A view with container styling applied
    func themedContainer(padding: CGFloat = 16, cornerRadius: CGFloat = 12) -> some View {
        self
            .padding(padding)
            .background(AppTheme.cardBackground)
            .cornerRadius(cornerRadius)
    }
    
    /// Applies the app's main background color (Griege 050)
    /// - Returns: A view with the app background applied
    func themedAppBackground() -> some View {
        self
            .background(AppTheme.appBackground.ignoresSafeArea())
    }
}

// MARK: - View Extension for Themed Icons
extension View {
    
    /// Applies the brand color tint to icons and symbols
    /// - Returns: A view with brand color tint applied
    func brandTinted() -> some View {
        self
            .foregroundStyle(AppTheme.brandColor)
    }
    
    /// Applies accent icon styling
    /// - Returns: A view with accent icon color applied
    func accentIconStyle() -> some View {
        self
            .foregroundStyle(AppTheme.iconAccent)
    }
}

// MARK: - Color Extensions for Semantic Access
extension Color {
    
    // MARK: - Brand Colors
    /// Primary brand color (orange) - use for primary actions and accents
    static let brandPrimary = AppTheme.brandColor
    
    /// Darker brand color - use for hover states and pressed states
    static let brandDark = AppTheme.brandColorDark
    
    // MARK: - Background Colors
    /// Main app background - Griege 050
    static let appBackground = AppTheme.appBackground
    
    /// Card background - Griege 200
    static let cardBackground = AppTheme.cardBackground
    
    /// Container background - for nested elements
    static let containerBackground = AppTheme.containerBackground
    
    // MARK: - Text Colors
    /// Primary text color
    static let textPrimary = AppTheme.textPrimary
    
    /// Secondary text color
    static let textSecondary = AppTheme.textSecondary
    
    /// Tertiary text color
    static let textTertiary = AppTheme.textTertiary
}
