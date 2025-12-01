import SwiftUI

// MARK: - ButtondemoView

enum ButtondemoState: String, CaseIterable {
    case `default` = "Default"
    case active_pressed = "Active / Pressed"
    case loading = "Loading"
    case success = "Success"
    case inactive = "Inactive"
}

enum ButtondemoStyle: String, CaseIterable {
    case orange_filled = "Orange Filled"
    case orange_outlined = "Orange Outlined"
}

struct ButtondemoView: View {
    var label: String
    var action: () -> Void
    var state: ButtondemoState = .`default`
    var size: DesignSystemGlobal.ButtonSize = .md
    var style: ButtondemoStyle = .orange_filled
    var width: DesignSystemGlobal.ButtonWidth = .fitContent
    var hasBorder: Bool = true  // ← ADDED
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: size.fontSize, weight: fontWeight))
                .foregroundStyle(textColor)
                .frame(maxWidth: width == .fullWidth ? .infinity : nil)
        }
        .padding(.horizontal, size.horizontalPadding)
        .frame(height: size.height)
        .background(backgroundColor)
        .cornerRadius(size.cornerRadius)
        .overlay(
            Group {
                if hasBorder {  // ← CHANGED
                    RoundedRectangle(cornerRadius: size.cornerRadius)
                        .stroke(borderColor, lineWidth: size.borderWidth)
                }
            }
        )
        .disabled(state == .inactive)
    }

    private var backgroundColor: Color {
        switch (style, state) {
        case (.orange_outlined, _):
            return DesignSystemGlobal.BackgroundContainerColorWhite
        case (.orange_filled, .`default`):
            return colorScheme == .dark ? DesignSystemDarkLarge.BrandBrand300 : DesignSystemLightLarge.BrandBrand300
        case (.orange_filled, .active_pressed):
            return colorScheme == .dark ? DesignSystemDarkLarge.BrandBrand300 : DesignSystemLightLarge.BrandBrand300
        case (.orange_filled, .loading):
            return colorScheme == .dark ? DesignSystemDarkLarge.BrandBrand300 : DesignSystemLightLarge.BrandBrand300
        case (.orange_filled, .success):
            return colorScheme == .dark ? DesignSystemDarkLarge.BrandBrand300 : DesignSystemLightLarge.BrandBrand300
        case (.orange_filled, .inactive):
            return colorScheme == .dark ? DesignSystemDarkLarge.BackgroundButtonColorBrandFilledInactive : DesignSystemLightLarge.BackgroundButtonColorBrandFilledInactive
        }
    }

    private var textColor: Color {
        switch (style, state) {
        case (.orange_outlined, .inactive):
            return colorScheme == .dark ? DesignSystemDarkLarge.TextButtonColorOrangeOutlineInactive : DesignSystemLightLarge.TextButtonColorOrangeOutlineInactive
        case (.orange_outlined, _):
            return colorScheme == .dark ? DesignSystemDarkLarge.TextButtonColorOrangeOutlineDefault : DesignSystemLightLarge.TextButtonColorOrangeOutlineDefault
        case (.orange_filled, .`default`):
            return colorScheme == .dark ? DesignSystemDarkLarge.TextButtonColorOrangeFilledDefault : DesignSystemLightLarge.TextButtonColorOrangeFilledDefault
        case (.orange_filled, .active_pressed):
            return colorScheme == .dark ? DesignSystemDarkLarge.TextButtonColorOrangeFilledDefault : DesignSystemLightLarge.TextButtonColorOrangeFilledDefault
        case (.orange_filled, .loading):
            return colorScheme == .dark ? DesignSystemDarkLarge.TextButtonColorOrangeFilledDefault : DesignSystemLightLarge.TextButtonColorOrangeFilledDefault
        case (.orange_filled, .success):
            return colorScheme == .dark ? DesignSystemDarkLarge.TextButtonColorOrangeFilledDefault : DesignSystemLightLarge.TextButtonColorOrangeFilledDefault
        case (.orange_filled, .inactive):
            return colorScheme == .dark ? DesignSystemDarkLarge.TextButtonColorOrangeFilledInactive : DesignSystemLightLarge.TextButtonColorOrangeFilledInactive
        }
    }

    private var borderColor: Color {
        switch (style, state) {
        case (.orange_outlined, .inactive):
            return colorScheme == .dark ? DesignSystemDarkLarge.BorderButtonColorOrangeOutlineInactive : DesignSystemLightLarge.BorderButtonColorOrangeOutlineInactive
        case (.orange_outlined, _):
            return colorScheme == .dark ? DesignSystemDarkLarge.BorderButtonColorOrangeOutlineDefault : DesignSystemLightLarge.BorderButtonColorOrangeOutlineDefault
        case (.orange_filled, .`default`):
            return colorScheme == .dark ? DesignSystemDarkLarge.BorderButtonColorDefault : DesignSystemLightLarge.BorderButtonColorDefault
        case (.orange_filled, .active_pressed):
            return colorScheme == .dark ? DesignSystemDarkLarge.BorderButtonColorFocus : DesignSystemLightLarge.BorderButtonColorFocus
        case (.orange_filled, .loading):
            return colorScheme == .dark ? DesignSystemDarkLarge.BorderButtonColorDefault : DesignSystemLightLarge.BorderButtonColorDefault
        case (.orange_filled, .success):
            return colorScheme == .dark ? DesignSystemDarkLarge.BorderButtonColorDefault : DesignSystemLightLarge.BorderButtonColorDefault
        case (.orange_filled, .inactive):
            return colorScheme == .dark ? DesignSystemDarkLarge.BorderButtonColorFocus : DesignSystemLightLarge.BorderButtonColorFocus
        }
    }

    private var fontWeight: Font.Weight {
        .bold
    }

    private var borderWidth: CGFloat {
        DesignSystemGlobal.BorderWidthXs
    }
}

// ← REMOVED: ButtondemoSize enum (no longer needed)
// ← REMOVED: private var cornerRadius (now from size token)
// ← REMOVED: private var fontSize (now from size token)
// ← REMOVED: private var horizontalPadding (now from size token)
// ← REMOVED: private var verticalPadding (replaced by fixed height)

#Preview("All Sizes") {
    VStack(spacing: DesignSystemGlobal.Spacing4) {
        ButtondemoView(label: "Small", action: {}, size: .sm)
        ButtondemoView(label: "Medium", action: {}, size: .md)
        ButtondemoView(label: "Large", action: {}, size: .lg)
        ButtondemoView(label: "Extra Large", action: {}, size: .xl)
        ButtondemoView(label: "2XL", action: {}, size: .xxl)
    }
    .padding()
}
#Preview("Full Width") {
    VStack(spacing: DesignSystemGlobal.Spacing4) {
        ButtondemoView(label: "Full Width Medium", action: {}, size: .md, width: .fullWidth)
        ButtondemoView(label: "Full Width Large", action: {}, size: .lg, width: .fullWidth)
    }
    .padding()
}

#Preview("States") {
    VStack(spacing: DesignSystemGlobal.Spacing4) {
        ButtondemoView(label: "Default", action: {}, state: .`default`)
        ButtondemoView(label: "Active / Pressed", action: {}, state: .active_pressed)
        ButtondemoView(label: "Loading", action: {}, state: .loading)
        ButtondemoView(label: "Success", action: {}, state: .success)
        ButtondemoView(label: "Inactive", action: {}, state: .inactive)
    }
    .padding()
}
