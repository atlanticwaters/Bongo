# Custom Font Setup Instructions

## Overview
This app uses custom fonts from the `_docs` folder. The design system references two font families:
- **THD LgVar Beta** - Display font for headers and heroes
- **THD SmVar Beta** - Informational font for body text and captions

## Setup Steps

### 1. Add Font Files to Xcode Project
1. Locate the font files in the `_docs` folder (should have `.ttf` or `.otf` extensions)
2. Drag the font files into your Xcode project
3. Make sure "Copy items if needed" is checked
4. Ensure the fonts are added to your app target

### 2. Register Fonts in Info.plist
Add the following to your `Info.plist` file:

```xml
<key>UIAppFonts</key>
<array>
    <string>THD-LgVar-Beta.ttf</string>
    <string>THD-SmVar-Beta.ttf</string>
</array>
```

**Note:** Adjust the file names to match your actual font file names in the `_docs` folder.

### 3. Verify Font Names
The custom font extension in `CustomFonts.swift` uses the PostScript names:
- `THD LgVar Beta`
- `THD SmVar Beta`

To verify these are correct:
1. Open Font Book on macOS
2. Install the fonts temporarily
3. Right-click on the font and select "Show in Finder"
4. Get Info on the font file and check the PostScript name
5. Update the font names in `CustomFonts.swift` if needed

### 4. Font Registration in App
The fonts are automatically available once added to Info.plist. The `CustomFonts.swift` file provides convenient access through:
- `Font.thdHero1`, `Font.thdHero2`, etc.
- `Font.thdH1`, `Font.thdH2`, etc.
- `Font.thdBodyMd`, `Font.thdBodyLg`, etc.

### 5. Using Custom Fonts in SwiftUI

#### Method 1: Direct Font Extension
```swift
Text("Hello World")
    .font(.thdH1)
```

#### Method 2: Custom Modifier
```swift
Text("Hello World")
    .thdFont(.h1)
```

#### Method 3: Custom Size
```swift
Text("Hello World")
    .font(.thdDisplay(size: 24))
```

## Font Family Reference

### Display Family (THD LgVar Beta)
Used for: Headlines, Titles, Hero Text
- Hero1: 64pt
- Hero2: 56pt
- Hero3: 48pt
- Hero4: 40pt
- Hero5: 36pt
- H1: 32pt
- H2: 28pt
- H3: 24pt
- H4: 20pt
- H5: 18pt
- H6: 16pt

### Informational Family (THD SmVar Beta)
Used for: Body text, Captions, UI elements
- Body XL: 20pt
- Body Lg: 18pt
- Body Md: 16pt
- Body Sm: 14pt
- Body Xs: 12pt
- Caption: 11pt

## Fallback Behavior
If the custom fonts are not found, the system will fall back to the San Francisco font family. This ensures your app remains functional even without the custom fonts installed.

## Testing
To test if fonts are loading correctly:
1. Run the app
2. Check the console for font registration messages
3. View the Design System tab to see all typography scales
4. If fonts don't appear, verify:
   - Font files are in the bundle
   - Info.plist entries are correct
   - Font names match PostScript names
