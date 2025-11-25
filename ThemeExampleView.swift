//
// ThemeExampleView.swift
//
// Example view demonstrating proper usage of the app theme system
//

import SwiftUI

// MARK: - Theme Example View
/// Demonstrates all the ways to use the centralized theme system
struct ThemeExampleView: View {
    
    // MARK: - State
    @State private var isLiked = false
    @State private var rating = 3
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // MARK: - Brand Color Examples
                    brandColorSection
                    
                    // MARK: - Card Background Examples
                    cardBackgroundSection
                    
                    // MARK: - Icon Examples
                    iconSection
                    
                    // MARK: - Text Hierarchy Examples
                    textHierarchySection
                    
                    // MARK: - Interactive Examples
                    interactiveSection
                }
                .padding()
            }
            .navigationTitle("Theme Examples")
            .themedAppBackground()  // Applies Griege 050 background
        }
        .tint(AppTheme.brandColor)  // Brand color for navigation elements
    }
    
    // MARK: - Brand Color Section
    private var brandColorSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Brand Colors")
                .font(.headline)
                .foregroundStyle(Color.textPrimary)
            
            Text("Primary brand color is used for accents and interactive elements")
                .font(.caption)
                .foregroundStyle(Color.textSecondary)
            
            HStack(spacing: 16) {
                // Brand primary color swatch
                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.brandPrimary)
                        .frame(width: 60, height: 60)
                    
                    Text("Brand")
                        .font(.caption)
                        .foregroundStyle(Color.textSecondary)
                }
                
                // Brand dark color swatch
                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.brandDark)
                        .frame(width: 60, height: 60)
                    
                    Text("Dark")
                        .font(.caption)
                        .foregroundStyle(Color.textSecondary)
                }
                
                Spacer()
            }
        }
        .themedContainer()  // Applies padding + Griege 200 background
    }
    
    // MARK: - Card Background Section
    private var cardBackgroundSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Background Colors")
                .font(.headline)
                .foregroundStyle(Color.textPrimary)
            
            Text("Consistent backgrounds create visual hierarchy")
                .font(.caption)
                .foregroundStyle(Color.textSecondary)
            
            VStack(spacing: 12) {
                // App background example
                HStack {
                    Circle()
                        .fill(Color.appBackground)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Circle()
                                .stroke(Color.borderDefault, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("App Background")
                            .font(.subheadline)
                            .foregroundStyle(Color.textPrimary)
                        
                        Text("Griege 050 - Main background")
                            .font(.caption)
                            .foregroundStyle(Color.textTertiary)
                    }
                    
                    Spacer()
                }
                
                // Card background example
                HStack {
                    Circle()
                        .fill(Color.cardBackground)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Circle()
                                .stroke(Color.borderDefault, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Card Background")
                            .font(.subheadline)
                            .foregroundStyle(Color.textPrimary)
                        
                        Text("Griege 200 - Cards & containers")
                            .font(.caption)
                            .foregroundStyle(Color.textTertiary)
                    }
                    
                    Spacer()
                }
            }
        }
        .themedContainer()
    }
    
    // MARK: - Icon Section
    private var iconSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Icon Styling")
                .font(.headline)
                .foregroundStyle(Color.textPrimary)
            
            Text("Use .brandTinted() for accent icons")
                .font(.caption)
                .foregroundStyle(Color.textSecondary)
            
            HStack(spacing: 24) {
                // Brand tinted icon
                VStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 32))
                        .brandTinted()  // Applies brand orange color
                    
                    Text("Brand")
                        .font(.caption)
                        .foregroundStyle(Color.textSecondary)
                }
                
                // Accent icon style
                VStack(spacing: 8) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 32))
                        .accentIconStyle()  // Alternative accent styling
                    
                    Text("Accent")
                        .font(.caption)
                        .foregroundStyle(Color.textSecondary)
                }
                
                // Standard icon
                VStack(spacing: 8) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(AppTheme.iconPrimary)
                    
                    Text("Primary")
                        .font(.caption)
                        .foregroundStyle(Color.textSecondary)
                }
                
                Spacer()
            }
        }
        .themedContainer()
    }
    
    // MARK: - Text Hierarchy Section
    private var textHierarchySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Text Hierarchy")
                .font(.headline)
                .foregroundStyle(Color.textPrimary)
            
            Text("Use semantic text colors for proper hierarchy")
                .font(.caption)
                .foregroundStyle(Color.textSecondary)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Primary text color")
                    .font(.body)
                    .foregroundStyle(Color.textPrimary)
                
                Text("Secondary text color for descriptions")
                    .font(.body)
                    .foregroundStyle(Color.textSecondary)
                
                Text("Tertiary text color for labels and hints")
                    .font(.body)
                    .foregroundStyle(Color.textTertiary)
            }
        }
        .themedContainer()
    }
    
    // MARK: - Interactive Section
    private var interactiveSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Interactive Elements")
                .font(.headline)
                .foregroundStyle(Color.textPrimary)
            
            Text("Buttons and controls use brand colors automatically")
                .font(.caption)
                .foregroundStyle(Color.textSecondary)
            
            VStack(spacing: 12) {
                // Like button
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        isLiked.toggle()
                    }
                } label: {
                    HStack {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .brandTinted()
                        Text(isLiked ? "Liked" : "Like")
                            .foregroundStyle(Color.textPrimary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appBackground)
                    .cornerRadius(8)
                }
                .buttonStyle(.plain)
                
                // Rating picker - uses brand color as tint
                Picker("Rating", selection: $rating) {
                    ForEach(1...5, id: \.self) { star in
                        Text("\(star) Star\(star > 1 ? "s" : "")")
                    }
                }
                .pickerStyle(.menu)
                
                // Action button with brand color
                Button {
                    print("Action performed")
                } label: {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Primary Action")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.brandColor)
                    .foregroundStyle(.white)
                    .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
        }
        .themedContainer()
    }
}

// MARK: - Example Usage in a Product Card

/// Example of how to build a product card with the theme system
struct ThemedProductCard: View {
    let productName: String
    let price: String
    let rating: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Product image placeholder
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.appBackground)
                .aspectRatio(16/9, contentMode: .fit)
                .overlay(
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundStyle(Color.textTertiary)
                )
            
            // Product info
            VStack(alignment: .leading, spacing: 4) {
                Text(productName)
                    .font(.headline)
                    .foregroundStyle(Color.textPrimary)
                    .lineLimit(2)
                
                HStack {
                    // Star rating
                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(rating) ? "star.fill" : "star")
                                .font(.caption)
                                .brandTinted()  // Orange stars
                        }
                    }
                    
                    Text(String(format: "%.1f", rating))
                        .font(.caption)
                        .foregroundStyle(Color.textSecondary)
                }
                
                Text(price)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.textPrimary)
            }
        }
        .themedCard()  // Applies Griege 200 background
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}

// MARK: - Preview

#Preview("Theme Examples") {
    ThemeExampleView()
}

#Preview("Product Card") {
    ThemedProductCard(
        productName: "Genesis E-315 3-Burner Liquid Propane Gas Grill",
        price: "$899.00",
        rating: 4.5
    )
    .padding()
    .themedAppBackground()
}
