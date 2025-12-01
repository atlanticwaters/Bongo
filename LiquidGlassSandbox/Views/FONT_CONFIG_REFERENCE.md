# Font Configuration Reference Card

Fill this out with your actual font information for quick reference:

## 📁 Font Files in Resources Folder

### Display Font (Large/Headers)
- **File Name:** `________________________.___`
- **File Extension:** [ ] .ttf  [ ] .otf
- **File Size:** __________ KB
- **PostScript Name:** `________________________`
- **In Info.plist:** [ ] Yes  [ ] No
- **In Build Phases:** [ ] Yes  [ ] No

### Informational Font (Body Text)
- **File Name:** `________________________.___`
- **File Extension:** [ ] .ttf  [ ] .otf
- **File Size:** __________ KB
- **PostScript Name:** `________________________`
- **In Info.plist:** [ ] Yes  [ ] No
- **In Build Phases:** [ ] Yes  [ ] No

---

## 📝 Info.plist Configuration

Copy this section into your Info.plist (after filling in above):

```xml
<key>UIAppFonts</key>
<array>
    <string>YOUR-DISPLAY-FONT-FILENAME.ttf</string>
    <string>YOUR-INFORMATIONAL-FONT-FILENAME.ttf</string>
</array>
```

**Actual configuration to use:**
```xml
<key>UIAppFonts</key>
<array>
    <string>________________________</string>
    <string>________________________</string>
</array>
```

---

## 🔧 Code Updates Needed

### If PostScript names are different, update CustomFonts.swift:

**For Display Font (thdDisplay):**
```swift
let possibleNames = [
    "THD LgVar Beta",           // Default
    "THDLgVarBeta",             // No spaces
    "THD-LgVar-Beta",           // Hyphens
    "________________________"  // YOUR ACTUAL NAME HERE
]
```

**For Informational Font (thdInformational):**
```swift
let possibleNames = [
    "THD SmVar Beta",           // Default
    "THDSmVarBeta",             // No spaces
    "THD-SmVar-Beta",           // Hyphens
    "________________________"  // YOUR ACTUAL NAME HERE
]
```

---

## ✅ Setup Checklist

### File System
- [ ] Fonts are in Resources folder
- [ ] Can see fonts in Xcode Project Navigator
- [ ] Both Display and Informational fonts present

### Xcode Target Configuration
- [ ] Display font: Target Membership checked
- [ ] Informational font: Target Membership checked
- [ ] Both fonts in Build Phases → Copy Bundle Resources

### Info.plist
- [ ] UIAppFonts key exists
- [ ] Display font file name added
- [ ] Informational font file name added
- [ ] Spelling matches exactly (case-sensitive)

### Code Integration
- [ ] CustomFontRegistration.registerFonts() in app init
- [ ] Console output checked
- [ ] Font registration success messages seen
- [ ] All fonts listed in console output

### Testing
- [ ] App builds without errors
- [ ] Console shows font registration
- [ ] FontTestView added to app
- [ ] Fonts display correctly in FontTestView
- [ ] No "⚠️ font not found" warnings

---

## 🐛 Console Output Analysis

After running the app, record what you see:

### Font Registration Messages:
```
✅ Successfully registered font: ________________________
✅ Successfully registered font: ________________________
```

### Font Availability Check:
```
[ ] ✅ Custom fonts loaded successfully!
[ ] ⚠️ Custom fonts not available (using fallback)
```

### PostScript Names Found:
Look in the "All available fonts in the system" list for THD fonts:

**Family:** ________________________
  - **Name:** ________________________
  - **Name:** ________________________

---

## 🎯 Quick Commands

### Clean and Rebuild
```
⌘ ⇧ K    (Clean build folder)
⌘ B      (Build)
⌘ R      (Run)
```

### Check Font Registration
1. Run app
2. Open Console in Xcode (⌘ ⇧ C)
3. Search for "font" or "THD"

### Test Visually
Add to any view:
```swift
VStack {
    Text("Display Font Test")
        .font(.thdDisplay(size: 32))
    Text("Informational Font Test")  
        .font(.thdInformational(size: 20))
}
```

---

## 📞 Support Notes

If fonts still don't load after setup:

**Issue:** ____________________________________________________________

**Console Shows:** _____________________________________________________

**Steps Tried:** _______________________________________________________

**Current Status:** ____________________________________________________

---

## 🎉 Success!

Once working, record successful configuration:

**Date Working:** __________

**Xcode Version:** __________

**iOS Target:** __________

**Final File Names Used:**
- Display: ________________________
- Informational: ________________________

**Final PostScript Names:**
- Display: ________________________
- Informational: ________________________

**Notes:** ____________________________________________________________

____________________________________________________________________

____________________________________________________________________
