# Testing Guide for Liquid Glass Sandbox

## Quick Start

This project includes comprehensive test coverage for the Liquid Glass Sandbox iOS app. Here's everything you need to know to get started with testing.

---

## 📁 Test Files Overview

### Test Scripts

| File | Purpose | Run Time |
|------|---------|----------|
| `LiquidGlassSandboxTests.swift` | Unit tests for business logic and components | ~10 seconds |
| `LiquidGlassSandboxUITests.swift` | UI/Integration tests for user flows | ~3 minutes |
| `run_tests.sh` | Convenient test runner script | Varies |
| `TEST_PLAN.md` | Comprehensive testing documentation | N/A |

---

## 🚀 Running Tests

### Method 1: Test Runner Script (Recommended)

The easiest way to run tests:

```bash
# Make the script executable (first time only)
chmod +x run_tests.sh

# Run all tests
./run_tests.sh all

# Run only unit tests (fast)
./run_tests.sh unit

# Run only UI tests
./run_tests.sh ui

# Run tests with coverage
./run_tests.sh coverage

# Run on iPad
./run_tests.sh ipad

# Clean build and test
./run_tests.sh clean
```

### Method 2: Xcode GUI

1. Open `LiquidGlassSandbox.xcodeproj` in Xcode
2. Press `Cmd + U` to run all tests
3. Or click the diamond icons next to individual tests

### Method 3: Command Line (xcodebuild)

```bash
# Run all tests
xcodebuild test \
  -project LiquidGlassSandbox.xcodeproj \
  -scheme LiquidGlassSandbox \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=18.0'

# Run unit tests only
xcodebuild test \
  -project LiquidGlassSandbox.xcodeproj \
  -scheme LiquidGlassSandbox \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=18.0' \
  -only-testing:LiquidGlassSandboxTests

# Run UI tests only
xcodebuild test \
  -project LiquidGlassSandbox.xcodeproj \
  -scheme LiquidGlassSandbox \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=18.0' \
  -only-testing:LiquidGlassSandboxUITests
```

---

## 📋 Test Coverage

### Unit Tests (70% of test suite)

Tests business logic, state management, and calculations:

- ✅ Design system color and border values
- ✅ State management (toggles, sliders, navigation)
- ✅ Blur intensity calculations
- ✅ Animation parameter validation
- ✅ Gradient and color opacity logic
- ✅ Layout value validation
- ✅ Performance benchmarks

**Total Tests**: 40+ unit tests
**Expected Run Time**: ~10 seconds

### UI Tests (20% of test suite)

Tests user interactions and UI flows:

- ✅ App launch and navigation
- ✅ Tab switching
- ✅ Glass material rendering
- ✅ Adaptive layout behavior
- ✅ Dynamic blur interactions
- ✅ Interactive controls (buttons, toggles, sliders)
- ✅ Color system display
- ✅ Orientation changes
- ✅ Accessibility

**Total Tests**: 30+ UI tests
**Expected Run Time**: ~3 minutes

### Manual Tests (10% of test suite)

See `TEST_PLAN.md` for manual testing checklist.

---

## 🎯 What's Being Tested

### Glass Components View
- All 5 material types render correctly
- Blur effects work over gradient backgrounds
- Scrolling performance is smooth

### Adaptive UI View
- List displays correctly on iPhone
- Split view works on iPad
- Navigation to detail views
- Responsive layout changes

### Dynamic Blur View
- Scroll-responsive blur
- Interactive drag gestures
- Material intensity comparison

### Interactive Glass View
- Button interactions and animations
- Toggle state changes
- Slider value updates
- Segmented control tab switching

### Color & Gradient View
- Semantic color display
- Gradient rendering (linear, radial, angular)
- Opacity variations
- Light/Dark mode detection

---

## 🔧 Setting Up Tests in Xcode

If you're starting from scratch, here's how to add the test files to your Xcode project:

### 1. Create Test Targets

1. In Xcode, go to File → New → Target
2. Select "Unit Testing Bundle" and name it `LiquidGlassSandboxTests`
3. Repeat for "UI Testing Bundle" and name it `LiquidGlassSandboxUITests`

### 2. Add Test Files

1. Drag `LiquidGlassSandboxTests.swift` into the Unit Tests target
2. Drag `LiquidGlassSandboxUITests.swift` into the UI Tests target
3. Ensure the files are added to their respective targets in File Inspector

### 3. Configure Test Targets

For both test targets:
- Set **Host Application** to `LiquidGlassSandbox`
- Set **Deployment Target** to `iOS 18.0`
- Add `@testable import LiquidGlassSandbox` to unit test file

### 4. Enable Code Coverage

1. Product → Scheme → Edit Scheme
2. Select "Test" in sidebar
3. Check "Code Coverage" checkbox
4. Select "LiquidGlassSandbox" in the coverage targets

---

## 📊 Viewing Test Results

### In Xcode

1. After running tests, open the **Test Navigator** (`Cmd + 6`)
2. Green checkmarks = passed tests
3. Red X's = failed tests
4. Click on any test to see details

### Code Coverage Report

1. After running tests with coverage enabled
2. Open **Report Navigator** (`Cmd + 9`)
3. Select the latest test run
4. Click the "Coverage" tab
5. View coverage percentages for each file

### Command Line Output

When using `xcodebuild`, test results are printed to stdout:
```
Test Suite 'LiquidGlassSandboxTests' passed at 2025-11-21 10:30:45.123.
	 Executed 40 tests, with 0 failures (0 unexpected) in 8.234 (8.567) seconds
```

---

## 🐛 Troubleshooting

### Tests Not Found

**Problem**: "Test target has no tests" error

**Solution**:
1. Ensure test files are added to correct test target
2. Check that test classes inherit from `XCTestCase`
3. Verify test methods start with `test`

### Simulator Issues

**Problem**: Simulator fails to launch or tests timeout

**Solution**:
```bash
# Reset simulators
xcrun simctl shutdown all
xcrun simctl erase all

# Restart Xcode
killall Xcode
```

### Code Coverage Not Working

**Problem**: Coverage shows 0% or is missing

**Solution**:
1. Edit Scheme → Test → Options
2. Ensure "Code Coverage" is checked
3. Select correct targets for coverage collection

### UI Tests Failing on CI

**Problem**: UI tests pass locally but fail on CI

**Solution**:
1. Add delays with `sleep()` for animation completion
2. Increase timeout values
3. Use `.waitForExistence(timeout:)` for elements

---

## 📈 Performance Benchmarks

### Target Metrics

| Metric | Target | Your Result |
|--------|--------|-------------|
| Unit Tests | < 15s | _____ |
| UI Tests (iPhone) | < 3min | _____ |
| UI Tests (iPad) | < 3min | _____ |
| Code Coverage | > 80% | _____ |
| Memory Usage | < 100MB | _____ |

Run tests and fill in your results!

---

## 🔄 Continuous Integration

### GitHub Actions

Example workflow (`.github/workflows/test.yml`):

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: macos-14
    steps:
      - uses: actions/checkout@v3
      - name: Run Tests
        run: ./run_tests.sh coverage
```

### Xcode Cloud

1. Open App Store Connect
2. Configure Xcode Cloud
3. Add test workflow
4. Select "Run Tests" action

---

## 📚 Additional Resources

- **Full Test Plan**: See `TEST_PLAN.md` for detailed testing strategy
- **Apple XCTest Docs**: https://developer.apple.com/documentation/xctest
- **UI Testing Guide**: https://developer.apple.com/documentation/xctest/user_interface_tests
- **SwiftUI Testing**: https://www.swiftbysundell.com/articles/testing-swiftui-views/

---

## ✅ Testing Checklist

Before committing code:

- [ ] All unit tests pass (`./run_tests.sh unit`)
- [ ] All UI tests pass (`./run_tests.sh ui`)
- [ ] Code coverage is > 80% (`./run_tests.sh coverage`)
- [ ] No new warnings in test output
- [ ] Tests run successfully on both iPhone and iPad

Before releasing:

- [ ] All automated tests pass
- [ ] Manual testing checklist completed (see `TEST_PLAN.md`)
- [ ] Glass effects tested on physical device
- [ ] Performance metrics meet targets
- [ ] Accessibility tests pass

---

## 💡 Tips for Writing Tests

### Good Test Practices

✅ **Do:**
- Write descriptive test names: `testGlassButtonRespondsToTap()`
- Test one thing per test method
- Use arrange-act-assert pattern
- Add comments explaining complex test logic
- Keep tests independent and isolated

❌ **Don't:**
- Write tests that depend on other tests
- Use hard-coded delays (use `waitForExistence` instead)
- Test implementation details
- Skip writing tests for bug fixes
- Ignore failing tests

### Example Test Structure

```swift
func testFeatureName() throws {
    // Arrange: Set up test conditions
    let initialValue = 0

    // Act: Perform the action
    performAction()

    // Assert: Verify the result
    XCTAssertEqual(finalValue, expectedValue, "Description of what should happen")
}
```

---

## 🤝 Contributing Tests

When adding new features:

1. Write tests for new functionality
2. Ensure all tests pass before creating PR
3. Update `TEST_PLAN.md` if adding new test categories
4. Add manual testing steps for new UI components

---

## 📞 Getting Help

If you encounter issues with tests:

1. Check the troubleshooting section above
2. Review `TEST_PLAN.md` for detailed information
3. Check Xcode console for error messages
4. Open an issue with test failure details

---

**Happy Testing! 🎉**

Remember: Good tests make great apps. The time you invest in testing now will save hours of debugging later.
