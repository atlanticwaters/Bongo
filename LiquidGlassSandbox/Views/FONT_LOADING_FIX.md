# Font Loading Fix for THD Beta Fonts

## Problem
The app is unable to load the THD Beta custom fonts (THD LgVar Beta and THD SmVar Beta).

## Solution Steps

### Step 1: Locate Font Files
1. Find the font files in your project (should be `.ttf` or `.otf` files)
2. Common locations:
   - `_docs` folder
   - `Resources` folder
   - Project root

### Step 2: Add Fonts to Xcode Target
1. **Select the font files** in Xcode's Project Navigator
2. Open the **File Inspector** (⌘⌥1)
3. Under "Target Membership", ensure your app target is checked
4. If fonts aren't in your project yet:
   - Drag font files into Xcode
   - Check "Copy items if needed"
   - Select your app target

### Step 3: Update Info.plist
Add the font files to your Info.plist:

#### Option A: Using Xcode UI
1. Open your project's `Info.plist`
2. Add a new row with key: `Fonts provided by application` (or `UIAppFonts`)
3. Add array items with the exact font file names, including extensions

#### Option B: Using Source Code
Add this to your `Info.plist`:

```xml
<key>UIAppFonts</key>
<array>
    <string>THD-LgVar-Beta.ttf</string>
    <string>THD-SmVar-Beta.ttf</string>
</array>
```

**Important:** Replace the file names with your actual font file names!

### Step 4: Verify Font Names
The actual PostScript name might be different from the file name.

#### To Find the PostScript Name:
1. **On macOS:**
   - Double-click the font file to open Font Book
   - Select the font
   - Choose Font Info (⌘I)
   - Look for "PostScript name"

2. **Programmatically:**
   - Run the app with the updated `CustomFonts.swift`
   - Check the console output - it will list all available fonts
   - Look for the THD fonts in the list

3. **Common variations:**
   - `THD LgVar Beta`
   - `THDLgVarBeta`
   - `THD-LgVar-Beta`
   - `THD_LgVar_Beta`

### Step 5: Register Fonts in Your App
In your app's main entry point (usually `@main` struct), add font registration:

```swift
import SwiftUI

@main
struct YourApp: App {
    init() {
        // Register custom fonts
        CustomFontRegistration.registerFonts()
        
        // Check if fonts loaded successfully
        if CustomFontRegistration.areCustomFontsAvailable() {
            print("✅ Custom fonts loaded successfully!")
        } else {
            print("⚠️ Custom fonts not available, using fallback fonts")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### Step 6: Test Font Loading

#### Quick Test View:
Add this to test if fonts are working:

```swift
struct FontTestView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("THD Display Font")
                .font(.thdDisplay(size: 32))
            
            Text("THD Informational Font")
                .font(.thdInformational(size: 24))
            
            Text("System Fallback")
                .font(.system(size: 24))
        }
        .padding()
    }
}
```

## Common Issues and Solutions

### Issue 1: "Font not found" error
**Solution:** 
- Verify font files are in the bundle (Build Phases → Copy Bundle Resources)
- Check that file names in Info.plist match exactly (case-sensitive)
- Ensure Target Membership is set correctly

### Issue 2: Fonts work in Simulator but not on device
**Solution:**
- Check that fonts are included in the app bundle on device
- Verify Info.plist is part of the app target
- Check for any provisioning profile issues

### Issue 3: Console shows "⚠️ THD Display font not found"
**Solution:**
- The PostScript name doesn't match
- Use Font Book to find the correct PostScript name
- Update the `possibleNames` array in `CustomFonts.swift` if needed

### Issue 4: Fonts in _docs folder but not loading
**Solution:**
- Copy fonts into your Xcode project (don't just reference them)
- Ensure "Copy items if needed" is checked when adding
- Verify they appear in Copy Bundle Resources build phase

## Verification Checklist

- [ ] Font files (.ttf or .otf) are in Xcode project
- [ ] Font files have Target Membership checked for your app
- [ ] Font files are in Copy Bundle Resources (Build Phases)
- [ ] Info.plist has UIAppFonts array with correct file names
- [ ] App init() calls CustomFontRegistration.registerFonts()
- [ ] Console shows font registration success messages
- [ ] Test view displays text with custom fonts

## Fallback Behavior

The updated `CustomFonts.swift` now includes intelligent fallback:
- If THD fonts aren't found, it uses system San Francisco font
- This ensures your app works even without custom fonts
- Console warnings alert you to font loading issues
- No crashes or blank text if fonts are missing

## Updated Files

The following files have been updated to fix font loading:

1. **CustomFonts.swift**
   - Added automatic font registration with CTFontManager
   - Added multiple font name variations to try
   - Added fallback to system fonts
   - Added font availability checking
   - Added debugging output

2. **FONT_LOADING_FIX.md** (this file)
   - Complete setup instructions
   - Troubleshooting guide

## Next Steps

1. Follow Step 1-6 above
2. Run your app
3. Check the console for font registration messages
4. If you see "✅ Successfully registered font", fonts are working!
5. If you see "⚠️ Failed to register font", review the Common Issues section

## Need More Help?

If fonts still aren't loading:
1. Check the exact file names in your project
2. Review the console output when app launches
3. Try the FontTestView to see which fonts are actually loading
4. Verify the PostScript names match what's in the font files
