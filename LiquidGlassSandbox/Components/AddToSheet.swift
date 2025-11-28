import SwiftUI

// MARK: - Design System Type Alias
private typealias DS = DesignSystemGlobal

// MARK: - =============================================
// MARK: - ADD TO OPTION MODEL
// MARK: - =============================================

/// Types of destinations for adding products
enum AddToDestinationType: Identifiable, CaseIterable {
    case list
    case project
    
    var id: String {
        switch self {
        case .list: return "list"
        case .project: return "project"
        }
    }
    
    var title: String {
        switch self {
        case .list: return "List"
        case .project: return "Project"
        }
    }
    
    var description: String {
        switch self {
        case .list:
            return "Organize and save items for future reference or repeat purchases. Ideal for creating product collections for different tasks or jobs."
        case .project:
            return "Group items, track progress, and manage tasks for a specific job. Projects help you oversee everything from materials to costs, all in one place."
        }
    }
}

// MARK: - =============================================
// MARK: - ADD TO SHEET VIEW
// MARK: - =============================================

/// A bottom sheet for adding products to lists or projects
struct AddToSheet: View {
    
    // MARK: - Bindings
    @Binding var isPresented: Bool
    let product: Product
    @State private var selectedOption: AddToDestinationType? = nil
    var onOptionSelected: ((AddToDestinationType) -> Void)? = nil
    
    // MARK: - Colors from Design System
    private let textColor = DS.TextOnSurfaceColorPrimary
    private let secondaryTextColor = DS.TextOnSurfaceColorSecondary
    private let backgroundColor = DS.GreigeGreige050
    private let cardBackground = DS.BackgroundContainerColorWhite
    private let closeButtonBackground = DS.GreigeGreige100
    private let indicatorColor = DS.GreigeGreige400
    private let selectedBorderColor = DS.BorderButtonColorAccent
    private let defaultBorderColor = Color.clear
    
    // MARK: - Sizing from Design System
    private let closeButtonSize = DS.Spacing11         // 44pt
    private let closeIconSize = DS.FontFontSizeBodyLg  // 18pt
    private let titleSize = DS.FontFontSizeBodyLg      // 18pt
    private let productImageSize = DS.Spacing16        // 64pt
    private let optionTitleSize = DS.FontFontSizeBodyMd    // 16pt
    private let optionDescSize = DS.FontFontSizeBodySm     // 14pt
    private let radioSize = DS.FontFontSizeBodyXl      // 20pt
    private let cardCornerRadius = DS.BorderRadius3xl  // 16pt
    private let borderWidth = DS.BorderWidthSm         // 2pt
    
    // MARK: - Spacing from Design System
    private let horizontalPadding = DS.Spacing4        // 16pt
    private let verticalPadding = DS.Spacing3          // 12pt
    private let sectionSpacing = DS.Spacing4           // 16pt
    private let cardSpacing = DS.Spacing3              // 12pt
    private let cardPadding = DS.Spacing4              // 16pt
    private let headerBottomPadding = DS.Spacing5      // 20pt
    private let indicatorWidth = DS.Spacing9           // 36pt
    private let indicatorHeight = DS.Spacing1          // 4pt
    private let indicatorTopPadding = DS.Spacing2      // 8pt
    private let productInfoSpacing = DS.Spacing3       // 12pt
    
    var body: some View {
        VStack(spacing: DS.Spacing0) {
            // Drag indicator
            dragIndicator
            
            // Header with title and close button
            header
            
            // Product preview
            productPreview
            
            // Add to options
            optionsList
            
            Spacer()
        }
        .background(backgroundColor)
    }
    
    // MARK: - Drag Indicator
    private var dragIndicator: some View {
        RoundedRectangle(cornerRadius: DS.BorderRadius3xl)
            .fill(indicatorColor)
            .frame(width: indicatorWidth, height: indicatorHeight)
            .padding(.top, indicatorTopPadding)
    }
    
    // MARK: - Header
    private var header: some View {
        HStack {
            // Empty spacer to balance the close button
            Spacer()
                .frame(width: closeButtonSize)
            
            Spacer()
            
            // Centered title
            Text("Add To…")
                .font(.system(size: titleSize, weight: .semibold))
                .foregroundStyle(textColor)
            
            Spacer()
            
            // Close button
            closeButton
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.top, verticalPadding)
        .padding(.bottom, headerBottomPadding)
    }
    
    // MARK: - Close Button
    private var closeButton: some View {
        Button(action: {
            isPresented = false
        }) {
            Image(systemName: "xmark")
                .font(.system(size: closeIconSize, weight: .medium))
                .foregroundStyle(textColor)
                .frame(width: closeButtonSize, height: closeButtonSize)
                .background(
                    Circle()
                        .fill(closeButtonBackground)
                )
        }
    }
    
    // MARK: - Product Preview
    private var productPreview: some View {
        HStack(alignment: .top, spacing: productInfoSpacing) {
            // Product thumbnail
            Image(product.heroImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: productImageSize, height: productImageSize)
            
            // Product title
            VStack(alignment: .leading, spacing: DS.Spacing1) {
                Text(product.brand)
                    .font(.system(size: DS.FontFontSizeBodySm, weight: .bold))
                    .foregroundStyle(textColor)
                +
                Text(" ")
                +
                Text(product.name)
                    .font(.system(size: DS.FontFontSizeBodySm, weight: .regular))
                    .foregroundStyle(textColor)
            }
            .lineLimit(3)
            
            Spacer()
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.bottom, sectionSpacing)
    }
    
    // MARK: - Options List
    private var optionsList: some View {
        VStack(spacing: cardSpacing) {
            ForEach(AddToDestinationType.allCases) { option in
                optionCard(for: option)
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
    
    // MARK: - Option Card
    private func optionCard(for option: AddToDestinationType) -> some View {
        let isSelected = selectedOption == option
        
        return Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedOption = option
            }
            onOptionSelected?(option)
        }) {
            HStack(alignment: .top, spacing: cardSpacing) {
                // Radio button
                radioButton(isSelected: isSelected)
                
                // Option content
                VStack(alignment: .leading, spacing: DS.Spacing1) {
                    Text(option.title)
                        .font(.system(size: optionTitleSize, weight: .medium))
                        .foregroundStyle(textColor)
                    
                    Text(option.description)
                        .font(.system(size: optionDescSize, weight: .regular))
                        .foregroundStyle(secondaryTextColor)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
            }
            .padding(cardPadding)
            .background(
                RoundedRectangle(cornerRadius: cardCornerRadius)
                    .fill(cardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: cardCornerRadius)
                            .stroke(
                                isSelected ? selectedBorderColor : defaultBorderColor,
                                lineWidth: borderWidth
                            )
                    )
            )
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Radio Button
    private func radioButton(isSelected: Bool) -> some View {
        Circle()
            .stroke(isSelected ? selectedBorderColor : DS.GreigeGreige300, lineWidth: isSelected ? borderWidth : DS.BorderWidthXs)
            .frame(width: radioSize, height: radioSize)
            .overlay {
                if isSelected {
                    Circle()
                        .fill(selectedBorderColor)
                        .frame(width: radioSize - 8, height: radioSize - 8)
                }
            }
    }
}

// MARK: - =============================================
// MARK: - SHEET PRESENTATION MODIFIER
// MARK: - =============================================

/// A view modifier to present the AddToSheet
struct AddToSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    let product: Product
    var onOptionSelected: ((AddToDestinationType) -> Void)? = nil
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                AddToSheet(
                    isPresented: $isPresented,
                    product: product,
                    onOptionSelected: onOptionSelected
                )
                .presentationDetents([.medium])
                .presentationDragIndicator(.hidden)
                .presentationBackground(DesignSystemGlobal.GreigeGreige050)
            }
    }
}

// MARK: - View Extension
extension View {
    func addToSheet(isPresented: Binding<Bool>, product: Product, onOptionSelected: ((AddToDestinationType) -> Void)? = nil) -> some View {
        modifier(AddToSheetModifier(isPresented: isPresented, product: product, onOptionSelected: onOptionSelected))
    }
}

// MARK: - =============================================
// MARK: - PREVIEWS
// MARK: - =============================================

// Sample product for preview
private let sampleProduct = Product(
    id: "SORBUS-001",
    brand: "Sorbus",
    name: "3-Pack Floating Shelves, 24 in. W x 9 in. D Walnut Decorative Wall Shelves with Invisible Brackets",
    modelNumber: "SORBUS-001",
    heroImage: "shelves_product",
    currentPrice: 49.99,
    rating: 4.2,
    reviewCount: 156
)

#Preview("Add To Sheet") {
    AddToSheet(isPresented: .constant(true), product: sampleProduct)
}

#Preview("Add To Sheet - Full Context") {
    struct PreviewWrapper: View {
        @State private var showSheet = false
        
        var body: some View {
            ZStack {
                DesignSystemGlobal.BackgroundSurfaceColorGreige
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Button("Show Add To Sheet") {
                        showSheet = true
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(DesignSystemGlobal.BackgroundButtonColorBrandFilledDefault)
                    
                    Spacer()
                }
            }
            .addToSheet(isPresented: $showSheet, product: sampleProduct) { option in
                print("Selected: \(option.title)")
            }
        }
    }
    
    return PreviewWrapper()
}
