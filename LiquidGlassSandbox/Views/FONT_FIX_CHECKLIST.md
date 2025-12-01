# Font Loading Fix - Quick Checklist

## ✅ What's Been Fixed

The code has been updated with:
- Automatic font registration using `CTFontManagerRegisterFontsForURL`
- Multiple font name variations tried automatically
- Fallback to system fonts if custom fonts aren't found
- Debug logging to help identify issues
- Font availability checking

## 📋 Steps You Need To Do

### 1. Find Your Font Files
- [ ] Locate the THD Beta font files (`.ttf` or `.otf` files)
- [ ] Note the exact file names (including extensions)
- [ ] Common names: `THD-LgVar-Beta.ttf`, `THD-SmVar-Beta.ttf`

### 2. Add Fonts to Xcode Project
- [ ] Drag font files into Xcode project
- [ ] Check "Copy items if needed"
- [ ] Select your app target
- [ ] Verify fonts appear in Project Navigator

### 3. Verify Target Membership
- [ ] Select a font file in Xcode
- [ ] Open File Inspector (⌘⌥1)
- [ ] Confirm your app target is checked under "Target Membership"

### 4. Check Build Phases
- [ ] Select your app target in Xcode
- [ ] Go to Build Phases tab
- [ ] Expand "Copy Bundle Resources"
- [ ] Verify font files are listed there
- [ ] If not, click + to add them

### 5. Update Info.plist
- [ ] Open Info.plist
- [ ] Add new key: `Fonts provided by application` (type: Array)
  - Or use raw key: `UIAppFonts`
- [ ] Add string items with exact font file names:
  - Example: `THD-LgVar-Beta.ttf`
  - Example: `THD-SmVar-Beta.ttf`

**XML Example:**
```xml
<key>UIAppFonts</key>
<array>
    <string>YOUR-ACTUAL-FILENAME-1.ttf</string>
    <string>YOUR-ACTUAL-FILENAME-2.ttf</string>
</array>
```

### 6. Initialize Font Registration
- [ ] Find your `@main` app struct (usually named like `YourNameApp.swift`)
- [ ] Add font registration in `init()`:

```swift
@main
struct YourApp: App {
    init() {
        CustomFontRegistration.registerFonts()
        
        if CustomFontRegistration.areCustomFontsAvailable() {
            print("✅ Fonts loaded!")
        } else {
            print("⚠️ Using fallback fonts")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### 7. Test Font Loading
- [ ] Run your app
- [ ] Check the Xcode console
- [ ] Look for messages like:
  - ✅ `"Successfully registered font: ..."`
  - 📝 `"All available fonts in the system:"`
- [ ] Add `FontTestView()` to your app to visually test fonts

### 8. Verify in UI
- [ ] Navigate to a screen using custom fonts
- [ ] Text should appear in THD Beta fonts
- [ ] If using fallback, text appears in San Francisco font

## 🔍 Quick Test

Add this to your ContentView or any view to test:

```swift
VStack {
    Text("Display Font Test")
        .font(.thdDisplay(size: 32))
    
    Text("Informational Font Test")
        .font(.thdInformational(size: 20))
}
```

## 🐛 If Fonts Still Don't Load

### Check Console Output
Look for these messages and act accordingly:

| Message | What to Do |
|---------|-----------|
| "Successfully registered font" | ✅ Great! Fonts loaded |
| "Failed to register font" | Check file names match Info.plist |
| "THD Display font not found" | Verify PostScript name (see below) |
| No font messages at all | Add `CustomFontRegistration.registerFonts()` to app init |

### Verify PostScript Names
1. Double-click font file on Mac
2. Opens Font Book
3. Select the font
4. Press ⌘I for info
5. Find "PostScript name"
6. Must match name used in code

### Common Font Name Issues
The font's PostScript name might be:
- `THD LgVar Beta` (with spaces)
- `THDLgVarBeta` (no spaces)
- `THD-LgVar-Beta` (with hyphens)
- Something else entirely!

### Files Updated
- ✅ `CustomFonts.swift` - Smart font loading with fallback
- ✅ `FontTestView.swift` - Visual test view
- ✅ `FONT_LOADING_FIX.md` - Detailed guide
- ✅ `FONT_FIX_CHECKLIST.md` - This file!

## 📞 Next Steps

1. Complete checklist items 1-8 above
2. Run app and check console
3. Use `FontTestView` to verify visually
4. If issues persist, check console output and refer to `FONT_LOADING_FIX.md`

## 💡 Pro Tips

- Font files must be in app bundle (not just referenced)
- File names in Info.plist are case-sensitive
- PostScript name ≠ file name (sometimes!)
- System fonts work as fallback automatically
- Console logs show all registered fonts for debugging
