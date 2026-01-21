// SwiftUI Gestures Reference
// Source: https://developer.apple.com/documentation/swiftui/gestures

import SwiftUI

// MARK: - Tap Gesture

/// Simple tap gesture examples
struct TapGestureExample: View {
    @State private var tapCount = 0
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: 30) {
            // Single tap
            Circle()
                .fill(Color. blue)
                .frame(width: 100, height: 100)
                .onTapGesture {
                    tapCount += 1
                }
                .overlay(
                    Text("\(tapCount)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                )
            
            // Double tap
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.green)
                .frame(width: 200, height: 100)
                .onTapGesture(count: 2) {
                    print("Double tapped!")
                }
                . overlay(
                    Text("Double Tap Me")
                        .foregroundColor(.white)
                )
            
            // Long press with minimum duration
            RoundedRectangle(cornerRadius: 20)
                .fill(isPressed ? Color.purple : Color.orange)
                .frame(width: 200, height: 100)
                .onLongPressGesture(minimumDuration: 1.0) {
                    isPressed. toggle()
                }
                . overlay(
                    Text(isPressed ? "Pressed!" : "Long Press Me")
                        .foregroundColor(.white)
                )
                .animation(.easeInOut, value: isPressed)
        }
    }
}

// MARK:  - Long Press Gesture

struct LongPressGestureExample: View {
    @State private var isDetecting = false
    @State private var isComplete = false
    
    var body: some View {
        VStack(spacing: 30) {
            // Long press with progress feedback
            Circle()
                .fill(isDetecting ? Color.yellow : (isComplete ? Color.green : Color.blue))
                .frame(width: 150, height: 150)
                .scaleEffect(isDetecting ? 1.2 : 1.0)
                .gesture(
                    LongPressGesture(minimumDuration: 2.0)
                        .onChanged { _ in
                            isDetecting = true
                        }
                        .onEnded { _ in
                            isDetecting = false
                            isComplete = true
                            
                            // Reset after delay
                            DispatchQueue. main.asyncAfter(deadline: .now() + 1) {
                                isComplete = false
                            }
                        }
                )
                .overlay(
                    Text(isComplete ? "Complete!" : (isDetecting ? "Keep holding..." : "Hold me"))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                )
                .animation(.spring(), value: isDetecting)
                .animation(.spring(), value: isComplete)
        }
    }
}

// MARK: - Drag Gesture

struct DragGestureExample: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        VStack(spacing: 50) {
            // Simple drag
            Circle()
                .fill(isDragging ? Color.red : Color.blue)
                .frame(width: 100, height: 100)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging = true
                            offset = value.translation
                        }
                        .onEnded { _ in
                            isDragging = false
                            withAnimation(.spring()) {
                                offset = . zero
                            }
                        }
                )
            
            Text("Drag the circle")
                .font(.caption)
                .foregroundColor(. secondary)
        }
        .frame(height: 400)
    }
}

// MARK: - Drag with Constraints

struct ConstrainedDragExample: View {
    @State private var position = CGPoint(x: 150, y: 150)
    
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .fill(Color. purple)
                .frame(width: 80, height: 80)
                .position(position)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Constrain to bounds
                            let newX = min(max(value.location.x, 40), geometry.size.width - 40)
                            let newY = min(max(value.location.y, 40), geometry.size.height - 40)
                            position = CGPoint(x: newX, y: newY)
                        }
                )
        }
        .frame(height: 300)
        .border(Color.gray)
    }
}

// MARK: - Magnification Gesture (Pinch to Zoom)

struct MagnificationGestureExample: View {
    @State private var scale:  CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    var body:  some View {
        VStack(spacing: 30) {
            Image(systemName: "photo.fill")
                .font(. system(size: 100))
                .foregroundColor(.blue)
                .scaleEffect(scale)
                .gesture(
                    MagnificationGesture()
                        . onChanged { value in
                            scale = lastScale * value
                        }
                        .onEnded { _ in
                            lastScale = scale
                        }
                )
            
            Text("Scale: \(scale, specifier: "%.2f")")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Button("Reset") {
                withAnimation {
                    scale = 1.0
                    lastScale = 1.0
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

// MARK:  - Rotation Gesture

struct RotationGestureExample: View {
    @State private var rotation:  Angle = .zero
    @State private var lastRotation:  Angle = .zero
    
    var body: some View {
        VStack(spacing: 30) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [. blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 200, height: 120)
                .rotationEffect(rotation)
                .gesture(
                    RotationGesture()
                        .onChanged { value in
                            rotation = lastRotation + value
                        }
                        .onEnded { _ in
                            lastRotation = rotation
                        }
                )
                .overlay(
                    Text("Rotate Me")
                        .foregroundColor(.white)
                        .rotationEffect(-rotation)
                )
            
            Text("Rotation: \(rotation. degrees, specifier: "%.1f")°")
                .font(.caption)
                .foregroundColor(. secondary)
            
            Button("Reset") {
                withAnimation {
                    rotation = .zero
                    lastRotation = .zero
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

// MARK: - Combined Gestures (Simultaneous)

struct SimultaneousGesturesExample: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation:  Angle = .zero
    @State private var lastScale: CGFloat = 1.0
    @State private var lastRotation: Angle = .zero
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "star.fill")
                .font(. system(size: 100))
                .foregroundColor(.yellow)
                .scaleEffect(scale)
                .rotationEffect(rotation)
                .gesture(
                    SimultaneousGesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = lastScale * value
                            }
                            . onEnded { _ in
                                lastScale = scale
                            },
                        RotationGesture()
                            .onChanged { value in
                                rotation = lastRotation + value
                            }
                            .onEnded { _ in
                                lastRotation = rotation
                            }
                    )
                )
            
            VStack(spacing: 5) {
                Text("Pinch and rotate simultaneously")
                    .font(.caption)
                Text("Scale: \(scale, specifier: "%.2f")")
                    .font(.caption2)
                Text("Rotation:  \(rotation.degrees, specifier: "%.1f")°")
                    .font(.caption2)
            }
            .foregroundColor(.secondary)
            
            Button("Reset") {
                withAnimation {
                    scale = 1.0
                    rotation = .zero
                    lastScale = 1.0
                    lastRotation = .zero
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

// MARK: - Sequenced Gestures

struct SequencedGesturesExample: View {
    @State private var isLongPressed = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        VStack(spacing: 30) {
            Circle()
                .fill(isLongPressed ? Color.green : Color.blue)
                .frame(width: 100, height: 100)
                .offset(offset)
                .gesture(
                    // Long press followed by drag
                    LongPressGesture(minimumDuration: 0.5)
                        .onEnded { _ in
                            isLongPressed = true
                        }
                        .sequenced(before: DragGesture())
                        .onChanged { value in
                            switch value {
                            case .second(let drag, _):
                                offset = drag?. translation ?? .zero
                            default:
                                break
                            }
                        }
                        .onEnded { _ in
                            withAnimation {
                                isLongPressed = false
                                offset = .zero
                            }
                        }
                )
            
            Text("Long press, then drag")
                .font(.caption)
                .foregroundColor(. secondary)
        }
        . frame(height: 300)
    }
}

// MARK: - Exclusive Gestures

struct ExclusiveGesturesExample: View {
    @State private var message = "Tap or Long Press"
    
    var body: some View {
        VStack(spacing: 30) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.orange)
                .frame(width: 200, height: 150)
                .gesture(
                    // Long press takes priority over tap
                    LongPressGesture(minimumDuration: 1.0)
                        .onEnded { _ in
                            message = "Long Pressed!"
                        }
                        . exclusively(before: TapGesture()
                            .onEnded {
                                message = "Tapped!"
                            }
                        )
                )
                .overlay(
                    Text(message)
                        .foregroundColor(.white)
                        . multilineTextAlignment(.center)
                )
        }
    }
}

// MARK:  - Gesture State

struct GestureStateExample: View {
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    
    var body: some View {
        VStack(spacing: 30) {
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height:  100)
                .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            position. width += value.translation.width
                            position.height += value. translation.height
                        }
                )
            
            Text("Drag to move (persists)")
                .font(.caption)
                .foregroundColor(. secondary)
            
            Button("Reset") {
                withAnimation {
                    position = .zero
                }
            }
            .buttonStyle(.bordered)
        }
        .frame(height: 400)
    }
}

// MARK: - Swipe Gesture

struct SwipeGestureExample: View {
    @State private var offset:  CGFloat = 0
    @State private var swipeDirection = "None"
    
    var body:  some View {
        VStack(spacing: 30) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.purple)
                .frame(width: 300, height: 100)
                .offset(x: offset)
                .gesture(
                    DragGesture(minimumDistance: 50)
                        .onEnded { value in
                            let horizontalAmount = value.translation.width
                            let verticalAmount = value.translation.height
                            
                            if abs(horizontalAmount) > abs(verticalAmount) {
                                // Horizontal swipe
                                if horizontalAmount < 0 {
                                    swipeDirection = "Left"
                                    withAnimation {
                                        offset = -100
                                    }
                                } else {
                                    swipeDirection = "Right"
                                    withAnimation {
                                        offset = 100
                                    }
                                }
                            }
                            
                            // Reset after animation
                            DispatchQueue. main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    offset = 0
                                }
                            }
                        }
                )
                .overlay(
                    Text("Swipe:  \(swipeDirection)")
                        .foregroundColor(.white)
                )
            
            Text("Swipe left or right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

// MARK:  - Velocity-Based Gesture

struct VelocityGestureExample: View {
    @State private var offset = CGSize.zero
    @State private var velocity:  CGFloat = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Circle()
                .fill(Color.red)
                .frame(width: 80, height: 80)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value. translation
                        }
                        .onEnded { value in
                            // Calculate velocity
                            let magnitude = sqrt(
                                pow(value.predictedEndLocation.x - value. location.x, 2) +
                                pow(value.predictedEndLocation.y - value. location.y, 2)
                            )
                            velocity = magnitude
                            
                            // Animate based on velocity
                            withAnimation(.interpolatingSpring(
                                mass: 1,
                                stiffness: 100,
                                damping:  velocity > 500 ? 5 : 10,
                                initialVelocity: 0
                            )) {
                                offset = .zero
                            }
                        }
                )
            
            Text("Velocity: \(velocity, specifier:  "%.0f")")
                .font(. caption)
                .foregroundColor(.secondary)
            
            Text("Drag and release quickly")
                .font(.caption2)
                .foregroundColor(. secondary)
        }
        . frame(height: 400)
    }
}

// MARK: - Practical Example: Swipe to Delete

struct SwipeToDeleteExample: View {
    @State private var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(items, id: \.self) { item in
                SwipeToDeleteRow(text: item) {
                    withAnimation {
                        items.removeAll { $0 == item }
                    }
                }
            }
        }
    }
}

struct SwipeToDeleteRow: View {
    let text: String
    let onDelete: () -> Void
    
    @State private var offset: CGFloat = 0
    @State private var isSwiped = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            // Delete button background
            Color.red
                .frame(height: 60)
            
            HStack {
                Spacer()
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                        .padding(. horizontal, 30)
                }
            }
            
            // Main content
            HStack {
                Text(text)
                    .foregroundColor(.primary)
                    .padding()
                Spacer()
            }
            .frame(height: 60)
            .background(Color(. systemBackground))
            .offset(x: offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        // Only allow left swipe
                        if value. translation.width < 0 {
                            offset = value.translation.width
                        }
                    }
                    .onEnded { value in
                        if value.translation.width < -100 {
                            // Swipe far enough to reveal delete
                            withAnimation {
                                offset = -100
                                isSwiped = true
                            }
                        } else {
                            // Return to original position
                            withAnimation {
                                offset = 0
                                isSwiped = false
                            }
                        }
                    }
            )
        }
        .frame(height: 60)
    }
}

// MARK:  - Practical Example: Pull to Refresh

struct PullToRefreshExample: View {
    @State private var isRefreshing = false
    @State private var offset: CGFloat = 0
    @State private var items = Array(1...20)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Pull to refresh indicator
                ZStack {
                    if isRefreshing {
                        ProgressView()
                    } else {
                        Image(systemName: "arrow.down")
                            .rotationEffect(. degrees(offset > 100 ? 180 : 0))
                            .opacity(offset > 50 ? 1 : 0)
                    }
                }
                .frame(height: 60)
                .offset(y: offset > 0 ? offset - 60 : -60)
                
                // Content
                ForEach(items, id: \.self) { item in
                    HStack {
                        Text("Item \(item)")
                            .padding()
                        Spacer()
                    }
                    . background(Color(. systemGray6))
                    Divider()
                }
            }
            .offset(y: isRefreshing ? 60 : 0)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 0 && ! isRefreshing {
                            offset = value.translation.height
                        }
                    }
                    .onEnded { value in
                        if value.translation.height > 100 && !isRefreshing {
                            // Trigger refresh
                            isRefreshing = true
                            offset = 0
                            
                            // Simulate network request
                            DispatchQueue. main.asyncAfter(deadline: .now() + 2) {
                                items.insert(items.count + 1, at: 0)
                                isRefreshing = false
                            }
                        } else {
                            offset = 0
                        }
                    }
            )
        }
    }
}

// MARK:  - Practical Example: Draggable Card Stack

struct DraggableCardStackExample: View {
    @State private var cards = [
        CardData(id: 1, color: .red, title: "Card 1"),
        CardData(id: 2, color: .blue, title: "Card 2"),
        CardData(id: 3, color: .green, title: "Card 3"),
        CardData(id: 4, color:  .orange, title: "Card 4"),
        CardData(id: 5, color: .purple, title: "Card 5")
    ]
    
    var body: some View {
        ZStack {
            ForEach(cards) { card in
                DraggableCard(card: card) {
                    withAnimation {
                        cards.removeAll { $0.id == card.id }
                    }
                }
                .offset(y: CGFloat(cards.firstIndex(where: { $0.id == card.id }) ?? 0) * 10)
            }
        }
        .padding(40)
    }
}

struct CardData: Identifiable {
    let id: Int
    let color: Color
    let title: String
}

struct DraggableCard: View {
    let card: CardData
    let onRemove: () -> Void
    
    @State private var offset = CGSize.zero
    @State private var rotation:  Double = 0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(card.color. gradient)
            .frame(width: 300, height: 400)
            .overlay(
                Text(card.title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            )
            .rotationEffect(.degrees(rotation))
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation
                        rotation = Double(value.translation.width / 20)
                    }
                    .onEnded { value in
                        // Swipe threshold
                        if abs(value.translation.width) > 150 {
                            // Swiped off screen
                            withAnimation {
                                offset = CGSize(
                                    width: value.translation.width > 0 ? 500 : -500,
                                    height: value.translation.height
                                )
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                onRemove()
                            }
                        } else {
                            // Return to center
                            withAnimation(. spring()) {
                                offset = .zero
                                rotation = 0
                            }
                        }
                    }
            )
    }
}

// MARK: - Practical Example: Zoom & Pan Image

struct ZoomAndPanImageExample: View {
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    
    var body: some View {
        VStack {
            Image(systemName: "photo. fill")
                .font(.system(size: 200))
                .foregroundColor(. blue)
                .scaleEffect(scale)
                .offset(offset)
                .gesture(
                    SimultaneousGesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = lastScale * value
                            }
                            .onEnded { _ in
                                lastScale = scale
                                // Limit scale
                                if scale < 1.0 {
                                    withAnimation {
                                        scale = 1.0
                                        lastScale = 1.0
                                    }
                                } else if scale > 5.0 {
                                    scale = 5.0
                                    lastScale = 5.0
                                }
                            },
                        DragGesture()
                            .onChanged { value in
                                offset = CGSize(
                                    width:  lastOffset.width + value.translation. width,
                                    height:  lastOffset.height + value.translation.height
                                )
                            }
                            .onEnded { _ in
                                lastOffset = offset
                            }
                    )
                )
            
            HStack(spacing: 20) {
                Button("Reset") {
                    withAnimation {
                        scale = 1.0
                        lastScale = 1.0
                        offset = .zero
                        lastOffset = .zero
                    }
                }
                .buttonStyle(.bordered)
                
                Text("Scale: \(scale, specifier:  "%.2f")")
                    .font(.caption)
            }
            .padding()
        }
    }
}

// MARK:  - Practical Example: Interactive Slider

struct InteractiveSliderExample: View {
    @State private var value:  Double = 0.5
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Value: \(value, specifier: "%.2f")")
                .font(. title)
            
            CustomSlider(value: $value)
                .frame(height: 60)
                .padding(. horizontal, 40)
        }
    }
}

struct CustomSlider: View {
    @Binding var value: Double
    @State private var isDragging = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Track background
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                
                // Active track
                Capsule()
                    .fill(Color.blue)
                    .frame(width: geometry.size.width * value)
                
                // Thumb
                Circle()
                    .fill(Color. white)
                    .frame(width: 40, height: 40)
                    .shadow(radius: 4)
                    .scaleEffect(isDragging ? 1.2 : 1.0)
                    .offset(x: geometry.size.width * value - 20)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                isDragging = true
                                let newValue = gesture.location.x / geometry.size.width
                                value = min(max(0, newValue), 1.0)
                            }
                            .onEnded { _ in
                                isDragging = false
                            }
                    )
            }
            .frame(height: 60)
        }
    }
}

// MARK: - Complete Showcase

struct GesturesShowcase: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Basic Gestures") {
                    NavigationLink("Tap Gesture") {
                        TapGestureExample()
                            .navigationTitle("Tap Gesture")
                    }
                    
                    NavigationLink("Long Press") {
                        LongPressGestureExample()
                            .navigationTitle("Long Press")
                    }
                    
                    NavigationLink("Drag") {
                        DragGestureExample()
                            . navigationTitle("Drag Gesture")
                    }
                    
                    NavigationLink("Magnification (Pinch)") {
                        MagnificationGestureExample()
                            .navigationTitle("Magnification")
                    }
                    
                    NavigationLink("Rotation") {
                        RotationGestureExample()
                            .navigationTitle("Rotation")
                    }
                }
                
                Section("Combined Gestures") {
                    NavigationLink("Simultaneous") {
                        SimultaneousGesturesExample()
                            .navigationTitle("Simultaneous")
                    }
                    
                    NavigationLink("Sequenced") {
                        SequencedGesturesExample()
                            .navigationTitle("Sequenced")
                    }
                    
                    NavigationLink("Exclusive") {
                        ExclusiveGesturesExample()
                            .navigationTitle("Exclusive")
                    }
                }
                
                Section("Advanced") {
                    NavigationLink("Gesture State") {
                        GestureStateExample()
                            .navigationTitle("Gesture State")
                    }
                    
                    NavigationLink("Swipe Detection") {
                        SwipeGestureExample()
                            . navigationTitle("Swipe")
                    }
                    
                    NavigationLink("Velocity-Based") {
                        VelocityGestureExample()
                            .navigationTitle("Velocity")
                    }
                }
                
                Section("Practical Examples") {
                    NavigationLink("Swipe to Delete") {
                        SwipeToDeleteExample()
                            .navigationTitle("Swipe to Delete")
                    }
                    
                    NavigationLink("Pull to Refresh") {
                        PullToRefreshExample()
                            .navigationTitle("Pull to Refresh")
                    }
                    
                    NavigationLink("Card Stack") {
                        DraggableCardStackExample()
                            .navigationTitle("Card Stack")
                    }
                    
                    NavigationLink("Zoom & Pan") {
                        ZoomAndPanImageExample()
                            .navigationTitle("Zoom & Pan")
                    }
                    
                    NavigationLink("Custom Slider") {
                        InteractiveSliderExample()
                            .navigationTitle("Custom Slider")
                    }
                }
            }
            .navigationTitle("Gestures")
        }
    }
}

// MARK: - Preview
#Preview {
    GesturesShowcase()
}