# Quick Reference Guide

## ✅ Completed Tasks

### 1. Theme Selector ✅
**Location:** Design tab (6th tab)
- Segmented picker at top switches between 4 themes
- All colors update dynamically when theme changes
- Themes: Global, Light Medium, Dark Medium, Dark Large

**To Test:**
1. Open app
2. Go to Design tab
3. Tap different theme options
4. Watch all colors change

---

### 2. Greige100 Background ✅
**Location:** Entire app
- All tabs now have consistent Greige100 background
- Background defined in `ContentView.swift`
- Can also use `.appBackground()` modifier

**To Test:**
1. Navigate through all 6 tabs
2. Background should be light neutral color
3. Should be consistent across all views

---

### 3. Custom Fonts ✅
**Fonts:** THD LgVar Beta (Display), THD SmVar Beta (Informational)
**Location:** Design tab headlines and samples

**Setup Required:**
1. Find font files in `_docs` folder
2. Add to Xcode project (drag & drop)
3. Update Info.plist with font file names
4. See `FONT_SETUP_INSTRUCTIONS.md` for details

**To Test (after setup):**
1. Add fonts to project
2. Run app
3. Check Design tab
4. Headings should use custom fonts
5. Typography samples should show custom fonts

---

## Using Custom Fonts in Your Code

### Option 1: Predefined Styles
```swift
Text("Hello World")
    .font(.thdH1)        // Display font, H1 size
    .font(.thdBodyMd)    // Informational font, Body Medium
    .font(.thdCaption)   // Informational font, Caption
```

### Option 2: Custom Size
```swift
Text("Custom Size")
    .font(.thdDisplay(size: 24))
    .font(.thdInformational(size: 16))
```

### Option 3: View Modifier
```swift
Text("View Modifier")
    .thdFont(.h2)
    .thdFont(.bodyLg)
```

---

## Available Font Styles

### Display Family (Headers)
- `.thdHero1` through `.thdHero5` (64pt - 36pt)
- `.thdH1` through `.thdH6` (32pt - 16pt)

### Informational Family (Body)
- `.thdBodyXL` (20pt)
- `.thdBodyLg` (18pt)
- `.thdBodyMd` (16pt)
- `.thdBodySm` (14pt)
- `.thdBodyXs` (12pt)
- `.thdCaption` (11pt)

---

## Using Design System Colors

### Example
```swift
.background(DesignSystemGlobal.GreigeGreige100)
.foregroundColor(DesignSystemGlobal.BrandBrand400)
.shadow(color: DesignSystemGlobal.ElevationLow, radius: 8)
```

### Switching Themes
```swift
// In your view
@State private var selectedTheme: ThemeSelection = .global

// Then use
selectedTheme.brandColors[0]  // First brand color
selectedTheme.accentColors[1] // Green accent
selectedTheme.greigeColors[5] // Greige 500
```

---

## File Structure

### New Files
- `CustomFonts.swift` - Font extensions
- `AppBackground.swift` - Background modifier
- `FONT_SETUP_INSTRUCTIONS.md` - Font setup guide
- `IMPLEMENTATION_SUMMARY.md` - Detailed changes
- `QUICK_REFERENCE.md` - This file

### Modified Files
- `ContentView.swift` - Added background
- `ThemeShowcaseView 2.swift` - Theme switching & fonts

---

## Common Issues & Solutions

### Fonts Not Showing
1. ✓ Check fonts are in project bundle
2. ✓ Verify Info.plist entries match file names
3. ✓ Clean build folder (Cmd+Shift+K)
4. ✓ Rebuild project

### Colors Not Switching
1. ✓ Check you're using `selectedTheme` properties
2. ✓ Verify computed properties return arrays
3. ✓ Test with different themes in picker

### Background Not Showing
1. ✓ Verify GreigeGreige100 color exists
2. ✓ Check `.ignoresSafeArea()` is applied
3. ✓ Test on different devices/simulators

---

## Next Steps

1. **Add Font Files**
   - Locate in `_docs` folder
   - Add to project
   - Update Info.plist

2. **Test Everything**
   - Run app
   - Test all 6 tabs
   - Switch themes
   - Verify fonts (after setup)
   - Check background consistency

3. **Expand Custom Fonts** (Optional)
   - Apply to other tabs
   - Update GlassComponentsView
   - Update ColorAndGradientView
   - etc.

---

## Design Tokens Quick Access

### Spacing
```swift
DesignSystemGlobal.Spacing1  // 4pt
DesignSystemGlobal.Spacing2  // 8pt
DesignSystemGlobal.Spacing4  // 16pt
DesignSystemGlobal.Spacing6  // 24pt
```

### Border Radius
```swift
DesignSystemGlobal.BorderRadiusXs   // 1pt
DesignSystemGlobal.BorderRadiusLg   // 6pt
DesignSystemGlobal.BorderRadius3xl  // 16pt
```

### Shadows
```swift
DesignSystemGlobal.ElevationLowest  // Shadow color
DesignSystemGlobal.ElevationBlurRadiusBlur1  // Blur radius
```

---

## Testing Checklist

- [ ] App builds successfully
- [ ] All 6 tabs load without errors
- [ ] Greige100 background visible on all tabs
- [ ] Design tab loads properly
- [ ] Theme picker switches between 4 options
- [ ] Colors update when theme changes
- [ ] Brand colors show correctly
- [ ] Accent colors show correctly
- [ ] Greige neutrals show correctly
- [ ] Button states show correctly
- [ ] Background gradient changes with theme
- [ ] (After font setup) Custom fonts load
- [ ] (After font setup) Typography samples show custom fonts
- [ ] (After font setup) Headings use custom fonts

---

## Support & Documentation

- `FONT_SETUP_INSTRUCTIONS.md` - Complete font setup
- `IMPLEMENTATION_SUMMARY.md` - Detailed technical changes
- Design system files contain all tokens
- All custom fonts defined in `CustomFonts.swift`

---

Last Updated: November 24, 2025
Version: 1.0
