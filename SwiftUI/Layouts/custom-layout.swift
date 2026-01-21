// SwiftUI Custom Layout Reference
// Source: https://developer.apple.com/documentation/swiftui/custom-layout

import SwiftUI

// MARK: - Basic Custom Layout (iOS 16+)

/// Simple custom layout that arranges views horizontally with equal spacing
struct EqualSpacingLayout: Layout {
    func sizeThatFits(proposal:  ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard ! subviews.isEmpty else { return .zero }
        
        let maxHeight = subviews.map { $0.sizeThatFits(proposal).height }.max() ?? 0
        let totalWidth = subviews.map { $0.sizeThatFits(proposal).width }.reduce(0, +)
        
        return CGSize(width: totalWidth, height: maxHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        
        let spacing = (bounds.width - subviews.map { $0.sizeThatFits(proposal).width }.reduce(0, +)) / CGFloat(subviews.count + 1)
        
        var x = bounds.minX + spacing
        
        for subview in subviews {
            let size = subview.sizeThatFits(proposal)
            let point = CGPoint(x: x, y: bounds.midY)
            subview.place(at: point, anchor: .leading, proposal: proposal)
            x += size.width + spacing
        }
    }
}

struct EqualSpacingLayoutExample: View {
    var body:  some View {
        VStack(spacing: 30) {
            Text("Equal Spacing Layout")
                .font(. headline)
            
            EqualSpacingLayout {
                ForEach(1... 4, id: \.self) { index in
                    Circle()
                        .fill(Color.blue)
                        .frame(width: CGFloat(30 + index * 10), height: CGFloat(30 + index * 10))
                }
            }
            .frame(height: 100)
            .border(Color.gray)
            
            Text("Views are spaced equally")
                .font(.caption)
                .foregroundColor(. secondary)
        }
        . padding()
    }
}

// MARK: - Vertical Stack Layout

/// Custom vertical layout with configurable spacing
struct CustomVStack: Layout {
    var spacing: CGFloat
    
    init(spacing: CGFloat = 10) {
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(proposal) }
        let maxWidth = sizes.map { $0.width }.max() ?? 0
        let totalHeight = sizes.map { $0.height }.reduce(0, +) + spacing * CGFloat(subviews.count - 1)
        
        return CGSize(width: maxWidth, height: totalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var y = bounds.minY
        
        for subview in subviews {
            let size = subview.sizeThatFits(proposal)
            subview.place(
                at: CGPoint(x:  bounds.minX, y: y),
                anchor: .topLeading,
                proposal: proposal
            )
            y += size.height + spacing
        }
    }
}

struct CustomVStackExample: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Custom VStack")
                .font(.headline)
            
            CustomVStack(spacing: 20) {
                Text("Item 1")
                    .padding()
                    .background(Color.blue.opacity(0.2))
                
                Text("Item 2")
                    .padding()
                    .background(Color.green.opacity(0.2))
                
                Text("Item 3")
                    .padding()
                    .background(Color.orange.opacity(0.2))
            }
            .padding()
            .border(Color.gray)
        }
        .padding()
    }
}

// MARK: - Radial Layout

/// Layout that arranges views in a circle
struct RadialLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let radius = min(bounds.width, bounds.height) / 2
        let angle = Angle. degrees(360 / Double(subviews.count))
        
        for (index, subview) in subviews.enumerated() {
            let currentAngle = angle * Double(index) - . degrees(90)
            
            var point = CGPoint(x: 0, y: -radius)
                .applying(CGAffineTransform(rotationAngle: currentAngle. radians))
            
            point. x += bounds.midX
            point.y += bounds.midY
            
            subview.place(at: point, anchor: .center, proposal: . unspecified)
        }
    }
}

struct RadialLayoutExample: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Radial Layout")
                .font(.headline)
            
            RadialLayout {
                ForEach(0..<8) { index in
                    Circle()
                        .fill(Color. blue)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Text("\(index + 1)")
                                .foregroundColor(.white)
                                .font(. caption)
                        )
                }
            }
            .frame(width: 300, height: 300)
            .border(Color.gray)
            
            Text("Views arranged in a circle")
                .font(. caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

// MARK: - Flow Layout

/// Layout that wraps views to the next line when needed
struct FlowLayout: Layout {
    var spacing: CGFloat = 10
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache:  inout Cache) -> CGSize {
        let result = FlowResult(
            in: proposal. replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        
        for (index, subview) in subviews.enumerated() {
            subview.place(at: result.positions[index], anchor: .topLeading, proposal: . unspecified)
        }
    }
    
    struct Cache {
        // Can cache expensive calculations here
    }
    
    func makeCache(subviews: Subviews) -> Cache {
        Cache()
    }
}

struct FlowResult {
    var positions: [CGPoint] = []
    var size: CGSize = .zero
    
    init(in maxWidth: CGFloat, subviews: LayoutSubviews, spacing: CGFloat) {
        var currentX:  CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(. unspecified)
            
            if currentX + size.width > maxWidth && currentX > 0 {
                // Move to next line
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }
            
            positions.append(CGPoint(x: currentX, y: currentY))
            currentX += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
        
        self.size = CGSize(
            width: maxWidth,
            height: currentY + lineHeight
        )
    }
}

struct FlowLayoutExample: View {
    let tags = ["SwiftUI", "iOS", "Development", "Custom Layout", "Flow", "Wrap", "Tags", "Apple", "Xcode", "Swift"]
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Flow Layout")
                .font(.headline)
            
            FlowLayout(spacing: 10) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .padding(. horizontal, 12)
                        .padding(.vertical, 6)
                        . background(Color.blue)
                        .foregroundColor(. white)
                        .cornerRadius(15)
                }
            }
            .padding()
            .border(Color.gray)
            
            Text("Tags wrap to next line automatically")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

// MARK: - Grid Layout

/// Custom grid layout with configurable columns
struct CustomGridLayout: Layout {
    var columns: Int
    var spacing: CGFloat
    
    init(columns: Int = 3, spacing: CGFloat = 10) {
        self.columns = columns
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal:  ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let itemWidth = (width - spacing * CGFloat(columns - 1)) / CGFloat(columns)
        
        let rows = Int(ceil(Double(subviews.count) / Double(columns)))
        
        var maxHeights: [CGFloat] = Array(repeating: 0, count: rows)
        
        for (index, subview) in subviews.enumerated() {
            let row = index / columns
            let size = subview.sizeThatFits(.init(width: itemWidth, height:  nil))
            maxHeights[row] = max(maxHeights[row], size.height)
        }
        
        let totalHeight = maxHeights.reduce(0, +) + spacing * CGFloat(rows - 1)
        
        return CGSize(width: width, height: totalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let itemWidth = (bounds.width - spacing * CGFloat(columns - 1)) / CGFloat(columns)
        
        var y = bounds.minY
        var currentRow = 0
        var rowHeight: CGFloat = 0
        
        for (index, subview) in subviews.enumerated() {
            let column = index % columns
            let row = index / columns
            
            if row != currentRow {
                y += rowHeight + spacing
                currentRow = row
                rowHeight = 0
            }
            
            let x = bounds.minX + CGFloat(column) * (itemWidth + spacing)
            let size = subview.sizeThatFits(.init(width: itemWidth, height: nil))
            
            subview.place(
                at: CGPoint(x:  x, y: y),
                anchor: .topLeading,
                proposal: . init(width: itemWidth, height:  size.height)
            )
            
            rowHeight = max(rowHeight, size.height)
        }
    }
}

struct CustomGridLayoutExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Custom Grid Layout")
                    .font(.headline)
                
                CustomGridLayout(columns: 3, spacing: 15) {
                    ForEach(1...12, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue. opacity(0.7))
                            .aspectRatio(1, contentMode:  .fit)
                            .overlay(
                                Text("\(index)")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            )
                    }
                }
                . padding()
            }
        }
    }
}

// MARK:  - Waterfall Layout

/// Pinterest-style waterfall layout
struct WaterfallLayout: Layout {
    var columns: Int
    var spacing: CGFloat
    
    init(columns: Int = 2, spacing: CGFloat = 10) {
        self.columns = columns
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal:  ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        cache.calculate(width: width, subviews: subviews, columns: columns, spacing: spacing)
        return CGSize(width: width, height: cache.totalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        cache.calculate(width: bounds.width, subviews: subviews, columns: columns, spacing: spacing)
        
        for (index, subview) in subviews.enumerated() {
            if let position = cache.positions[safe: index], let size = cache.sizes[safe: index] {
                subview.place(
                    at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                    anchor: .topLeading,
                    proposal: ProposedViewSize(width: size.width, height: size.height)
                )
            }
        }
    }
    
    struct Cache {
        var positions: [CGPoint] = []
        var sizes: [CGSize] = []
        var totalHeight: CGFloat = 0
        
        mutating func calculate(width: CGFloat, subviews: LayoutSubviews, columns: Int, spacing: CGFloat) {
            positions.removeAll()
            sizes.removeAll()
            
            let itemWidth = (width - spacing * CGFloat(columns - 1)) / CGFloat(columns)
            var columnHeights = Array(repeating: CGFloat(0), count: columns)
            
            for subview in subviews {
                // Find shortest column
                let shortestColumn = columnHeights.enumerated().min(by: { $0.element < $1.element })?.offset ?? 0
                
                let size = subview.sizeThatFits(ProposedViewSize(width: itemWidth, height: nil))
                let x = CGFloat(shortestColumn) * (itemWidth + spacing)
                let y = columnHeights[shortestColumn]
                
                positions.append(CGPoint(x: x, y: y))
                sizes.append(CGSize(width: itemWidth, height: size.height))
                
                columnHeights[shortestColumn] += size.height + spacing
            }
            
            totalHeight = columnHeights.max() ?? 0
        }
    }
    
    func makeCache(subviews: Subviews) -> Cache {
        Cache()
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

struct WaterfallLayoutExample:  View {
    let heights:  [CGFloat] = [100, 150, 80, 200, 120, 180, 90, 160, 140, 110]
    
    var body:  some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Waterfall Layout")
                    .font(.headline)
                
                WaterfallLayout(columns: 2, spacing: 15) {
                    ForEach(Array(heights.enumerated()), id: \.offset) { index, height in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color. blue.opacity(0.7))
                            .frame(height: height)
                            .overlay(
                                Text("\(index + 1)")
                                    . foregroundColor(.white)
                                    .font(.title2)
                            )
                    }
                }
                .padding()
            }
        }
    }
}

// MARK:  - Layout with Properties

/// Layout with configurable alignment
struct AlignedLayout: Layout {
    var alignment: Alignment
    var spacing: CGFloat
    
    init(alignment: Alignment = . center, spacing: CGFloat = 10) {
        self.alignment = alignment
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal:  ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(proposal) }
        let maxWidth = sizes.map { $0.width }.max() ?? 0
        let totalHeight = sizes.map { $0.height }.reduce(0, +) + spacing * CGFloat(subviews.count - 1)
        
        return CGSize(width: maxWidth, height: totalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var y = bounds.minY
        
        for subview in subviews {
            let size = subview.sizeThatFits(proposal)
            
            let x:  CGFloat
            switch alignment. horizontal {
            case .leading:
                x = bounds.minX
            case .trailing:
                x = bounds.maxX - size.width
            default:
                x = bounds.midX - size.width / 2
            }
            
            subview.place(
                at: CGPoint(x: x, y: y),
                anchor: . topLeading,
                proposal:  proposal
            )
            
            y += size.height + spacing
        }
    }
}

struct AlignedLayoutExample: View {
    @State private var alignment: Alignment = .leading
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Aligned Layout")
                .font(.headline)
            
            Picker("Alignment", selection: $alignment) {
                Text("Leading").tag(Alignment.leading)
                Text("Center").tag(Alignment.center)
                Text("Trailing").tag(Alignment.trailing)
            }
            .pickerStyle(. segmented)
            .padding(. horizontal)
            
            AlignedLayout(alignment: alignment, spacing: 15) {
                Text("Short")
                    .padding()
                    .background(Color. blue.opacity(0.2))
                
                Text("Medium length")
                    .padding()
                    .background(Color.green.opacity(0.2))
                
                Text("Very long text item")
                    .padding()
                    .background(Color.orange.opacity(0.2))
            }
            .frame(width: 300)
            .border(Color. gray)
        }
        . padding()
    }
}

// MARK: - Layout with Animation

/// Layout that supports smooth animations
struct AnimatedFlowLayout: Layout {
    var spacing: CGFloat
    
    func sizeThatFits(proposal:  ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        
        for (index, subview) in subviews.enumerated() {
            let point = CGPoint(
                x: bounds.minX + result.positions[index].x,
                y: bounds.minY + result.positions[index].y
            )
            subview.place(at: point, anchor: .topLeading, proposal: .unspecified)
        }
    }
}

struct AnimatedFlowLayoutExample: View {
    @State private var items = ["Swift", "SwiftUI", "iOS", "macOS", "Xcode"]
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Animated Flow Layout")
                .font(. headline)
            
            AnimatedFlowLayout(spacing: 10) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding(. horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color. blue)
                        .foregroundColor(.white)
                        . cornerRadius(15)
                        .transition(.scale. combined(with: .opacity))
                }
            }
            . animation(.spring(), value: items)
            .frame(width: 300, alignment: .leading)
            .padding()
            .border(Color.gray)
            
            HStack(spacing: 15) {
                Button("Add") {
                    let newItems = ["watchOS", "tvOS", "visionOS", "iPadOS"]
                    if let random = newItems.randomElement(), !items.contains(random) {
                        items.append(random)
                    }
                }
                
                Button("Remove") {
                    if ! items.isEmpty {
                        items.removeLast()
                    }
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

// MARK: - Layout Value (Custom Layout Properties)

/// Layout using custom layout values for priorities
struct PriorityLayout: Layout {
    func sizeThatFits(proposal:  ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal:  ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sorted = subviews.sorted { view1, view2 in
            let priority1 = view1[LayoutPriorityKey. self]
            let priority2 = view2[LayoutPriorityKey.self]
            return priority1 > priority2
        }
        
        var currentY = bounds.minY
        
        for subview in sorted {
            let size = subview. sizeThatFits(proposal)
            subview.place(
                at: CGPoint(x: bounds.midX, y: currentY),
                anchor: .top,
                proposal: proposal
            )
            currentY += size. height + 10
        }
    }
}

struct LayoutPriorityKey: LayoutValueKey {
    static let defaultValue:  Int = 0
}

extension View {
    func layoutPriority(_ value: Int) -> some View {
        layoutValue(key: LayoutPriorityKey.self, value: value)
    }
}

struct PriorityLayoutExample: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Priority Layout")
                .font(.headline)
            
            Text("Views sorted by custom priority")
                .font(.caption)
                .foregroundColor(. secondary)
            
            PriorityLayout {
                Text("Priority 1")
                    .padding()
                    .background(Color.red.opacity(0.3))
                    .layoutPriority(1)
                
                Text("Priority 3 (First)")
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .layoutPriority(3)
                
                Text("Priority 0 (Last)")
                    . padding()
                    .background(Color.gray.opacity(0.3))
                    .layoutPriority(0)
                
                Text("Priority 2")
                    .padding()
                    .background(Color.blue. opacity(0.3))
                    .layoutPriority(2)
            }
            .frame(height: 300)
            .border(Color. gray)
        }
        . padding()
    }
}

// MARK: - Practical Example:  Tag Cloud

struct TagCloudLayout: Layout {
    func sizeThatFits(proposal:  ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal:  ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var positions: [CGPoint] = []
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 3
        
        for (index, subview) in subviews.enumerated() {
            let angle = (2 * .pi / Double(subviews.count)) * Double(index)
            let offset = radius * (0.5 + Double. random(in: 0... 0.5))
            
            var point = CGPoint(
                x: center. x + cos(angle) * offset,
                y: center.y + sin(angle) * offset
            )
            
            // Avoid overlaps
            for existingPoint in positions {
                if distance(point, existingPoint) < 60 {
                    point. x += 30
                    point.y += 30
                }
            }
            
            positions.append(point)
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
    
    func distance(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
        sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2))
    }
}

struct TagCloudExample: View {
    let tags = ["SwiftUI", "iOS", "macOS", "watchOS", "tvOS", "Swift", "Xcode", "App Store"]
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Tag Cloud Layout")
                .font(.headline)
            
            TagCloudLayout {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.system(size: CGFloat. random(in: 12...24)))
                        .padding(8)
                        .background(Color.blue. opacity(Double.random(in: 0.3...0.8)))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .frame(width: 350, height: 350)
            .border(Color. gray)
        }
        .padding()
    }
}

// MARK:  - Practical Example: Carousel Layout

struct CarouselLayout: Layout {
    var spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard let first = subviews.first else { return . zero }
        let size = first.sizeThatFits(proposal)
        return CGSize(
            width: proposal.width ??  size.width,
            height: size.height
        )
    }
    
    func placeSubviews(in bounds: CGRect, proposal:  ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let itemWidth = bounds.width * 0.7
        let itemHeight = bounds. height
        
        for (index, subview) in subviews.enumerated() {
            let xOffset = CGFloat(index) * (itemWidth + spacing)
            
            subview.place(
                at: CGPoint(x: bounds.minX + xOffset, y: bounds.minY),
                anchor: .topLeading,
                proposal: ProposedViewSize(width: itemWidth, height: itemHeight)
            )
        }
    }
}

struct CarouselLayoutExample: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Carousel Layout")
                .font(.headline)
            
            ScrollView(. horizontal, showsIndicators: false) {
                CarouselLayout(spacing: 20) {
                    ForEach(0..<5) { index in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    colors: [. blue, .purple],
                                    startPoint: . topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .overlay(
                                VStack {
                                    Image(systemName: "photo. fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.white)
                                    Text("Card \(index + 1)")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            )
                    }
                }
            }
            .frame(height: 250)
            .padding(. horizontal)
        }
    }
}

// MARK:  - Complete Showcase

struct CustomLayoutShowcase: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Basic Layouts") {
                    NavigationLink("Equal Spacing") {
                        EqualSpacingLayoutExample()
                            .navigationTitle("Equal Spacing")
                    }
                    
                    NavigationLink("Custom VStack") {
                        CustomVStackExample()
                            .navigationTitle("Custom VStack")
                    }
                    
                    NavigationLink("Radial Layout") {
                        RadialLayoutExample()
                            .navigationTitle("Radial")
                    }
                }
                
                Section("Flow & Grid") {
                    NavigationLink("Flow Layout") {
                        FlowLayoutExample()
                            .navigationTitle("Flow Layout")
                    }
                    
                    NavigationLink("Custom Grid") {
                        CustomGridLayoutExample()
                            .navigationTitle("Custom Grid")
                    }
                    
                    NavigationLink("Waterfall Layout") {
                        WaterfallLayoutExample()
                            . navigationTitle("Waterfall")
                    }
                }
                
                Section("Advanced") {
                    NavigationLink("Aligned Layout") {
                        AlignedLayoutExample()
                            .navigationTitle("Aligned")
                    }
                    
                    NavigationLink("Animated Flow") {
                        AnimatedFlowLayoutExample()
                            .navigationTitle("Animated Flow")
                    }
                    
                    NavigationLink("Priority Layout") {
                        PriorityLayoutExample()
                            .navigationTitle("Priority")
                    }
                }
                
                Section("Practical Examples") {
                    NavigationLink("Tag Cloud") {
                        TagCloudExample()
                            . navigationTitle("Tag Cloud")
                    }
                    
                    NavigationLink("Carousel") {
                        CarouselLayoutExample()
                            .navigationTitle("Carousel")
                    }
                }
            }
            .navigationTitle("Custom Layout")
        }
    }
}

// MARK: - Preview
#Preview {
    CustomLayoutShowcase()
}