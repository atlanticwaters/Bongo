import SwiftUI

// MARK: - Design System Type Alias
private typealias DS = DesignSystemGlobal

// MARK: - =============================================
// MARK: - PRODUCT LISTING PAGE
// MARK: - =============================================
//
// This file uses components from:
// - ProductSystem.swift: Product, FulfillmentInfo, ProductCard, etc.
// - Morph_Menu: Top navigation with morphing search
// - Bottom_Nav: Bottom tab navigation
//
// Additional PLP-specific components defined here:
// - FilterChip (Pickup, Delivery, Ship to Home)
// - ProductListingPage (main view)

// MARK: - =============================================
// MARK: - SORT OPTIONS
// MARK: - =============================================

enum SortOption: String, CaseIterable {
    case topRated = "Top Rated"
    case priceLowToHigh = "Price: Low to High"
    case priceHighToLow = "Price: High to Low"
    case bestSelling = "Best Selling"
    case newest = "Newest"
}

// MARK: - =============================================
// MARK: - FILTER CHIP COMPONENT
// MARK: - =============================================

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    private let fontSize = DS.FontFontSizeBodySm
    private let horizontalPadding = DS.Spacing3
    private let verticalPadding = DS.Spacing2
    private let cornerRadius = DS.BorderRadius3xl
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize, weight: isSelected ? .semibold : .regular))
                .foregroundStyle(isSelected ? DS.TextButtonColorOrangeFilledDefault : DS.TextOnSurfaceColorPrimary)
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, verticalPadding)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(isSelected ? DS.BackgroundButtonColorBrandFilledDefault : DS.BackgroundContainerColorWhite)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(isSelected ? Color.clear : DS.BorderOnContainerDefault, lineWidth: DS.BorderWidthXs)
                )
        }
    }
}

// MARK: - =============================================
// MARK: - VIEW TOGGLE
// MARK: - =============================================

enum ViewMode {
    case list
    case grid
}

struct ViewToggle: View {
    @Binding var mode: ViewMode
    
    var body: some View {
        HStack(spacing: DS.Spacing1) {
            Button(action: { mode = .list }) {
                Image(systemName: "list.bullet")
                    .foregroundStyle(mode == .list ? DS.TextOnSurfaceColorPrimary : DS.TextOnSurfaceColorTertiary)
            }
            Button(action: { mode = .grid }) {
                Image(systemName: "square.grid.2x2")
                    .foregroundStyle(mode == .grid ? DS.TextOnSurfaceColorPrimary : DS.TextOnSurfaceColorTertiary)
            }
        }
        .font(.system(size: DS.FontFontSizeBodyLg))
    }
}

// MARK: - =============================================
// MARK: - PRODUCT LISTING PAGE
// MARK: - =============================================

struct ProductListingPage: View {
    // MARK: - State
    @State private var products: [Product] = []
    @State private var selectedFilters: Set<String> = []
    @State private var selectedSort: SortOption = .topRated
    @State private var viewMode: ViewMode = .list
    @State private var cartItemCount: Int = 3
    
    // MARK: - Constants
    private let categoryTitle = "REFRIGERATORS"
    private let filterOptions = ["Pickup", "Delivery", "Ship to Home"]
    
    var body: some View {
        ZStack {
            // Background
            DS.BackgroundSurfaceColorGreige
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Navigation - Morph_Menu
                MorphingNavHeader()
                    .background(.regularMaterial)
                    .zIndex(1)
                
                // Scrollable Content
                ScrollView {
                    VStack(alignment: .leading, spacing: DS.Spacing4) {
                        // Category header
                        categoryHeader
                        
                        // Filter chips
                        filterChipsRow
                        
                        // Results bar (count + sort + view toggle)
                        resultsBar
                        
                        // Product list using ProductCard from ProductSystem
                        productList
                        
                        // Bottom padding to account for tab bar
                        Spacer()
                            .frame(height: DS.Spacing16)
                    }
                    .padding(.horizontal, DS.Spacing4)
                }
                .scrollIndicators(.hidden)
                .safeAreaInset(edge: .top, spacing: 0) {
                    Color.clear.frame(height: 0)
                        .background(.ultraThinMaterial)
                }
                .safeAreaInset(edge: .bottom, spacing: 0) {
                    Color.clear.frame(height: 0)
                        .background(.ultraThinMaterial)
                }
                
                // Bottom Navigation - Bottom_Nav
                MorphingTabBar()
                    .background(.regularMaterial)
                    .zIndex(1)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            loadSampleProducts()
        }
    }
    
    // MARK: - Category Header
    private var categoryHeader: some View {
        Text(categoryTitle)
            .font(.system(size: DS.FontFontSizeH2, weight: .bold))
            .foregroundStyle(DS.TextOnSurfaceColorPrimary)
            .padding(.top, DS.Spacing4)
    }
    
    // MARK: - Filter Chips Row
    private var filterChipsRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DS.Spacing2) {
                ForEach(filterOptions, id: \.self) { filter in
                    FilterChip(
                        title: filter,
                        isSelected: selectedFilters.contains(filter),
                        action: {
                            if selectedFilters.contains(filter) {
                                selectedFilters.remove(filter)
                            } else {
                                selectedFilters.insert(filter)
                            }
                        }
                    )
                }
            }
        }
    }
    
    // MARK: - Results Bar
    private var resultsBar: some View {
        HStack {
            Text("\(products.count) Results")
                .font(.system(size: DS.FontFontSizeBodySm, weight: .medium))
                .foregroundStyle(DS.TextOnSurfaceColorSecondary)
            
            Spacer()
            
            // Sort menu
            Menu {
                ForEach(SortOption.allCases, id: \.self) { option in
                    Button(action: { selectedSort = option }) {
                        HStack {
                            Text(option.rawValue)
                            if selectedSort == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack(spacing: DS.Spacing1) {
                    Text("Sort:")
                        .foregroundStyle(DS.TextOnSurfaceColorSecondary)
                    Text(selectedSort.rawValue)
                        .foregroundStyle(DS.TextOnSurfaceColorPrimary)
                    Image(systemName: "chevron.down")
                        .foregroundStyle(DS.TextOnSurfaceColorPrimary)
                }
                .font(.system(size: DS.FontFontSizeBodySm))
            }
            
            Divider()
                .frame(height: 20)
                .padding(.horizontal, DS.Spacing2)
            
            // View toggle
            ViewToggle(mode: $viewMode)
        }
    }
    
    // MARK: - Product List
    private var productList: some View {
        LazyVStack(spacing: DS.Spacing4) {
            ForEach(sortedProducts) { product in
                // Using ProductCard from ProductSystem.swift
                ProductCard(
                    product: product,
                    onAddToCart: {
                        cartItemCount += 1
                    },
                    onImageTap: {
                        // Open lightbox
                        print("Opening lightbox for \(product.name)")
                    }
                )
            }
        }
    }
    
    // MARK: - Sorted Products
    private var sortedProducts: [Product] {
        switch selectedSort {
        case .topRated:
            return products.sorted { $0.rating > $1.rating }
        case .priceLowToHigh:
            return products.sorted { $0.currentPrice < $1.currentPrice }
        case .priceHighToLow:
            return products.sorted { $0.currentPrice > $1.currentPrice }
        case .bestSelling:
            return products.sorted { $0.reviewCount > $1.reviewCount }
        case .newest:
            return products // Assume already in newest order
        }
    }
    
    // MARK: - Load Sample Products
    private func loadSampleProducts() {
        // Sample products - in a real app, load from SampleProducts.json via ProductDataLoader
        products = [
            Product(
                id: "LHFS28XBS",
                brand: "LG",
                name: "28 cu. ft. 3-Door French Door Refrigerator with Ice and Water Dispenser and Craft Ice",
                modelNumber: "LHFS28XBS",
                heroImage: "LHFS28XBS_hero",
                thumbnailImages: ["LHFS28XBS_thumb1", "LHFS28XBS_thumb2", "LHFS28XBS_thumb3"],
                additionalImageCount: 12,
                currentPrice: 2699.00,
                originalPrice: 3499.00,
                savingsPercentage: 23,
                rating: 4.5,
                reviewCount: 1247,
                isExclusive: false,
                promotionalBadge: "Get it by Christmas",
                pickupInfo: FulfillmentInfo(
                    primaryValue: "143 in stock",
                    secondaryValue: "at Woodstock, GA",
                    highlightedText: "Woodstock, GA"
                ),
                deliveryInfo: FulfillmentInfo(
                    primaryValue: "Free",
                    secondaryValue: "Tomorrow"
                ),
                fasterDeliveryInfo: FulfillmentInfo(
                    primaryValue: "Get it in 4 hours"
                )
            ),
            Product(
                id: "RF29BB8600QL",
                brand: "Samsung",
                name: "Bespoke 4-Door Flex with AI Family Hub+ and AI Vision Inside",
                modelNumber: "RF29BB8600QL",
                heroImage: "RF29BB8600QL_hero",
                thumbnailImages: ["RF29BB8600QL_thumb1", "RF29BB8600QL_thumb2", "RF29BB8600QL_thumb3"],
                additionalImageCount: 8,
                currentPrice: 3499.00,
                originalPrice: nil,
                savingsPercentage: nil,
                rating: 4.7,
                reviewCount: 892,
                isExclusive: true,
                promotionalBadge: nil,
                pickupInfo: FulfillmentInfo(
                    primaryValue: "56 in stock",
                    secondaryValue: "at Woodstock, GA",
                    highlightedText: "Woodstock, GA"
                ),
                deliveryInfo: FulfillmentInfo(
                    primaryValue: "Free",
                    secondaryValue: "Dec 5"
                ),
                fasterDeliveryInfo: nil
            ),
            Product(
                id: "LMXS28626S",
                brand: "LG",
                name: "28 cu. ft. 4-Door French Door Smart Refrigerator with Ice and Water Dispenser",
                modelNumber: "LMXS28626S",
                heroImage: "LMXS28626S_hero",
                thumbnailImages: ["LMXS28626S_thumb1", "LMXS28626S_thumb2", "LMXS28626S_thumb3"],
                additionalImageCount: 15,
                currentPrice: 2199.00,
                originalPrice: 2799.00,
                savingsPercentage: 21,
                rating: 4.3,
                reviewCount: 3456,
                isExclusive: false,
                promotionalBadge: "Best Seller",
                pickupInfo: FulfillmentInfo(
                    primaryValue: "289 in stock",
                    secondaryValue: "at Woodstock, GA",
                    highlightedText: "Woodstock, GA"
                ),
                deliveryInfo: FulfillmentInfo(
                    primaryValue: "Free",
                    secondaryValue: "Tomorrow"
                ),
                fasterDeliveryInfo: FulfillmentInfo(
                    primaryValue: "Get it in 2 hours"
                )
            ),
            Product(
                id: "LF21G6200S",
                brand: "LG",
                name: "21 cu. ft. SMART Counter Depth MAX French Door Refrigerator",
                modelNumber: "LF21G6200S",
                heroImage: "LF21G6200S_hero",
                thumbnailImages: ["LF21G6200S_thumb1", "LF21G6200S_thumb2"],
                additionalImageCount: 6,
                currentPrice: 1799.00,
                originalPrice: 2299.00,
                savingsPercentage: 22,
                rating: 4.4,
                reviewCount: 567,
                isExclusive: false,
                promotionalBadge: nil,
                pickupInfo: FulfillmentInfo(
                    primaryValue: "78 in stock",
                    secondaryValue: "at Woodstock, GA",
                    highlightedText: "Woodstock, GA"
                ),
                deliveryInfo: FulfillmentInfo(
                    primaryValue: "Free",
                    secondaryValue: "Dec 4"
                ),
                fasterDeliveryInfo: nil
            ),
            Product(
                id: "RF30BB6600QL",
                brand: "Samsung",
                name: "Bespoke 3-Door French Door Refrigerator with Beverage Center",
                modelNumber: "RF30BB6600QL",
                heroImage: "RF30BB6600QL_hero",
                thumbnailImages: ["RF30BB6600QL_thumb1", "RF30BB6600QL_thumb2"],
                additionalImageCount: 10,
                currentPrice: 2799.00,
                originalPrice: 3299.00,
                savingsPercentage: 15,
                rating: 4.6,
                reviewCount: 1123,
                isExclusive: true,
                promotionalBadge: "Get it by Christmas",
                pickupInfo: FulfillmentInfo(
                    primaryValue: "34 in stock",
                    secondaryValue: "at Woodstock, GA",
                    highlightedText: "Woodstock, GA"
                ),
                deliveryInfo: FulfillmentInfo(
                    primaryValue: "Free",
                    secondaryValue: "Tomorrow"
                ),
                fasterDeliveryInfo: FulfillmentInfo(
                    primaryValue: "Get it in 3 hours"
                )
            )
        ]
    }
}

// MARK: - =============================================
// MARK: - PREVIEWS
// MARK: - =============================================

#Preview("Product Listing Page") {
    ProductListingPage()
}

#Preview("Filter Chips") {
    HStack(spacing: 8) {
        FilterChip(title: "Pickup", isSelected: true, action: {})
        FilterChip(title: "Delivery", isSelected: false, action: {})
        FilterChip(title: "Ship to Home", isSelected: false, action: {})
    }
    .padding()
    .background(DesignSystemGlobal.BackgroundSurfaceColorGreige)
}
