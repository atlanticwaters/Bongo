# Theme Implementation Guide

This guide explains how the consistent theme pattern has been implemented in your app.

## Overview

The app now uses a centralized theme system based on your design tokens from `DesignSystemGlobal.swift`. This ensures:

1. **Brand Color** (BrandBrand300 - Orange) is used for all icons and accent colors
2. **Card Backgrounds** use Griege 200 for consistent cards throughout the app
3. **Main App Background** uses Griege 050 for a light, neutral base

## Theme Structure

### Core Theme File: `ThemeExtensions.swift`

The `ThemeExtensions.swift` file provides:

#### 1. AppTheme Struct
A centralized configuration for all theme colors:

```swift
public struct AppTheme {
    // Brand Colors
    public static let brandColor = DesignSystemGlobal.BrandBrand300  // Orange
    public static let brandColorDark = DesignSystemGlobal.BrandBrand400
    
    // Background Colors
    public static let appBackground = DesignSystemGlobal.GreigeGreige050  // Main background
    public static let cardBackground = DesignSystemGlobal.GreigeGreige200  // Card background
    
    // Text Colors
    public static let textPrimary = DesignSystemGlobal.TextOnSurfaceColorPrimary
    public static let textSecondary = DesignSystemGlobal.TextOnSurfaceColorSecondary
    
    // Icon Colors
    public static let iconAccent = DesignSystemGlobal.IconOnSurfaceColorAccent
    public static let iconPrimary = DesignSystemGlobal.IconOnSurfaceColorPrimary
}
```

#### 2. View Modifiers

##### `.themedCard(cornerRadius:)`
Applies Griege 200 background to create consistent card styling:

```swift
VStack {
    Text("Card Content")
}
.themedCard()  // Uses default 12pt corner radius
```

##### `.themedContainer(padding:cornerRadius:)`
Applies padding AND Griege 200 background:

```swift
VStack {
    Text("Container Content")
}
.themedContainer()  // Includes 16pt padding by default
```

##### `.themedAppBackground()`
Applies Griege 050 background for the main app background:

```swift
TabView {
    // tabs...
}
.themedAppBackground()
```

##### `.brandTinted()`
Applies brand color to icons:

```swift
Image(systemName: "star.fill")
    .brandTinted()  // Uses orange brand color
```

##### `.accentIconStyle()`
Applies accent icon color from design system:

```swift
Image(systemName: "heart.fill")
    .accentIconStyle()
```

#### 3. Color Extensions

For direct color access without modifiers:

```swift
Text("Hello")
    .foregroundStyle(Color.brandPrimary)

RoundedRectangle(cornerRadius: 8)
    .fill(Color.cardBackground)

// Available colors:
// .brandPrimary, .brandDark
// .appBackground, .cardBackground, .containerBackground
// .textPrimary, .textSecondary, .textTertiary
```

## Implementation in Your App

### 1. ContentView (Main Tab View)

The main TabView now applies:
- `.tint(AppTheme.brandColor)` - Makes all tab icons and tappable elements orange
- `.themedAppBackground()` - Sets Griege 050 as the main background

```swift
TabView(selection: $selectedTab) {
    // tabs...
}
.tint(AppTheme.brandColor)
.themedAppBackground()
```

### 2. Updated Views

The following views have been updated to use themed cards:

#### ColorAndGradientView
- Section containers use `.themedContainer()` for Griege 200 backgrounds
- Replaces all `.background(.gray.opacity(0.05))` instances

#### GlassComponentsView
- Material demonstration cards use `.themedContainer()`
- Consistent Griege 200 backgrounds for all glass material examples

#### AdaptiveUIView
- Detail panel cards use `.themedCard()` or `.themedContainer()`
- Icons use `.brandTinted()` for consistent orange brand color

### 3. AppBackground.swift

Updated to use `AppTheme.appBackground` (Griege 050) instead of hardcoded Griege 100:

```swift
struct AppBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppTheme.appBackground.ignoresSafeArea())
    }
}
```

## Usage Examples

### Creating a Card

```swift
VStack(spacing: 12) {
    Text("Card Title")
        .font(.headline)
    
    Text("Card description")
        .font(.body)
        .foregroundStyle(Color.textSecondary)
}
.themedContainer()  // Automatic padding + Griege 200 background
```

### Creating an Icon Button

```swift
Button {
    // action
} label: {
    Image(systemName: "star.fill")
        .brandTinted()  // Orange brand color
}
```

### Creating a Custom Background

```swift
ScrollView {
    // content
}
.themedAppBackground()  // Griege 050 background
```

## Global Tint Configuration

To set the brand color as the global tint for the entire app, add this to your App struct:

```swift
@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(AppTheme.brandColor)  // Sets global tint
        }
    }
}
```

Or apply it to ContentView as currently implemented:

```swift
TabView {
    // tabs
}
.tint(AppTheme.brandColor)
```

## Design Token Mapping

| Theme Constant | Design Token | Color | Usage |
|----------------|--------------|-------|-------|
| `AppTheme.brandColor` | `BrandBrand300` | Orange (#F96302) | Icons, buttons, accents |
| `AppTheme.appBackground` | `GreigeGreige050` | Light beige | Main app background |
| `AppTheme.cardBackground` | `GreigeGreige200` | Medium beige | Cards, containers |
| `AppTheme.textPrimary` | `TextOnSurfaceColorPrimary` | Dark gray | Primary text |
| `AppTheme.textSecondary` | `TextOnSurfaceColorSecondary` | Medium gray | Secondary text |

## Migration Guide

### Before
```swift
VStack {
    Text("Content")
}
.padding()
.background(.gray.opacity(0.1))
.cornerRadius(12)
```

### After
```swift
VStack {
    Text("Content")
}
.themedContainer()
```

---

### Before
```swift
Image(systemName: "heart.fill")
    .foregroundColor(.blue)
```

### After
```swift
Image(systemName: "heart.fill")
    .brandTinted()
```

---

### Before
```swift
.background(Color(red: 0.973, green: 0.961, blue: 0.949))
```

### After
```swift
.themedAppBackground()
// or
.background(Color.appBackground)
```

## Best Practices

1. **Always use theme colors** instead of hardcoded colors
2. **Use view modifiers** (`.themedCard()`, `.themedContainer()`) for consistency
3. **Apply `.brandTinted()`** to icons that should be accent-colored
4. **Use semantic color names** from `Color` extensions
5. **Keep `AppTheme`** as the single source of truth for colors

## Extending the Theme

To add new theme elements:

1. Add to `AppTheme` struct:
```swift
public static let customColor = DesignSystemGlobal.YourToken
```

2. Add extension to `Color` if needed:
```swift
extension Color {
    static let customColor = AppTheme.customColor
}
```

3. Create view modifier if appropriate:
```swift
extension View {
    func customStyle() -> some View {
        self.background(AppTheme.customColor)
    }
}
```

## Files Modified

1. ✅ `ThemeExtensions.swift` - Created (new theme system)
2. ✅ `AppBackground.swift` - Updated to use Griege 050
3. ✅ `ContentView.swift` - Added brand tint and themed background
4. ✅ `ColorAndGradientView.swift` - Updated all section containers
5. ✅ `GlassComponentsView.swift` - Updated all card backgrounds
6. ✅ `AdaptiveUIView.swift` - Updated cards and icons

## Testing Checklist

- [ ] All tab icons appear in orange brand color
- [ ] Main app background is Griege 050 (light beige)
- [ ] All card backgrounds are Griege 200 (medium beige)
- [ ] Icons throughout app use brand orange color
- [ ] Navigation links and buttons use brand color
- [ ] Text hierarchy uses correct semantic colors
- [ ] Theme colors work in both light and dark mode

## Support

If you need to adjust colors:
- Edit `AppTheme` in `ThemeExtensions.swift`
- All usages will automatically update throughout the app
