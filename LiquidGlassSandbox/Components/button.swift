import SwiftUI

// MARK: - ButtondemoView

enum ButtondemoSize: String, CaseIterable {
    case sm = "Sm"
}

enum ButtondemoStyle: String, CaseIterable {
    case orange_filled = "Orange Filled"
}

enum ButtondemoState: String, CaseIterable {
    case `default` = "Default"
    case active_pressed = "Active / Pressed"
    case loading = "Loading"
    case success = "Success"
    case inactive = "Inactive"
}

struct ButtondemoView: View {
    var label: String
    var action: () -> Void
    var state: ButtondemoState = .`default`
    var size: ButtondemoSize = .sm
    var type: ButtondemoStyle = .orange_filled
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: fontSize, weight: fontWeight))
                .foregroundStyle(textColor)
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: borderWidth)
        )
        .disabled(state == .inactive || state == .disabled)
    }

    private var backgroundColor: Color {
        switch state {
        case .`default`: return DesignSystemGlobal.BrandBrand300
        case .active_pressed: return DesignSystemGlobal.BrandBrand300
        case .loading: return DesignSystemGlobal.BrandBrand300
        case .success: return DesignSystemGlobal.BrandBrand300
        case .inactive: return DesignSystemGlobal.BackgroundButtonColorBrandFilledInactive
        }
    }

    private var textColor: Color {
        switch state {
        case .`default`: return DesignSystemGlobal.TextButtonColorOrangeFilledDefault
        case .active_pressed: return DesignSystemGlobal.TextButtonColorOrangeFilledDefault
        case .loading: return DesignSystemGlobal.TextButtonColorBrandFilledDefault
        case .success: return DesignSystemGlobal.TextButtonColorBrandFilledDefault
        case .inactive: return DesignSystemGlobal.TextButtonColorBrandFilledPressed
        }
    }

    private var borderColor: Color {
        switch state {
        case .`default`: return DesignSystemGlobal.BorderButtonColorDefault
        case .active_pressed: return DesignSystemGlobal.BorderButtonColorFocus
        case .loading: return DesignSystemGlobal.BorderButtonColorDefault
        case .success: return DesignSystemGlobal.BorderButtonColorDefault
        case .inactive: return DesignSystemGlobal.BorderButtonColorFocus
        }
    }

    private var cornerRadius: CGFloat {
        DesignSystemGlobal.BorderRadiusLg
    }

    private var fontSize: CGFloat {
        DesignSystemGlobal.FontFontSizeBodySm
    }

    private var fontWeight: Font.Weight {
        .bold
    }

    private var horizontalPadding: CGFloat {
        67
    }

    private var verticalPadding: CGFloat {
        DesignSystemGlobal.Spacing10
    }

    private var borderWidth: CGFloat {
        DesignSystemGlobal.BorderWidthXs
    }
}

#Preview {
    VStack(spacing: DesignSystemGlobal.Spacing4) {
        ButtondemoView(label: "Default", action: {}, state: .`default`)
        ButtondemoView(label: "Active / Pressed", action: {}, state: .active_pressed)
        ButtondemoView(label: "Loading", action: {}, state: .loading)
        ButtondemoView(label: "Success", action: {}, state: .success)
        ButtondemoView(label: "Inactive", action: {}, state: .inactive)
    }
    .padding()
}