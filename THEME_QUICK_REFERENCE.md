# Theme Quick Reference Card

## 🎨 Quick Color Access

```swift
// Brand Colors
AppTheme.brandColor          // Orange #F96302
Color.brandPrimary           // Same as above

// Backgrounds
AppTheme.appBackground       // Griege 050 #F8F5F2
AppTheme.cardBackground      // Griege 200 #BAB7B4
Color.cardBackground         // Same as above

// Text
Color.textPrimary           // Dark text
Color.textSecondary         // Medium gray text
Color.textTertiary          // Light gray text
```

## 🔧 Quick Modifiers

```swift
// Apply card background (Griege 200)
.themedCard()

// Apply card background WITH padding
.themedContainer()

// Apply app background (Griege 050)
.themedAppBackground()

// Apply brand color to icon
.brandTinted()
```

## 📋 Common Patterns

### Pattern 1: Create a Card
```swift
VStack {
    Text("Content")
}
.themedContainer()
```

### Pattern 2: Brand Icon
```swift
Image(systemName: "star.fill")
    .brandTinted()
```

### Pattern 3: Full Screen View
```swift
NavigationStack {
    ScrollView {
        // content
    }
}
.themedAppBackground()
.tint(AppTheme.brandColor)
```

### Pattern 4: Button with Brand Color
```swift
Button("Action") {
    // action
}
.buttonStyle(.borderedProminent)
// Automatically uses brand color due to .tint()
```

## 🎯 Before → After

### Cards
```swift
// ❌ Before
.background(.gray.opacity(0.05))
.cornerRadius(12)

// ✅ After
.themedCard()
```

### Icons
```swift
// ❌ Before
.foregroundColor(.blue)

// ✅ After
.brandTinted()
```

### Backgrounds
```swift
// ❌ Before
.background(Color(red: 0.973, green: 0.961, blue: 0.949))

// ✅ After
.themedAppBackground()
```

## 📦 Where Things Live

| What | File |
|------|------|
| Theme setup | `ThemeExtensions.swift` |
| Full guide | `THEME_IMPLEMENTATION_GUIDE.md` |
| Change summary | `THEME_CHANGES_SUMMARY.md` |
| Examples | `ThemeExampleView.swift` |
| Color preview | `ThemeColorsPreview.swift` |

## ⚡ Most Used Code Snippets

### Standard Card
```swift
VStack(spacing: 12) {
    Text("Title")
        .font(.headline)
        .foregroundStyle(Color.textPrimary)
    
    Text("Description")
        .font(.body)
        .foregroundStyle(Color.textSecondary)
}
.themedContainer()
```

### Icon Row
```swift
HStack {
    Image(systemName: "star.fill")
        .brandTinted()
    Text("Featured")
        .foregroundStyle(Color.textPrimary)
}
```

### Full View Template
```swift
struct MyView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Content cards here
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

## 🔍 Visual Checklist

When you run the app, you should see:

- ✅ Orange tab bar icons (not blue)
- ✅ Very light beige main background
- ✅ Medium beige card backgrounds
- ✅ Orange accent color on buttons and links
- ✅ Orange icons where accent is used

## 💡 Pro Tips

1. **Always import SwiftUI** - theme extensions need it
2. **Apply .tint() early** - put it on NavigationStack or TabView
3. **Use .themedContainer() for padding** - includes padding automatically
4. **Chain modifiers** - `.themedCard().padding()` works great
5. **Semantic colors are better** - use `.textPrimary` not hardcoded colors

## 🚨 Common Mistakes

### ❌ Don't Do This
```swift
.background(Color.gray)  // Hardcoded
.foregroundColor(.blue)  // Not branded
.padding().background(Color.cardBackground).cornerRadius(12)  // Too verbose
```

### ✅ Do This Instead
```swift
.background(Color.cardBackground)  // Or use modifier
.brandTinted()  // Branded
.themedContainer()  // Simple
```

## 📱 Test Your Changes

Run these checks:
1. Open app → See orange tabs
2. Scroll any view → See light beige background
3. Look at cards → See medium beige backgrounds
4. Tap buttons → See orange accent color
5. Check icons → See orange on featured icons

## 🎓 Learn More

- Read `THEME_IMPLEMENTATION_GUIDE.md` for complete documentation
- Check `ThemeExampleView.swift` for live examples
- View `ThemeColorsPreview.swift` to see all colors
- Refer to `DesignSystemGlobal.swift` for all available tokens

---

**Quick Help:** If colors don't look right, check that you're using the theme modifiers and color extensions. All theme code is in `ThemeExtensions.swift`.
