// SwiftUI Layout Fundamentals Reference
// Source: https://developer.apple.com/documentation/swiftui/layout-fundamentals

import SwiftUI

// MARK: - Stack Layouts

/// VStack - Vertical stack layout
struct VStackExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("VStack arranges views vertically")
                .font(.headline)
            
            // Default spacing
            VStack {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
            }
            .padding()
            .background(Color. blue. opacity(0.2))
            .cornerRadius(10)
            
            // Custom spacing
            VStack(spacing:  30) {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
            }
            . padding()
            .background(Color.green.opacity(0.2))
            .cornerRadius(10)
            
            // With alignment
            VStack(alignment: .leading, spacing: 10) {
                Text("Leading aligned")
                Text("Also leading")
                Text("All leading")
            }
            . frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color. orange.opacity(0.2))
            .cornerRadius(10)
        }
        .padding()
    }
}

/// HStack - Horizontal stack layout
struct HStackExample: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("HStack arranges views horizontally")
                .font(.headline)
            
            // Default spacing
            HStack {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
            }
            .padding()
            .background(Color. blue.opacity(0.2))
            .cornerRadius(10)
            
            // Custom spacing
            HStack(spacing: 30) {
                Circle().fill(Color.red).frame(width: 40, height: 40)
                Circle().fill(Color.green).frame(width: 40, height: 40)
                Circle().fill(Color.blue).frame(width: 40, height: 40)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            
            // With alignment
            HStack(alignment: .top, spacing: 10) {
                Text("Top")
                    .font(.caption)
                Text("Aligned")
                    .font(.title)
                Text("Items")
                    .font(.body)
            }
            .padding()
            .background(Color. purple.opacity(0.2))
            .cornerRadius(10)
        }
        .padding()
    }
}

/// ZStack - Layered stack layout
struct ZStackExample: View {
    var body:  some View {
        VStack(spacing: 30) {
            Text("ZStack layers views on top of each other")
                .font(.headline)
                .padding()
            
            // Basic layering
            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    . frame(width: 200, height: 200)
                
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 150, height: 150)
                
                Rectangle()
                    . fill(Color.red)
                    .frame(width: 100, height: 100)
            }
            
            // With alignment
            ZStack(alignment: . topLeading) {
                Rectangle()
                    .fill(Color.blue. opacity(0.3))
                    .frame(width: 250, height: 150)
                
                Text("Top Leading")
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(5)
            }
            
            // Practical example:  Badge
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue)
                    .frame(width: 200, height: 100)
                    .overlay(
                        Text("Notification")
                            .foregroundColor(.white)
                    )
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text("5")
                            .foregroundColor(.white)
                            .font(.caption)
                    )
                    .offset(x: 10, y: -10)
            }
        }
        .padding()
    }
}

// MARK: - Spacer and Divider

struct SpacerAndDividerExample:  View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Spacer & Divider")
                .font(.headline)
            
            // Spacer pushes content
            VStack {
                Text("Top")
                Spacer()
                Text("Bottom")
            }
            .frame(height: 150)
            .padding()
            .background(Color. blue.opacity(0.2))
            .cornerRadius(10)
            
            // Spacer with min length
            HStack {
                Text("Left")
                Spacer(minLength: 50)
                Text("Right")
            }
            .padding()
            .background(Color. green.opacity(0.2))
            .cornerRadius(10)
            
            // Divider
            VStack(spacing: 0) {
                Text("Section 1")
                    .padding()
                Divider()
                Text("Section 2")
                    .padding()
                Divider()
                Text("Section 3")
                    . padding()
            }
            . background(Color.orange.opacity(0.2))
            .cornerRadius(10)
            
            // Horizontal divider in HStack
            HStack(spacing:  0) {
                Text("Left")
                    .frame(maxWidth: .infinity)
                Divider()
                Text("Right")
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 60)
            .background(Color. purple.opacity(0.2))
            .cornerRadius(10)
        }
        .padding()
    }
}

// MARK: - Frame and Sizing

struct FrameAndSizingExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Frame & Sizing")
                    .font(.headline)
                
                // Fixed frame
                Text("Fixed 200x100")
                    .frame(width: 200, height: 100)
                    .background(Color.blue)
                    .foregroundColor(.white)
                
                // Minimum frame
                Text("Min 150x80")
                    .frame(minWidth: 150, minHeight:  80)
                    .background(Color.green)
                    .foregroundColor(.white)
                
                // Maximum frame
                Text("Max Width")
                    .frame(maxWidth: .infinity)
                    . padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                
                // Ideal frame
                Text("Ideal 180x90")
                    .frame(idealWidth: 180, idealHeight: 90)
                    .background(Color.purple)
                    .foregroundColor(.white)
                
                // Combined constraints
                Text("Combined")
                    .frame(minWidth: 100, maxWidth: 300, minHeight: 50, maxHeight: 100)
                    .background(Color.red)
                    .foregroundColor(.white)
                
                // Frame with alignment
                Text("Trailing")
                    .frame(width: 250, height: 80, alignment: .trailing)
                    .background(Color.cyan. opacity(0.3))
                    .border(Color.cyan)
                
                Text("Top Leading")
                    .frame(width: 250, height: 80, alignment:  .topLeading)
                    .background(Color.pink.opacity(0.3))
                    .border(Color.pink)
            }
            .padding()
        }
    }
}

// MARK:  - Alignment

struct AlignmentExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Alignment Guide")
                    .font(.headline)
                
                // HStack alignments
                Group {
                    HStack(alignment: .top) {
                        alignmentBox("Top", height: 60)
                        alignmentBox("Top", height: 100)
                        alignmentBox("Top", height: 80)
                    }
                    
                    HStack(alignment:  .center) {
                        alignmentBox("Center", height: 60)
                        alignmentBox("Center", height: 100)
                        alignmentBox("Center", height: 80)
                    }
                    
                    HStack(alignment: .bottom) {
                        alignmentBox("Bottom", height: 60)
                        alignmentBox("Bottom", height:  100)
                        alignmentBox("Bottom", height: 80)
                    }
                }
                
                // VStack alignments
                Group {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Leading aligned")
                        Text("Also leading")
                        Text("All leading")
                    }
                    . frame(maxWidth: .infinity, alignment: .leading)
                    . padding()
                    .background(Color.blue.opacity(0.2))
                    
                    VStack(alignment: . center, spacing: 10) {
                        Text("Center aligned")
                        Text("Also center")
                        Text("All center")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green. opacity(0.2))
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text("Trailing aligned")
                        Text("Also trailing")
                        Text("All trailing")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                    .background(Color.orange. opacity(0.2))
                }
                
                // Custom alignment
                HStack(alignment: .customCenter, spacing: 20) {
                    Text("Custom")
                        .font(.title)
                        .alignmentGuide(.customCenter) { d in d[VerticalAlignment.center] }
                    
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 60, height:  60)
                        .alignmentGuide(.customCenter) { d in d[VerticalAlignment.center] }
                    
                    Text("Alignment")
                        .font(.caption)
                        .alignmentGuide(.customCenter) { d in d[VerticalAlignment.center] }
                }
                . padding()
                .background(Color.purple.opacity(0.2))
            }
            .padding()
        }
    }
    
    func alignmentBox(_ text: String, height: CGFloat) -> some View {
        Text(text)
            .frame(width: 80, height: height)
            .background(Color.blue. opacity(0.3))
            .border(Color.blue)
    }
}

// Custom alignment guide
extension VerticalAlignment {
    static let customCenter = VerticalAlignment(CustomCenter.self)
}

private struct CustomCenter: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context[VerticalAlignment.center]
    }
}

// MARK: - Padding and Spacing

struct PaddingAndSpacingExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Padding & Spacing")
                    . font(.headline)
                
                // Uniform padding
                Text("Padding 20")
                    .padding(20)
                    .background(Color. blue)
                    .foregroundColor(.white)
                
                // Directional padding
                Text("Custom Padding")
                    .padding(. top, 30)
                    .padding(.leading, 40)
                    . padding(.trailing, 10)
                    .padding(.bottom, 20)
                    . background(Color.green)
                    .foregroundColor(.white)
                
                // Edge insets
                Text("Edge Insets")
                    . padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40))
                    .background(Color.orange)
                    .foregroundColor(.white)
                
                // Multiple paddings (compound)
                Text("Multiple")
                    .padding()
                    .background(Color.red)
                    .padding()
                    .background(Color. blue)
                    .padding()
                    .background(Color. green)
                    .foregroundColor(.white)
                
                // Stack spacing
                VStack(spacing: 0) {
                    Text("No Spacing")
                    Text("Between")
                    Text("Items")
                }
                .padding()
                .background(Color. purple. opacity(0.2))
                
                VStack(spacing: 20) {
                    Text("20pt Spacing")
                    Text("Between")
                    Text("Items")
                }
                .padding()
                .background(Color.cyan.opacity(0.2))
            }
            .padding()
        }
    }
}

// MARK: - Overlay and Background

struct OverlayAndBackgroundExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Overlay & Background")
                    .font(.headline)
                
                // Basic background
                Text("Background")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(. white)
                
                // Shaped background
                Text("Rounded Background")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.green)
                    )
                    .foregroundColor(.white)
                
                // Gradient background
                Text("Gradient")
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [. blue, .purple],
                            startPoint: .leading,
                            endPoint: . trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                // Basic overlay
                Circle()
                    .fill(Color.orange)
                    .frame(width: 100, height: 100)
                    .overlay(
                        Text("Overlay")
                            . foregroundColor(.white)
                    )
                
                // Complex overlay
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue)
                    .frame(width: 200, height: 150)
                    .overlay(
                        VStack {
                            Text("Complex")
                                .font(.title)
                            Text("Overlay")
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                    )
                
                // Overlay with alignment
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 200, height: 150)
                    .overlay(
                        Text("Top Trailing")
                            .foregroundColor(.white)
                            .padding(8),
                        alignment: .topTrailing
                    )
                
                // Combined background and overlay
                Text("Both")
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                        Circle()
                            .fill(Color.red)
                            .frame(width: 20, height: 20)
                            .overlay(
                                Text("3")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                            ),
                        alignment: .topTrailing
                    )
                    .padding()
            }
            .padding()
        }
    }
}

// MARK:  - GeometryReader

struct GeometryReaderExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("GeometryReader")
                    .font(.headline)
                
                // Basic GeometryReader
                GeometryReader { geometry in
                    VStack {
                        Text("Width: \(Int(geometry.size.width))")
                        Text("Height: \(Int(geometry.size.height))")
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color.blue. opacity(0.2))
                }
                .frame(height: 100)
                
                // Responsive layout
                GeometryReader { geometry in
                    HStack(spacing: 10) {
                        ForEach(0..<3) { _ in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green)
                                .frame(width: (geometry.size.width - 20) / 3)
                        }
                    }
                }
                .frame(height: 100)
                
                // Safe area insets
                GeometryReader { geometry in
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Safe Area:")
                            .font(.caption)
                        Text("Top:  \(Int(geometry.safeAreaInsets.top))")
                            .font(.caption2)
                        Text("Bottom:  \(Int(geometry.safeAreaInsets.bottom))")
                            .font(.caption2)
                        Text("Leading: \(Int(geometry.safeAreaInsets.leading))")
                            .font(.caption2)
                        Text("Trailing: \(Int(geometry.safeAreaInsets.trailing))")
                            .font(.caption2)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.orange.opacity(0.2))
                }
                .frame(height: 120)
                
                // Circular layout with GeometryReader
                GeometryReader { geometry in
                    ZStack {
                        ForEach(0..<8) { index in
                            let angle = Double(index) * (360.0 / 8.0) * .pi / 180.0
                            let radius = min(geometry.size.width, geometry.size.height) / 3
                            
                            Circle()
                                .fill(Color. purple)
                                .frame(width: 30, height: 30)
                                .offset(
                                    x: cos(angle) * radius,
                                    y: sin(angle) * radius
                                )
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .frame(height: 200)
            }
            .padding()
        }
    }
}

// MARK: - Layout Priority

struct LayoutPriorityExample: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Layout Priority")
                .font(.headline)
            
            // Without priority
            HStack {
                Text("This is a long text that might get truncated")
                    .lineLimit(1)
                    .background(Color.blue. opacity(0.2))
                
                Text("Short")
                    .background(Color.green. opacity(0.2))
            }
            .padding()
            .border(Color.gray)
            
            // With priority
            HStack {
                Text("This is a long text that gets priority")
                    .lineLimit(1)
                    .layoutPriority(1)
                    .background(Color.blue. opacity(0.2))
                
                Text("Short")
                    .background(Color.green. opacity(0.2))
            }
            .padding()
            .border(Color.gray)
            
            // Multiple priorities
            HStack {
                Text("Low")
                    .layoutPriority(0)
                    .background(Color.red.opacity(0.2))
                
                Text("Medium")
                    .layoutPriority(1)
                    .background(Color.orange.opacity(0.2))
                
                Text("High")
                    .layoutPriority(2)
                    .background(Color.green.opacity(0.2))
            }
            .padding()
            .border(Color.gray)
        }
        .padding()
    }
}

// MARK: - Fixed Size

struct FixedSizeExample:  View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Fixed Size")
                    .font(.headline)
                
                // Without fixedSize
                Text("This is a long text that will wrap to multiple lines in the available space")
                    .frame(width: 150)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                
                // With fixedSize
                Text("This is a long text that will wrap to multiple lines in the available space")
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 150)
                    .padding()
                    .background(Color.green.opacity(0.2))
                
                // Horizontal fixedSize
                HStack {
                    Text("Not Fixed")
                        .padding()
                        .background(Color.orange.opacity(0.2))
                    
                    Text("Fixed")
                        .fixedSize()
                        .padding()
                        .background(Color.purple.opacity(0.2))
                }
                .frame(width: 200)
                .border(Color.gray)
                
                // Prevent truncation
                HStack {
                    Text("This text would normally truncate")
                        . lineLimit(1)
                        . background(Color.red.opacity(0.2))
                    
                    Spacer()
                }
                .frame(width: 200)
                .border(Color.gray)
                
                HStack {
                    Text("This text won't truncate")
                        . fixedSize()
                        .background(Color. green.opacity(0.2))
                    
                    Spacer()
                }
                .frame(width: 200)
                .border(Color.gray)
            }
            .padding()
        }
    }
}

// MARK: - Aspect Ratio

struct AspectRatioExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Aspect Ratio")
                    .font(.headline)
                
                // Fit mode
                Rectangle()
                    .fill(Color.blue)
                    .aspectRatio(16/9, contentMode: .fit)
                    .frame(width: 300)
                    .border(Color.gray)
                
                Text("16:9 - Fit")
                    .font(.caption)
                
                // Fill mode
                Rectangle()
                    .fill(Color.green)
                    .aspectRatio(16/9, contentMode: .fill)
                    .frame(width: 300, height: 150)
                    .clipped()
                    .border(Color.gray)
                
                Text("16:9 - Fill")
                    .font(.caption)
                
                // Square aspect ratio
                Image(systemName: "photo. fill")
                    .resizable()
                    .aspectRatio(1, contentMode: . fit)
                    .frame(width: 150)
                    .foregroundColor(.orange)
                
                Text("1:1 Square")
                    .font(.caption)
                
                // Different ratios
                HStack(spacing: 20) {
                    Rectangle()
                        .fill(Color.red)
                        .aspectRatio(1, contentMode:  .fit)
                    
                    Rectangle()
                        .fill(Color.orange)
                        .aspectRatio(4/3, contentMode: .fit)
                    
                    Rectangle()
                        .fill(Color.yellow)
                        .aspectRatio(16/9, contentMode:  .fit)
                }
                .frame(height: 100)
            }
            .padding()
        }
    }
}

// MARK: - Practical Example:  Card Layout

struct CardLayoutExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Card Layout Examples")
                    .font(.headline)
                    .padding()
                
                // Simple card
                VStack(alignment: .leading, spacing: 10) {
                    Text("Simple Card")
                        .font(. title2)
                        .bold()
                    
                    Text("This is a basic card layout with padding, background, and rounded corners.")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Spacer()
                        Button("Action") {}
                            .buttonStyle(. bordered)
                    }
                }
                .padding()
                .background(Color(. systemBackground))
                .cornerRadius(15)
                .shadow(radius: 5)
                . padding(. horizontal)
                
                // Image card
                VStack(alignment:  .leading, spacing: 0) {
                    Image(systemName: "photo. fill")
                        .resizable()
                        .aspectRatio(16/9, contentMode: .fit)
                        .foregroundColor(.blue)
                        .background(Color.blue.opacity(0.1))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Image Card")
                            .font(. headline)
                        
                        Text("Card with image header")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
                .background(Color(.systemBackground))
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)
                
                // Profile card
                HStack(spacing: 15) {
                    Circle()
                        .fill(Color.purple. gradient)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Text("JD")
                                .foregroundColor(.white)
                                .font(.title3)
                        )
                    
                    VStack(alignment:  .leading, spacing: 4) {
                        Text("John Doe")
                            .font(. headline)
                        
                        Text("iOS Developer")
                            .font(. subheadline)
                            . foregroundColor(.secondary)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundColor(.yellow)
                            Text("4.8")
                                .font(.caption)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(. systemBackground))
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)
            }
            .padding(. vertical)
        }
    }
}

// MARK: - Practical Example: Responsive Grid

struct ResponsiveGridExample: View {
    let items = Array(1...12)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Responsive Grid")
                    .font(.headline)
                
                // Fixed columns
                LazyVGrid(columns: [
                    GridItem(.fixed(100)),
                    GridItem(.fixed(100)),
                    GridItem(. fixed(100))
                ], spacing: 15) {
                    ForEach(items, id: \.self) { item in
                        gridBox(item)
                    }
                }
                .padding()
                
                Text("Flexible Columns")
                    .font(.headline)
                
                // Flexible columns
                LazyVGrid(columns:  [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 15) {
                    ForEach(items, id: \.self) { item in
                        gridBox(item)
                    }
                }
                .padding()
                
                Text("Adaptive Columns")
                    .font(.headline)
                
                // Adaptive columns
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 80))
                ], spacing: 15) {
                    ForEach(items, id: \.self) { item in
                        gridBox(item)
                    }
                }
                .padding()
            }
        }
    }
    
    func gridBox(_ number: Int) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue.opacity(0.7))
            .aspectRatio(1, contentMode:  .fit)
            .overlay(
                Text("\(number)")
                    .foregroundColor(.white)
                    .font(.title2)
            )
    }
}

// MARK: - Practical Example: Complex Layout

struct ComplexLayoutExample:  View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [. blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 200)
                    
                    HStack(alignment: .bottom, spacing: 15) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(. system(size: 50))
                                    .foregroundColor(.blue)
                            )
                            .offset(y: 30)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Profile Name")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            
                            Text("@username")
                                .font(. subheadline)
                                . foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.bottom, 8)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                // Stats
                HStack(spacing: 0) {
                    statView(value: "1.2K", label: "Posts")
                    Divider().frame(height: 40)
                    statView(value: "45. 3K", label: "Followers")
                    Divider().frame(height: 40)
                    statView(value: "892", label: "Following")
                }
                .padding(.top, 50)
                .padding(.horizontal)
                
                // Bio
                VStack(alignment: .leading, spacing: 10) {
                    Text("About")
                        .font(.headline)
                    
                    Text("iOS Developer passionate about creating beautiful and functional apps with SwiftUI.")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Label("San Francisco", systemImage: "location. fill")
                        Spacer()
                        Label("apple.com", systemImage: "link")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
                
                // Content grid
                LazyVGrid(columns: [
                    GridItem(. flexible()),
                    GridItem(. flexible()),
                    GridItem(. flexible())
                ], spacing:  2) {
                    ForEach(0..<9) { _ in
                        Rectangle()
                            .fill(Color.blue.opacity(0.3))
                            .aspectRatio(1, contentMode:  .fit)
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    func statView(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(. title2)
                .bold()
            Text(label)
                .font(. caption)
                .foregroundColor(. secondary)
        }
        . frame(maxWidth: .infinity)
    }
}

// MARK:  - Complete Showcase

struct LayoutFundamentalsShowcase: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Stack Layouts") {
                    NavigationLink("VStack") {
                        VStackExample()
                            .navigationTitle("VStack")
                    }
                    
                    NavigationLink("HStack") {
                        HStackExample()
                            .navigationTitle("HStack")
                    }
                    
                    NavigationLink("ZStack") {
                        ZStackExample()
                            . navigationTitle("ZStack")
                    }
                }
                
                Section("Layout Helpers") {
                    NavigationLink("Spacer & Divider") {
                        SpacerAndDividerExample()
                            .navigationTitle("Spacer & Divider")
                    }
                    
                    NavigationLink("Frame & Sizing") {
                        FrameAndSizingExample()
                            .navigationTitle("Frame & Sizing")
                    }
                    
                    NavigationLink("Alignment") {
                        AlignmentExample()
                            .navigationTitle("Alignment")
                    }
                }
                
                Section("Spacing & Decoration") {
                    NavigationLink("Padding & Spacing") {
                        PaddingAndSpacingExample()
                            .navigationTitle("Padding & Spacing")
                    }
                    
                    NavigationLink("Overlay & Background") {
                        OverlayAndBackgroundExample()
                            .navigationTitle("Overlay & Background")
                    }
                }
                
                Section("Advanced Layout") {
                    NavigationLink("GeometryReader") {
                        GeometryReaderExample()
                            .navigationTitle("GeometryReader")
                    }
                    
                    NavigationLink("Layout Priority") {
                        LayoutPriorityExample()
                            .navigationTitle("Layout Priority")
                    }
                    
                    NavigationLink("Fixed Size") {
                        FixedSizeExample()
                            .navigationTitle("Fixed Size")
                    }
                    
                    NavigationLink("Aspect Ratio") {
                        AspectRatioExample()
                            .navigationTitle("Aspect Ratio")
                    }
                }
                
                Section("Practical Examples") {
                    NavigationLink("Card Layouts") {
                        CardLayoutExample()
                            .navigationTitle("Cards")
                    }
                    
                    NavigationLink("Responsive Grid") {
                        ResponsiveGridExample()
                            .navigationTitle("Grid")
                    }
                    
                    NavigationLink("Complex Layout") {
                        ComplexLayoutExample()
                            .navigationTitle("Complex")
                    }
                }
            }
            .navigationTitle("Layout Fundamentals")
        }
    }
}

// MARK: - Preview
#Preview {
    LayoutFundamentalsShowcase()
}