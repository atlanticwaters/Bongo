import SwiftUI

// MARK: - Interactive Glass View
// Showcases interactive components that respond to user input with smooth animations
struct InteractiveGlassView: View {

    // MARK: - State Properties
    @State private var isPressed = false
    @State private var selectedTab: Int = 0
    @State private var toggleValue = false
    @State private var sliderValue: CGFloat = 0.5

    // MARK: - View Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // MARK: Header
                    Text("Interactive Glass Components")
                        .font(.system(size: 28, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()

                    // MARK: Glass Button Demo
                    VStack(spacing: 12) {
                        Text("Glass Buttons")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        VStack(spacing: 12) {
                            // Primary glass button
                            Button(action: { }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "checkmark.circle.fill")
                                    Text("Primary Action")
                                        .font(.headline)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(16)
                                .foregroundColor(.white)
                            }
                            .buttonStyle(.glass)
                            // Add scale animation on press
                            .scaleEffect(isPressed ? 0.95 : 1.0)
                            .onLongPressGesture(
                                minimumDuration: 0,
                                perform: { },
                                onPressingChanged: { pressing in
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        isPressed = pressing
                                    }
                                }
                            )

                            // Secondary glass button
                            Button(action: { }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "plus.circle")
                                    Text("Secondary Action")
                                        .font(.headline)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(16)
                                .background(.thinMaterial)
                                .foregroundColor(.blue)
                                .cornerRadius(12)
                            }

                            // Tertiary glass button
                            Button(action: { }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "trash")
                                    Text("Destructive Action")
                                        .font(.headline)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(16)
                                .background(.ultraThinMaterial)
                                .foregroundColor(.red)
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding()
                    .background(.gray.opacity(0.05))
                    .cornerRadius(12)

                    // MARK: Toggle with Glass Background
                    VStack(spacing: 12) {
                        Text("Interactive Controls")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Enable Feature")
                                    .font(.headline)
                                Text("Toggle to activate")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            // Toggle switch with glass background
                            Toggle("", isOn: $toggleValue)
                                .tint(.blue)  // Color when enabled
                        }
                        .padding(12)
                        .background(.thinMaterial)
                        .cornerRadius(12)

                        // Show content conditionally based on toggle
                        if toggleValue {
                            Text("Feature is now enabled!")
                                .font(.body)
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .background(.regularMaterial)
                                .foregroundColor(.green)
                                .cornerRadius(12)
                                // Transition: fades in smoothly
                                .transition(.opacity)
                        }
                    }
                    .padding()
                    .background(.gray.opacity(0.05))
                    .cornerRadius(12)

                    // MARK: Slider with Glass Background
                    VStack(spacing: 12) {
                        Text("Slider Control")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        VStack(spacing: 12) {
                            // Display current value
                            Text("Value: \(String(format: "%.0f%%", sliderValue * 100))")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .foregroundColor(.white)
                                .glassEffect(in: .rect(cornerRadius: 8))

                            // Interactive slider
                            Slider(value: $sliderValue, in: 0...1)
                                .tint(.blue)  // Track color
                                .padding()
                                .background(.thinMaterial)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(.gray.opacity(0.05))
                    .cornerRadius(12)

                    // MARK: Tab Navigation with Glass
                    VStack(spacing: 12) {
                        Text("Segmented Tabs")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // Custom segmented control using HStack and buttons
                        HStack(spacing: 0) {
                            ForEach(0..<3, id: \.self) { index in
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        selectedTab = index
                                    }
                                }) {
                                    Text(["Overview", "Details", "More"][index])
                                        .font(.headline)
                                        .frame(maxWidth: .infinity)
                                        .padding(12)
                                        .foregroundColor(
                                            selectedTab == index ? .white : .blue
                                        )
                                        .background(
                                            Group {
                                                if selectedTab == index {
                                                    RoundedRectangle(cornerRadius: 0)
                                                        .fill(.thinMaterial)
                                                }
                                            }
                                        )
                                }
                            }
                        }
                        .background(.thinMaterial)
                        .cornerRadius(12)

                        // Content based on selected tab
                        VStack {
                            if selectedTab == 0 {
                                Text("Overview Content")
                                    .font(.body)
                            } else if selectedTab == 1 {
                                Text("Details Content")
                                    .font(.body)
                            } else {
                                Text("More Content")
                                    .font(.body)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(.regularMaterial)
                        .cornerRadius(12)
                        .transition(.opacity)
                    }
                    .padding()
                    .background(.gray.opacity(0.05))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle("Interactive Glass")
        }
    }
}

// MARK: - Preview
#Preview {
    InteractiveGlassView()
}
