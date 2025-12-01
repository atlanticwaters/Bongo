import SwiftUI

// MARK: - Product Card Component
/// A comprehensive product card component matching The Home Depot design system
/// Based on Figma design: Keyless/B2B/BasicPod
struct ProductCard: View {
    // MARK: - Properties
    let productImage: String
    let badgeText: String?
    let collectionName: String
    let productTitle: String
    let modelNumber: String
    let internetNumber: String
    let storeSKU: String
    let price: Decimal
    let wasPrice: Decimal?
    let savingsAmount: Decimal?
    let savingsPercent: Int?
    let rating: Double
    let reviewCount: Int
    let deliveryOption: DeliveryOption
    let fasterDeliveryOption: FasterDeliveryOption?
    let isSponsored: Bool
    let availableColors: [Color]
    let additionalColorCount: Int
    
    // MARK: - Nested Types
    struct DeliveryOption {
        let isFree: Bool
        let date: String
        let availableCount: Int
    }
    
    struct FasterDeliveryOption {
        let timeframe: String
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image Section with Badge
            ZStack(alignment: .topLeading) {
                // Product Image
                AsyncImage(url: URL(string: productImage)) { image in
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
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .background(DesignSystemGlobal.BackgroundContainerColorGreige)
                
                // Exclusive Badge
                if let badge = badgeText {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Exclusive")
                            .font(.thdBodyXs)
                            .fontWeight(.bold)
                            .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                        
                        Text(badge)
                            .font(.thdBodyXs)
                            .fontWeight(.bold)
                            .foregroundColor(DesignSystemGlobal.BackgroundFeedbackColorSuccessAccent2)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(Color.white)
                    .cornerRadius(4)
                    .padding(12)
                }
            }
            
            // Content Section
            VStack(alignment: .leading, spacing: 8) {
                // Collection Name
                Text(collectionName)
                    .font(.thdBodyXs)
                    .fontWeight(.bold)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                    .lineLimit(1)
                
                // Product Title
                Text(productTitle)
                    .font(.thdBodySm)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                    .lineLimit(2)
                    .lineSpacing(2)
                
                // Product Details
                VStack(alignment: .leading, spacing: 2) {
                    Text("Model: \(modelNumber)")
                        .font(.thdBodyXs)
                        .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
                    
                    Text("Internet: \(internetNumber)")
                        .font(.thdBodyXs)
                        .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
                    
                    Text("Store SKU: \(storeSKU)")
                        .font(.thdBodyXs)
                        .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
                }
                
                // Price Section
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text("$")
                            .font(.thdH1)
                            .fontWeight(.heavy)
                            .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                        
                        Text(formattedPrice(price))
                            .font(.thdH1)
                            .fontWeight(.heavy)
                            .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                        
                        if let cents = formattedCents(price) {
                            Text(cents)
                                .font(.thdBodySm)
                                .fontWeight(.bold)
                                .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                        }
                    }
                    
                    // Savings Information
                    if let wasPrice = wasPrice, let savingsAmount = savingsAmount, let savingsPercent = savingsPercent {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Was $\(formattedFullPrice(wasPrice))")
                                .font(.thdBodyXs)
                                .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
                            
                            Text("Saving $\(formattedFullPrice(savingsAmount)) (\(savingsPercent)%)")
                                .font(.thdBodyXs)
                                .fontWeight(.bold)
                                .foregroundColor(DesignSystemGlobal.BackgroundFeedbackColorErrorAccent2)
                        }
                    }
                }
                
                // Rating Section
                HStack(spacing: 4) {
                    RatingStars(rating: rating)
                    
                    Text("(\(String(format: "%.1f", rating))/\(reviewCount))")
                        .font(.thdBodyXs)
                        .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                        .lineLimit(1)
                }
                .padding(.top, 4)
                
                // Delivery Information
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        Text("Delivery:")
                            .font(.thdBodySm)
                            .fontWeight(.bold)
                            .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                        
                        if deliveryOption.isFree {
                            Text("Free")
                                .font(.thdBodySm)
                                .fontWeight(.bold)
                                .foregroundColor(DesignSystemGlobal.BackgroundFeedbackColorSuccessAccent2)
                        }
                    }
                    
                    HStack(spacing: 4) {
                        Text(deliveryOption.date)
                            .font(.thdBodySm)
                            .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                        
                        Text("|")
                            .font(.thdBodySm)
                            .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
                        
                        Text("\(formatNumber(deliveryOption.availableCount)) avail")
                            .font(.thdBodySm)
                            .foregroundColor(DesignSystemGlobal.BackgroundFeedbackColorSuccessAccent2)
                    }
                    
                    if let fasterDelivery = fasterDeliveryOption {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Faster Delivery:")
                                .font(.thdBodySm)
                                .fontWeight(.bold)
                                .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                            
                            Text("Get it in \(fasterDelivery.timeframe)")
                                .font(.thdBodySm)
                                .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                        }
                        .padding(.top, 2)
                    }
                }
                .padding(.top, 4)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            
            // Sponsored Label
            if isSponsored {
                Text("Sponsored")
                    .font(.thdBodyXs)
                    .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorSecondary)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 8)
            }
            
            Spacer()
            
            // Action Buttons
            VStack(spacing: 8) {
                Button(action: {
                    // Add to cart action
                }) {
                    Text("Add to Cart")
                        .font(.thdBodySm)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(DesignSystemGlobal.BackgroundButtonColorBrandFilledDefault)
                        .cornerRadius(24)
                }
                
                Button(action: {
                    // Add to list action
                }) {
                    Text("Add to ...")
                        .font(.thdBodySm)
                        .fontWeight(.bold)
                        .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(DesignSystemGlobal.BorderButtonColorDefault, lineWidth: 2)
                        )
                        .cornerRadius(24)
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
            
            // Color Swatches
            HStack(spacing: 8) {
                ForEach(Array(availableColors.prefix(3).enumerated()), id: \.offset) { index, color in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(width: 32, height: 32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(DesignSystemGlobal.BorderInputColorDefault, lineWidth: 1)
                        )
                }
                
                if additionalColorCount > 0 {
                    Text("+\(additionalColorCount)")
                        .font(.thdBodyXs)
                        .foregroundColor(DesignSystemGlobal.TextOnSurfaceColorPrimary)
                        .frame(width: 32, height: 32)
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    // MARK: - Helper Methods
    private func formattedPrice(_ price: Decimal) -> String {
        let nsPrice = price as NSDecimalNumber
        let wholePart = Int(nsPrice.doubleValue)
        return "\(formatNumber(wholePart))"
    }
    
    private func formattedCents(_ price: Decimal) -> String? {
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
        HStack(spacing: 1) {
            ForEach(0..<5) { index in
                starImage(for: index)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
            }
        }
    }
    
    private func starImage(for index: Int) -> Image {
        let position = Double(index) + 1.0
        
        if rating >= position {
            // Full star
            return Image(systemName: "star.fill")
        } else if rating > Double(index) && rating < position {
            // Half star
            return Image(systemName: "star.leadinghalf.filled")
        } else {
            // Empty star
            return Image(systemName: "star")
        }
    }
}

// MARK: - Preview
struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(
            productImage: "https://images.thdstatic.com/productImages/sample.jpg",
            badgeText: "Get it by Christmas",
            collectionName: "Home Decorators Collection",
            productTitle: "35.4 in. W x 10.2 in. D x 2 in. H Driftwood Gradieted with spott...",
            modelNumber: "A7A19A100WUL01",
            internetNumber: "58954165",
            storeSKU: "1002-565-568",
            price: 1798.48,
            wasPrice: 3499.00,
            savingsAmount: 1701.00,
            savingsPercent: 49,
            rating: 4.5,
            reviewCount: 281,
            deliveryOption: ProductCard.DeliveryOption(
                isFree: true,
                date: "Tomorrow",
                availableCount: 2243
            ),
            fasterDeliveryOption: ProductCard.FasterDeliveryOption(
                timeframe: "2 hours"
            ),
            isSponsored: true,
            availableColors: [
                Color(red: 0.8, green: 0.7, blue: 0.6),
                Color(red: 0.9, green: 0.8, blue: 0.7),
                Color(red: 0.7, green: 0.6, blue: 0.5)
            ],
            additionalColorCount: 99
        )
        .frame(width: 320)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
