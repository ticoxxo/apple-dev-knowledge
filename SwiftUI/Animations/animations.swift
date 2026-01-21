// SwiftUI Animations Reference
// Source: https://developer.apple.com/documentation/swiftui/animations

import SwiftUI

// MARK: - Basic Implicit Animations

/// Simple implicit animations with . animation() modifier
struct ImplicitAnimationExample: View {
    @State private var isExpanded = false
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 40) {
            // Size animation
            RoundedRectangle(cornerRadius: isExpanded ? 50 : 20)
                .fill(Color.blue)
                .frame(width: isExpanded ? 300 : 150, height: isExpanded ? 300 : 150)
                .animation(.easeInOut(duration: 0.5), value: isExpanded)
            
            // Rotation animation
            Image(systemName: "arrow.right")
                .font(.largeTitle)
                .foregroundColor(.green)
                .rotationEffect(.degrees(rotation))
                .animation(.linear(duration: 1), value: rotation)
            
            // Scale animation
            Circle()
                .fill(Color. purple)
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: scale)
            
            // Controls
            HStack(spacing: 20) {
                Button(isExpanded ? "Shrink" : "Expand") {
                    isExpanded.toggle()
                }
                
                Button("Rotate") {
                    rotation += 90
                }
                
                Button(scale > 1 ? "Scale Down" : "Scale Up") {
                    scale = scale > 1 ? 1.0 : 1.5
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

// MARK:  - Explicit Animations with withAnimation

struct ExplicitAnimationExample: View {
    @State private var offset: CGFloat = 0
    @State private var opacity: Double = 1.0
    @State private var color: Color = .blue
    
    var body: some View {
        VStack(spacing: 40) {
            Circle()
                .fill(color)
                .frame(width: 100, height: 100)
                .offset(x: offset)
                .opacity(opacity)
            
            VStack(spacing: 15) {
                Button("Slide") {
                    withAnimation(.easeInOut(duration: 1)) {
                        offset = offset == 0 ? 100 : 0
                    }
                }
                
                Button("Fade") {
                    withAnimation(.easeIn(duration: 0.5)) {
                        opacity = opacity == 1 ? 0.2 : 1.0
                    }
                }
                
                Button("Change Color") {
                    withAnimation(.spring()) {
                        color = color == .blue ? .red : . blue
                    }
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

// MARK: - Animation Curves

struct AnimationCurvesExample: View {
    @State private var move = false
    
    var body: some View {
        VStack(spacing: 20) {
            AnimatedRow(title: "Linear", color: .blue, move: move, animation: .linear(duration: 1))
            AnimatedRow(title: "EaseIn", color: .green, move: move, animation: .easeIn(duration: 1))
            AnimatedRow(title: "EaseOut", color: .orange, move: move, animation: . easeOut(duration: 1))
            AnimatedRow(title: "EaseInOut", color: .purple, move: move, animation: .easeInOut(duration: 1))
            
            Button(move ? "Reset" : "Animate") {
                withAnimation {
                    move.toggle()
                }
            }
            . buttonStyle(.borderedProminent)
            . padding(. top, 20)
        }
        .padding()
    }
}

struct AnimatedRow: View {
    let title: String
    let color: Color
    let move: Bool
    let animation: Animation
    
    var body: some View {
        HStack {
            Text(title)
                .font(. caption)
                .frame(width: 80, alignment: .leading)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 30)
                
                Circle()
                    .fill(color)
                    .frame(width: 30, height: 30)
                    .offset(x: move ? 250 : 0)
                    .animation(animation, value: move)
            }
        }
    }
}

// MARK:  - Spring Animations

struct SpringAnimationExample: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 30) {
            // Default spring
            Circle()
                .fill(Color.blue)
                .frame(width: 60, height: 60)
                .offset(y: isAnimating ? -100 : 0)
                .animation(.spring(), value: isAnimating)
            
            Text("Default Spring")
                .font(.caption)
            
            // Custom spring - bouncy
            Circle()
                .fill(Color.green)
                .frame(width: 60, height: 60)
                .offset(y: isAnimating ?  -100 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.3), value: isAnimating)
            
            Text("Bouncy (low damping)")
                .font(. caption)
            
            // Custom spring - smooth
            Circle()
                .fill(Color.purple)
                .frame(width: 60, height: 60)
                .offset(y: isAnimating ? -100 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.9), value: isAnimating)
            
            Text("Smooth (high damping)")
                .font(.caption)
            
            // Interpolating spring
            Circle()
                .fill(Color.orange)
                .frame(width: 60, height: 60)
                .offset(y: isAnimating ?  -100 : 0)
                .animation(.interpolatingSpring(stiffness:  50, damping: 5), value: isAnimating)
            
            Text("Interpolating Spring")
                .font(.caption)
            
            Button("Animate") {
                isAnimating.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Repeating Animations

struct RepeatingAnimationExample: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0
    @State private var opacity: Double = 1.0
    
    var body: some View {
        VStack(spacing: 50) {
            // Forever repeating
            Circle()
                .fill(Color. blue)
                .frame(width: 80, height: 80)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        scale = 1.5
                    }
                }
            
            Text("Scale (Forever)")
                .font(.caption)
            
            // Repeat count
            Circle()
                .fill(Color. green)
                .frame(width: 80, height: 80)
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    withAnimation(.linear(duration: 2).repeatCount(3, autoreverses: false)) {
                        rotation = 360
                    }
                }
            
            Text("Rotation (3 times)")
                .font(. caption)
            
            // Pulsing effect
            Circle()
                .fill(Color.purple)
                .frame(width: 80, height: 80)
                .opacity(opacity)
                .onAppear {
                    withAnimation(. easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                        opacity = 0.3
                    }
                }
            
            Text("Pulse (Forever)")
                .font(.caption)
        }
        .padding()
    }
}

// MARK: - Delayed Animations

struct DelayedAnimationExample: View {
    @State private var show = false
    
    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 20) {
                ForEach(0..<5) { index in
                    Circle()
                        .fill(Color. blue)
                        .frame(width: 40, height: 40)
                        .scaleEffect(show ? 1.0 : 0.1)
                        .animation(
                            . spring(response: 0.4, dampingFraction: 0.6)
                                .delay(Double(index) * 0.1),
                            value: show
                        )
                }
            }
            
            Button(show ? "Hide" : "Show") {
                show.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Animation Speed

struct AnimationSpeedExample:  View {
    @State private var move = false
    
    var body: some View {
        VStack(spacing: 30) {
            AnimatedCircle(title: "Speed 0.5x (Slower)", color: .blue, move: move, speed: 0.5)
            AnimatedCircle(title: "Speed 1x (Normal)", color: .green, move: move, speed: 1.0)
            AnimatedCircle(title: "Speed 2x (Faster)", color: .orange, move: move, speed:  2.0)
            
            Button(move ? "Reset" : "Animate") {
                move.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct AnimatedCircle: View {
    let title: String
    let color: Color
    let move:  Bool
    let speed: Double
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(. caption)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 40)
                
                Circle()
                    .fill(color)
                    .frame(width: 40, height: 40)
                    .offset(x: move ? 280 : 0)
                    .animation(. easeInOut(duration: 1).speed(speed), value: move)
            }
        }
    }
}

// MARK: - Matched Geometry Effect

struct MatchedGeometryExample: View {
    @Namespace private var animation
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 40) {
            if isExpanded {
                // Expanded view
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color. blue. gradient)
                    .matchedGeometryEffect(id:  "shape", in: animation)
                    .frame(width: 300, height: 400)
                    .overlay(
                        VStack {
                            Spacer()
                            Text("Expanded")
                                . font(.title)
                                . foregroundColor(.white)
                                .matchedGeometryEffect(id:  "text", in: animation)
                            Spacer()
                        }
                    )
            } else {
                // Compact view
                VStack {
                    Spacer()
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            . fill(Color.blue. gradient)
                            .matchedGeometryEffect(id: "shape", in: animation)
                            .frame(width: 100, height: 100)
                            .overlay(
                                Text("Compact")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .matchedGeometryEffect(id: "text", in: animation)
                            )
                        Spacer()
                    }
                    .padding()
                }
            }
            
            Button(isExpanded ? "Collapse" : "Expand") {
                withAnimation(. spring(response: 0.6, dampingFraction: 0.8)) {
                    isExpanded.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK:  - Phase Animator (iOS 17+)

struct PhaseAnimatorExample: View {
    enum Phase:  CaseIterable {
        case initial
        case move
        case scale
        case rotate
        
        var offset: CGFloat {
            switch self {
            case .initial: return 0
            case .move: return 100
            case .scale: return 100
            case .rotate: return 0
            }
        }
        
        var scale: CGFloat {
            switch self {
            case .initial: return 1.0
            case .move: return 1.0
            case .scale: return 1.5
            case .rotate: return 1.0
            }
        }
        
        var rotation: Double {
            switch self {
            case . initial: return 0
            case .move: return 0
            case .scale: return 0
            case .rotate: return 360
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 40) {
            PhaseAnimator(Phase.allCases, trigger: 0) { phase in
                RoundedRectangle(cornerRadius: 20)
                    . fill(Color.blue)
                    .frame(width: 100, height: 100)
                    .offset(x: phase. offset)
                    .scaleEffect(phase.scale)
                    .rotationEffect(. degrees(phase.rotation))
            } animation: { phase in
                . spring(response: 0.5, dampingFraction: 0.7)
            }
            
            Text("Phase Animator")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

// MARK:  - Keyframe Animator (iOS 17+)

struct KeyframeAnimatorExample: View {
    @State private var startAnimation = false
    
    var body: some View {
        VStack(spacing: 40) {
            Circle()
                .fill(Color. purple)
                .frame(width: 80, height: 80)
                .keyframeAnimator(initialValue: AnimationValues(), trigger: startAnimation) { view, value in
                    view
                        .offset(y: value.verticalOffset)
                        .scaleEffect(value.scale)
                        .rotationEffect(. degrees(value.rotation))
                } keyframes: { _ in
                    KeyframeTrack(\. verticalOffset) {
                        CubicKeyframe(-100, duration: 0.3)
                        CubicKeyframe(0, duration: 0.3)
                    }
                    
                    KeyframeTrack(\.scale) {
                        SpringKeyframe(1.2, duration: 0.3, spring: .bouncy)
                        SpringKeyframe(1.0, duration: 0.3, spring: .bouncy)
                    }
                    
                    KeyframeTrack(\.rotation) {
                        LinearKeyframe(360, duration: 0.6)
                    }
                }
            
            Button("Animate") {
                startAnimation. toggle()
            }
            . buttonStyle(.borderedProminent)
            
            Text("Keyframe Animator")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct AnimationValues {
    var verticalOffset: CGFloat = 0
    var scale: CGFloat = 1.0
    var rotation: Double = 0
}

// MARK: - Transitions

struct TransitionsExample: View {
    @State private var show = false
    
    var body: some View {
        VStack(spacing: 30) {
            Button(show ? "Hide" : "Show") {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    show.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
            
            ScrollView {
                VStack(spacing: 20) {
                    if show {
                        // Opacity
                        transitionBox(title: "Opacity", color: .blue)
                            .transition(.opacity)
                        
                        // Scale
                        transitionBox(title: "Scale", color: .green)
                            . transition(.scale)
                        
                        // Slide
                        transitionBox(title: "Slide", color: . orange)
                            .transition(. slide)
                        
                        // Move (from edge)
                        transitionBox(title: "Move", color: . purple)
                            .transition(. move(edge: .trailing))
                        
                        // Offset
                        transitionBox(title: "Offset", color: . red)
                            .transition(. offset(x: 100, y: 0))
                        
                        // Combined
                        transitionBox(title: "Scale + Opacity", color: .pink)
                            .transition(.scale.combined(with: .opacity))
                        
                        // Asymmetric
                        transitionBox(title: "Asymmetric", color: .cyan)
                            .transition(.asymmetric(
                                insertion: .move(edge: .leading),
                                removal: .move(edge: .trailing)
                            ))
                    }
                }
                .padding()
            }
        }
    }
    
    func transitionBox(title: String, color: Color) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(color)
            .frame(height: 80)
            .overlay(
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
            )
    }
}

// MARK: - Custom Transitions

struct CustomTransitionExample: View {
    @State private var show = false
    
    var body: some View {
        VStack(spacing: 40) {
            Button(show ?  "Hide" : "Show") {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    show.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
            
            if show {
                RoundedRectangle(cornerRadius: 20)
                    . fill(Color.blue. gradient)
                    .frame(width: 200, height: 200)
                    .overlay(
                        Text("Custom\nTransition")
                            . foregroundColor(.white)
                            .font(.title)
                            .multilineTextAlignment(.center)
                    )
                    .transition(. pivot)
            }
        }
        .padding()
    }
}

// Custom pivot transition
extension AnyTransition {
    static var pivot: AnyTransition {
        . modifier(
            active: PivotModifier(rotation: -90, opacity: 0),
            identity: PivotModifier(rotation: 0, opacity: 1)
        )
    }
}

struct PivotModifier: ViewModifier {
    let rotation: Double
    let opacity:  Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(rotation), anchor: .topLeading)
            .opacity(opacity)
    }
}

// MARK: - Animation with Binding

struct BindingAnimationExample: View {
    @State private var value:  Double = 50
    
    var body: some View {
        VStack(spacing: 40) {
            Circle()
                .fill(Color. blue)
                .frame(width: value * 2, height: value * 2)
            
            Text("Size: \(Int(value))")
                .font(.headline)
            
            Slider(value: $value. animation(.spring()), in: 30...100)
                .padding(. horizontal, 40)
            
            Text("Drag slider (animated binding)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

// MARK: - Practical Example:  Loading Spinner

struct LoadingSpinnerExample: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 40) {
            // Rotating spinner
            Circle()
                .trim(from: 0, to:  0.7)
                .stroke(Color.blue, lineWidth: 5)
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
            
            // Dot spinner
            HStack(spacing: 10) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 15, height: 15)
                        .scaleEffect(isAnimating ? 1.0 : 0.5)
                        .animation(
                            .easeInOut(duration: 0.6)
                                .repeatForever()
                                .delay(Double(index) * 0.2),
                            value: isAnimating
                        )
                }
            }
            
            // Bars spinner
            HStack(spacing: 5) {
                ForEach(0..<5) { index in
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.blue)
                        .frame(width: 8, height: isAnimating ? 40 : 20)
                        .animation(
                            .easeInOut(duration: 0.5)
                                .repeatForever()
                                .delay(Double(index) * 0.1),
                            value: isAnimating
                        )
                }
            }
        }
        .onAppear {
            isAnimating = true
        }
        .padding()
    }
}

// MARK: - Practical Example: Progress Bar

struct ProgressBarExample:  View {
    @State private var progress:  Double = 0.0
    
    var body: some View {
        VStack(spacing: 30) {
            // Linear progress
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    . fill(Color.gray.opacity(0.3))
                    .frame(height: 20)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    . frame(width: 300 * progress, height: 20)
                    .animation(.spring(), value: progress)
            }
            . frame(width: 300)
            
            Text("\(Int(progress * 100))%")
                .font(.headline)
            
            // Circular progress
            ZStack {
                Circle()
                    . stroke(Color.gray. opacity(0.3), lineWidth: 15)
                    .frame(width: 100, height: 100)
                
                Circle()
                    .trim(from: 0, to: progress)
                    . stroke(Color.blue, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(-90))
                    .animation(. spring(), value: progress)
                
                Text("\(Int(progress * 100))%")
                    .font(.caption)
            }
            
            HStack(spacing: 20) {
                Button("Start") {
                    withAnimation {
                        progress = 0.0
                    }
                    
                    Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                        if progress < 1.0 {
                            progress += 0.02
                        } else {
                            timer.invalidate()
                        }
                    }
                }
                
                Button("Reset") {
                    withAnimation {
                        progress = 0.0
                    }
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

// MARK: - Practical Example:  Skeleton Loading

struct SkeletonLoadingExample: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing:  20) {
            ForEach(0..<3) { _ in
                HStack(spacing: 15) {
                    // Avatar skeleton
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [. clear, .white. opacity(0.3), .clear],
                                        startPoint: .leading,
                                        endPoint:  .trailing
                                    )
                                )
                                .offset(x: isAnimating ? 100 : -100)
                                .mask(Circle())
                        )
                    
                    VStack(alignment: .leading, spacing: 10) {
                        // Title skeleton
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 20)
                            . overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(
                                        LinearGradient(
                                            colors: [. clear, .white.opacity(0.3), .clear],
                                            startPoint: .leading,
                                            endPoint:  .trailing
                                        )
                                    )
                                    .offset(x: isAnimating ? 300 : -300)
                                    .mask(RoundedRectangle(cornerRadius: 5))
                            )
                        
                        // Subtitle skeleton
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 150, height: 15)
                            .overlay(
                                RoundedRectangle(cornerRadius:  5)
                                    . fill(
                                        LinearGradient(
                                            colors: [.clear, .white. opacity(0.3), .clear],
                                            startPoint:  .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .offset(x: isAnimating ? 200 : -200)
                                    .mask(RoundedRectangle(cornerRadius: 5).frame(width: 150))
                            )
                    }
                }
                .padding()
                .background(Color(. systemBackground))
                .cornerRadius(10)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 1. 5).repeatForever(autoreverses: false)) {
                isAnimating = true
            }
        }
        .padding()
    }
}

// MARK: - Practical Example:  Animated Menu

struct AnimatedMenuExample: View {
    @State private var isExpanded = false
    
    let menuItems = [
        ("house. fill", "Home", Color.blue),
        ("magnifyingglass", "Search", Color.green),
        ("heart.fill", "Favorites", Color.red),
        ("person.fill", "Profile", Color.purple)
    ]
    
    var body: some View {
        ZStack {
            if isExpanded {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            isExpanded = false
                        }
                    }
                    .transition(.opacity)
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        ForEach(Array(menuItems.enumerated()), id: \.offset) { index, item in
                            if isExpanded {
                                MenuButton(icon: item.0, title: item.1, color: item.2)
                                    .transition(.scale. combined(with: .opacity))
                                    .animation(
                                        .spring(response: 0.4, dampingFraction: 0.7)
                                            . delay(Double(index) * 0.05),
                                        value: isExpanded
                                    )
                            }
                        }
                        
                        // Main button
                        Button(action: {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                isExpanded.toggle()
                            }
                        }) {
                            Image(systemName: isExpanded ?  "xmark" : "plus")
                                . font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .rotationEffect(.degrees(isExpanded ? 45 : 0))
                                .shadow(radius: 5)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct MenuButton: View {
    let icon: String
    let title:  String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Text(title)
                .font(. headline)
                .foregroundColor(.primary)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(Color(. systemBackground))
                .cornerRadius(10)
                .shadow(radius: 3)
            
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(color)
                .clipShape(Circle())
                .shadow(radius: 3)
        }
    }
}

// MARK:  - Practical Example: Card Flip

struct CardFlipExample: View {
    @State private var isFlipped = false
    
    var body: some View {
        VStack(spacing: 40) {
            ZStack {
                // Back of card
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color. red. gradient)
                    .frame(width: 250, height: 350)
                    .overlay(
                        Text("Back")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    )
                    .rotation3DEffect(
                        . degrees(isFlipped ? 0 : 180),
                        axis: (x: 0, y: 1, z: 0)
                    )
                
                // Front of card
                RoundedRectangle(cornerRadius: 20)
                    . fill(Color.blue.gradient)
                    .frame(width: 250, height: 350)
                    .overlay(
                        VStack {
                            Image(systemName: "creditcard. fill")
                                .font(. system(size: 80))
                                .foregroundColor(.white)
                            Text("Front")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                    )
                    .rotation3DEffect(
                        .degrees(isFlipped ?  180 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
            }
            
            Button("Flip Card") {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    isFlipped.toggle()
                }
            }
            .buttonStyle(. borderedProminent)
        }
        .padding()
    }
}

// MARK: - Complete Showcase

struct AnimationsShowcase: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Basic Animations") {
                    NavigationLink("Implicit Animation") {
                        ImplicitAnimationExample()
                            .navigationTitle("Implicit")
                    }
                    
                    NavigationLink("Explicit Animation") {
                        ExplicitAnimationExample()
                            .navigationTitle("Explicit")
                    }
                    
                    NavigationLink("Animation Curves") {
                        AnimationCurvesExample()
                            . navigationTitle("Curves")
                    }
                    
                    NavigationLink("Spring Animations") {
                        SpringAnimationExample()
                            .navigationTitle("Spring")
                    }
                }
                
                Section("Advanced Animations") {
                    NavigationLink("Repeating") {
                        RepeatingAnimationExample()
                            .navigationTitle("Repeating")
                    }
                    
                    NavigationLink("Delayed") {
                        DelayedAnimationExample()
                            . navigationTitle("Delayed")
                    }
                    
                    NavigationLink("Animation Speed") {
                        AnimationSpeedExample()
                            .navigationTitle("Speed")
                    }
                    
                    NavigationLink("Matched Geometry") {
                        MatchedGeometryExample()
                            .navigationTitle("Matched Geometry")
                    }
                }
                
                Section("iOS 17+") {
                    NavigationLink("Phase Animator") {
                        PhaseAnimatorExample()
                            .navigationTitle("Phase Animator")
                    }
                    
                    NavigationLink("Keyframe Animator") {
                        KeyframeAnimatorExample()
                            .navigationTitle("Keyframe")
                    }
                }
                
                Section("Transitions") {
                    NavigationLink("Built-in Transitions") {
                        TransitionsExample()
                            .navigationTitle("Transitions")
                    }
                    
                    NavigationLink("Custom Transition") {
                        CustomTransitionExample()
                            .navigationTitle("Custom")
                    }
                }
                
                Section("Other Techniques") {
                    NavigationLink("Binding Animation") {
                        BindingAnimationExample()
                            . navigationTitle("Binding")
                    }
                }
                
                Section("Practical Examples") {
                    NavigationLink("Loading Spinners") {
                        LoadingSpinnerExample()
                            .navigationTitle("Spinners")
                    }
                    
                    NavigationLink("Progress Bars") {
                        ProgressBarExample()
                            .navigationTitle("Progress")
                    }
                    
                    NavigationLink("Skeleton Loading") {
                        SkeletonLoadingExample()
                            . navigationTitle("Skeleton")
                    }
                    
                    NavigationLink("Animated Menu") {
                        AnimatedMenuExample()
                            . navigationTitle("Menu")
                    }
                    
                    NavigationLink("Card Flip") {
                        CardFlipExample()
                            . navigationTitle("Card Flip")
                    }
                }
            }
            .navigationTitle("Animations")
        }
    }
}

// MARK:  - Preview
#Preview {
    AnimationsShowcase()
}