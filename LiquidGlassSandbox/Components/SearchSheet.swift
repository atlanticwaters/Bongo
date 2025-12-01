import SwiftUI

// MARK: - Design System Type Alias
private typealias DS = DesignSystemGlobal

// MARK: - Filter Option Model
/// Represents a filter option in the sheet
struct FilterOption: Identifiable {
    let id: Int
    let label: String
    var currentValue: String? = nil  // Optional secondary label showing current selection
}

// MARK: - Sort & Filter Sheet View
/// A bottom sheet for sorting and filtering product listings.
/// Uses native iOS sheet presentation with custom styling.
struct SortFilterSheet: View {
    
    // MARK: - Bindings
    @Binding var isPresented: Bool
    
    // MARK: - Filter Options Data
    private let filterOptions: [FilterOption] = [
        FilterOption(id: 0, label: "Sort By", currentValue: "Best Match"),
        FilterOption(id: 1, label: "Get it Fast"),
        FilterOption(id: 2, label: "Category"),
        FilterOption(id: 3, label: "Review Rating"),
        FilterOption(id: 4, label: "Bundle / Single"),
        FilterOption(id: 5, label: "Bulk Delivery"),
        FilterOption(id: 6, label: "New Arrival"),
        FilterOption(id: 7, label: "Brand"),
        FilterOption(id: 8, label: "Price"),
        FilterOption(id: 9, label: "Shelf Width"),
        FilterOption(id: 10, label: "Decorative Shelving Type"),
        FilterOption(id: 11, label: "Shelf Material"),
        FilterOption(id: 12, label: "Shelf Size"),
        FilterOption(id: 13, label: "Shelf Color Family")
    ]
    
    // MARK: - Colors from Design System
    private let textColor = DS.TextOnSurfaceColorPrimary                   // Primary text
    private let secondaryTextColor = DS.TextOnSurfaceColorTertiary         // Secondary text
    private let backgroundColor = DS.BackgroundSurfaceColorGreige          // Sheet background
    private let rowBackground = DS.BackgroundContainerColorWhite         // Row background
    private let closeButtonBackground = DS.GreigeGreige100                 // Close button bg
    private let indicatorColor = DS.GreigeGreige200                        // Drag indicator
    
    // MARK: - Sizing from Design System
    private let closeButtonSize = DS.Spacing11         // 44pt - close button dimensions
    private let closeIconSize = DS.FontFontSizeBodyLg  // 18pt - close icon size
    private let titleSize = DS.FontFontSizeBodyLg      // 18pt - title size
    private let labelSize = DS.FontFontSizeBodyMd      // 16pt - row label size
    private let secondaryLabelSize = DS.FontFontSizeBodySm // 14pt - secondary label size
    private let rowCornerRadius = DS.BorderRadius3xl   // 16pt - row corner radius
    
    // MARK: - Spacing from Design System
    private let horizontalPadding = DS.Spacing4        // 16pt - outer horizontal padding
    private let verticalPadding = DS.Spacing3          // 12pt - vertical padding
    private let rowSpacing = DS.Spacing2               // 8pt - space between rows
    private let rowInternalPadding = DS.Spacing4       // 16pt - padding inside rows
    private let headerBottomPadding = DS.Spacing5      // 20pt - space below header
    private let indicatorWidth = DS.Spacing9           // 36pt - drag indicator width
    private let indicatorHeight = DS.Spacing1          // 4pt - drag indicator height
    private let indicatorTopPadding = DS.Spacing2      // 8pt - space above indicator
    private let labelStackSpacing = DS.Spacing1        // 4pt - space between label and value
    
    // MARK: - Row Heights
    // ⬇️ ROW HEIGHT SETTINGS ARE HERE ⬇️
    private let firstRowHeight = DS.Spacing16          // 72pt - taller first row (Sort By)
    private let standardRowHeight = DS.Spacing10       // 56pt - standard row height
    
    var body: some View {
        VStack(spacing: DS.Spacing0) {
            // Drag indicator
            dragIndicator
            
            // Header with title and close button
            header
            
            // Scrollable list of filter options
            filterList
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
            Text("Sort & Filter")
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
    
    // MARK: - Filter List
    private var filterList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: rowSpacing) {
                ForEach(filterOptions) { option in
                    filterRow(for: option, isFirstRow: option.id == 0)
                }
            }
            .padding(.horizontal, horizontalPadding)
        }
    }
    
    // MARK: - Filter Row
    /// - Parameter isFirstRow: When true, uses taller height for the first row
    private func filterRow(for option: FilterOption, isFirstRow: Bool = false) -> some View {
        // Use firstRowHeight for first row, standardRowHeight for all others
        let rowHeight = isFirstRow ? firstRowHeight : standardRowHeight
        
        return Button(action: {
            // Handle filter option tap - could navigate to sub-sheet or expand
            print("\(option.label) tapped")
        }) {
            HStack {
                VStack(alignment: .leading, spacing: labelStackSpacing) {
                    // Primary label
                    Text(option.label)
                        .font(.system(size: labelSize, weight: .regular))
                        .foregroundStyle(textColor)
                    
                    // Secondary label (current value) if present
                    if let currentValue = option.currentValue {
                        Text(currentValue)
                            .font(.system(size: secondaryLabelSize, weight: .regular))
                            .foregroundStyle(secondaryTextColor)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, rowInternalPadding)
            .frame(height: rowHeight)
            .background(
                RoundedRectangle(cornerRadius: rowCornerRadius)
                    .fill(rowBackground)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Sheet Presentation Modifier
/// A view modifier to present the SortFilterSheet
struct SortFilterSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                SortFilterSheet(isPresented: $isPresented)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden) // We use custom indicator
                    .presentationBackground(DesignSystemGlobal.BackgroundSurfaceColorGreige)
            }
    }
}

// MARK: - View Extension
extension View {
    func sortFilterSheet(isPresented: Binding<Bool>) -> some View {
        modifier(SortFilterSheetModifier(isPresented: isPresented))
    }
}

// MARK: - Preview
#Preview("Sheet Only") {
    SortFilterSheet(isPresented: .constant(true))
}

#Preview("Full Context") {
    struct PreviewWrapper: View {
        @State private var showSheet = false
        
        var body: some View {
            ZStack {
                DesignSystemGlobal.BackgroundSurfaceColorGreige
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    MorphingNavHeader()
                    
                    Spacer()
                    
                    // Demo button to trigger sheet
                    Button("Show Sort & Filter") {
                        showSheet = true
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(DesignSystemGlobal.BackgroundButtonColorBrandFilledDefault)
                    
                    Spacer()
                    
                    MorphingTabBar()
                }
            }
            .sortFilterSheet(isPresented: $showSheet)
        }
    }
    
    return PreviewWrapper()
}
