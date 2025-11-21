# Liquid Glass Sandbox

A comprehensive iOS 18+ sandbox application demonstrating Apple's Liquid Glass design system features including glass morphism effects, adaptive blur, dynamic backgrounds, and modern SwiftUI components.

## 📱 Overview

This app showcases the Liquid Glass design language with:
- **Glass Morphism** - Frosted glass surfaces with backdrop filters
- **Adaptive Blur** - Blur intensity that responds to content and context
- **Dynamic Shadows** - Subtle, context-aware shadow system
- **Fluid Animations** - Smooth transitions using spring physics
- **Semantic Colors** - Colors that adapt to light/dark mode

## 🎯 Features

### 1. Glass Components
Demonstrates all 5 iOS 18 glass material types:
- Ultra Thin Material
- Thin Material
- Regular Material
- Thick Material
- Liquid Glass (iOS 18)

### 2. Adaptive UI
Responsive layouts that adapt to:
- iPhone (compact width)
- iPad (regular width)
- Portrait/Landscape orientations

### 3. Dynamic Blur
Interactive blur effects with:
- Scroll-responsive blur
- Gesture-based blur intensity
- Material comparison

### 4. Interactive Components
Glass-styled UI elements:
- Buttons with press animations
- Toggle switches
- Sliders with real-time values
- Segmented controls

### 5. Color System
Comprehensive color exploration:
- Semantic color swatches
- Linear, radial, and angular gradients
- Opacity variations
- Dark/Light mode detection

## 🛠 Requirements

- **Xcode**: 16.0+ (for iOS 18 support)
- **Swift**: 6.0+
- **iOS**: 18.0+ (deployment target)
- **Devices**: iPhone and iPad

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/atlanticwaters/Bongo.git
cd Bongo
```

### 2. Open in Xcode

```bash
open LiquidGlassSandbox.xcodeproj
```

### 3. Select Your Target

- Choose a simulator: **iPhone 15 Pro** or **iPad Pro 12.9"**
- Or connect a physical iOS 18+ device

### 4. Build and Run

Press `Cmd + R` or click the Run button in Xcode.

## 📂 Project Structure

```
LiquidGlassSandbox/
├── LiquidGlassSandboxApp.swift          # App entry point
├── Views/
│   ├── ContentView.swift                # Main navigation hub
│   ├── GlassComponentsView.swift        # Glass morphism examples
│   ├── AdaptiveUIView.swift             # Adaptive layouts
│   ├── DynamicBlurView.swift            # Blur demonstrations
│   ├── InteractiveGlassView.swift       # Interactive components
│   └── ColorAndGradientView.swift       # Color system
├── DesignSystem/
│   ├── DesignSystemGlobal.swift         # Global design tokens
│   ├── DesignSystemLightLarge.swift     # Light mode (large)
│   ├── DesignSystemLightMedium.swift    # Light mode (medium)
│   ├── DesignSystemDarkLarge.swift      # Dark mode (large)
│   └── DesignSystemDarkMedium.swift     # Dark mode (medium)
└── Resources/
    └── Assets.xcassets                  # Color sets, images

LiquidGlassSandboxTests/
└── LiquidGlassSandboxTests.swift        # Unit tests (40+ tests)

LiquidGlassSandboxUITests/
└── LiquidGlassSandboxUITests.swift      # UI tests (30+ tests)
```

## 🧪 Testing

This project includes comprehensive test coverage:

### Quick Test Commands

```bash
# Run unit tests (fast, ~10 seconds)
./run_tests.sh unit

# Run UI tests (~3 minutes)
./run_tests.sh ui

# Run all tests with code coverage
./run_tests.sh coverage

# Run tests on iPad
./run_tests.sh ipad
```

### In Xcode

- Press `Cmd + U` to run all tests
- Open Test Navigator (`Cmd + 6`) to run individual tests

### Test Coverage

- **40+ Unit Tests** - Business logic and calculations
- **30+ UI Tests** - User interactions and flows
- **80%+ Code Coverage** target

See [TESTING_README.md](TESTING_README.md) for detailed testing guide.

## 📚 Documentation

- **[LIQUID_GLASS_SANDBOX_GUIDE.md](_docs/LIQUID_GLASS_SANDBOX_GUIDE.md)** - Complete implementation guide with annotated code
- **[TEST_PLAN.md](TEST_PLAN.md)** - Comprehensive testing strategy and documentation
- **[TESTING_README.md](TESTING_README.md)** - Quick testing reference guide

## 🎨 Design System

The app includes a comprehensive design system with:

- **Colors**: Semantic colors for different UI states
- **Typography**: Dynamic type support
- **Spacing**: Consistent padding and margins
- **Border Radius**: Standardized corner radii
- **Opacity Levels**: Defined transparency values

All design tokens are defined in `DesignSystem/*.swift` files.

## 💡 Key Concepts Demonstrated

### SwiftUI Features
- `TabView` for navigation
- `NavigationStack` for hierarchical navigation
- `@State` and `@Environment` property wrappers
- Material effects (`.ultraThinMaterial`, `.glass`, etc.)
- Gesture handling (`DragGesture`)
- Adaptive layouts with `@Environment(\.horizontalSizeClass)`

### iOS 18 Specific
- Liquid Glass materials
- Modern blur effects
- Adaptive color system
- ProMotion display support

## 🔍 Example Code

### Glass Material Usage

```swift
VStack {
    Text("Glass Effect")
        .foregroundColor(.white)
}
.frame(maxWidth: .infinity)
.frame(height: 120)
.background(.ultraThinMaterial)  // Glass effect
.cornerRadius(16)
```

### Adaptive Layout

```swift
@Environment(\.horizontalSizeClass) var horizontalSizeClass

if horizontalSizeClass == .regular {
    // iPad/Mac: Side-by-side layout
    HStack {
        ListPanel()
        DetailPanel()
    }
} else {
    // iPhone: Stacked layout
    NavigationLink {
        DetailPanel()
    } label: {
        ListItem()
    }
}
```

## 🐛 Troubleshooting

### Glass Effects Not Showing
- Ensure deployment target is iOS 18.0+
- Test on physical device for best results
- Simulator may not render all effects accurately

### Build Errors
- Clean build folder: `Cmd + Shift + K`
- Delete derived data: `Rm -rf ~/Library/Developer/Xcode/DerivedData`
- Restart Xcode

### Test Failures
- Reset simulator: `xcrun simctl shutdown all && xcrun simctl erase all`
- Check test target settings
- Review [TESTING_README.md](TESTING_README.md) troubleshooting section

## 📈 Performance

Target metrics for optimal performance:

| Metric | Target |
|--------|--------|
| App Launch | < 1s |
| Tab Switch | < 0.3s |
| Scroll FPS | > 60fps |
| Memory Usage | < 100MB |
| Glass Render | < 16ms |

## 🤝 Contributing

This is a sandbox/learning project. Feel free to:
- Experiment with different glass effects
- Add new views and components
- Modify design system tokens
- Enhance animations and transitions

## 📄 License

This project is for educational purposes.

## 🙏 Acknowledgments

- Built with Apple's SwiftUI framework
- Demonstrates iOS 18 design patterns
- Inspired by Apple's design guidelines

## 📞 Support

For questions or issues:
- Review the [documentation](_docs/LIQUID_GLASS_SANDBOX_GUIDE.md)
- Check the [test plan](TEST_PLAN.md)
- Open an issue on GitHub

---

**Built with ❤️ using SwiftUI and iOS 18**

Explore the future of iOS design with Liquid Glass! 🎨✨
