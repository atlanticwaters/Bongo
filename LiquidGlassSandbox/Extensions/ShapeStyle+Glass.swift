import SwiftUI

extension ShapeStyle where Self == Material {
    /// A custom glass material that provides a frosted glass effect.
    /// Currently aliases to .ultraThinMaterial but can be customized.
    public static var glass: Material { .ultraThinMaterial }
}
