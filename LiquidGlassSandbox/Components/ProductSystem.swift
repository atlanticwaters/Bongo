import SwiftUI

// MARK: - Design System Type Alias
private typealias DS = DesignSystemGlobal

// MARK: - =============================================
// MARK: - DATA MODELS
// MARK: - =============================================

/// Model representing product data
struct Product: Identifiable {
    let id: String
    let brand: String
    let name: String
    let modelNumber: String
    let heroImage: String
    var thumbnailImages: [String] = []
    var additionalImageCount: Int = 0
    let currentPrice: Decimal
    var originalPrice: Decimal? = nil
    var savingsPercentage: Int? = nil
    let rating: Double
    let reviewCount: Int
    var isExclusive: Bool = false
    var promotionalBadge: String? = nil
    var pickupInfo: FulfillmentInfo? = nil
    var deliveryInfo: FulfillmentInfo? = nil
    var fasterDeliveryInfo: FulfillmentInfo? = nil
}

/// Model for fulfillment information
struct FulfillmentInfo {
    let primaryValue: String
    var secondaryValue: String? = nil
    var tertiaryValue: String? = nil
    var highlightedText: String? = nil
}

// MARK: - =============================================
// MARK: - PRODUCT BADGE COMPONENT
// MARK: - =============================================

enum ProductBadgeType {
    case exclusive
    case promotional
    
    var backgroundColor: Color {
        switch self {
        case .exclusive: return DS.BackgroundAccentColorGreen
        case .promotional: return .clear
        }
    }
    
    var textColor: Color {
        switch self {
        case .exclusive: return DS.BackgroundContainerColorWhite
        case .promotional: return DS.BackgroundAccentColorRed
        }
    }
}

struct ProductBadge: View {
    let text: String
    let type: ProductBadgeType
    
    private let fontSize = DS.FontFontSizeBodyXs
    private let horizontalPadding = DS.Spacing2
    private let verticalPadding = DS.Spacing1
    private let cornerRadius = DS.BorderRadiusLg
    
    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .semibold))
            .foregroundStyle(type.textColor)
            .padding(.horizontal, type == .exclusive ? horizontalPadding : 0)
            .padding(.vertical, type == .exclusive ? verticalPadding : 0)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(type.backgroundColor)
            )
    }
}

// MARK: - =============================================
// MARK: - PRODUCT IMAGE COMPONENT
// MARK: - =============================================

struct ProductImageView: View {
    @State private var currentHeroImage: String
    let thumbnails: [String]
    var additionalCount: Int = 0
    var onHeroTap: (() -> Void)? = nil
    
    init(heroImage: String, thumbnails: [String] = [], additionalCount: Int = 0, onHeroTap: (() -> Void)? = nil) {
        self._currentHeroImage = State(initialValue: heroImage)
        self.thumbnails = thumbnails
        self.additionalCount = additionalCount
        self.onHeroTap = onHeroTap
    }
    
    private let thumbnailSize = DS.Spacing8
    private let thumbnailSpacing = DS.Spacing2
    private let thumbnailCornerRadius = DS.BorderRadiusLg
    private let borderColor = DS.BorderOnContainerDefault
    private let selectedBorderColor = DS.BorderButtonColorAccent
    private let borderWidth = DS.BorderWidthXs
    private let selectedBorderWidth = DS.BorderWidthSm
    
    var body: some View {
        VStack(spacing: thumbnailSpacing) {
            heroImageView
            if !thumbnails.isEmpty {
                thumbnailStrip
            }
        }
    }
    
    private var heroImageView: some View {
        Image(currentHeroImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .onTapGesture { onHeroTap?() }
    }
    
    private var thumbnailStrip: some View {
        HStack(spacing: thumbnailSpacing) {
            ForEach(thumbnails.prefix(3), id: \.self) { thumbnail in
                let isSelected = thumbnail == currentHeroImage
                Image(thumbnail)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: thumbnailSize, height: thumbnailSize)
                    .clipShape(RoundedRectangle(cornerRadius: thumbnailCornerRadius))
                    .overlay(
                        RoundedRectangle(cornerRadius: thumbnailCornerRadius)
                            .stroke(isSelected ? selectedBorderColor : borderColor,
                                    lineWidth: isSelected ? selectedBorderWidth : borderWidth)
                    )
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            currentHeroImage = thumbnail
                        }
                    }
            }
            if additionalCount > 0 {
                Text("+\(additionalCount)")
                    .font(.system(size: DS.FontFontSizeBodyXs, weight: .medium))
                    .foregroundStyle(DS.TextOnSurfaceColorSecondary)
                    .frame(width: thumbnailSize, height: thumbnailSize)
            }
        }
    }
}

// MARK: - =============================================
// MARK: - PRODUCT TITLE COMPONENT
// MARK: - =============================================

struct ProductTitle: View {
    let brand: String
    let name: String
    var modelNumber: String? = nil
    
    private let brandSize = DS.FontFontSizeBodySm
    private let nameSize = DS.FontFontSizeBodySm
    private let modelSize = DS.FontFontSizeBodyXs
    private let spacing = DS.Spacing1
    private let brandColor = DS.TextOnSurfaceColorPrimary
    private let nameColor = DS.TextOnSurfaceColorSecondary
    private let modelColor = DS.TextOnSurfaceColorTertiary
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text(brand)
                .font(.system(size: brandSize, weight: .bold))
                .foregroundStyle(brandColor)
            Text(name)
                .font(.system(size: nameSize, weight: .regular))
                .foregroundStyle(nameColor)
                .lineLimit(2)
            if let model = modelNumber {
                Text("Model: \(model)")
                    .font(.system(size: modelSize, weight: .regular))
                    .foregroundStyle(modelColor)
            }
        }
    }
}

// MARK: - =============================================
// MARK: - PRODUCT PRICE COMPONENT
// MARK: - =============================================

struct ProductPrice: View {
    let currentPrice: Decimal
    let originalPrice: Decimal?
    let savingsPercentage: Int?
    
    private let currentPriceSize = DS.FontFontSizeH3
    private let centsSize = DS.FontFontSizeBodySm
    private let originalPriceSize = DS.FontFontSizeBodyXs
    private let savingsSize = DS.FontFontSizeBodyXs
    private let spacing = DS.Spacing1
    private let currentPriceColor = DS.TextOnSurfaceColorPrimary
    private let originalPriceColor = DS.TextOnSurfaceColorTertiary
    private let savingsColor = DS.BackgroundAccentColorGreen
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            currentPriceView
            if originalPrice != nil || savingsPercentage != nil {
                if let original = originalPrice {
                    Text("Was \(formatPrice(original))")
                        .font(.system(size: originalPriceSize, weight: .regular))
                        .foregroundStyle(originalPriceColor)
                        .strikethrough()
                }
                if let savings = savingsPercentage, let original = originalPrice {
                    let savedAmount = original - currentPrice
                    Text("Saving \(formatPrice(savedAmount)) (\(savings)%)")
                        .font(.system(size: savingsSize, weight: .medium))
                        .foregroundStyle(savingsColor)
                }
            }
        }
    }
    
    private var currentPriceView: some View {
        HStack(alignment: .top, spacing: 0) {
            Text("$")
                .font(.system(size: centsSize, weight: .bold))
                .foregroundStyle(currentPriceColor)
            let dollars = Int(truncating: currentPrice as NSNumber)
            let cents = Int(truncating: ((currentPrice - Decimal(dollars)) * 100) as NSNumber)
            Text("\(dollars)")
                .font(.system(size: currentPriceSize, weight: .bold))
                .foregroundStyle(currentPriceColor)
            Text(String(format: "%02d", cents))
                .font(.system(size: centsSize, weight: .bold))
                .foregroundStyle(currentPriceColor)
                .offset(y: 2)
        }
    }
    
    private func formatPrice(_ price: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        return formatter.string(from: price as NSNumber) ?? "$0.00"
    }
}

// MARK: - =============================================
// MARK: - PRODUCT RATING COMPONENT
// MARK: - =============================================

struct ProductRating: View {
    let rating: Double
    let reviewCount: Int
    
    private let starSize = DS.FontFontSizeBodyMd
    private let textSize = DS.FontFontSizeBodySm
    private let spacing = DS.Spacing1
    private let starColor = DS.BackgroundAccentColorYellow
    private let emptyStarColor = DS.GreigeGreige200
    private let textColor = DS.TextOnSurfaceColorSecondary
    
    var body: some View {
        HStack(spacing: spacing) {
            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { index in
                    starImage(for: index)
                }
            }
            Text("(\(String(format: "%.1f", rating)) / \(reviewCount))")
                .font(.system(size: textSize, weight: .regular))
                .foregroundStyle(textColor)
        }
    }
    
    private func starImage(for index: Int) -> some View {
        let fillAmount = rating - Double(index)
        return Image(systemName: fillAmount >= 1 ? "star.fill" : (fillAmount > 0 ? "star.leadinghalf.filled" : "star"))
            .font(.system(size: starSize))
            .foregroundStyle(fillAmount > 0 ? starColor : emptyStarColor)
    }
}

// MARK: - =============================================
// MARK: - FULFILLMENT OPTION COMPONENT
// MARK: - =============================================

enum FulfillmentType {
    case pickup
    case delivery
    case fasterDelivery
    
    var label: String {
        switch self {
        case .pickup: return "Pickup:"
        case .delivery: return "Delivery:"
        case .fasterDelivery: return "Faster Delivery:"
        }
    }
}

struct FulfillmentOption: View {
    let type: FulfillmentType
    let primaryValue: String
    var secondaryValue: String? = nil
    var tertiaryValue: String? = nil
    var highlightedText: String? = nil
    
    private let labelSize = DS.FontFontSizeBodySm
    private let valueSize = DS.FontFontSizeBodySm
    private let spacing = DS.Spacing1
    private let labelColor = DS.TextOnSurfaceColorPrimary
    private let valueColor = DS.TextOnSurfaceColorSecondary
    private let highlightColor = DS.BackgroundAccentColorBlue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: spacing) {
                Text(type.label)
                    .font(.system(size: labelSize, weight: .bold))
                    .foregroundStyle(labelColor)
                Text(primaryValue)
                    .font(.system(size: valueSize, weight: .regular))
                    .foregroundStyle(shouldHighlight(primaryValue) ? highlightColor : valueColor)
            }
            if let secondary = secondaryValue {
                Text(secondary)
                    .font(.system(size: valueSize, weight: .regular))
                    .foregroundStyle(shouldHighlight(secondary) ? highlightColor : valueColor)
            }
            if let tertiary = tertiaryValue {
                Text(tertiary)
                    .font(.system(size: valueSize, weight: .regular))
                    .foregroundStyle(shouldHighlight(tertiary) ? highlightColor : valueColor)
            }
        }
    }
    
    private func shouldHighlight(_ text: String) -> Bool {
        return highlightedText == text
    }
}

// MARK: - =============================================
// MARK: - QUANTITY SELECTOR COMPONENT
// MARK: - =============================================

struct QuantitySelector: View {
    @Binding var quantity: Int
    var minQuantity: Int = 1
    var maxQuantity: Int = 999
    
    private let height = DS.Spacing11
    private let buttonWidth = DS.Spacing12
    private let iconSize = DS.FontFontSizeBodyLg
    private let fontSize = DS.FontFontSizeBodyMd
    private let cornerRadius = DS.BorderRadius3xl
    private let gradientStart = DS.BrandBrand200
    private let gradientEnd = DS.BrandBrand400
    private let iconColor = DS.TextOnSurfaceColorPrimary
    private let textColor = DS.TextOnSurfaceColorPrimary
    private let backgroundColor = DS.BackgroundContainerColorWhite
    
    var body: some View {
        HStack(spacing: 0) {
            decrementButton
            quantityDisplay
            incrementButton
        }
        .frame(height: height)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(LinearGradient(colors: [gradientStart, gradientEnd], startPoint: .leading, endPoint: .trailing))
        )
    }
    
    private var decrementButton: some View {
        Button(action: { if quantity > minQuantity { quantity -= 1 } }) {
            Image(systemName: "minus")
                .font(.system(size: iconSize, weight: .medium))
                .foregroundStyle(quantity > minQuantity ? iconColor : iconColor.opacity(0.4))
                .frame(width: buttonWidth, height: height)
        }
        .disabled(quantity <= minQuantity)
    }
    
    private var quantityDisplay: some View {
        Text("\(quantity)")
            .font(.system(size: fontSize, weight: .semibold))
            .foregroundStyle(textColor)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(backgroundColor)
    }
    
    private var incrementButton: some View {
        Button(action: { if quantity < maxQuantity { quantity += 1 } }) {
            Image(systemName: "plus")
                .font(.system(size: iconSize, weight: .medium))
                .foregroundStyle(quantity < maxQuantity ? iconColor : iconColor.opacity(0.4))
                .frame(width: buttonWidth, height: height)
        }
        .disabled(quantity >= maxQuantity)
    }
}

// MARK: - =============================================
// MARK: - BUTTON COMPONENTS
// MARK: - =============================================

// MARK: - Button State
enum ButtonState: String, CaseIterable {
    case `default` = "Default"
    case active_pressed = "Active / Pressed"
    case loading = "Loading"
    case success = "Success"
    case inactive = "Inactive"
}

// MARK: - Button Style
enum ButtonStyle: String, CaseIterable {
    case orangeFilled = "Orange Filled"
    case orangeOutline = "Orange Outline"
    case whiteFilled = "White Filled"
    case ghostFilled = "Ghost Filled"
}

// MARK: - Primary Button (Orange Filled)
struct PrimaryActionButton: View {
    let title: String
    var icon: String? = nil
    let action: () -> Void
    var state: ButtonState = .default
    var size: DesignSystemGlobal.ButtonSize = .lg
    var width: DesignSystemGlobal.ButtonWidth = .fullWidth
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: DS.Spacing2) {
                if state == .loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: textColor))
                        .scaleEffect(0.8)
                } else if state == .success {
                    Image(systemName: "checkmark")
                        .font(.system(size: size.fontSize, weight: .semibold))
                } else if let iconName = icon {
                    Image(systemName: iconName)
                        .font(.system(size: size.fontSize, weight: .semibold))
                }
                
                Text(title)
                    .font(.system(size: size.fontSize, weight: .bold))
            }
            .foregroundStyle(textColor)
            .frame(maxWidth: width == .fullWidth ? .infinity : nil)
        }
        .padding(.horizontal, size.horizontalPadding)
        .frame(height: size.height)
        .background(backgroundColor)
        .cornerRadius(size.cornerRadius)
        .disabled(state == .inactive || state == .loading)
    }
    
    private var backgroundColor: Color {
        switch state {
        case .default, .active_pressed, .loading, .success:
            return colorScheme == .dark
                ? DesignSystemGlobal.BrandBrand300
                : DesignSystemGlobal.BrandBrand300
        case .inactive:
            return DesignSystemGlobal.BackgroundButtonColorBrandFilledInactive
        }
    }
    
    private var textColor: Color {
        switch state {
        case .default, .active_pressed, .loading, .success:
            return DesignSystemGlobal.TextButtonColorOrangeFilledDefault
        case .inactive:
            return DesignSystemGlobal.TextButtonColorOrangeFilledInactive
        }
    }
}

// MARK: - Secondary Button (Orange Outline)
struct SecondaryActionButton: View {
    let title: String
    var icon: String? = nil
    let action: () -> Void
    var state: ButtonState = .default
    var size: DesignSystemGlobal.ButtonSize = .lg
    var width: DesignSystemGlobal.ButtonWidth = .fullWidth
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: DS.Spacing2) {
                if state == .loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: textColor))
                        .scaleEffect(0.8)
                } else if state == .success {
                    Image(systemName: "checkmark")
                        .font(.system(size: size.fontSize, weight: .semibold))
                } else if let iconName = icon {
                    Image(systemName: iconName)
                        .font(.system(size: size.fontSize, weight: .semibold))
                }
                
                Text(title)
                    .font(.system(size: size.fontSize, weight: .bold))
            }
            .foregroundStyle(textColor)
            .frame(maxWidth: width == .fullWidth ? .infinity : nil)
        }
        .padding(.horizontal, size.horizontalPadding)
        .frame(height: size.height)
        .background(backgroundColor)
        .cornerRadius(size.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: size.cornerRadius)
                .stroke(borderColor, lineWidth: size.borderWidth)
        )
        .disabled(state == .inactive || state == .loading)
    }
    
    private var backgroundColor: Color {
        return DesignSystemGlobal.BackgroundContainerColorWhite
    }
    
    private var textColor: Color {
        switch state {
        case .default, .active_pressed, .loading, .success:
            return DesignSystemGlobal.TextButtonColorOrangeOutlineDefault
        case .inactive:
            return DesignSystemGlobal.TextButtonColorOrangeOutlineInactive
        }
    }
    
    private var borderColor: Color {
        switch state {
        case .default, .loading, .success:
            return DesignSystemGlobal.BorderButtonColorOrangeOutlineDefault
        case .active_pressed:
            return DesignSystemGlobal.BorderButtonColorPressed
        case .inactive:
            return DesignSystemGlobal.BorderButtonColorOrangeOutlineInactive
        }
    }
}

// MARK: - Tertiary Button (Ghost/Text Button)
struct TertiaryActionButton: View {
    let title: String
    var icon: String? = nil
    let action: () -> Void
    var state: ButtonState = .default
    var size: DesignSystemGlobal.ButtonSize = .md
    var width: DesignSystemGlobal.ButtonWidth = .fitContent
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: DS.Spacing2) {
                if let iconName = icon {
                    Image(systemName: iconName)
                        .font(.system(size: size.fontSize, weight: .semibold))
                }
                
                Text(title)
                    .font(.system(size: size.fontSize, weight: .bold))
            }
            .foregroundStyle(textColor)
            .frame(maxWidth: width == .fullWidth ? .infinity : nil)
        }
        .padding(.horizontal, size.horizontalPadding)
        .frame(height: size.height)
        .background(backgroundColor)
        .cornerRadius(size.cornerRadius)
        .disabled(state == .inactive)
    }
    
    private var backgroundColor: Color {
        switch state {
        case .default, .loading, .success, .inactive:
            return DesignSystemGlobal.BackgroundButtonColorGhostFilledDefault
        case .active_pressed:
            return DesignSystemGlobal.BackgroundButtonColorGhostFilledPressed
        }
    }
    
    private var textColor: Color {
        switch state {
        case .default, .active_pressed, .loading, .success:
            return DesignSystemGlobal.TextButtonColorGhostFilledDefault
        case .inactive:
            return DesignSystemGlobal.TextButtonColorGhostFilledInactive
        }
    }
}

// MARK: - =============================================
// MARK: - PRODUCT CARD (Compact View)
// MARK: - =============================================

/// Layout: Badges top-left over image, image with thumbnails below,
/// details to the right (title, price, rating, fulfillment), CTA at bottom
struct ProductCard: View {
    let product: Product
    var onAddToCart: (() -> Void)? = nil
    var onImageTap: (() -> Void)? = nil
    
    private let cardPadding = DS.Spacing4
    private let contentSpacing = DS.Spacing3
    private let sectionSpacing = DS.Spacing2
    private let badgeSpacing = DS.Spacing1
    private let imageWidth: CGFloat = 120
    private let cornerRadius = DS.BorderRadius3xl
    private let backgroundColor = DS.BackgroundContainerColorWhite
    private let shadowColor = DS.Shadow100
    
    var body: some View {
        HStack(alignment: .top, spacing: contentSpacing) {
            // Left: Image section with badges
            VStack(alignment: .leading, spacing: sectionSpacing) {
                // Badges stacked vertically
                VStack(alignment: .leading, spacing: badgeSpacing) {
                    if product.isExclusive {
                        ProductBadge(text: "Exclusive", type: .exclusive)
                    }
                    if let promo = product.promotionalBadge {
                        ProductBadge(text: promo, type: .promotional)
                    }
                }
                
                // Product image with thumbnails
                ProductImageView(
                    heroImage: product.heroImage,
                    thumbnails: product.thumbnailImages,
                    additionalCount: product.additionalImageCount,
                    onHeroTap: onImageTap
                )
                .frame(width: imageWidth)
            }
            
            // Right: Details section
            VStack(alignment: .leading, spacing: sectionSpacing) {
                ProductTitle(brand: product.brand, name: product.name, modelNumber: product.modelNumber)
                ProductPrice(currentPrice: product.currentPrice, originalPrice: product.originalPrice, savingsPercentage: product.savingsPercentage)
                ProductRating(rating: product.rating, reviewCount: product.reviewCount)
                
                // Fulfillment options
                VStack(alignment: .leading, spacing: badgeSpacing) {
                    if let pickup = product.pickupInfo {
                        FulfillmentOption(type: .pickup, primaryValue: pickup.primaryValue, secondaryValue: pickup.secondaryValue, highlightedText: pickup.highlightedText)
                    }
                    if let delivery = product.deliveryInfo {
                        FulfillmentOption(type: .delivery, primaryValue: delivery.primaryValue, secondaryValue: delivery.secondaryValue, highlightedText: delivery.highlightedText)
                    }
                    if let faster = product.fasterDeliveryInfo {
                        FulfillmentOption(type: .fasterDelivery, primaryValue: faster.primaryValue, secondaryValue: faster.secondaryValue)
                    }
                }
                
                Spacer()
                
                PrimaryActionButton(title: "Add to Cart") { onAddToCart?() }
            }
        }
        .padding(cardPadding)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
                .shadow(color: shadowColor, radius: DS.ElevationBlurRadiusBlur2, x: 0, y: DS.ElevationPositionY2)
        )
    }
}

// MARK: - =============================================
// MARK: - PRODUCT POD (Detailed View)
// MARK: - =============================================

struct ProductPod: View {
    let product: Product
    @State private var quantity: Int = 1
    @State private var showAddToSheet: Bool = false
    var onAddToCart: ((Int) -> Void)? = nil
    var onImageTap: (() -> Void)? = nil
    
    private let cardPadding = DS.Spacing4
    private let contentSpacing = DS.Spacing4
    private let sectionSpacing = DS.Spacing3
    private let badgeSpacing = DS.Spacing1
    private let buttonSpacing = DS.Spacing2
    private let imageWidth: CGFloat = 140
    private let cornerRadius = DS.BorderRadius3xl
    private let backgroundColor = DS.BackgroundContainerColorWhite
    private let shadowColor = DS.Shadow100
    
    var body: some View {
        HStack(alignment: .top, spacing: contentSpacing) {
            // Left: Image section
            VStack(alignment: .leading, spacing: sectionSpacing) {
                VStack(alignment: .leading, spacing: badgeSpacing) {
                    if product.isExclusive {
                        ProductBadge(text: "Exclusive", type: .exclusive)
                    }
                    if let promo = product.promotionalBadge {
                        ProductBadge(text: promo, type: .promotional)
                    }
                }
                Image(product.heroImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageWidth)
                    .onTapGesture { onImageTap?() }
            }
            
            // Right: Details + actions
            VStack(alignment: .leading, spacing: sectionSpacing) {
                ProductTitle(brand: product.brand, name: product.name, modelNumber: product.modelNumber)
                ProductPrice(currentPrice: product.currentPrice, originalPrice: product.originalPrice, savingsPercentage: product.savingsPercentage)
                ProductRating(rating: product.rating, reviewCount: product.reviewCount)
                
                // Fulfillment options (full)
                VStack(alignment: .leading, spacing: sectionSpacing) {
                    if let pickup = product.pickupInfo {
                        FulfillmentOption(type: .pickup, primaryValue: pickup.primaryValue, secondaryValue: pickup.secondaryValue, tertiaryValue: pickup.tertiaryValue, highlightedText: pickup.highlightedText)
                    }
                    if let delivery = product.deliveryInfo {
                        FulfillmentOption(type: .delivery, primaryValue: delivery.primaryValue, secondaryValue: delivery.secondaryValue, tertiaryValue: delivery.tertiaryValue, highlightedText: delivery.highlightedText)
                    }
                    if let faster = product.fasterDeliveryInfo {
                        FulfillmentOption(type: .fasterDelivery, primaryValue: faster.primaryValue, secondaryValue: faster.secondaryValue)
                    }
                }
                
                Spacer()
                
                // Actions
                VStack(spacing: buttonSpacing) {
                    QuantitySelector(quantity: $quantity)
                    PrimaryActionButton(title: "Add to Cart") { onAddToCart?(quantity) }
                    SecondaryActionButton(title: "Add to ...") { showAddToSheet = true }
                }
            }
        }
        .padding(cardPadding)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
                .shadow(color: shadowColor, radius: DS.ElevationBlurRadiusBlur2, x: 0, y: DS.ElevationPositionY2)
        )
        .addToSheet(isPresented: $showAddToSheet, product: product) { option in
            print("Adding to \(option.title)")
            showAddToSheet = false
        }
    }
}

// MARK: - =============================================
// MARK: - PREVIEWS
// MARK: - =============================================

private let sampleProduct = Product(
    id: "A7A19A100WUL01",
    brand: "Home Decorators Collection",
    name: "35.4 in. W x 10.2 in. D x 2 in. H Driftwood Gradieted with spott...",
    modelNumber: "A7A19A100WUL01",
    heroImage: "product_box",
    thumbnailImages: ["thumb1", "thumb2", "thumb3"],
    additionalImageCount: 99,
    currentPrice: 1798.48,
    originalPrice: 3499.00,
    savingsPercentage: 49,
    rating: 4.5,
    reviewCount: 281,
    isExclusive: true,
    promotionalBadge: "Get it by Christmas",
    pickupInfo: FulfillmentInfo(primaryValue: "2,243 in stock", secondaryValue: "at Washington Courthouse, OH", highlightedText: "Washington Courthouse, OH"),
    deliveryInfo: FulfillmentInfo(primaryValue: "Free", secondaryValue: "Tomorrow", highlightedText: nil),
    fasterDeliveryInfo: FulfillmentInfo(primaryValue: "Get it in 2 hours")
)

#Preview("Product Card") {
    ScrollView {
        ProductCard(product: sampleProduct)
            .padding()
    }
    .background(DesignSystemGlobal.BackgroundSurfaceColorGreige)
}

#Preview("Product Pod") {
    ScrollView {
        ProductPod(product: sampleProduct)
            .padding()
    }
    .background(DesignSystemGlobal.BackgroundSurfaceColorGreige)
}

#Preview("Button States - Primary") {
    VStack(spacing: DesignSystemGlobal.Spacing4) {
        PrimaryActionButton(title: "Default", action: {}, state: .default)
        PrimaryActionButton(title: "Active / Pressed", action: {}, state: .active_pressed)
        PrimaryActionButton(title: "Loading", action: {}, state: .loading)
        PrimaryActionButton(title: "Success", action: {}, state: .success)
        PrimaryActionButton(title: "Inactive", action: {}, state: .inactive)
    }
    .padding()
    .background(DesignSystemGlobal.BackgroundSurfaceColorGreige)
}

#Preview("Button States - Secondary") {
    VStack(spacing: DesignSystemGlobal.Spacing4) {
        SecondaryActionButton(title: "Default", action: {}, state: .default)
        SecondaryActionButton(title: "Active / Pressed", action: {}, state: .active_pressed)
        SecondaryActionButton(title: "Loading", action: {}, state: .loading)
        SecondaryActionButton(title: "Success", action: {}, state: .success)
        SecondaryActionButton(title: "Inactive", action: {}, state: .inactive)
    }
    .padding()
    .background(DesignSystemGlobal.BackgroundSurfaceColorGreige)
}

#Preview("Button Sizes") {
    VStack(spacing: DesignSystemGlobal.Spacing4) {
        PrimaryActionButton(title: "Small", action: {}, size: .sm, width: .fitContent)
        PrimaryActionButton(title: "Medium", action: {}, size: .md, width: .fitContent)
        PrimaryActionButton(title: "Large", action: {}, size: .lg, width: .fitContent)
        PrimaryActionButton(title: "Extra Large", action: {}, size: .xl, width: .fitContent)
        PrimaryActionButton(title: "2XL", action: {}, size: .xxl, width: .fitContent)
    }
    .padding()
    .background(DesignSystemGlobal.BackgroundSurfaceColorGreige)
}

#Preview("Button Types Comparison") {
    VStack(spacing: DesignSystemGlobal.Spacing4) {
        PrimaryActionButton(title: "Primary Action", action: {})
        SecondaryActionButton(title: "Secondary Action", action: {})
        TertiaryActionButton(title: "Tertiary Action", action: {}, width: .fullWidth)
    }
    .padding()
    .background(DesignSystemGlobal.BackgroundSurfaceColorGreige)
}
