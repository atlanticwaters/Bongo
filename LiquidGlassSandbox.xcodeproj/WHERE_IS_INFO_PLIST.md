# Finding and Configuring Info.plist in Xcode

## Modern Xcode (Xcode 13+)

In modern Xcode projects, Info.plist is often embedded in the target settings rather than being a separate file you can see.

### Step-by-Step Visual Guide

```
1. Project Navigator
   └── YourProjectName (📁 - the top item with blue icon)
       ├── Targets
       │   └── YourAppName ← Click this!
       └── Project
           └── YourProjectName

2. After clicking your app target, you'll see tabs:
   [General] [Signing & Capabilities] [Resource Tags] [Info] [Build Settings] [Build Phases] [Build Rules]
                                                       ↑
                                                  Click here!

3. In the Info tab, you'll see:
   ┌─────────────────────────────────────────────────────┐
   │ Custom iOS Target Properties                        │
   │ ┌─────────────────────────────────────────────────┐ │
   │ │ Key                               Type    Value  │ │
   │ │ Bundle name                       String  $(P... │ │
   │ │ Bundle display name               String  $(P... │ │
   │ │ Executable file                   String  $(E... │ │
   │ │ [+] ← Click to add new           [-]             │ │
   │ └─────────────────────────────────────────────────┘ │
   └─────────────────────────────────────────────────────┘

4. Click the [+] button and start typing:
   "Fonts provided by application"
   
   Xcode will auto-complete it for you!
   
   Or type the raw key: UIAppFonts

5. Change the Type dropdown from "String" to "Array"

6. Click the disclosure triangle (▶) next to "Fonts provided by application"
   It will expand:
   
   Fonts provided by application    Array    (2 items)
   ▼ Item 0                         String    THD-LgVar-Beta.ttf
   ▼ Item 1                         String    THD-SmVar-Beta.ttf
     [+] Add new item               [-]

7. Add your font file names exactly as they appear in your Resources folder
```

## If You Can't Find the Target Settings

### Method 1: Use the Helper View
Run the `InfoPlistHelperView()` I just created - it will:
- Show you where Info.plist is
- List fonts in your bundle
- Tell you if UIAppFonts is configured
- Give you the exact file names to add

### Method 2: Look for a Physical File
Some projects still have a physical Info.plist file:

```
In Xcode Project Navigator, look for:

YourProject/
├── YourAppName/
│   ├── Info.plist ← Look here first
│   ├── Resources/
│   │   └── Info.plist ← Or here
│   └── Supporting Files/
│       └── Info.plist ← Or here
```

If you find it, you can edit it directly:
- Right-click → Open As → Source Code
- Add this XML:

```xml
<key>UIAppFonts</key>
<array>
    <string>THD-LgVar-Beta.ttf</string>
    <string>THD-SmVar-Beta.ttf</string>
</array>
```

## Quick Keyboard Shortcut

1. Press `⌘1` to open Project Navigator
2. Click the top-most item (your project)
3. Click your app target under TARGETS
4. Click the "Info" tab
5. Click the `+` button
6. Type "Fonts provided by application"

## Verification Steps

After adding fonts to Info.plist:

### 1. Check in Code
Add this temporarily to any view:
```swift
let fonts = Bundle.main.object(forInfoDictionaryKey: "UIAppFonts") as? [String]
print("Fonts in Info.plist: \(fonts ?? [])")
```

### 2. Use the Helper View
```swift
// In your ContentView or any view:
InfoPlistHelperView()
```

This will show you:
- ✅ Whether UIAppFonts is configured
- 📋 What fonts are listed
- 📦 What fonts are actually in your bundle
- 📝 Step-by-step instructions

### 3. Check Build Output
1. Clean build folder (⌘⇧K)
2. Build (⌘B)
3. Check for warnings about missing fonts

## Common Locations by Project Type

### SwiftUI App (Xcode 13+)
- Usually embedded in target, no physical file
- Use target Info tab

### UIKit App or Older Projects
- Usually has Info.plist file in project root
- Can edit directly

### Cross-platform Project
- May have separate Info.plist for each platform
- Check iOS folder specifically

## What to Look For in Resources Folder

Your Resources folder should have files like:
- `THD-LgVar-Beta.ttf` or `.otf`
- `THD-SmVar-Beta.ttf` or `.otf`

Or possibly:
- `THDLgVarBeta.ttf`
- `THDSmVarBeta.ttf`

Or variations with underscores:
- `THD_LgVar_Beta.ttf`
- `THD_SmVar_Beta.ttf`

**The exact file names are what you need to add to Info.plist!**

## Still Can't Find It?

Run the `InfoPlistHelperView` and it will tell you:
1. Exact location of Info.plist (or if it's embedded)
2. Whether UIAppFonts is already configured
3. What font files are in your bundle
4. Exact file names to copy/paste

Just add this to any view:
```swift
NavigationLink("Check Font Config") {
    InfoPlistHelperView()
}
```

Or in ContentView:
```swift
struct ContentView: View {
    var body: some View {
        TabView {
            YourMainView()
                .tabItem { Label("Home", systemImage: "house") }
            
            InfoPlistHelperView()
                .tabItem { Label("Font Config", systemImage: "textformat") }
        }
    }
}
```
