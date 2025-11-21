//
// LiquidGlassSandboxUITests.swift
// UI Tests for Liquid Glass Sandbox App
//
// This test suite validates all interactive components, navigation,
// glass materials, and adaptive layouts in the Liquid Glass Sandbox app.
//

import XCTest

// MARK: - Main UI Test Class
final class LiquidGlassSandboxUITests: XCTestCase {

    // MARK: - Properties
    var app: XCUIApplication!

    // MARK: - Setup & Teardown
    override func setUpWithError() throws {
        // Stop immediately when a failure occurs
        continueAfterFailure = false

        // Initialize the application
        app = XCUIApplication()

        // Configure launch arguments for testing
        app.launchArguments = ["UI-Testing"]

        // Launch the app
        app.launch()
    }

    override func tearDownWithError() throws {
        // Clean up after each test
        app = nil
    }

    // MARK: - App Launch Tests

    func testAppLaunches() throws {
        // Test that the app launches successfully
        XCTAssertTrue(app.exists, "App should launch successfully")

        // Verify the tab bar is present
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.exists, "Tab bar should be visible on launch")
    }

    func testInitialTabIsGlassComponents() throws {
        // Verify that the first tab (Glass Components) is selected by default
        let glassTab = app.tabBars.buttons["Glass"]
        XCTAssertTrue(glassTab.exists, "Glass tab should exist")
        XCTAssertTrue(glassTab.isSelected, "Glass tab should be selected by default")
    }

    // MARK: - Navigation Tests

    func testTabNavigation() throws {
        let tabBar = app.tabBars.firstMatch

        // Test navigation to each tab
        let tabs = ["Glass", "Adaptive", "Blur", "Interactive", "Colors"]

        for tabName in tabs {
            let tab = tabBar.buttons[tabName]
            XCTAssertTrue(tab.exists, "\(tabName) tab should exist")

            // Tap the tab
            tab.tap()

            // Wait for the view to load
            sleep(1)

            // Verify tab is selected
            XCTAssertTrue(tab.isSelected, "\(tabName) tab should be selected after tap")
        }
    }

    func testNavigationTitles() throws {
        // Test that each tab displays the correct navigation title
        let expectedTitles = [
            ("Glass", "Glass Components"),
            ("Adaptive", "Adaptive Layouts"),
            ("Blur", "Dynamic Blur"),
            ("Interactive", "Interactive Glass"),
            ("Colors", "Colors & Gradients")
        ]

        for (tabName, expectedTitle) in expectedTitles {
            // Navigate to tab
            app.tabBars.buttons[tabName].tap()
            sleep(1)

            // Check navigation bar title
            let navigationBar = app.navigationBars[expectedTitle]
            XCTAssertTrue(navigationBar.exists, "Navigation bar should show '\(expectedTitle)'")
        }
    }

    // MARK: - Glass Components View Tests

    func testGlassComponentsExist() throws {
        // Navigate to Glass tab
        app.tabBars.buttons["Glass"].tap()

        // Verify header exists
        let header = app.staticTexts["Glass Morphism Materials"]
        XCTAssertTrue(header.exists, "Glass Components header should exist")

        // Verify material sections exist
        let materials = [
            "Ultra Thin Material",
            "Thin Material",
            "Regular Material",
            "Thick Material",
            "Liquid Glass (iOS 18)"
        ]

        for material in materials {
            let materialLabel = app.staticTexts[material]
            XCTAssertTrue(materialLabel.exists, "\(material) label should exist")
        }
    }

    func testGlassComponentsScrolling() throws {
        // Navigate to Glass tab
        app.tabBars.buttons["Glass"].tap()

        // Get the scroll view
        let scrollView = app.scrollViews.firstMatch
        XCTAssertTrue(scrollView.exists, "Scroll view should exist")

        // Scroll down to bottom
        let liquidGlass = app.staticTexts["Liquid Glass (iOS 18)"]
        scrollView.swipeUp()
        sleep(1)

        // Verify we can see the last element after scrolling
        XCTAssertTrue(liquidGlass.exists, "Should be able to scroll to Liquid Glass section")
    }

    // MARK: - Adaptive UI View Tests

    func testAdaptiveUIListItems() throws {
        // Navigate to Adaptive tab
        app.tabBars.buttons["Adaptive"].tap()

        // Wait for view to load
        sleep(1)

        // Verify list items exist
        for i in 1...6 {
            let featureText = app.staticTexts["Feature \(i)"]

            // Scroll to make item visible if needed
            if !featureText.isHittable {
                app.swipeUp()
            }

            XCTAssertTrue(featureText.exists, "Feature \(i) should exist in list")
        }
    }

    func testAdaptiveUINavigation() throws {
        // Navigate to Adaptive tab
        app.tabBars.buttons["Adaptive"].tap()
        sleep(1)

        // Tap on first feature
        app.staticTexts["Feature 1"].tap()
        sleep(1)

        // Verify detail view appears
        let detailNavBar = app.navigationBars["Feature Details"]
        XCTAssertTrue(detailNavBar.exists, "Detail view should appear")

        // Verify detail content exists
        let detailHeader = app.staticTexts["Feature 1"]
        XCTAssertTrue(detailHeader.exists, "Detail header should exist")

        // Go back
        app.navigationBars.buttons.element(boundBy: 0).tap()
        sleep(1)

        // Verify we're back at the list
        XCTAssertTrue(app.staticTexts["Feature 1"].exists, "Should return to list view")
    }

    // MARK: - Dynamic Blur View Tests

    func testDynamicBlurSections() throws {
        // Navigate to Blur tab
        app.tabBars.buttons["Blur"].tap()
        sleep(1)

        // Verify main sections exist
        let header = app.staticTexts["Dynamic Blur Effects"]
        XCTAssertTrue(header.exists, "Blur header should exist")

        let scrollSection = app.staticTexts["Scroll-Responsive Blur"]
        XCTAssertTrue(scrollSection.exists, "Scroll-Responsive Blur section should exist")

        // Scroll down to see more sections
        app.swipeUp()
        sleep(1)

        let gestureSection = app.staticTexts["Interactive Gesture Blur"]
        XCTAssertTrue(gestureSection.exists, "Interactive Gesture Blur section should exist")
    }

    func testDynamicBlurMaterialComparison() throws {
        // Navigate to Blur tab
        app.tabBars.buttons["Blur"].tap()
        sleep(1)

        // Scroll to material comparison section
        app.swipeUp()
        app.swipeUp()
        sleep(1)

        // Verify material intensity labels exist
        let materials = ["Ultra Thin", "Thin", "Regular", "Thick"]

        for material in materials {
            let label = app.staticTexts[material]

            // Scroll if needed to find the element
            if !label.isHittable {
                app.swipeUp()
                sleep(1)
            }

            XCTAssertTrue(label.exists, "\(material) material label should exist")
        }
    }

    func testDynamicBlurGesture() throws {
        // Navigate to Blur tab
        app.tabBars.buttons["Blur"].tap()
        sleep(1)

        // Scroll to gesture section
        app.swipeUp()
        sleep(1)

        // Find the "Drag Me" element
        let dragElement = app.staticTexts["Drag Me"]
        XCTAssertTrue(dragElement.exists, "Drag Me element should exist")

        // Get the element's coordinates
        let start = dragElement.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let end = dragElement.coordinate(withNormalizedOffset: CGVector(dx: 0.8, dy: 0.5))

        // Perform drag gesture
        start.press(forDuration: 0, thenDragTo: end)
        sleep(1)

        // The blur value should update (we can't test the exact value, but we verify no crash)
        XCTAssertTrue(dragElement.exists, "Element should still exist after drag")
    }

    // MARK: - Interactive Glass View Tests

    func testInteractiveButtons() throws {
        // Navigate to Interactive tab
        app.tabBars.buttons["Interactive"].tap()
        sleep(1)

        // Verify glass button section exists
        let buttonHeader = app.staticTexts["Glass Buttons"]
        XCTAssertTrue(buttonHeader.exists, "Glass Buttons header should exist")

        // Verify button labels exist
        let primaryButton = app.buttons["Primary Action"]
        let secondaryButton = app.buttons["Secondary Action"]
        let destructiveButton = app.buttons["Destructive Action"]

        XCTAssertTrue(primaryButton.exists, "Primary button should exist")
        XCTAssertTrue(secondaryButton.exists, "Secondary button should exist")
        XCTAssertTrue(destructiveButton.exists, "Destructive button should exist")

        // Test button interaction
        primaryButton.tap()
        sleep(0.5)

        // Button should still exist after tap (verifies no crash)
        XCTAssertTrue(primaryButton.exists, "Primary button should exist after tap")
    }

    func testInteractiveToggle() throws {
        // Navigate to Interactive tab
        app.tabBars.buttons["Interactive"].tap()
        sleep(1)

        // Scroll down to toggle section
        app.swipeUp()
        sleep(1)

        // Find the toggle
        let toggle = app.switches.firstMatch
        XCTAssertTrue(toggle.exists, "Toggle should exist")

        // Get initial state
        let initialValue = toggle.value as? String

        // Tap the toggle
        toggle.tap()
        sleep(1)

        // Verify state changed
        let newValue = toggle.value as? String
        XCTAssertNotEqual(initialValue, newValue, "Toggle state should change after tap")

        // Verify conditional content appears when toggle is on
        if toggle.value as? String == "1" {
            let enabledMessage = app.staticTexts["Feature is now enabled!"]
            XCTAssertTrue(enabledMessage.exists, "Enabled message should appear when toggle is on")
        }
    }

    func testInteractiveSlider() throws {
        // Navigate to Interactive tab
        app.tabBars.buttons["Interactive"].tap()
        sleep(1)

        // Scroll down to slider section
        app.swipeUp()
        app.swipeUp()
        sleep(1)

        // Find the slider
        let slider = app.sliders.firstMatch
        XCTAssertTrue(slider.exists, "Slider should exist")

        // Get initial value
        let initialValue = slider.value as? String

        // Adjust slider to 75%
        slider.adjust(toNormalizedSliderPosition: 0.75)
        sleep(1)

        // Verify value changed
        let newValue = slider.value as? String
        XCTAssertNotEqual(initialValue, newValue, "Slider value should change after adjustment")

        // Verify value display updates
        let valueLabel = app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'Value:'")).firstMatch
        XCTAssertTrue(valueLabel.exists, "Value label should exist")
    }

    func testInteractiveSegmentedTabs() throws {
        // Navigate to Interactive tab
        app.tabBars.buttons["Interactive"].tap()
        sleep(1)

        // Scroll down to segmented tabs section
        for _ in 0..<3 {
            app.swipeUp()
            sleep(0.5)
        }

        // Verify tab buttons exist
        let overviewTab = app.buttons["Overview"]
        let detailsTab = app.buttons["Details"]
        let moreTab = app.buttons["More"]

        XCTAssertTrue(overviewTab.exists, "Overview tab should exist")
        XCTAssertTrue(detailsTab.exists, "Details tab should exist")
        XCTAssertTrue(moreTab.exists, "More tab should exist")

        // Test tab switching
        detailsTab.tap()
        sleep(1)

        // Verify content changes
        let detailsContent = app.staticTexts["Details Content"]
        XCTAssertTrue(detailsContent.exists, "Details content should appear after tap")

        // Switch to another tab
        moreTab.tap()
        sleep(1)

        let moreContent = app.staticTexts["More Content"]
        XCTAssertTrue(moreContent.exists, "More content should appear after tap")
    }

    // MARK: - Color and Gradient View Tests

    func testColorSystemDisplay() throws {
        // Navigate to Colors tab
        app.tabBars.buttons["Colors"].tap()
        sleep(1)

        // Verify header exists
        let header = app.staticTexts["Liquid Glass Colors"]
        XCTAssertTrue(header.exists, "Colors header should exist")

        // Verify semantic colors section
        let semanticHeader = app.staticTexts["Semantic Colors"]
        XCTAssertTrue(semanticHeader.exists, "Semantic Colors section should exist")

        // Verify color labels exist
        let colors = ["Primary", "Secondary", "Success", "Warning", "Destructive"]

        for color in colors {
            let colorLabel = app.staticTexts[color]

            // Scroll if needed
            if !colorLabel.isHittable {
                app.swipeUp()
                sleep(0.5)
            }

            XCTAssertTrue(colorLabel.exists, "\(color) color label should exist")
        }
    }

    func testGradientExamples() throws {
        // Navigate to Colors tab
        app.tabBars.buttons["Colors"].tap()
        sleep(1)

        // Scroll down to gradients section
        app.swipeUp()
        app.swipeUp()
        sleep(1)

        // Verify gradient section exists
        let gradientHeader = app.staticTexts["Gradient Systems"]
        XCTAssertTrue(gradientHeader.exists, "Gradient Systems section should exist")

        // Verify gradient types
        let gradientTypes = ["Linear Gradient", "Radial Gradient", "Angular Gradient"]

        for gradientType in gradientTypes {
            let label = app.staticTexts[gradientType]

            if !label.isHittable {
                app.swipeUp()
                sleep(0.5)
            }

            XCTAssertTrue(label.exists, "\(gradientType) should exist")
        }
    }

    func testOpacityVariations() throws {
        // Navigate to Colors tab
        app.tabBars.buttons["Colors"].tap()
        sleep(1)

        // Scroll to opacity section
        for _ in 0..<4 {
            app.swipeUp()
            sleep(0.5)
        }

        // Verify opacity section exists
        let opacityHeader = app.staticTexts["Opacity Variations"]
        XCTAssertTrue(opacityHeader.exists, "Opacity Variations section should exist")

        // Verify opacity labels exist
        let opacities = ["100%", "80%", "60%", "40%", "20%"]

        for opacity in opacities {
            let label = app.staticTexts.matching(NSPredicate(format: "label CONTAINS '\(opacity)'")).firstMatch

            if !label.isHittable {
                app.swipeUp()
                sleep(0.5)
            }

            XCTAssertTrue(label.exists, "Opacity \(opacity) should exist")
        }
    }

    func testColorModeIndicator() throws {
        // Navigate to Colors tab
        app.tabBars.buttons["Colors"].tap()
        sleep(1)

        // Scroll to color mode section
        for _ in 0..<5 {
            app.swipeUp()
            sleep(0.5)
        }

        // Verify color mode section exists
        let modeHeader = app.staticTexts["Current Color Mode"]
        XCTAssertTrue(modeHeader.exists, "Current Color Mode section should exist")

        // Verify mode indicator exists (either Light or Dark)
        let lightMode = app.staticTexts["Light Mode"]
        let darkMode = app.staticTexts["Dark Mode"]

        XCTAssertTrue(lightMode.exists || darkMode.exists, "Color mode indicator should exist")
    }

    // MARK: - Performance Tests

    func testScrollPerformance() throws {
        // Test scroll performance in Glass Components view
        app.tabBars.buttons["Glass"].tap()
        sleep(1)

        measure {
            // Perform multiple scroll actions
            for _ in 0..<5 {
                app.swipeUp()
                app.swipeDown()
            }
        }
    }

    func testTabSwitchingPerformance() throws {
        measure {
            // Rapidly switch between tabs
            let tabs = ["Glass", "Adaptive", "Blur", "Interactive", "Colors"]

            for tabName in tabs {
                app.tabBars.buttons[tabName].tap()
            }
        }
    }

    // MARK: - Accessibility Tests

    func testAccessibilityLabels() throws {
        // Verify that key UI elements have accessibility labels
        app.tabBars.buttons["Glass"].tap()
        sleep(1)

        // Tab bar buttons should be accessible
        let tabs = ["Glass", "Adaptive", "Blur", "Interactive", "Colors"]

        for tabName in tabs {
            let tab = app.tabBars.buttons[tabName]
            XCTAssertTrue(tab.isEnabled, "\(tabName) tab should be accessible")
        }
    }

    func testVoiceOverCompatibility() throws {
        // Test that VoiceOver can navigate through the app
        // This is a basic test - full VoiceOver testing requires device testing

        app.tabBars.buttons["Interactive"].tap()
        sleep(1)

        let button = app.buttons["Primary Action"]
        XCTAssertTrue(button.isEnabled, "Interactive buttons should be accessible")
    }

    // MARK: - Edge Case Tests

    func testRapidTabSwitching() throws {
        // Test that rapid tab switching doesn't cause crashes
        for _ in 0..<10 {
            app.tabBars.buttons["Glass"].tap()
            app.tabBars.buttons["Adaptive"].tap()
            app.tabBars.buttons["Blur"].tap()
            app.tabBars.buttons["Interactive"].tap()
            app.tabBars.buttons["Colors"].tap()
        }

        // App should still be responsive
        XCTAssertTrue(app.tabBars.firstMatch.exists, "App should remain functional after rapid switching")
    }

    func testScrollToExtremes() throws {
        // Test scrolling to extreme positions
        app.tabBars.buttons["Glass"].tap()
        sleep(1)

        let scrollView = app.scrollViews.firstMatch

        // Scroll to bottom
        for _ in 0..<10 {
            scrollView.swipeUp()
        }

        sleep(1)

        // Scroll back to top
        for _ in 0..<10 {
            scrollView.swipeDown()
        }

        // Verify app is still functional
        XCTAssertTrue(scrollView.exists, "Scroll view should still exist")
    }

    // MARK: - Orientation Tests

    func testLandscapeOrientation() throws {
        // Test app behavior in landscape mode
        XCUIDevice.shared.orientation = .landscapeLeft
        sleep(2)

        // Verify app adapts to landscape
        app.tabBars.buttons["Adaptive"].tap()
        sleep(1)

        // App should still function in landscape
        XCTAssertTrue(app.exists, "App should function in landscape mode")

        // Restore portrait orientation
        XCUIDevice.shared.orientation = .portrait
        sleep(2)
    }

    func testOrientationChanges() throws {
        // Test multiple orientation changes
        let orientations: [UIDeviceOrientation] = [.portrait, .landscapeLeft, .landscapeRight, .portrait]

        for orientation in orientations {
            XCUIDevice.shared.orientation = orientation
            sleep(2)

            // Verify app remains functional
            XCTAssertTrue(app.tabBars.firstMatch.exists, "Tab bar should exist in \(orientation)")
        }
    }

    // MARK: - Screenshot Tests

    func testCaptureScreenshots() throws {
        // Capture screenshots for each main view
        let tabs = [
            "Glass",
            "Adaptive",
            "Blur",
            "Interactive",
            "Colors"
        ]

        for tabName in tabs {
            // Navigate to tab
            app.tabBars.buttons[tabName].tap()
            sleep(2)

            // Capture screenshot
            let screenshot = app.screenshot()
            let attachment = XCTAttachment(screenshot: screenshot)
            attachment.name = "\(tabName)_Tab_Screenshot"
            attachment.lifetime = .keepAlways
            add(attachment)
        }
    }
}
