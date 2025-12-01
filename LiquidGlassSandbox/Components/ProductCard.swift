import SwiftUI

// MARK: - Product Card Component
/// B2B Basic Pod - A product card component matching The Home Depot design system
/// Based on Figma design: Keyless/B2B/BasicPod (node-id=20-4284)
///
/// This component accepts a Product model from ProductSystem.swift
/// Layout: Horizontal card with image on left, content on right

struct ProductCard: View {
    // MARK: - Properties
    let product: Product
    var onAddToCart: (() -> Void)? = nil
    var onAddToList: (() -> Void)? = nil
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            // LEFT COLUMN: Product Image + Color Swatches
            leftColumn
            
            // RIGHT COLUMN: Product Details + Buttons
            rightColumn
        }
        .background(DesignSystemGlobal.BackgroundContainerColorWhite)
        .cornerRadius(DesignSystemGlobal.BorderRadiusXl)
        .shadow(color: DesignSystemGlobal.ElevationLow, radius: DesignSystemGlobal.ElevationBlurRadiusBlur2, x: 0, y: DesignSystemGlobal.ElevationPositionY2)
    }
    
    // MARK: - Left Column (Image + Swatches)
    private var leftColumn: some View {
        VStack(alignment: .center, spacing: DesignSystemGlobal.Spacing3) {
            ZStack(alignment: .topLeading) {
                // Product Image
                productImageView
                
                // Exclusive Badge (top-left corner)
                if product.isExclusive || product.promotionalBadge != nil {
                    badgeStack
                }
            }
            
            // Color Swatches (if available)
            if let colors = product.availableColors, !colors.isEmpty {
                colorSwatches(colors: colors)
            }
        }
        .padding(.leading, DesignSystemGlobal.Spacing4)
        .padding(.top, DesignSystemGlobal.Spacing4)
        .padding(.bottom, DesignSystemGlobal.Spacing4)
    }
    
    // MARK: - Product Image
    private var productImageView: some View {
        Group {
            if product.heroImage.hasPrefix("http") {
                // Remote image URL
                AsyncImage(url: URL(string: product.heroImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Rectangle()
                        .fill(DesignSystemGlobal.BackgroundContainerColorGreige)
                        .overlay {
                            ProgressView()
                        }
                }
            } else {
                // Local asset
                Image(product.heroImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: 160, height: 160)
        .background(DesignSystemGlobal.BackgroundContainerColorGreige)
    }
    
    // MARK: - Badge Stack
    private var badgeStack: some View {
        VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing1px) {
            if product.isExclusive {
                Text("Exclusive")
                    .font(.thdBodyXs)
                    .fontWeight(.bold)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
            }
            
            if let promo = product.promotionalBadge {
                Text(promo)
                    .font(.thdBodyXs)
                    .fontWeight(.bold)
                    .foregroundColor(DesignSystemGlobal.BackgroundFeedbackColorSuccessAccent2)
            }
        }
        .padding(.horizontal, DesignSystemGlobal.Spacing2)
        .padding(.vertical, DesignSystemGlobal.Spacing1 + DesignSystemGlobal.Spacing1px)
        .background(DesignSystemGlobal.BackgroundContainerColorWhite)
        .cornerRadius(DesignSystemGlobal.BorderRadiusMd)
        .shadow(color: DesignSystemGlobal.ElevationLowest, radius: DesignSystemGlobal.ElevationBlurRadiusBlur1 / 2, x: 0, y: DesignSystemGlobal.ElevationPositionY1)
        .padding(DesignSystemGlobal.Spacing2)
    }
    
    // MARK: - Color Swatches
    private func colorSwatches(colors: [Product.ProductColor]) -> some View {
        HStack(spacing: DesignSystemGlobal.Spacing2) {
            ForEach(Array(colors.prefix(3).enumerated()), id: \.offset) { index, productColor in
                RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadiusMd)
                    .fill(productColor.color)
                    .frame(width: DesignSystemGlobal.Spacing8, height: DesignSystemGlobal.Spacing8)
                    .overlay(
                        RoundedRectangle(cornerRadius: DesignSystemGlobal.BorderRadiusMd)
                            .stroke(productColor.borderColor ?? DesignSystemGlobal.BorderInputColorDefault, lineWidth: DesignSystemGlobal.BorderWidthXs)
                    )
            }
            
            if product.additionalColorCount > 0 {
                Text("+\(product.additionalColorCount)")
                    .font(.thdBodyXs)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                    .frame(width: DesignSystemGlobal.Spacing8, height: DesignSystemGlobal.Spacing8)
            }
        }
    }
    
    // MARK: - Right Column (Details + Actions)
    private var rightColumn: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Sponsored Label (if applicable)
            if product.isSponsored {
                Text("Sponsored")
                    .font(.thdBodyXs)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
                    .padding(.bottom, DesignSystemGlobal.Spacing1)
            }
            
            // Brand Name
            Text(product.brand)
                .font(.thdBodyXs)
                .fontWeight(.bold)
                .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                .lineLimit(1)
            
            // Product Title
            Text(product.name)
                .font(.thdBodySm)
                .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                .lineLimit(2)
                .lineSpacing(0)
                .padding(.top, DesignSystemGlobal.Spacing1)
            
            // Product Details (Model, Internet, SKU)
            productDetails
            
            // Price Display
            priceSection
            
            // Was Price & Savings
            savingsSection
            
            // Rating Stars
            ratingSection
            
            // Delivery Information
            deliverySection
            
            // Action Buttons
            actionButtons
        }
        .padding(.leading, DesignSystemGlobal.Spacing3)
        .padding(.trailing, DesignSystemGlobal.Spacing4)
        .padding(.top, DesignSystemGlobal.Spacing4)
        .padding(.bottom, DesignSystemGlobal.Spacing4)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Product Details
    private var productDetails: some View {
        VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing1px) {
            Text("Model: \(product.modelNumber)")
                .font(.thdBodyXs)
                .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
            
            if let internetNumber = product.internetNumber {
                Text("Internet: \(internetNumber)")
                    .font(.thdBodyXs)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
            }
            
            if let storeSKU = product.storeSKU {
                Text("Store SKU: \(storeSKU)")
                    .font(.thdBodyXs)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
            }
        }
        .padding(.top, DesignSystemGlobal.Spacing1)
    }
    
    // MARK: - Price Section
    private var priceSection: some View {
        HStack(alignment: .firstTextBaseline, spacing: DesignSystemGlobal.Spacing1px) {
            Text("$")
                .font(.thdH1)
                .fontWeight(.heavy)
                .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
            
            Text(formattedPriceDollars(product.currentPrice))
                .font(.thdH1)
                .fontWeight(.heavy)
                .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
            
            if let cents = formattedPriceCents(product.currentPrice) {
                Text(cents)
                    .font(.thdBodySm)
                    .fontWeight(.bold)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                    .baselineOffset(DesignSystemGlobal.Spacing1 + DesignSystemGlobal.Spacing1px)
            }
        }
        .padding(.top, DesignSystemGlobal.Spacing2)
    }
    
    // MARK: - Savings Section
    @ViewBuilder
    private var savingsSection: some View {
        if let originalPrice = product.originalPrice,
           let savingsPercent = product.savingsPercentage {
            let savingsAmount = originalPrice - product.currentPrice
            
            VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing1px) {
                Text("Was $\(formattedFullPrice(originalPrice))")
                    .font(.thdBodyXs)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
                
                Text("Saving $\(formattedFullPrice(savingsAmount)) (\(savingsPercent)%)")
                    .font(.thdBodyXs)
                    .fontWeight(.bold)
                    .foregroundColor(DesignSystemGlobal.BackgroundFeedbackColorErrorAccent2)
            }
            .padding(.top, DesignSystemGlobal.Spacing1px)
        }
    }
    
    // MARK: - Rating Section
    private var ratingSection: some View {
        HStack(spacing: DesignSystemGlobal.Spacing1) {
            RatingStars(rating: product.rating)
            
            Text("(\(String(format: "%.1f", product.rating))/\(formatNumber(product.reviewCount)))")
                .font(.thdBodyXs)
                .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
        }
        .padding(.top, DesignSystemGlobal.Spacing1 + DesignSystemGlobal.Spacing1px)
    }
    
    // MARK: - Delivery Section
    private var deliverySection: some View {
        VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing1px) {
            // Delivery row
            if let delivery = product.deliveryInfo {
                HStack(spacing: DesignSystemGlobal.Spacing1) {
                    Text("Delivery:")
                        .font(.thdBodySm)
                        .fontWeight(.bold)
                        .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                    
                    if delivery.primaryValue.lowercased() == "free" {
                        Text("Free")
                            .font(.thdBodySm)
                            .fontWeight(.bold)
                            .foregroundColor(DesignSystemGlobal.BackgroundFeedbackColorSuccessAccent2)
                    }
                }
                
                HStack(spacing: DesignSystemGlobal.Spacing1) {
                    if let date = delivery.secondaryValue {
                        Text(date)
                            .font(.thdBodySm)
                            .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                    }
                    
                    // Show pickup availability if present
                    if let pickup = product.pickupInfo {
                        Text("|")
                            .font(.thdBodySm)
                            .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
                        
                        Text(pickup.primaryValue)
                            .font(.thdBodySm)
                            .foregroundColor(DesignSystemGlobal.BackgroundFeedbackColorSuccessAccent2)
                    }
                }
            }
            
            // Faster delivery option
            if let faster = product.fasterDeliveryInfo {
                VStack(alignment: .leading, spacing: DesignSystemGlobal.Spacing1px) {
                    Text("Faster Delivery:")
                        .font(.thdBodySm)
                        .fontWeight(.bold)
                        .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                    
                    Text(faster.primaryValue)
                        .font(.thdBodySm)
                        .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                }
                .padding(.top, DesignSystemGlobal.Spacing1)
            }
        }
        .padding(.top, DesignSystemGlobal.Spacing2)
    }
    
    // MARK: - Action Buttons
    private var actionButtons: some View {
        VStack(spacing: DesignSystemGlobal.Spacing2) {
            // Add to Cart Button (Primary)
            ButtondemoView(
                label: "Add to Cart",
                action: { onAddToCart?() },
                state: .default,
                size: .sm,
                style: .orange_filled,
                width: .fullWidth,
                hasBorder: false
            )
            
            // Add to List Button (Secondary - Outlined)
            ButtondemoView(
                label: "Add to ...",
                action: { onAddToList?() },
                state: .default,
                size: .sm,
                style: .orange_outlined,
                width: .fullWidth,
                hasBorder: true
            )
        }
        .padding(.top, DesignSystemGlobal.Spacing3)
    }
    
    // MARK: - Helper Methods
    private func formattedPriceDollars(_ price: Decimal) -> String {
        let nsPrice = price as NSDecimalNumber
        let wholePart = Int(nsPrice.doubleValue)
        return "\(formatNumber(wholePart))"
    }
    
    private func formattedPriceCents(_ price: Decimal) -> String? {
        let nsPrice = price as NSDecimalNumber
        let doubleValue = nsPrice.doubleValue
        let wholePart = Int(doubleValue)
        let fractionalPart = Int((doubleValue - Double(wholePart)) * 100)
        
        if fractionalPart > 0 {
            return String(format: ".%02d", fractionalPart)
        }
        return nil
    }
    
    private func formattedFullPrice(_ price: Decimal) -> String {
        let nsPrice = price as NSDecimalNumber
        return String(format: "%.2f", nsPrice.doubleValue)
    }
    
    private func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

// MARK: - Rating Stars Component
struct RatingStars: View {
    let rating: Double
    
    var body: some View {
        HStack(spacing: DesignSystemGlobal.Spacing1px) {
            ForEach(0..<5) { index in
                starImage(for: index)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                    .font(.system(size: DesignSystemGlobal.FontFontSizeBodyMd))
            }
        }
    }
    
    private func starImage(for index: Int) -> Image {
        let position = Double(index) + 1.0
        
        if rating >= position {
            return Image(systemName: "star.fill")
        } else if rating > Double(index) && rating < position {
            return Image(systemName: "star.leadinghalf.filled")
        } else {
            return Image(systemName: "star")
        }
    }
}

// MARK: - Preview
#Preview("ProductCard") {
    let sampleProduct = Product(
        id: "A7A19A100WUL01",
        brand: "Home Decorators Collection",
        name: "35.4 in. W x 10.2 in. D x 2 in. H Driftwood Gradieted with spott...",
        modelNumber: "A7A19A100WUL01",
        heroImage: "product_sample",
        thumbnailImages: [],
        additionalImageCount: 99,
        currentPrice: 1798.48,
        originalPrice: 3499.00,
        savingsPercentage: 49,
        rating: 4.5,
        reviewCount: 281,
        isExclusive: true,
        promotionalBadge: "Get it by Christmas",
        pickupInfo: FulfillmentInfo(
            primaryValue: "2,243 in stock",
            secondaryValue: "at Washington Courthouse, OH",
            highlightedText: "Washington Courthouse, OH"
        ),
        deliveryInfo: FulfillmentInfo(
            primaryValue: "Free",
            secondaryValue: "Tomorrow"
        ),
        fasterDeliveryInfo: FulfillmentInfo(
            primaryValue: "Get it in 2 hours"
        ),
        internetNumber: "58954165",
        storeSKU: "1002-565-568",
        isSponsored: true,
        availableColors: [
            Product.ProductColor(color: Color(red: 0.85, green: 0.75, blue: 0.65)),
            Product.ProductColor(color: Color(red: 0.75, green: 0.65, blue: 0.55)),
            Product.ProductColor(color: Color(red: 0.65, green: 0.55, blue: 0.45))
        ],
        additionalColorCount: 99
    )
    
    ProductCard(product: sampleProduct)
        .frame(width: 398)
        .padding()
        //.background(DesignSystemGlobal.BackgroundSurfaceColorGreige)
}
