//
// DesignSystemTokenInspector.swift
//
// Utility for inspecting design system token files
//

import Foundation

/// Utility struct for inspecting and discovering design system files
struct DesignSystemTokenInspector {
    
    /// Returns a list of available design system file names
    /// - Returns: An array of design system file names
    static func availableDesignSystems() -> [String] {
        return [
            "DesignSystemGlobal.swift",
            "ThemeExtensions.swift"
        ]
    }
}
