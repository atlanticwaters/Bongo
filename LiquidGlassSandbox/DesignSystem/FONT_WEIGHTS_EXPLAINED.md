# Understanding Font Weights in Your Design System

## Current State

Your `DesignSystemGlobal.swift` defines font weights, but they're **not currently being applied** to custom fonts.

### Defined Font Weights

```swift
// Body text weights (as Strings)
public static let FontFontWeightBodyBold = "800"
public static let FontFontWeightBodyLight = "Light"
public static let FontFontWeightBodyMedium = "Medium"
public static let FontFontWeightBodyRegular = "Regular"
public static let FontFontWeightBodySemibold = "SemiBold"

// Heading weights (as Strings)
public static let FontFontWeightHeadingBold = "Bold"
public static let FontFontWeightHeadingExtrabold = "ExtraBold"
public static let FontFontWeightHeadingSemibold = "SemiBold"

// Condensed weights (as CGFloat - possibly incorrect)
public static let FontFontWeightCondensedBold = CGFloat(48)
public static let FontFontWeightCondensedRegular = CGFloat(56)
public static let FontFontWeightCondensedSemibold = CGFloat(37)
```

## The Problem

Custom fonts work differently than system fonts:

### System Fonts (Current Behavior)
```swift
.font(.system(size: 24, weight: .bold))  // ✅ Weight works
```

### Custom Fonts (Current Behavior)
```swift
.font(.custom("THD LgVar Beta", size: 24))  // ❌ Always default weight
```

## How Custom Font Weights Work

There are **three ways** to handle weights with custom fonts:

### Method 1: Separate Font Files (Most Common)

If you have multiple weight files:
```
THD-LgVar-Beta-Light.ttf
THD-LgVar-Beta-Regular.ttf
THD-LgVar-Beta-Medium.ttf
THD-LgVar-Beta-Semibold.ttf
THD-LgVar-Beta-Bold.ttf
THD-LgVar-Beta-Extrabold.ttf
```

Each weight is a **different font file** with its own PostScript name:
```
"THD LgVar Beta Light"
"THD LgVar Beta Regular"
"THD LgVar Beta Medium"
"THD LgVar Beta Semibold"
"THD LgVar Beta Bold"
"THD LgVar Beta Extrabold"
```

### Method 2: Variable Fonts (Modern)

If "THD LgVar Beta" is a true **variable font**, you can use:

```swift
// Variable fonts support dynamic weight
let font = UIFont(name: "THD LgVar Beta", size: 24)
let attributes: [UIFontDescriptor.AttributeName: Any] = [
    .init("NSCTFontVariationAttribute"): [
        "wght": 700.0  // 400 = Regular, 700 = Bold
    ]
]
```

The **"Var" in the name suggests this might be a variable font!**

### Method 3: Font Family with Traits (iOS Approach)

iOS groups related fonts into families. You can access different weights:

```swift
// Get all variations in the family
UIFont.fontNames(forFamilyName: "THD LgVar Beta")
// Might return:
// ["THD LgVar Beta", "THD LgVar Beta Bold", "THD LgVar Beta Light", ...]
```

## What You Need To Do

### Step 1: Identify Your Font Structure

Run the `InfoPlistHelperView` or add this code:

```swift
// Check what fonts you actually have
print("Font Families:")
for family in UIFont.familyNames.sorted() {
    if family.contains("THD") {
        print("Family: \(family)")
        for name in UIFont.fontNames(forFamilyName: family) {
            print("  - \(name)")
        }
    }
}
```

This will tell you:
- **Option A:** Multiple files = Separate font files for each weight
- **Option B:** One file with traits = Variable font or family grouping
- **Option C:** Just one file = Single weight only

### Step 2: Check Resources Folder

Look in your Resources folder:
- **Multiple files?** → Use Method 1 (separate files)
- **One or two files?** → Check if variable font (Method 2)

### Step 3: Test Variable Font Support

```swift
let font = UIFont(name: "THD LgVar Beta", size: 24)
let traits = font?.fontDescriptor.fontAttributes[.traits] as? [String: Any]
print("Font traits: \(traits ?? [:])")
```

## Expected Font File Names

Based on your design system, you should have these weight files:

### Display Font (THD LgVar Beta)
- `THD-LgVar-Beta-Semibold.ttf` (Headings)
- `THD-LgVar-Beta-Bold.ttf` (Headings)
- `THD-LgVar-Beta-Extrabold.ttf` (Headings)

### Informational Font (THD SmVar Beta)
- `THD-SmVar-Beta-Light.ttf` (Body)
- `THD-SmVar-Beta-Regular.ttf` (Body)
- `THD-SmVar-Beta-Medium.ttf` (Body)
- `THD-SmVar-Beta-Semibold.ttf` (Body)
- `THD-SmVar-Beta-Bold.ttf` (Body)

## Variable Font Weights

If these are variable fonts, weights map like this:

| Design Token | Numeric Weight | CSS Value |
|--------------|----------------|-----------|
| Light | 300 | 300 |
| Regular | 400 | 400 |
| Medium | 500 | 500 |
| Semibold | 600 | 600 |
| Bold | 700 | 700 |
| Extrabold | 800 | 800 |

## Next Steps

1. **Check Resources folder** - How many THD font files do you have?
2. **Run font detection code** - What PostScript names exist?
3. **Choose implementation** - Based on what you find:
   - Multiple files → I'll update `CustomFonts.swift` to use specific weight names
   - Variable font → I'll add variable font support
   - Single weight → Document this limitation

Once you tell me what font files you have, I can update the code accordingly!

## Questions to Answer

1. **How many THD font files are in your Resources folder?**
   - [ ] 2 files (one Display, one Informational)
   - [ ] More than 2 files (multiple weights)
   - [ ] Not sure

2. **What are the exact file names?**
   - Write them here: _________________________________

3. **When you run the font family check, what does it show?**
   - Write the output here: _________________________________

With this information, I can provide the exact solution for proper weight support!
