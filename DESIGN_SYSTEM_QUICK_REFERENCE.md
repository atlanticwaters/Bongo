# Design System Quick Reference

## 🎯 For Developers: How to Use Design Tokens

### Quick Access Patterns

```swift
// ✅ CORRECT - Use semantic names from AppTheme
.background(AppTheme.brandColor)
.padding(AppTheme.spacingStandard)
.cornerRadius(AppTheme.cornerRadiusLarge)

// ✅ ALSO CORRECT - Use Color extensions
.foregroundStyle(Color.brandPrimary)
.background(Color.cardBackground)

// ✅ BEST - Use view modifiers
.themedCard()
.themedContainer()
.brandTinted()

// ❌ WRONG - Don't access design system files directly in views
.background(DesignSystemGlobal.BrandBrand300)  // Don't do this!

// ❌ WRONG - Don't hardcode values
.background(Color(red: 0.976, green: 0.388, blue: 0.008))  // Don't do this!
```

## 🎨 Available Tokens

### Colors

```swift
// Brand
AppTheme.brandColor           // Main brand orange
AppTheme.brandColorDark       // Darker brand orange
Color.brandPrimary            // Same as brandColor
Color.brandDark               // Same as brandColorDark

// Backgrounds
AppTheme.appBackground        // Griege 050 - main background
AppTheme.cardBackground       // Griege 200 - cards
Color.appBackground           // Same as above
Color.cardBackground          // Same as above

// Text
AppTheme.textPrimary          // Dark text
AppTheme.textSecondary        // Medium gray text
AppTheme.textTertiary         // Light gray text
Color.textPrimary             // Same as above
Color.textSecondary           // Same as above
Color.textTertiary            // Same as above

// Icons
AppTheme.iconAccent           // Brand orange for icons
AppTheme.iconPrimary          // Dark for standard icons
```

### Spacing

```swift
AppTheme.spacingCompact       // 12pt
AppTheme.spacingStandard      // 16pt
AppTheme.spacingLoose         // 24pt
```

### Border Radius

```swift
AppTheme.cornerRadiusStandard // 8pt
AppTheme.cornerRadiusLarge    // 12pt
```

## 🔧 View Modifiers

### Card Styling

```swift
// Standard card with Griege 200 background
VStack {
    Text("Content")
}
.themedCard()

// Card with custom corner radius
VStack {
    Text("Content")
}
.themedCard(cornerRadius: 16)
```

### Container Styling

```swift
// Container with padding + background
VStack {
    Text("Content")
}
.themedContainer()

// Container with custom padding and corner radius
VStack {
    Text("Content")
}
.themedContainer(padding: 20, cornerRadius: 16)
```

### Background Styling

```swift
// Main app background (Griege 050)
ScrollView {
    // content
}
.themedAppBackground()
```

### Icon Styling

```swift
// Brand-colored icon
Image(systemName: "star.fill")
    .brandTinted()

// Accent icon
Image(systemName: "heart.fill")
    .accentIconStyle()
```

## 📋 Common Patterns

### Pattern 1: Feature Card

```swift
VStack(alignment: .leading, spacing: 12) {
    HStack {
        Image(systemName: "star.fill")
            .brandTinted()
        Text("Feature Title")
            .font(.headline)
            .foregroundStyle(Color.textPrimary)
    }
    
    Text("Feature description here")
        .font(.body)
        .foregroundStyle(Color.textSecondary)
}
.themedContainer()
```

### Pattern 2: Section Header

```swift
VStack(alignment: .leading, spacing: 8) {
    Text("Section Title")
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(Color.textPrimary)
    
    Text("Section subtitle")
        .font(.caption)
        .foregroundStyle(Color.textSecondary)
}
.padding()
```

### Pattern 3: Button

```swift
Button {
    // action
} label: {
    HStack {
        Image(systemName: "checkmark")
        Text("Confirm")
    }
    .font(.headline)
    .foregroundStyle(.white)
    .padding(AppTheme.spacingStandard)
    .frame(maxWidth: .infinity)
    .background(AppTheme.brandColor)
    .cornerRadius(AppTheme.cornerRadiusStandard)
}
.buttonStyle(.plain)
```

### Pattern 4: List Row

```swift
HStack(spacing: AppTheme.spacingStandard) {
    Image(systemName: "doc.fill")
        .brandTinted()
    
    VStack(alignment: .leading, spacing: 4) {
        Text("Item Title")
            .font(.headline)
            .foregroundStyle(Color.textPrimary)
        
        Text("Item subtitle")
            .font(.caption)
            .foregroundStyle(Color.textSecondary)
    }
    
    Spacer()
}
.themedContainer()
```

### Pattern 5: Full View

```swift
struct MyView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppTheme.spacingLoose) {
                    // Content sections
                }
                .padding()
            }
            .navigationTitle("My View")
            .themedAppBackground()
        }
        .tint(AppTheme.brandColor)
    }
}
```

## 🎯 Token Sources

All tokens come from:
- `DesignSystemGlobal.swift` (primary source)
- `DesignSystemLightMedium.swift` (light mode variant)
- `DesignSystemDarkMedium.swift` (dark mode variant)
- Other design system files in Design System folder

Accessed via:
- `AppTheme` struct in `ThemeExtensions.swift`
- View modifiers (`.themedCard()`, etc.)
- Color extensions (`Color.brandPrimary`, etc.)

## 🔍 Verification

To verify tokens are working:
1. Open the "Tokens" tab in the app
2. Check the "Color Tokens" section
3. Verify values match design system files
4. Test "Live Component Demo" section

## 🚨 Rules

1. **Never hardcode colors** - always use tokens
2. **Never access DesignSystemGlobal directly in views** - use AppTheme
3. **Prefer view modifiers** - use `.themedCard()` over manual styling
4. **Use semantic names** - `Color.brandPrimary` not `BrandBrand300`
5. **Document token usage** - add comments showing which token is used

## 📚 Documentation

Full documentation:
- `DESIGN_SYSTEM_INTEGRATION.md` - Complete integration guide
- `THEME_IMPLEMENTATION_GUIDE.md` - Theme usage guide
- `ThemeExtensions.swift` - Implementation with inline docs
- `DesignSystemDemoView.swift` - Live demonstration

## 💡 Tips

1. **Import SwiftUI** - Required for all theme APIs
2. **Apply .tint() early** - On NavigationStack or TabView
3. **Use spacing tokens** - Don't hardcode padding values
4. **Test in light and dark mode** - Tokens adapt automatically
5. **Check the demo view** - See tokens in action

## ⚡ Quick Commands

```swift
// Add to any view for debugging
.onAppear {
    print("Brand Color: \(AppTheme.brandColor)")
    print("Card Background: \(AppTheme.cardBackground)")
}

// Inspect token at runtime
if let info = DesignSystemTokenInspector.tokenInfo(for: "brandColor") {
    print("Token info: \(info)")
}
```

---

**Remember:** The design system is the source of truth. When tokens change, regenerate the design system files and the entire app updates automatically!
