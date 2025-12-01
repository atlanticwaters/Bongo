import SwiftUI

// MARK: - =============================================
// MARK: - PRODUCT SYSTEM DATA MODELS
// MARK: - =============================================
//
// This file contains the core product data models used throughout the app:
// - Product: Main product model with all product information
// - FulfillmentInfo: Delivery, pickup, and shipping information
// - SortOption: Product sorting options

// MARK: - =============================================
// MARK: - PRODUCT MODEL
// MARK: - =============================================

/// Represents a product with all its details, pricing, and fulfillment information
struct Product: Identifiable, Codable {
    let id: String
    let brand: String
    let name: String
    let modelNumber: String
    let heroImage: String
    let thumbnailImages: [String]
    let additionalImageCount: Int
    let currentPrice: Decimal
    let originalPrice: Decimal?
    let savingsPercentage: Int?
    let rating: Double
    let reviewCount: Int
    let isExclusive: Bool
    let promotionalBadge: String?
    let pickupInfo: FulfillmentInfo?
    let deliveryInfo: FulfillmentInfo?
    let fasterDeliveryInfo: FulfillmentInfo?
    
    // Additional B2B fields
    var internetNumber: String? = nil
    var storeSKU: String? = nil
    var isSponsored: Bool = false
    var availableColors: [ProductColor]? = nil
    var additionalColorCount: Int = 0
    
    // MARK: - Nested Types
    
    /// Represents a color option for a product
    struct ProductColor: Codable {
        let colorHex: String
        let borderColorHex: String?
        
        init(colorHex: String, borderColorHex: String? = nil) {
            self.colorHex = colorHex
            self.borderColorHex = borderColorHex
        }
        
        /// SwiftUI Color from hex string
        var color: Color {
            Color(hex: colorHex) ?? .gray
        }
        
        /// Optional border color
        var borderColor: Color? {
            guard let hex = borderColorHex else { return nil }
            return Color(hex: hex)
        }
        
        // Convenience initializer for SwiftUI colors (non-Codable usage)
        init(color: Color, borderColor: Color? = nil) {
            self.colorHex = color.toHex() ?? "#808080"
            self.borderColorHex = borderColor?.toHex()
        }
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case id, brand, name, modelNumber, heroImage, thumbnailImages
        case additionalImageCount, currentPrice, originalPrice, savingsPercentage
        case rating, reviewCount, isExclusive, promotionalBadge
        case pickupInfo, deliveryInfo, fasterDeliveryInfo
        case internetNumber, storeSKU, isSponsored
        case availableColors, additionalColorCount
    }
    
    // MARK: - Memberwise Initializer
    init(
        id: String,
        brand: String,
        name: String,
        modelNumber: String,
        heroImage: String,
        thumbnailImages: [String] = [],
        additionalImageCount: Int = 0,
        currentPrice: Decimal,
        originalPrice: Decimal? = nil,
        savingsPercentage: Int? = nil,
        rating: Double,
        reviewCount: Int,
        isExclusive: Bool = false,
        promotionalBadge: String? = nil,
        pickupInfo: FulfillmentInfo? = nil,
        deliveryInfo: FulfillmentInfo? = nil,
        fasterDeliveryInfo: FulfillmentInfo? = nil,
        internetNumber: String? = nil,
        storeSKU: String? = nil,
        isSponsored: Bool = false,
        availableColors: [ProductColor]? = nil,
        additionalColorCount: Int = 0
    ) {
        self.id = id
        self.brand = brand
        self.name = name
        self.modelNumber = modelNumber
        self.heroImage = heroImage
        self.thumbnailImages = thumbnailImages
        self.additionalImageCount = additionalImageCount
        self.currentPrice = currentPrice
        self.originalPrice = originalPrice
        self.savingsPercentage = savingsPercentage
        self.rating = rating
        self.reviewCount = reviewCount
        self.isExclusive = isExclusive
        self.promotionalBadge = promotionalBadge
        self.pickupInfo = pickupInfo
        self.deliveryInfo = deliveryInfo
        self.fasterDeliveryInfo = fasterDeliveryInfo
        self.internetNumber = internetNumber
        self.storeSKU = storeSKU
        self.isSponsored = isSponsored
        self.availableColors = availableColors
        self.additionalColorCount = additionalColorCount
    }
}

// MARK: - =============================================
// MARK: - FULFILLMENT INFO
// MARK: - =============================================

/// Represents delivery, pickup, or shipping information for a product
struct FulfillmentInfo: Codable {
    let primaryValue: String
    let secondaryValue: String?
    let highlightedText: String?
    
    init(primaryValue: String, secondaryValue: String? = nil, highlightedText: String? = nil) {
        self.primaryValue = primaryValue
        self.secondaryValue = secondaryValue
        self.highlightedText = highlightedText
    }
}

// MARK: - =============================================
// MARK: - SORT OPTIONS
// MARK: - =============================================

/// Available sorting options for product lists
enum SortOption: String, CaseIterable {
    case topRated = "Top Rated"
    case priceLowToHigh = "Price: Low to High"
    case priceHighToLow = "Price: High to Low"
    case bestSelling = "Best Selling"
    case newest = "Newest"
}

// MARK: - =============================================
// MARK: - COLOR EXTENSION
// MARK: - =============================================

extension Color {
    /// Initialize Color from hex string
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
    
    /// Convert Color to hex string
    func toHex() -> String? {
        guard let components = UIColor(self).cgColor.components else { return nil }
        
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}

// MARK: - =============================================
// MARK: - PRODUCTS RESPONSE (for JSON decoding)
// MARK: - =============================================

/// Wrapper for decoding products array from JSON
struct ProductsResponse: Codable {
    let products: [Product]
}
