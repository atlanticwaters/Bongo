# Theme System Usage Audit

## Current Status

This document tracks which views in the app are using the ThemeExtensions properly and which need updates.

## Theme System Components

### AppTheme (defined in ThemeExtensions.swift)

**Colors:**
- `AppTheme.brandColor` - Primary brand color (orange)
- `AppTheme.brandColorDark` - Darker brand for pressed states
- `AppTheme.appBackground` - Main app background (Griege 050)
- `AppTheme.cardBackground` - Card backgrounds (Greige 200)
- `AppTheme.textPrimary` - Primary text color
- `AppTheme.textSecondary` - Secondary text color
- `AppTheme.textTertiary` - Tertiary text color
- `AppTheme.iconAccent` - Accent icon color
- `AppTheme.iconPrimary` - Primary icon color
- `AppTheme.borderDefault` - Border color

**Spacing:**
- `AppTheme.spacingCompact` - 12pt
- `AppTheme.spacingStandard` - 16pt
- `AppTheme.spacingLoose` - 24pt

**Corner Radius:**
- `AppTheme.cornerRadiusStandard` - 8pt
- `AppTheme.cornerRadiusLarge` - 12pt

### View Modifiers

- `.themedAppBackground()` - Applies main app background
- `.themedCard(cornerRadius:)` - Applies card styling
- `.themedContainer(padding:cornerRadius:)` - Applies container styling with padding
- `.brandTinted()` - Applies brand color tint to icons
- `.accentIconStyle()` - Applies accent icon color

### Color Extensions

Direct color access:
- `Color.brandPrimary`
- `Color.brandDark`
- `Color.appBackground`
- `Color.cardBackground`
- `Color.textPrimary`
- `Color.textSecondary`
- `Color.textTertiary`
- `Color.borderDefault`

## View-by-View Audit

### ✅ ContentView.swift
**Status:** Uses theme system properly (after target membership fix)

**Usage:**
- `.tint(AppTheme.brandColor)` - Tab bar tint
- `.themedAppBackground()` - Main background

**Action Required:** Fix target membership for dependencies

---

### ✅ DesignSystemDemoView.swift
**Status:** Excellent theme usage - demonstrates all tokens

**Usage:**
- All design tokens demonstrated
- All view modifiers used
- Reference implementation for other views

**Action Required:** None - use as reference

---

### ✅ DesignSystemShowcaseView.swift (ThemeShowcaseView.swift)
**Status:** Demonstrates theme system

**Action Required:** Verify target membership

---

### ⚠️ GlassComponentsView.swift
**Status:** NOT using theme system

**Current Issues:**
- Hardcoded colors (`.blue`, `.purple`, `.white`)
- No use of AppTheme
- No themed backgrounds
- No use of design tokens

**Recommended Changes:**
```swift
// Replace:
.foregroundColor(.white)
// With:
.foregroundStyle(Color.textPrimary)

// Add at NavigationStack level:
.themedAppBackground()

// Use brand colors instead of hardcoded:
Color.brandPrimary  // instead of .blue
```

**Action Required:** Refactor to use theme tokens

---

### ⚠️ AdaptiveUIView.swift
**Status:** NOT using theme system

**Current Issues:**
- Hardcoded colors (`.gray`, `.gray.opacity(0.05)`)
- No use of AppTheme
- No themed backgrounds

**Recommended Changes:**
```swift
// Replace:
.foregroundColor(.gray)
// With:
.foregroundStyle(Color.textSecondary)

// Replace:
.background(.gray.opacity(0.05))
// With:
.background(Color.appBackground)

// Add at NavigationStack level:
.themedAppBackground()

// Use design system spacing:
.padding(AppTheme.spacingStandard)
```

**Action Required:** Refactor to use theme tokens

---

### ⚠️ DynamicBlurView.swift
**Status:** NOT using theme system (needs verification)

**Expected Issues:**
- Likely using hardcoded colors
- May not use themed backgrounds

**Action Required:** Audit and refactor

---

### ⚠️ InteractiveGlassView.swift
**Status:** NOT using theme system (needs verification)

**Expected Issues:**
- Likely using hardcoded colors
- Interactive elements may not use brand colors

**Recommended Changes:**
```swift
// Button should use:
.background(AppTheme.brandColor)
.cornerRadius(AppTheme.cornerRadiusStandard)

// Pressed state should use:
.background(AppTheme.brandColorDark)
```

**Action Required:** Audit and refactor

---

### ⚠️ ColorAndGradientView.swift
**Status:** Partially using theme system

**Current Issues:**
- Demonstrates colors but may not use design tokens
- Hardcoded colors (`.blue`, `.gray`, `.green`, `.red`, `.yellow`)

**Recommended Changes:**
- If demonstrating system colors, that's fine
- If demonstrating app colors, use design tokens
- Add `.themedAppBackground()` to NavigationStack
- Use `Color.textPrimary` for text instead of default

**Action Required:** Verify purpose and update accordingly

---

## Migration Priority

### Priority 1: Critical (Required for theme consistency)
1. **ContentView.swift** - Fix target membership issues
2. **GlassComponentsView.swift** - Main demo view, should showcase theme
3. **AdaptiveUIView.swift** - Should demonstrate adaptive theme usage

### Priority 2: Important (Improves consistency)
4. **InteractiveGlassView.swift** - Interactive elements should use brand colors
5. **DynamicBlurView.swift** - Should use themed backgrounds

### Priority 3: Optional (Depends on purpose)
6. **ColorAndGradientView.swift** - Verify if intentionally demonstrating system colors

## Refactoring Checklist

For each view, verify:

- [ ] Imports SwiftUI (should be only import needed)
- [ ] Uses `.themedAppBackground()` on root container
- [ ] Uses `Color.textPrimary`, `Color.textSecondary`, `Color.textTertiary` for text
- [ ] Uses `Color.brandPrimary` for accent elements
- [ ] Uses `AppTheme.cornerRadiusStandard` or `.cornerRadiusLarge` for corners
- [ ] Uses `AppTheme.spacingStandard`, `.spacingCompact`, or `.spacingLoose` for spacing
- [ ] Uses `.themedCard()` or `.themedContainer()` for cards/containers
- [ ] Uses `.brandTinted()` for brand-colored icons
- [ ] No hardcoded hex colors
- [ ] No hardcoded spacing values (unless pixel-perfect is required)

## Testing After Migration

After migrating each view:

1. Build and run the app
2. Navigate to the view's tab
3. Verify colors match the design system
4. Verify spacing is consistent
5. Verify corners are rounded properly
6. Check both light and dark mode (if supported)

## Benefits of Full Theme Adoption

Once all views use the theme system:

1. **Consistency** - All views use the same colors, spacing, and styling
2. **Maintainability** - Change a color once, updates everywhere
3. **Design-to-Code Pipeline** - Designers can update tokens, regenerate files, app updates automatically
4. **Dark Mode Support** - Easy to add by updating tokens
5. **Accessibility** - Centralized place to adjust contrast ratios
6. **Professionalism** - Polished, cohesive user experience

## Next Steps

1. Fix target membership issues in ContentView.swift (see TARGET_MEMBERSHIP_FIX.md)
2. Refactor GlassComponentsView.swift to use theme tokens
3. Refactor AdaptiveUIView.swift to use theme tokens
4. Audit remaining views
5. Create example refactor PR for one view to establish pattern
6. Update this document as views are migrated

