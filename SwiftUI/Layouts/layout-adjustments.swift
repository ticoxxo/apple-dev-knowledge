// SwiftUI Layout Adjustments Reference
// Source: https://developer.apple.com/documentation/swiftui/layout-adjustments

import SwiftUI

// MARK: - Position and Offset

/// Position - Sets the center point of a view
struct PositionExample: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Position")
                .font(.headline)
            
            // Position with coordinates
            ZStack {
                Rectangle()
                    . fill(Color.gray.opacity(0.2))
                    .frame(width: 300, height: 200)
                    .border(Color.gray)
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 40)
                    .position(x: 50, y: 50)
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 40, height: 40)
                    .position(x: 250, y: 50)
                
                Circle()
                    . fill(Color.red)
                    .frame(width: 40, height: 40)
                    .position(x: 150, y: 150)
            }
            
            Text("position(x:y: ) sets absolute coordinates")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

/// Offset - Shifts a view from its natural position
struct OffsetExample:  View {
    @State private var offsetX: CGFloat = 0
    @State private var offsetY:  CGFloat = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Offset")
                .font(.headline)
            
            // Visual demonstration
            ZStack {
                Rectangle()
                    .fill(Color. gray.opacity(0.2))
                    .frame(width: 300, height: 200)
                    .border(Color. gray)
                
                // Original position (reference)
                Circle()
                    .stroke(Color.blue. opacity(0.3), style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .frame(width: 60, height: 60)
                
                // Offset circle
                Circle()
                    . fill(Color.blue)
                    .frame(width: 60, height: 60)
                    .offset(x: offsetX, y: offsetY)
            }
            
            VStack(spacing: 15) {
                HStack {
                    Text("X: \(Int(offsetX))")
                        .frame(width: 80)
                    Slider(value: $offsetX, in: -100...100)
                }
                
                HStack {
                    Text("Y: \(Int(offsetY))")
                        .frame(width: 80)
                    Slider(value: $offsetY, in: -100...100)
                }
            }
            . padding(. horizontal)
            
            Button("Reset") {
                withAnimation {
                    offsetX = 0
                    offsetY = 0
                }
            }
            .buttonStyle(. bordered)
        }
        .padding()
    }
}

/// CGSize offset variant
struct OffsetCGSizeExample: View {
    @State private var offset = CGSize. zero
    
    var body:  some View {
        VStack(spacing: 30) {
            Text("Offset with CGSize")
                .font(. headline)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color. purple)
                .frame(width: 100, height: 100)
                .offset(offset)
                .gesture(
                    DragGesture()
                        . onChanged { value in
                            offset = value.translation
                        }
                        .onEnded { _ in
                            withAnimation(. spring()) {
                                offset = .zero
                            }
                        }
                )
            
            Text("Drag to offset")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(height: 300)
    }
}

// MARK: - Rotation

struct RotationExample: View {
    @State private var degrees:  Double = 0
    @State private var radians: Double = 0
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Rotation")
                .font(.headline)
            
            // Rotation in degrees
            VStack(spacing:  15) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue. gradient)
                    .frame(width: 150, height: 100)
                    .rotationEffect(.degrees(degrees))
                    .overlay(
                        Text("Degrees")
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(-degrees))
                    )
                
                HStack {
                    Text("\(Int(degrees))°")
                        .frame(width: 60)
                    Slider(value: $degrees, in: 0...360)
                }
                .padding(.horizontal)
            }
            
            // Rotation in radians
            VStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.green.gradient)
                    .frame(width: 150, height: 100)
                    .rotationEffect(.radians(radians))
                    .overlay(
                        Text("Radians")
                            .foregroundColor(.white)
                            .rotationEffect(. radians(-radians))
                    )
                
                HStack {
                    Text(String(format: "%.2f", radians))
                        .frame(width: 60)
                    Slider(value:  $radians, in: 0.. .(2 * .pi))
                }
                .padding(.horizontal)
            }
            
            Button("Reset") {
                withAnimation {
                    degrees = 0
                    radians = 0
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

/// Rotation with anchor point
struct RotationAnchorExample: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Rotation with Anchor Point")
                .font(.headline)
            
            HStack(spacing: 30) {
                // Top leading anchor
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(rotation), anchor: .topLeading)
                    
                    Text("Top Leading")
                        .font(. caption)
                }
                
                // Center anchor (default)
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(rotation), anchor: .center)
                    
                    Text("Center")
                        . font(.caption)
                }
                
                // Bottom trailing anchor
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        . fill(Color.orange)
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(rotation), anchor: .bottomTrailing)
                    
                    Text("Bottom Trailing")
                        .font(.caption)
                }
            }
            .padding(40)
            
            HStack {
                Text("\(Int(rotation))°")
                    .frame(width: 60)
                Slider(value: $rotation, in: 0...360)
            }
            .padding(.horizontal)
            
            Button("Reset") {
                withAnimation {
                    rotation = 0
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

/// 3D Rotation
struct Rotation3DExample: View {
    @State private var rotationX: Double = 0
    @State private var rotationY: Double = 0
    @State private var rotationZ: Double = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("3D Rotation")
                .font(. headline)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [. blue, .purple],
                        startPoint: . topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 200, height: 150)
                .overlay(
                    Text("3D Card")
                        .font(.title)
                        .foregroundColor(.white)
                )
                .rotation3DEffect(
                    . degrees(rotationX),
                    axis: (x: 1, y: 0, z:  0)
                )
                .rotation3DEffect(
                    .degrees(rotationY),
                    axis: (x:  0, y: 1, z: 0)
                )
                .rotation3DEffect(
                    .degrees(rotationZ),
                    axis: (x: 0, y: 0, z: 1)
                )
            
            VStack(spacing: 15) {
                HStack {
                    Text("X: \(Int(rotationX))°")
                        .frame(width: 80)
                    Slider(value: $rotationX, in: -180...180)
                }
                
                HStack {
                    Text("Y: \(Int(rotationY))°")
                        . frame(width: 80)
                    Slider(value: $rotationY, in: -180...180)
                }
                
                HStack {
                    Text("Z: \(Int(rotationZ))°")
                        .frame(width: 80)
                    Slider(value: $rotationZ, in:  -180...180)
                }
            }
            .padding(. horizontal)
            
            Button("Reset") {
                withAnimation {
                    rotationX = 0
                    rotationY = 0
                    rotationZ = 0
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

// MARK: - Scale

struct ScaleExample: View {
    @State private var scale:  CGFloat = 1.0
    @State private var scaleX: CGFloat = 1.0
    @State private var scaleY: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Scale")
                .font(.headline)
            
            // Uniform scale
            VStack(spacing:  15) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 100, height:  100)
                    .scaleEffect(scale)
                
                HStack {
                    Text("Scale: \(scale, specifier: "%.2f")")
                        .frame(width: 120)
                    Slider(value: $scale, in: 0.5...2.0)
                }
                .padding(.horizontal)
            }
            
            // Non-uniform scale
            VStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 15)
                    . fill(Color.green)
                    .frame(width: 100, height: 100)
                    .scaleEffect(x: scaleX, y: scaleY)
                
                HStack {
                    Text("X: \(scaleX, specifier: "%. 2f")")
                        . frame(width: 100)
                    Slider(value: $scaleX, in:  0.5...2.0)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Y: \(scaleY, specifier: "%.2f")")
                        .frame(width: 100)
                    Slider(value: $scaleY, in: 0.5...2.0)
                }
                .padding(.horizontal)
            }
            
            Button("Reset") {
                withAnimation {
                    scale = 1.0
                    scaleX = 1.0
                    scaleY = 1.0
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

/// Scale with anchor point
struct ScaleAnchorExample: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Scale with Anchor Point")
                .font(.headline)
            
            HStack(spacing: 30) {
                // Top leading anchor
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color. blue)
                        .frame(width: 60, height: 60)
                        .scaleEffect(scale, anchor: .topLeading)
                    
                    Text("Top Leading")
                        .font(. caption)
                }
                . frame(width: 100, height: 100)
                .border(Color.gray. opacity(0.3))
                
                // Center anchor
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        . fill(Color.green)
                        .frame(width: 60, height: 60)
                        .scaleEffect(scale, anchor: .center)
                    
                    Text("Center")
                        .font(.caption)
                }
                .frame(width: 100, height: 100)
                .border(Color. gray.opacity(0.3))
                
                // Bottom trailing anchor
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.orange)
                        .frame(width: 60, height: 60)
                        .scaleEffect(scale, anchor: .bottomTrailing)
                    
                    Text("Bottom Trailing")
                        . font(.caption)
                }
                .frame(width: 100, height: 100)
                .border(Color.gray.opacity(0.3))
            }
            
            HStack {
                Text("Scale: \(scale, specifier:  "%.2f")")
                    .frame(width: 120)
                Slider(value:  $scale, in: 0.5...2.0)
            }
            .padding(.horizontal)
            
            Button("Reset") {
                withAnimation {
                    scale = 1.0
                }
            }
            . buttonStyle(.bordered)
        }
        .padding()
    }
}

// MARK: - Transform Effect

struct TransformEffectExample:  View {
    @State private var translateX: CGFloat = 0
    @State private var translateY:  CGFloat = 0
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Transform Effect (CGAffineTransform)")
                .font(.headline)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color. purple. gradient)
                .frame(width: 100, height: 100)
                .transformEffect(
                    CGAffineTransform(translationX: translateX, y:  translateY)
                        .rotated(by: rotation * .pi / 180)
                        .scaledBy(x: scale, y: scale)
                )
            
            VStack(spacing: 15) {
                HStack {
                    Text("Translate X:")
                        .frame(width: 100, alignment: .leading)
                    Slider(value: $translateX, in: -100...100)
                }
                
                HStack {
                    Text("Translate Y:")
                        .frame(width: 100, alignment:  .leading)
                    Slider(value: $translateY, in: -100...100)
                }
                
                HStack {
                    Text("Rotation:")
                        .frame(width: 100, alignment: .leading)
                    Slider(value: $rotation, in: 0... 360)
                }
                
                HStack {
                    Text("Scale:")
                        .frame(width: 100, alignment:  .leading)
                    Slider(value: $scale, in:  0.5...2.0)
                }
            }
            .padding(.horizontal)
            
            Button("Reset") {
                withAnimation {
                    translateX = 0
                    translateY = 0
                    rotation = 0
                    scale = 1.0
                }
            }
            .buttonStyle(. bordered)
        }
        . padding()
    }
}

// MARK: - Projection Effect (3D Perspective)

struct ProjectionEffectExample: View {
    @State private var perspectiveX: Double = 0
    @State private var perspectiveY: Double = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Projection Effect (3D Transform)")
                .font(.headline)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [.orange, .red],
                        startPoint: . topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 200, height: 150)
                .overlay(
                    Text("3D")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                )
                .projectionEffect(
                    ProjectionTransform(
                        CGAffineTransform(a: 1, b: perspectiveX, c: perspectiveY, d: 1, tx: 0, ty:  0)
                    )
                )
            
            VStack(spacing: 15) {
                HStack {
                    Text("Skew X:")
                        .frame(width: 80)
                    Slider(value: $perspectiveX, in: -0.5...0.5)
                }
                
                HStack {
                    Text("Skew Y:")
                        .frame(width: 80)
                    Slider(value: $perspectiveY, in: -0.5...0.5)
                }
            }
            .padding(.horizontal)
            
            Button("Reset") {
                withAnimation {
                    perspectiveX = 0
                    perspectiveY = 0
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

// MARK: - Coordinate Space

struct CoordinateSpaceExample:  View {
    @State private var localPosition: CGPoint = .zero
    @State private var globalPosition: CGPoint = .zero
    @State private var namedPosition: CGPoint = .zero
    
    var body: some View {
        VStack(spacing:  30) {
            Text("Coordinate Spaces")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Local:  (\(Int(localPosition.x)), \(Int(localPosition.y)))")
                Text("Global: (\(Int(globalPosition.x)), \(Int(globalPosition.y)))")
                Text("Named:  (\(Int(namedPosition.x)), \(Int(namedPosition.y)))")
            }
            .font(.caption)
            .padding()
            . background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            VStack(spacing: 20) {
                Text("Outer Container")
                    .font(.caption)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 300, height: 200)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green.opacity(0.3))
                        .frame(width: 150, height: 100)
                        .overlay(
                            Text("Drag Me")
                                .foregroundColor(.green)
                        )
                        .gesture(
                            DragGesture(coordinateSpace: .local)
                                .onChanged { value in
                                    localPosition = value. location
                                }
                        )
                        .gesture(
                            DragGesture(coordinateSpace:  .global)
                                .onChanged { value in
                                    globalPosition = value.location
                                }
                        )
                        .gesture(
                            DragGesture(coordinateSpace: .named("container"))
                                .onChanged { value in
                                    namedPosition = value.location
                                }
                        )
                }
            }
            .coordinateSpace(name: "container")
            
            Text("Drag the green box to see coordinates")
                .font(. caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

// MARK: - Ignore Safe Area

struct IgnoreSafeAreaExample: View {
    @State private var ignoreTop = false
    @State private var ignoreBottom = false
    
    var body: some View {
        ZStack {
            // Background that can ignore safe area
            LinearGradient(
                colors:  [.blue, .purple],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(edges: ignoreTop && ignoreBottom ?  .all : 
                            ignoreTop ?  .top : 
                            ignoreBottom ? . bottom : [])
            
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Ignore Safe Area")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Toggle("Ignore Top", isOn:  $ignoreTop)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                    
                    Toggle("Ignore Bottom", isOn: $ignoreBottom)
                        .padding()
                        . background(Color.white.opacity(0.2))
                        . cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

// MARK:  - Safe Area Inset

struct SafeAreaInsetExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(1...20, id: \.self) { index in
                    Text("Item \(index)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Text("Custom Header")
                    .font(.headline)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                }
            }
            .padding()
            .background(Color.blue.opacity(0.9))
            .foregroundColor(.white)
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button("Action 1") {}
                Spacer()
                Button("Action 2") {}
            }
            . padding()
            .background(Color.gray.opacity(0.9))
            .buttonStyle(.bordered)
        }
    }
}

// MARK: - Container Relative Frame

struct ContainerRelativeFrameExample: View {
    var body: some View {
        ScrollView(. horizontal) {
            HStack(spacing: 0) {
                ForEach(0..<5) { index in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hue: Double(index) / 5.0, saturation: 0.7, brightness: 0.9))
                        .containerRelativeFrame(. horizontal)
                        .overlay(
                            Text("Page \(index + 1)")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        )
                }
            }
        }
        .scrollTargetBehavior(.paging)
    }
}

// MARK:  - Practical Example:  Parallax Effect

struct ParallaxEffectExample: View {
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Parallax header
                GeometryReader { geometry in
                    let offset = geometry.frame(in: . global).minY
                    
                    ZStack {
                        Image(systemName: "photo. fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height + (offset > 0 ? offset : 0))
                            .clipped()
                            .offset(y: offset > 0 ? -offset : 0)
                            .foregroundColor(.blue)
                        
                        // Overlay that fades in
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [.clear, .black.opacity(0.7)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        
                        VStack {
                            Spacer()
                            Text("Parallax Header")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                }
                .frame(height: 300)
                
                // Content
                VStack(spacing: 20) {
                    ForEach(1...20, id: \.self) { index in
                        Text("Item \(index)")
                            . frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(. systemBackground))
                    }
                }
                .background(Color(. systemBackground))
            }
        }
        .ignoresSafeArea(edges:  .top)
    }
}

// MARK: - Practical Example:  Floating Button

struct FloatingButtonExample:  View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(1...30, id: \.self) { index in
                        HStack {
                            Text("Item \(index)")
                            Spacer()
                        }
                        .padding()
                        .background(Color(. systemGray6))
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
            
            // Floating action button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action:  {}) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding()
                }
            }
        }
    }
}

// MARK:  - Practical Example: Sticky Header

struct StickyHeaderExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(0..<5) { section in
                    Section {
                        ForEach(1...10, id: \.self) { item in
                            HStack {
                                Text("Item \(item)")
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemBackground))
                        }
                    } header: {
                        HStack {
                            Text("Section \(section + 1)")
                                .font(.headline)
                            Spacer()
                        }
                        .padding()
                        .background(Color. blue. opacity(0.2))
                    }
                }
            }
        }
    }
}

// MARK:  - Practical Example: Card Perspective

struct CardPerspectiveExample: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Drag the card")
                .font(.headline)
            
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [.purple, .blue],
                        startPoint: . topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 300, height: 200)
                .overlay(
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Credit Card")
                                .font(. title2)
                            Spacer()
                            Image(systemName: "creditcard. fill")
                                .font(. title)
                        }
                        
                        Spacer()
                        
                        Text("•••• •••• •••• 1234")
                            .font(. title3)
                            .tracking(2)
                        
                        HStack {
                            Text("JOHN DOE")
                                .font(.caption)
                            Spacer()
                            Text("12/25")
                                .font(. caption)
                        }
                    }
                    .foregroundColor(.white)
                    .padding(25)
                )
                .rotation3DEffect(
                    . degrees(Double(dragAmount.height) / 10),
                    axis: (x: 1, y: 0, z:  0)
                )
                .rotation3DEffect(
                    . degrees(Double(dragAmount.width) / 10),
                    axis: (x: 0, y: 1, z: 0)
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragAmount = value.translation
                        }
                        .onEnded { _ in
                            withAnimation(. spring()) {
                                dragAmount = . zero
                            }
                        }
                )
        }
        .padding()
    }
}

// MARK: - Practical Example: Scale on Tap

struct ScaleOnTapExample: View {
    @State private var selectedIndex:  Int?  = nil
    
    let items = ["🍎", "🍊", "🍋", "🍇", "🍓", "🥝", "🍑", "🍒"]
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Tap an item")
                .font(.headline)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 20) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    Text(item)
                        .font(.system(size: 50))
                        .frame(width: 70, height: 70)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                . fill(selectedIndex == index ? Color.blue. opacity(0.2) : Color.gray.opacity(0.1))
                        )
                        .scaleEffect(selectedIndex == index ?  1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedIndex)
                        .onTapGesture {
                            selectedIndex = index
                        }
                }
            }
            .padding()
        }
    }
}

// MARK:  - Complete Showcase

struct LayoutAdjustmentsShowcase: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Position & Offset") {
                    NavigationLink("Position") {
                        PositionExample()
                            .navigationTitle("Position")
                    }
                    
                    NavigationLink("Offset") {
                        OffsetExample()
                            .navigationTitle("Offset")
                    }
                    
                    NavigationLink("Offset (CGSize)") {
                        OffsetCGSizeExample()
                            .navigationTitle("Offset CGSize")
                    }
                }
                
                Section("Rotation") {
                    NavigationLink("2D Rotation") {
                        RotationExample()
                            .navigationTitle("2D Rotation")
                    }
                    
                    NavigationLink("Rotation Anchor") {
                        RotationAnchorExample()
                            .navigationTitle("Rotation Anchor")
                    }
                    
                    NavigationLink("3D Rotation") {
                        Rotation3DExample()
                            .navigationTitle("3D Rotation")
                    }
                }
                
                Section("Scale") {
                    NavigationLink("Scale Effect") {
                        ScaleExample()
                            .navigationTitle("Scale")
                    }
                    
                    NavigationLink("Scale Anchor") {
                        ScaleAnchorExample()
                            .navigationTitle("Scale Anchor")
                    }
                }
                
                Section("Transforms") {
                    NavigationLink("Transform Effect") {
                        TransformEffectExample()
                            .navigationTitle("Transform")
                    }
                    
                    NavigationLink("Projection Effect") {
                        ProjectionEffectExample()
                            .navigationTitle("Projection")
                    }
                }
                
                Section("Coordinate Spaces") {
                    NavigationLink("Coordinate Space") {
                        CoordinateSpaceExample()
                            .navigationTitle("Coordinates")
                    }
                }
                
                Section("Safe Area") {
                    NavigationLink("Ignore Safe Area") {
                        IgnoreSafeAreaExample()
                            .navigationTitle("Ignore Safe Area")
                    }
                    
                    NavigationLink("Safe Area Inset") {
                        SafeAreaInsetExample()
                            .navigationTitle("Safe Area Inset")
                    }
                }
                
                Section("Container") {
                    NavigationLink("Container Relative Frame") {
                        ContainerRelativeFrameExample()
                            .navigationTitle("Container Frame")
                    }
                }
                
                Section("Practical Examples") {
                    NavigationLink("Parallax Effect") {
                        ParallaxEffectExample()
                            .navigationTitle("Parallax")
                    }
                    
                    NavigationLink("Floating Button") {
                        FloatingButtonExample()
                            .navigationTitle("Floating Button")
                    }
                    
                    NavigationLink("Sticky Header") {
                        StickyHeaderExample()
                            .navigationTitle("Sticky Header")
                    }
                    
                    NavigationLink("Card Perspective") {
                        CardPerspectiveExample()
                            .navigationTitle("Card Perspective")
                    }
                    
                    NavigationLink("Scale on Tap") {
                        ScaleOnTapExample()
                            .navigationTitle("Scale on Tap")
                    }
                }
            }
            . navigationTitle("Layout Adjustments")
        }
    }
}

// MARK:  - Preview
#Preview {
    LayoutAdjustmentsShowcase()
}