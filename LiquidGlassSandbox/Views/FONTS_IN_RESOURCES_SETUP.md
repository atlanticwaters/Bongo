# Fonts Now in Resources Folder - Setup Guide

Great! Now that the fonts are in your Resources folder, here's what you need to do:

## Step 1: Identify the Exact Font File Names

First, we need to know the exact names of your font files. Common possibilities:

- `THD-LgVar-Beta.ttf` / `THD-LgVar-Beta.otf`
- `THD-SmVar-Beta.ttf` / `THD-SmVar-Beta.otf`
- `THDLgVarBeta.ttf` / `THDLgVarBeta.otf`
- `THDSmVarBeta.ttf` / `THDSmVarBeta.otf`
- `THD_LgVar_Beta.ttf` / `THD_LgVar_Beta.otf`
- `THD_SmVar_Beta.ttf` / `THD_SmVar_Beta.otf`

**👉 Check your Resources folder and note the EXACT file names including extensions.**

## Step 2: Verify Fonts Are in Your App Target

1. In Xcode, select one of the font files in the Resources folder
2. Open the File Inspector (⌘⌥1)
3. Under "Target Membership", make sure your app target is checked
4. Repeat for all font files

## Step 3: Verify Fonts in Copy Bundle Resources

1. Select your app target in the Project Navigator
2. Click the "Build Phases" tab
3. Expand "Copy Bundle Resources"
4. **Look for your font files in the list**
5. If they're not there:
   - Click the + button
   - Add your font files from Resources folder

## Step 4: Update Info.plist

You need to add the font files to your Info.plist. Here are the two methods:

### Method A: Using Xcode's Property List Editor

1. Open `Info.plist` in Xcode
2. Right-click in the list and select "Add Row"
3. Type: `Fonts provided by application` (Xcode will auto-complete)
   - Or use the raw key: `UIAppFonts`
4. Set type to `Array`
5. Click the disclosure triangle to expand
6. Click the + next to the array
7. Add each font file name **exactly as it appears in Resources**

Example entries:
- `THD-LgVar-Beta.ttf`
- `THD-SmVar-Beta.ttf`

### Method B: Using Source Code Editor

Right-click Info.plist → Open As → Source Code, then add:

```xml
<key>UIAppFonts</key>
<array>
    <string>THD-LgVar-Beta.ttf</string>
    <string>THD-SmVar-Beta.ttf</string>
</array>
```

**⚠️ IMPORTANT: Replace these with your actual file names!**

## Step 5: Find Your PostScript Font Names

The font file name is not always the same as the font's PostScript name that you use in code. To find the actual PostScript names:

### Option 1: Use Font Book (Recommended)
1. In Finder, navigate to your Resources folder
2. Double-click on `THD-LgVar-Beta.ttf` (or whatever it's named)
3. Font Book will open
4. Select the font in Font Book
5. Press ⌘I (Command-I) to open Font Info
6. Look for "PostScript name" - **write this down!**
7. Repeat for the other font file

### Option 2: Let the Code Tell You
1. Make sure fonts are in Info.plist (Step 4)
2. Add font registration to your app (Step 6)
3. Run the app
4. Check the Xcode console - it will list all available fonts
5. Look for "THD" in the font list

## Step 6: Update App Initialization

Find your app's main entry point (file with `@main`), usually something like:
- `YourAppNameApp.swift`
- `LiquidGlassSandboxApp.swift`
- `AppDelegate.swift`

Add font registration:

```swift
import SwiftUI

@main
struct YourApp: App {
    init() {
        // Register custom fonts
        CustomFontRegistration.registerFonts()
        
        // Check if fonts loaded successfully
        if CustomFontRegistration.areCustomFontsAvailable() {
            print("✅ Custom THD fonts loaded successfully!")
        } else {
            print("⚠️ Custom fonts not available, using system font fallback")
            print("📋 Check Info.plist has UIAppFonts with correct file names")
            print("📋 Check fonts are in Copy Bundle Resources build phase")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

## Step 7: Test the Fonts

### Quick Console Test
1. Build and run your app (⌘R)
2. Look at the Xcode console
3. You should see:
   - `✅ Successfully registered font: [filename]` for each font
   - `📝 All available fonts in the system:` followed by a list
   - Look for your THD fonts in that list

### Visual Test
Add `FontTestView()` somewhere in your app to see all fonts visually:

```swift
struct ContentView: View {
    var body: some View {
        TabView {
            // Your normal content
            YourMainView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            // Font test view
            FontTestView()
                .tabItem {
                    Label("Fonts", systemImage: "textformat")
                }
        }
    }
}
```

## Step 8: If PostScript Names Don't Match

If the console shows your fonts loaded but with different names than expected, update `CustomFonts.swift`:

```swift
static func thdDisplay(size: CGFloat, weight: Font.Weight = .regular) -> Font {
    let possibleNames = [
        "THD LgVar Beta",           // Original expected name
        "THDLgVarBeta",             // No spaces
        "THD-LgVar-Beta",           // Hyphens
        "YOUR-ACTUAL-POSTSCRIPT-NAME-HERE"  // Add the real PostScript name
    ]
    
    for fontName in possibleNames {
        if UIFont(name: fontName, size: size) != nil {
            return .custom(fontName, size: size)
        }
    }
    
    print("⚠️ THD Display font not found, using system font")
    return .system(size: size, weight: weight, design: .default)
}
```

## Common Issues & Solutions

### Issue: Console shows "Failed to register font"
**Solution:** 
- Check file names in Info.plist match exactly (case-sensitive!)
- Verify fonts are in Copy Bundle Resources
- Make sure Target Membership is checked

### Issue: Console shows "Successfully registered font" but text looks wrong
**Solution:**
- The PostScript name is different from the file name
- Check console output for the actual font name
- Update `CustomFonts.swift` with the correct PostScript name

### Issue: Fonts work in Simulator but not on device
**Solution:**
- Clean build folder (⌘⇧K)
- Delete app from device
- Rebuild and reinstall

### Issue: No font registration messages in console
**Solution:**
- Add `CustomFontRegistration.registerFonts()` to your app's `init()`
- Make sure you're looking at the right console output
- Try adding a print statement before registration to confirm init is running

## Quick Verification Checklist

- [ ] Font files are in Resources folder
- [ ] Font files visible in Xcode Project Navigator
- [ ] Target Membership checked for each font
- [ ] Fonts listed in "Copy Bundle Resources" build phase
- [ ] Info.plist has `UIAppFonts` array
- [ ] Font file names in Info.plist match exactly
- [ ] `CustomFontRegistration.registerFonts()` called in app init
- [ ] Console shows successful registration
- [ ] FontTestView shows fonts correctly

## What File Names Do You Have?

Once you've checked your Resources folder, the exact font file names are:

**Display Font:** `___________________.___`

**Informational Font:** `___________________.___`

Write these down and use them exactly in your Info.plist!

## Next Steps

1. ✅ Complete Steps 1-7 above
2. 🧪 Run the app and check console output
3. 👀 Use FontTestView to verify fonts visually
4. 📝 Update this doc with your actual file names for reference

---

**Pro Tip:** Take a screenshot of Font Book's info panel showing the PostScript name - it's the definitive source of truth for what name to use in code!
