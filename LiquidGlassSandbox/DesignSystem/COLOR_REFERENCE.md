# Design System Color Reference

Quick reference guide for all color variables in the design system with Swift code examples.

---

## Brand Colors

### Brand Orange
```swift
DesignSystemGlobal.BrandBrand025  // rgb(255, 250, 246)
DesignSystemGlobal.BrandBrand050  // rgb(254, 242, 233)
DesignSystemGlobal.BrandBrand100  // rgb(254, 218, 195)
DesignSystemGlobal.BrandBrand200  // rgb(251, 162, 104)
DesignSystemGlobal.BrandBrand300  // rgb(249, 99, 2)    ⭐ Primary Brand
DesignSystemGlobal.BrandBrand400  // rgb(233, 92, 2)
DesignSystemGlobal.BrandBrand500  // rgb(202, 80, 2)
DesignSystemGlobal.BrandBrand600  // rgb(179, 71, 1)
DesignSystemGlobal.BrandBrand700  // rgb(149, 59, 1)
DesignSystemGlobal.BrandBrand800  // rgb(120, 48, 1)
DesignSystemGlobal.BrandBrand900  // rgb(64, 26, 1)
DesignSystemGlobal.BrandBrand950  // rgb(24, 9, 0)
```

**Usage:**
```swift
.foregroundStyle(DesignSystemGlobal.BrandBrand300)
.background(DesignSystemGlobal.BrandBrand050)
.tint(DesignSystemGlobal.BrandBrand300)
```

---

## Greige (Neutral Gray-Beige)

### Primary Neutrals
```swift
DesignSystemGlobal.GreigeGreige025  // rgb(251, 250, 249)
DesignSystemGlobal.GreigeGreige050  // rgb(248, 245, 242) ⭐ Background
DesignSystemGlobal.GreigeGreige100  // rgb(229, 225, 222)
DesignSystemGlobal.GreigeGreige200  // rgb(186, 183, 180) ⭐ Cards
DesignSystemGlobal.GreigeGreige300  // rgb(151, 148, 146)
DesignSystemGlobal.GreigeGreige400  // rgb(139, 136, 135)
DesignSystemGlobal.GreigeGreige500  // rgb(120, 118, 117)
DesignSystemGlobal.GreigeGreige600  // rgb(106, 104, 103)
DesignSystemGlobal.GreigeGreige700  // rgb(88, 87, 86)
DesignSystemGlobal.GreigeGreige800  // rgb(71, 69, 69)
DesignSystemGlobal.GreigeGreige900  // rgb(37, 37, 36)   ⭐ Text
DesignSystemGlobal.GreigeGreige950  // rgb(13, 13, 13)
```

**Usage:**
```swift
.background(DesignSystemGlobal.GreigeGreige050)  // App background
.background(DesignSystemGlobal.GreigeGreige200)  // Card background
.foregroundStyle(DesignSystemGlobal.GreigeGreige900)  // Primary text
```

---

## Accent Colors

### Bottle Green
```swift
DesignSystemGlobal.BottleGreenBottleGreen025  // rgb(250, 252, 251)
DesignSystemGlobal.BottleGreenBottleGreen050  // rgb(240, 245, 243)
DesignSystemGlobal.BottleGreenBottleGreen100  // rgb(216, 228, 222)
DesignSystemGlobal.BottleGreenBottleGreen200  // rgb(160, 190, 174)
DesignSystemGlobal.BottleGreenBottleGreen300  // rgb(115, 158, 136)
DesignSystemGlobal.BottleGreenBottleGreen400  // rgb(99, 147, 123)
DesignSystemGlobal.BottleGreenBottleGreen500  // rgb(74, 129, 101)  ⭐ Success
DesignSystemGlobal.BottleGreenBottleGreen600  // rgb(57, 116, 86)
DesignSystemGlobal.BottleGreenBottleGreen700  // rgb(34, 98, 66)
DesignSystemGlobal.BottleGreenBottleGreen800  // rgb(13, 80, 46)
DesignSystemGlobal.BottleGreenBottleGreen900  // rgb(0, 44, 18)
DesignSystemGlobal.BottleGreenBottleGreen950  // rgb(0, 16, 6)
```

### Moonlight Blue
```swift
DesignSystemGlobal.MoonlightMoonlight025  // rgb(251, 251, 253)
DesignSystemGlobal.MoonlightMoonlight050  // rgb(243, 244, 248)
DesignSystemGlobal.MoonlightMoonlight100  // rgb(223, 225, 235)
DesignSystemGlobal.MoonlightMoonlight200  // rgb(176, 182, 208)
DesignSystemGlobal.MoonlightMoonlight300  // rgb(139, 147, 185)
DesignSystemGlobal.MoonlightMoonlight400  // rgb(126, 135, 177)
DesignSystemGlobal.MoonlightMoonlight500  // rgb(105, 116, 165) ⭐ Info
DesignSystemGlobal.MoonlightMoonlight600  // rgb(90, 102, 155)
DesignSystemGlobal.MoonlightMoonlight700  // rgb(73, 84, 137)
DesignSystemGlobal.MoonlightMoonlight800  // rgb(58, 68, 109)
DesignSystemGlobal.MoonlightMoonlight900  // rgb(30, 36, 58)
DesignSystemGlobal.MoonlightMoonlight950  // rgb(11, 12, 20)
```

### Cinnabar Red
```swift
DesignSystemGlobal.CinnabarCinnabar025  // rgb(254, 249, 249)
DesignSystemGlobal.CinnabarCinnabar050  // rgb(253, 241, 240)
DesignSystemGlobal.CinnabarCinnabar100  // rgb(251, 218, 215)
DesignSystemGlobal.CinnabarCinnabar200  // rgb(245, 162, 155)
DesignSystemGlobal.CinnabarCinnabar300  // rgb(240, 107, 97)
DesignSystemGlobal.CinnabarCinnabar400  // rgb(237, 85, 73)
DesignSystemGlobal.CinnabarCinnabar500  // rgb(223, 52, 39)   ⭐ Error
DesignSystemGlobal.CinnabarCinnabar600  // rgb(198, 46, 35)
DesignSystemGlobal.CinnabarCinnabar700  // rgb(165, 39, 29)
DesignSystemGlobal.CinnabarCinnabar800  // rgb(134, 31, 23)
DesignSystemGlobal.CinnabarCinnabar900  // rgb(73, 17, 13)
DesignSystemGlobal.CinnabarCinnabar950  // rgb(28, 6, 5)
```

### Lemon Yellow
```swift
DesignSystemGlobal.LemonLemon025  // rgb(254, 251, 237)
DesignSystemGlobal.LemonLemon050  // rgb(253, 246, 210)
DesignSystemGlobal.LemonLemon100  // rgb(249, 226, 112)  ⭐ Warning
DesignSystemGlobal.LemonLemon200  // rgb(207, 183, 58)
DesignSystemGlobal.LemonLemon300  // rgb(165, 149, 71)
DesignSystemGlobal.LemonLemon400  // rgb(151, 137, 72)
DesignSystemGlobal.LemonLemon500  // rgb(129, 119, 71)
DesignSystemGlobal.LemonLemon600  // rgb(113, 105, 69)
DesignSystemGlobal.LemonLemon700  // rgb(92, 87, 63)
DesignSystemGlobal.LemonLemon800  // rgb(74, 70, 55)
DesignSystemGlobal.LemonLemon900  // rgb(38, 37, 33)
DesignSystemGlobal.LemonLemon950  // rgb(13, 13, 13)
```

### Chamoisee Brown
```swift
DesignSystemGlobal.ChamoiseeChamoisee025  // rgb(252, 251, 251)
DesignSystemGlobal.ChamoiseeChamoisee050  // rgb(247, 244, 242)
DesignSystemGlobal.ChamoiseeChamoisee100  // rgb(232, 224, 219)
DesignSystemGlobal.ChamoiseeChamoisee200  // rgb(199, 180, 168)
DesignSystemGlobal.ChamoiseeChamoisee300  // rgb(172, 143, 124)
DesignSystemGlobal.ChamoiseeChamoisee400  // rgb(163, 130, 110)
DesignSystemGlobal.ChamoiseeChamoisee500  // rgb(144, 112, 91)
DesignSystemGlobal.ChamoiseeChamoisee600  // rgb(128, 99, 81)
DesignSystemGlobal.ChamoiseeChamoisee700  // rgb(107, 82, 67)
DesignSystemGlobal.ChamoiseeChamoisee800  // rgb(85, 66, 54)
DesignSystemGlobal.ChamoiseeChamoisee900  // rgb(45, 35, 28)
DesignSystemGlobal.ChamoiseeChamoisee950  // rgb(16, 12, 10)
```

---

## Background Colors

### Container Backgrounds
```swift
// Primary containers
DesignSystemGlobal.BackgroundContainerColorWhite
DesignSystemGlobal.BackgroundContainerColorGreige
DesignSystemGlobal.BackgroundContainerColorBrand
DesignSystemGlobal.BackgroundContainerColorBrandAccent
DesignSystemGlobal.BackgroundContainerColorInverse

// Transparent overlays
DesignSystemGlobal.BackgroundContainerColorTransparent05
DesignSystemGlobal.BackgroundContainerColorTransparent10
DesignSystemGlobal.BackgroundContainerColorTransparent20
```

### Surface Backgrounds
```swift
DesignSystemGlobal.BackgroundSurfaceColorGreige
DesignSystemGlobal.BackgroundSurfaceColorInverse
```

### Button Backgrounds
```swift
// Brand buttons
DesignSystemGlobal.BackgroundButtonColorBrandFilledDefault
DesignSystemGlobal.BackgroundButtonColorBrandFilledInactive

// White buttons
DesignSystemGlobal.BackgroundButtonColorWhiteFilledDefault
DesignSystemGlobal.BackgroundButtonColorWhiteFilledInactive

// Ghost buttons
DesignSystemGlobal.BackgroundButtonColorGhostFilledDefault
DesignSystemGlobal.BackgroundButtonColorGhostFilledInactive
DesignSystemGlobal.BackgroundButtonColorGhostFilledPressed

// Transparent buttons
DesignSystemGlobal.BackgroundButtonColorTransparent05Default
DesignSystemGlobal.BackgroundButtonColorTransparent10Default
```

### Feedback Backgrounds
```swift
// Error
DesignSystemGlobal.BackgroundFeedbackColorErrorAccent1     // Light
DesignSystemGlobal.BackgroundFeedbackColorErrorAccent2     // Dark

// Success
DesignSystemGlobal.BackgroundFeedbackColorSuccessAccent1   // Light
DesignSystemGlobal.BackgroundFeedbackColorSuccessAccent2   // Dark

// Warning
DesignSystemGlobal.BackgroundFeedbackColorWarningAccent1   // Light
DesignSystemGlobal.BackgroundFeedbackColorWarningAccent2   // Dark

// Informational
DesignSystemGlobal.BackgroundFeedbackColorInformationalAccent1  // Light
DesignSystemGlobal.BackgroundFeedbackColorInformationalAccent2  // Dark
```

---

## Text Colors

### On Container (Cards/Panels)
```swift
DesignSystemGlobal.TextOnContainerColorPrimary       // Main text
DesignSystemGlobal.TextOnContainerColorSecondary     // Secondary text
DesignSystemGlobal.TextOnContainerColorTertiary      // Subtle text
DesignSystemGlobal.TextOnContainerColorQuatrenary    // Least emphasis
DesignSystemGlobal.TextOnContainerColorInactive      // Disabled text
DesignSystemGlobal.TextOnContainerColorInverse       // Light on dark

// Semantic colors
DesignSystemGlobal.TextOnContainerColorAccent        // Brand orange
DesignSystemGlobal.TextOnContainerColorAccent2       // Dark orange
DesignSystemGlobal.TextOnContainerColorError
DesignSystemGlobal.TextOnContainerColorSuccess
DesignSystemGlobal.TextOnContainerColorWarning
DesignSystemGlobal.TextOnContainerColorInformational
```

### On Surface (Main backgrounds)
```swift
DesignSystemGlobal.TextOnSurfaceColorPrimary
DesignSystemGlobal.TextOnSurfaceColorSecondary
DesignSystemGlobal.TextOnSurfaceColorTertiary
DesignSystemGlobal.TextOnSurfaceColorQuatrenary
DesignSystemGlobal.TextOnSurfaceColorInactive
DesignSystemGlobal.TextOnSurfaceColorInverse

// Semantic colors
DesignSystemGlobal.TextOnSurfaceColorAccent
DesignSystemGlobal.TextOnSurfaceColorAccent2
DesignSystemGlobal.TextOnSurfaceColorError
DesignSystemGlobal.TextOnSurfaceColorSuccess
DesignSystemGlobal.TextOnSurfaceColorWarning
DesignSystemGlobal.TextOnSurfaceColorInformational
```

### Button Text
```swift
DesignSystemGlobal.TextButtonColorOrangeFilledDefault
DesignSystemGlobal.TextButtonColorOrangeOutlineDefault
DesignSystemGlobal.TextButtonColorWhiteFilledDefault
DesignSystemGlobal.TextButtonColorGhostFilledDefault
```

---

## Border Colors

### Input Borders
```swift
DesignSystemGlobal.BorderInputColorDefault      // Normal state
DesignSystemGlobal.BorderInputColorActive       // Active state
DesignSystemGlobal.BorderInputColorFocus        // Focused state
DesignSystemGlobal.BorderInputColorPressed      // Pressed state
DesignSystemGlobal.BorderInputColorInactive     // Disabled state
DesignSystemGlobal.BorderInputColorAccent       // Brand accent
DesignSystemGlobal.BorderInputColorError        // Error state
DesignSystemGlobal.BorderInputColorSuccess      // Success state
DesignSystemGlobal.BorderInputColorWarning      // Warning state
```

### Button Borders
```swift
DesignSystemGlobal.BorderButtonColorDefault
DesignSystemGlobal.BorderButtonColorFocus
DesignSystemGlobal.BorderButtonColorPressed
DesignSystemGlobal.BorderButtonColorInactive
DesignSystemGlobal.BorderButtonColorAccent
DesignSystemGlobal.BorderButtonColorOrangeOutlineDefault
```

### Container Borders
```swift
DesignSystemGlobal.BorderOnContainerDefault
DesignSystemGlobal.BorderOnContainerActive
DesignSystemGlobal.BorderOnContainerPressed
DesignSystemGlobal.BorderOnContainerInactive
DesignSystemGlobal.BorderOnContainerInverse
```

---

## Icon Colors

### On Container
```swift
DesignSystemGlobal.IconOnContainerColorPrimary
DesignSystemGlobal.IconOnContainerColorSecondary
DesignSystemGlobal.IconOnContainerColorTertiary
DesignSystemGlobal.IconOnContainerColorInactive
DesignSystemGlobal.IconOnContainerColorInverse

// Semantic icons
DesignSystemGlobal.IconOnContainerColorAccent
DesignSystemGlobal.IconOnContainerColorError
DesignSystemGlobal.IconOnContainerColorSuccess
DesignSystemGlobal.IconOnContainerColorWarning
DesignSystemGlobal.IconOnContainerColorInformational
```

### On Surface
```swift
DesignSystemGlobal.IconOnSurfaceColorPrimary
DesignSystemGlobal.IconOnSurfaceColorSecondary
DesignSystemGlobal.IconOnSurfaceColorTertiary
DesignSystemGlobal.IconOnSurfaceColorInactive
DesignSystemGlobal.IconOnSurfaceColorInverse

// Semantic icons
DesignSystemGlobal.IconOnSurfaceColorAccent
DesignSystemGlobal.IconOnSurfaceColorError
DesignSystemGlobal.IconOnSurfaceColorSuccess
DesignSystemGlobal.IconOnSurfaceColorWarning
DesignSystemGlobal.IconOnSurfaceColorInformational
```

---

## Transparent Colors

### Transparent Black
```swift
DesignSystemGlobal.TransparentBlackTransparentBlack025  // 2% opacity
DesignSystemGlobal.TransparentBlackTransparentBlack050  // 5% opacity
DesignSystemGlobal.TransparentBlackTransparentBlack100  // 10% opacity
DesignSystemGlobal.TransparentBlackTransparentBlack200  // 15% opacity
DesignSystemGlobal.TransparentBlackTransparentBlack300  // 20% opacity
DesignSystemGlobal.TransparentBlackTransparentBlack400  // 24% opacity
DesignSystemGlobal.TransparentBlackTransparentBlack500  // 32% opacity
DesignSystemGlobal.TransparentBlackTransparentBlack600  // 50% opacity
DesignSystemGlobal.TransparentBlackTransparentBlack700  // 60% opacity
DesignSystemGlobal.TransparentBlackTransparentBlack800  // 70% opacity
DesignSystemGlobal.TransparentBlackTransparentBlack900  // 88% opacity
DesignSystemGlobal.TransparentBlackTransparentBlack950  // 96% opacity
```

### Transparent White
```swift
DesignSystemGlobal.TransparentWhiteTransparentWhite025  // 2% opacity
DesignSystemGlobal.TransparentWhiteTransparentWhite050  // 5% opacity
DesignSystemGlobal.TransparentWhiteTransparentWhite100  // 10% opacity
DesignSystemGlobal.TransparentWhiteTransparentWhite200  // 15% opacity
DesignSystemGlobal.TransparentWhiteTransparentWhite300  // 20% opacity
DesignSystemGlobal.TransparentWhiteTransparentWhite400  // 24% opacity
DesignSystemGlobal.TransparentWhiteTransparentWhite500  // 32% opacity
DesignSystemGlobal.TransparentWhiteTransparentWhite600  // 50% opacity
DesignSystemGlobal.TransparentWhiteTransparentWhite700  // 60% opacity
DesignSystemGlobal.TransparentWhiteTransparentWhite800  // 70% opacity
DesignSystemGlobal.TransparentWhiteTransparentWhite900  // 88% opacity
DesignSystemGlobal.TransparentWhiteTransparentWhite950  // 96% opacity
```

---

## Elevation/Shadow Colors

```swift
DesignSystemGlobal.ElevationLowest   // 5% black
DesignSystemGlobal.ElevationLow      // 10% black
DesignSystemGlobal.ElevationMed      // 12% black
DesignSystemGlobal.ElevationHigh     // 18% black
DesignSystemGlobal.ElevationHighest  // 24% black

// Alternative shadow definitions
DesignSystemGlobal.Shadow50          // 5% black
DesignSystemGlobal.Shadow100         // 10% black
DesignSystemGlobal.Shadow200         // 12% black
DesignSystemGlobal.Shadow300         // 18% black
DesignSystemGlobal.Shadow500         // 24% black
```

---

## Base Neutrals

```swift
DesignSystemGlobal.NeutralsBlack        // Pure black
DesignSystemGlobal.NeutralsWhite        // Pure white
DesignSystemGlobal.NeutralsTransparent  // Fully transparent
```

---

## Common Usage Examples

### Basic Text
```swift
Text("Primary Text")
    .foregroundStyle(DesignSystemGlobal.TextOnSurfaceColorPrimary)

Text("Secondary Text")
    .foregroundStyle(DesignSystemGlobal.TextOnSurfaceColorSecondary)

Text("Brand Text")
    .foregroundStyle(DesignSystemGlobal.BrandBrand300)
```

### Backgrounds
```swift
VStack {
    // content
}
.background(DesignSystemGlobal.BackgroundContainerColorWhite)

ScrollView {
    // content
}
.background(DesignSystemGlobal.GreigeGreige050)
```

### Buttons
```swift
Button("Action") {
    // action
}
.background(DesignSystemGlobal.BackgroundButtonColorBrandFilledDefault)
.foregroundStyle(DesignSystemGlobal.TextButtonColorOrangeFilledDefault)
```

### Borders
```swift
TextField("Input", text: $text)
    .overlay(
        RoundedRectangle(cornerRadius: 8)
            .stroke(DesignSystemGlobal.BorderInputColorDefault, lineWidth: 1)
    )
```

### Feedback States
```swift
// Error message
Text("Error occurred")
    .foregroundStyle(DesignSystemGlobal.TextOnContainerColorError)
    .padding()
    .background(DesignSystemGlobal.BackgroundFeedbackColorErrorAccent1)

// Success message
Text("Success!")
    .foregroundStyle(DesignSystemGlobal.TextOnContainerColorSuccess)
    .padding()
    .background(DesignSystemGlobal.BackgroundFeedbackColorSuccessAccent1)
```

### Glass Effects with Colors
```swift
ZStack {
    LinearGradient(
        colors: [
            DesignSystemGlobal.BrandBrand300.opacity(0.3),
            DesignSystemGlobal.MoonlightMoonlight500.opacity(0.2)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    VStack {
        Text("Liquid Glass")
    }
    .background(.regularMaterial)
}
```

---

## Quick Color Selection Guide

**Use for:**
- **Primary Text**: `TextOnSurfaceColorPrimary` (Greige 900)
- **Background**: `GreigeGreige050`
- **Cards**: `BackgroundContainerColorWhite` or `GreigeGreige200`
- **Brand Accent**: `BrandBrand300` (orange)
- **Links**: `BrandBrand300` or `BrandBrand400`
- **Success**: `BottleGreenBottleGreen500`
- **Error**: `CinnabarCinnabar500`
- **Warning**: `LemonLemon100`
- **Info**: `MoonlightMoonlight500`
- **Borders**: `BorderOnContainerDefault` (Greige 200)
- **Subtle overlays**: `TransparentBlackTransparentBlack050`
