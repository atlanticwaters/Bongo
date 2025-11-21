#!/bin/bash

#
# run_tests.sh
# Liquid Glass Sandbox Test Runner Script
#
# This script provides convenient commands to run different test suites
# for the Liquid Glass Sandbox iOS application.
#
# Usage:
#   ./run_tests.sh [option]
#
# Options:
#   all         - Run all tests (unit + UI) on iPhone simulator
#   unit        - Run unit tests only (fast)
#   ui          - Run UI tests only
#   iphone      - Run all tests on iPhone 15 Pro
#   ipad        - Run all tests on iPad Pro
#   coverage    - Run tests with code coverage
#   clean       - Clean build and run all tests
#   help        - Show this help message
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="LiquidGlassSandbox"
SCHEME="LiquidGlassSandbox"
PROJECT_FILE="${PROJECT_NAME}.xcodeproj"

# Default destinations
IPHONE_DESTINATION="platform=iOS Simulator,name=iPhone 15 Pro,OS=18.0"
IPAD_DESTINATION="platform=iOS Simulator,name=iPad Pro (12.9-inch),OS=18.0"

# Print colored message
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Print section header
print_header() {
    echo ""
    print_message "$BLUE" "================================================"
    print_message "$BLUE" "$1"
    print_message "$BLUE" "================================================"
    echo ""
}

# Check if Xcode project exists
check_project() {
    if [ ! -d "$PROJECT_FILE" ]; then
        print_message "$RED" "Error: $PROJECT_FILE not found!"
        print_message "$YELLOW" "Make sure you're in the project directory."
        exit 1
    fi
}

# Clean build folder
clean_build() {
    print_header "Cleaning Build Folder"
    xcodebuild clean \
        -project "$PROJECT_FILE" \
        -scheme "$SCHEME"
    print_message "$GREEN" "✓ Build folder cleaned"
}

# Run unit tests
run_unit_tests() {
    local destination=${1:-$IPHONE_DESTINATION}

    print_header "Running Unit Tests"
    print_message "$YELLOW" "Destination: $destination"

    xcodebuild test \
        -project "$PROJECT_FILE" \
        -scheme "$SCHEME" \
        -destination "$destination" \
        -only-testing:"${PROJECT_NAME}Tests" \
        | xcpretty || true

    if [ ${PIPESTATUS[0]} -eq 0 ]; then
        print_message "$GREEN" "✓ Unit tests passed!"
    else
        print_message "$RED" "✗ Unit tests failed!"
        exit 1
    fi
}

# Run UI tests
run_ui_tests() {
    local destination=${1:-$IPHONE_DESTINATION}

    print_header "Running UI Tests"
    print_message "$YELLOW" "Destination: $destination"

    xcodebuild test \
        -project "$PROJECT_FILE" \
        -scheme "$SCHEME" \
        -destination "$destination" \
        -only-testing:"${PROJECT_NAME}UITests" \
        | xcpretty || true

    if [ ${PIPESTATUS[0]} -eq 0 ]; then
        print_message "$GREEN" "✓ UI tests passed!"
    else
        print_message "$RED" "✗ UI tests failed!"
        exit 1
    fi
}

# Run all tests
run_all_tests() {
    local destination=${1:-$IPHONE_DESTINATION}

    print_header "Running All Tests"
    print_message "$YELLOW" "Destination: $destination"

    xcodebuild test \
        -project "$PROJECT_FILE" \
        -scheme "$SCHEME" \
        -destination "$destination" \
        | xcpretty || true

    if [ ${PIPESTATUS[0]} -eq 0 ]; then
        print_message "$GREEN" "✓ All tests passed!"
    else
        print_message "$RED" "✗ Some tests failed!"
        exit 1
    fi
}

# Run tests with code coverage
run_with_coverage() {
    local destination=${1:-$IPHONE_DESTINATION}

    print_header "Running Tests with Code Coverage"
    print_message "$YELLOW" "Destination: $destination"

    xcodebuild test \
        -project "$PROJECT_FILE" \
        -scheme "$SCHEME" \
        -destination "$destination" \
        -enableCodeCoverage YES \
        -resultBundlePath ./TestResults \
        | xcpretty || true

    if [ ${PIPESTATUS[0]} -eq 0 ]; then
        print_message "$GREEN" "✓ Tests passed with coverage!"
        print_message "$BLUE" "Coverage results saved to: ./TestResults"
    else
        print_message "$RED" "✗ Tests failed!"
        exit 1
    fi
}

# Run tests on multiple devices
run_multi_device() {
    print_header "Running Tests on Multiple Devices"

    print_message "$YELLOW" "Testing on iPhone 15 Pro..."
    run_all_tests "$IPHONE_DESTINATION"

    print_message "$YELLOW" "Testing on iPad Pro..."
    run_all_tests "$IPAD_DESTINATION"

    print_message "$GREEN" "✓ All multi-device tests completed!"
}

# Show help
show_help() {
    print_header "Liquid Glass Sandbox Test Runner"

    echo "Usage: ./run_tests.sh [option]"
    echo ""
    echo "Options:"
    echo "  all         - Run all tests (unit + UI) on iPhone simulator"
    echo "  unit        - Run unit tests only (fast, ~10 seconds)"
    echo "  ui          - Run UI tests only (~3 minutes)"
    echo "  iphone      - Run all tests on iPhone 15 Pro"
    echo "  ipad        - Run all tests on iPad Pro"
    echo "  multi       - Run tests on both iPhone and iPad"
    echo "  coverage    - Run tests with code coverage report"
    echo "  clean       - Clean build and run all tests"
    echo "  help        - Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./run_tests.sh unit       # Quick unit test run"
    echo "  ./run_tests.sh coverage   # Full test with coverage"
    echo "  ./run_tests.sh clean      # Clean build and test"
    echo ""
}

# Check for xcpretty (optional but recommended)
check_xcpretty() {
    if ! command -v xcpretty &> /dev/null; then
        print_message "$YELLOW" "Note: xcpretty not found. Install it for better output:"
        print_message "$YELLOW" "  gem install xcpretty"
        echo ""
    fi
}

# Main script logic
main() {
    check_project
    check_xcpretty

    case "${1:-all}" in
        all)
            run_all_tests "$IPHONE_DESTINATION"
            ;;
        unit)
            run_unit_tests "$IPHONE_DESTINATION"
            ;;
        ui)
            run_ui_tests "$IPHONE_DESTINATION"
            ;;
        iphone)
            run_all_tests "$IPHONE_DESTINATION"
            ;;
        ipad)
            run_all_tests "$IPAD_DESTINATION"
            ;;
        multi)
            run_multi_device
            ;;
        coverage)
            run_with_coverage "$IPHONE_DESTINATION"
            ;;
        clean)
            clean_build
            run_all_tests "$IPHONE_DESTINATION"
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            print_message "$RED" "Error: Unknown option '$1'"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
