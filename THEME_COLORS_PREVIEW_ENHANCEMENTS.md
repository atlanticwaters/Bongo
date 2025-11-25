# Theme Colors Preview Enhancements

## Overview
The Theme Colors Preview has been enhanced with an interactive Greige shade selector, allowing users to visualize how all colors look on different background surfaces.

## New Features

### 🎨 Interactive Background Selector

#### Key Features:
- **12 Greige Shades**: Choose from all Greige shades (025 to 950)
- **Live Preview**: See all color sections update instantly
- **Visual Grid**: Easy-to-use grid layout with color swatches
- **Active Indicator**: Currently selected shade is highlighted with brand color
- **Smooth Animations**: Elegant transitions when switching backgrounds

#### User Experience:
1. At the top of the view, users see the "Card Background Selector"
2. Current selection is displayed with a small swatch and label
3. Grid of 12 Greige options below
4. Tap any Greige shade to change the background
5. All sections (Brand Colors, Text Colors, etc.) update in real-time

### 📊 Greige Shade Options

```swift
Greige 025 - Lightest (almost white)
Greige 050 - Light mode app background
Greige 100 - Very light
Greige 200 - Light mode card background
Greige 300 - Light neutral
Greige 400 - Medium-light neutral
Greige 500 - Middle neutral
Greige 600 - Medium-dark neutral
Greige 700 - Dark neutral
Greige 800 - Dark mode card background
Greige 900 - Dark mode app background
Greige 950 - Darkest (almost black)
```

### 🔍 What Gets Updated

When you change the background shade, these sections update:
- ✅ Background selector section itself
- ✅ Brand Colors section
- ✅ Background Colors section
- ✅ Text Colors section
- ✅ Icon Colors section
- ✅ Usage Examples section

Each section maintains its nested card structure (light backgrounds inside) while the outer container uses the selected Greige shade.

## Visual Design

### Selector Interface
```
┌─────────────────────────────────────┐
│ Card Background Selector            │
│ Choose a Greige shade...            │
│                                     │
│ Current Background: [■] Greige 050  │
│                                     │
│ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐     │
│ │025│ │050│ │100│ │200│ │300│ ... │
│ └───┘ └───┘ └───┘ └───┘ └───┘     │
└─────────────────────────────────────┘
```

### Color Section Layout
```
┌────────────────────────────────────────┐
│ Brand Colors [Selected Greige BG]      │
│ Primary accent colors...               │
│                                        │
│  ┌──────────────────────────────────┐ │
│  │ Brand Primary [Light BG]         │ │
│  │ [■] #F96302                      │ │
│  └──────────────────────────────────┘ │
│                                        │
│  ┌──────────────────────────────────┐ │
│  │ Brand Dark [Light BG]            │ │
│  │ [■] #E95C02                      │ │
│  └──────────────────────────────────┘ │
└────────────────────────────────────────┘
```

## Implementation Details

### New Data Model
```swift
enum GreigeShade: String, CaseIterable, Hashable {
    case greige025, greige050, greige100, ...
    
    var color: Color // Returns actual Color from DesignSystemGlobal
    var name: String // "Greige 025"
    var shortName: String // "025"
}
```

### State Management
```swift
@State private var selectedGreigeShade: GreigeShade = .greige050
```

Default is Greige 050 (light mode app background), providing a familiar starting point.

### Adaptive Styling
All sections now use:
```swift
.background(selectedGreigeShade.color)
```

Inner cards maintain their own backgrounds:
```swift
.background(AppTheme.appBackground(for: colorScheme))
```

This creates a layered effect showing the contrast between the selected Greige and the standard backgrounds.

## Usage Tips

### For Designers
- **Test Contrast**: Quickly verify how brand colors look on different backgrounds
- **Light/Dark Validation**: Switch between light shades (025-300) and dark shades (700-950)
- **Readability Check**: Ensure text hierarchy is visible on all backgrounds
- **Surface Depth**: Visualize the layering of surfaces

### For Developers
- **Color Reference**: See exact hex values and tokens for each color
- **Usage Guidelines**: Understand where each color should be used
- **Integration Examples**: View practical implementations
- **Contrast Testing**: Verify WCAG compliance across backgrounds

### Testing Scenarios

1. **Light Backgrounds (025-300)**
   - Verify dark text is readable
   - Check brand color visibility
   - Ensure icons have sufficient contrast

2. **Middle Neutrals (400-600)**
   - Test with both light and dark text
   - Verify versatility of the palette
   - Check accessibility

3. **Dark Backgrounds (700-950)**
   - Verify light text is readable
   - Check inverse color usage
   - Ensure proper dark mode experience

## Benefits

### Enhanced Understanding
- **Real-time Visualization**: See immediate impact of background changes
- **Comprehensive Testing**: Test all color combinations quickly
- **Design Validation**: Verify design system decisions

### Improved Workflow
- **Faster Iteration**: No need to modify code to test backgrounds
- **Better Documentation**: Interactive reference for the team
- **Accessibility Testing**: Easy contrast checking

### Design System Confidence
- **Proven Combinations**: See which colors work best together
- **Consistent Application**: Understand proper usage patterns
- **Quality Assurance**: Catch contrast issues early

## Accessibility Considerations

The selector ensures:
- ✅ Clear visual indication of selected shade
- ✅ Sufficient contrast in all text labels
- ✅ Large touch targets (44pt minimum)
- ✅ Semantic color naming
- ✅ Descriptive labels for screen readers

## Technical Notes

### Performance
- Smooth animations using `withAnimation(.easeInOut(duration: 0.2))`
- Efficient state updates with `@State`
- No lag when switching between shades

### Compatibility
- Works in light and dark mode
- Adapts to all screen sizes with `.adaptive` grid
- Compatible with VoiceOver and accessibility features

### Future Enhancements
Consider adding:
- [ ] Color contrast ratio calculator
- [ ] Export selected combinations
- [ ] Favorite backgrounds feature
- [ ] Comparison mode (side-by-side)
- [ ] WCAG compliance indicators

## Example Use Cases

### Use Case 1: Designing a New Card
1. Open Theme Colors Preview
2. Select your intended background shade
3. Review how all colors look on that surface
4. Verify text hierarchy is clear
5. Check icon visibility

### Use Case 2: Validating Dark Mode
1. Switch system to dark mode
2. Select dark Greige shades (700-950)
3. Verify all colors adapt properly
4. Check inverse text colors
5. Validate overall readability

### Use Case 3: Documenting Color Usage
1. Select standard app background (050)
2. Screenshot the view
3. Select card background (200)
4. Screenshot again
5. Use in design documentation

## Summary

The interactive Greige selector transforms the Theme Colors Preview from a static reference into a dynamic testing tool. Designers and developers can now:

- ✅ Test color combinations instantly
- ✅ Validate contrast and readability
- ✅ Understand the Greige palette usage
- ✅ Make informed design decisions
- ✅ Ensure accessibility compliance

This enhancement makes the design system more practical and actionable for the entire team! 🎨
