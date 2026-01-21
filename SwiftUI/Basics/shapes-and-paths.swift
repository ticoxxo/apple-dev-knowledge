// SwiftUI Shapes and Paths Reference
// Source: https://developer.apple.com/documentation/swiftui/shapes/

import SwiftUI

// MARK:  - Basic Built-in Shapes

/// Rectangle - A rectangular shape aligned inside the frame
struct RectangleExamples: View {
    var body: some View {
        VStack(spacing: 20) {
            // Basic rectangle
            Rectangle()
                .fill(. blue)
                .frame(width: 200, height: 100)
            
            // Rectangle with stroke
            Rectangle()
                .stroke(.red, lineWidth: 4)
                .frame(width: 200, height: 100)
            
            // Rectangle with gradient
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: . topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 200, height: 100)
        }
    }
}

/// RoundedRectangle - A rectangular shape with rounded corners
struct RoundedRectangleExamples: View {
    var body:  some View {
        VStack(spacing: 20) {
            // Rounded rectangle with corner radius
            RoundedRectangle(cornerRadius: 25)
                .fill(.green)
                .frame(width: 200, height: 100)
            
            // Rounded rectangle with specific corner style
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .stroke(.orange, lineWidth: 3)
                .frame(width: 200, height: 100)
            
            // Different corner styles
            HStack {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(.blue)
                    .frame(width: 80, height: 80)
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.purple)
                    .frame(width: 80, height: 80)
            }
        }
    }
}

/// Circle - A circular shape
struct CircleExamples: View {
    var body: some View {
        VStack(spacing: 20) {
            // Filled circle
            Circle()
                .fill(.red)
                .frame(width: 100, height: 100)
            
            // Stroked circle
            Circle()
                .stroke(.blue, lineWidth: 5)
                .frame(width: 100, height: 100)
            
            // Circle with stroke border (grows inward)
            Circle()
                .strokeBorder(.green, lineWidth: 10)
                .frame(width: 100, height: 100)
            
            // Partial circle (trim)
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(.purple, lineWidth: 8)
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(-90))
        }
    }
}

/// Ellipse - An elliptical shape
struct EllipseExamples: View {
    var body:  some View {
        VStack(spacing: 20) {
            // Basic ellipse
            Ellipse()
                .fill(.orange)
                .frame(width: 200, height: 100)
            
            // Stroked ellipse
            Ellipse()
                .stroke(.pink, lineWidth: 4)
                .frame(width: 150, height: 80)
            
            // Ellipse with gradient
            Ellipse()
                .fill(
                    RadialGradient(
                        colors: [.yellow, .orange, .red],
                        center: .center,
                        startRadius: 10,
                        endRadius: 100
                    )
                )
                .frame(width: 200, height: 120)
        }
    }
}

/// Capsule - A capsule shape (rounded ends)
struct CapsuleExamples: View {
    var body: some View {
        VStack(spacing: 20) {
            // Horizontal capsule
            Capsule()
                .fill(.blue)
                .frame(width: 200, height: 50)
            
            // Vertical capsule
            Capsule()
                .fill(.green)
                .frame(width: 50, height: 150)
            
            // Capsule button style
            Text("Tap Me")
                .foregroundColor(.white)
                .padding(. horizontal, 30)
                .padding(.vertical, 15)
                .background(
                    Capsule()
                        .fill(.purple)
                )
            
            // Capsule with stroke
            Capsule(style: .continuous)
                .stroke(.red, lineWidth: 3)
                .frame(width: 180, height: 60)
        }
    }
}

// MARK: - Custom Shapes with Path

/// Triangle - Custom shape using Path
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect. maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

/// Arc - Custom arc shape
struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        
        return path
    }
}

/// Star - Custom star shape
struct Star:  Shape {
    let corners: Int
    let smoothness: Double
    
    func path(in rect: CGRect) -> Path {
        guard corners >= 2 else { return Path() }
        
        let center = CGPoint(x: rect.width / 2, y: rect. height / 2)
        var currentAngle = -CGFloat.pi / 2
        let angleAdjustment = . pi * 2 / CGFloat(corners * 2)
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness
        
        var path = Path()
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
        
        let bottomEdge = rect.maxY
        let maxY = center.y
        
        for corner in 0..<corners * 2 {
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom:  CGFloat
            
            if corner. isMultiple(of: 2) {
                bottom = CGPoint(x: center.x + cosAngle * center.x, y: center.y + sinAngle * center.y).y
            } else {
                bottom = CGPoint(x: center.x + cosAngle * innerX, y: center.y + sinAngle * innerY).y
            }
            
            let y = bottom
            let x = corner. isMultiple(of: 2) ? center.x + cosAngle * center.x : center.x + cosAngle * innerX
            
            path.addLine(to: CGPoint(x: x, y: y))
            currentAngle += angleAdjustment
        }
        
        path.closeSubpath()
        return path
    }
}

/// Polygon - Custom polygon shape
struct Polygon: Shape {
    let sides: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        let angle = (2 * .pi) / CGFloat(sides)
        
        let startPoint = CGPoint(
            x:  center.x + radius * cos(-(. pi / 2)),
            y: center.y + radius * sin(-(.pi / 2))
        )
        
        path.move(to: startPoint)
        
        for side in 1. .<sides {
            let x = center.x + radius * cos(angle * CGFloat(side) - (.pi / 2))
            let y = center.y + radius * sin(angle * CGFloat(side) - (.pi / 2))
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.closeSubpath()
        return path
    }
}

// MARK: - Shape Modifiers and Styling

struct ShapeModifiersExamples: View {
    var body: some View {
        VStack(spacing: 30) {
            // Fill styles
            Circle()
                .fill(.blue)
                .frame(width: 100, height: 100)
            
            // Stroke styles
            Circle()
                .stroke(.red, lineWidth: 5)
                .frame(width: 100, height: 100)
            
            // Stroke with style
            Circle()
                .stroke(. green, style: StrokeStyle(
                    lineWidth: 8,
                    lineCap:  .round,
                    lineJoin: .round,
                    dash: [10, 5]
                ))
                .frame(width: 100, height: 100)
            
            // Stroke border (grows inward)
            Circle()
                .strokeBorder(.purple, lineWidth: 10)
                .frame(width: 100, height: 100)
            
            // Gradient fills
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [. red, .orange, .yellow],
                        startPoint: .leading,
                        endPoint: . trailing
                    )
                )
                .frame(width: 200, height: 100)
            
            // Angular gradient
            Circle()
                .fill(
                    AngularGradient(
                        colors: [.red, . yellow, .green, .blue, .purple, .red],
                        center: .center
                    )
                )
                .frame(width: 100, height: 100)
        }
    }
}

// MARK: - Animatable Shapes

struct AnimatableShapeExample: View {
    @State private var progress: CGFloat = 0
    
    var body: some View {
        VStack(spacing:  40) {
            // Animated circle trim
            Circle()
                .trim(from: 0, to: progress)
                .stroke(.blue, lineWidth: 8)
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 2), value: progress)
            
            // Animated arc
            Arc(
                startAngle: .degrees(0),
                endAngle: .degrees(360 * Double(progress)),
                clockwise: false
            )
            .stroke(. purple, lineWidth: 8)
            .frame(width: 100, height: 100)
            .animation(.easeInOut(duration: 2), value: progress)
            
            // Control
            Button(progress < 1 ? "Animate" : "Reset") {
                if progress < 1 {
                    progress = 1
                } else {
                    progress = 0
                }
            }
            .buttonStyle(. borderedProminent)
        }
        .padding()
    }
}

// MARK:  - InsettableShape Protocol

/// Custom shape that supports inset
struct InsetCircle: InsettableShape {
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        path.addEllipse(in: rect)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> InsetCircle {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

struct InsetShapeExample: View {
    var body: some View {
        VStack(spacing: 20) {
            // Regular stroke grows outward
            Circle()
                .stroke(.red, lineWidth: 20)
                .frame(width: 100, height: 100)
            
            // StrokeBorder uses inset
            Circle()
                .strokeBorder(.blue, lineWidth: 20)
                .frame(width: 100, height: 100)
            
            // Custom inset shape
            InsetCircle()
                .strokeBorder(.green, lineWidth: 20)
                .frame(width: 100, height: 100)
        }
    }
}

// MARK: - Shape Transformations

struct ShapeTransformationsExample: View {
    var body:  some View {
        VStack(spacing: 30) {
            // Rotation
            Rectangle()
                .fill(.blue)
                .frame(width: 100, height: 60)
                .rotationEffect(. degrees(45))
            
            // Scale
            Circle()
                .fill(.green)
                .frame(width: 100, height: 100)
                .scaleEffect(0.7)
            
            // Offset
            RoundedRectangle(cornerRadius: 20)
                .fill(.purple)
                .frame(width: 100, height: 100)
                .offset(x: 20, y: 20)
            
            // Combined transformations
            Triangle()
                .fill(.orange)
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(180))
                .scaleEffect(0.8)
        }
    }
}

// MARK: - Practical Examples

/// Progress Ring
struct ProgressRing: View {
    var progress:  Double
    var lineWidth: CGFloat = 10
    var color: Color = .blue
    
    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(color. opacity(0.2), lineWidth: lineWidth)
            
            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
        }
    }
}

/// Custom Button with Shape
struct CustomShapeButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .padding(. horizontal, 30)
                .padding(.vertical, 15)
                .background(
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: . trailing
                            )
                        )
                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                )
        }
    }
}

/// Badge with custom shape
struct Badge: View {
    let count: Int
    
    var body: some View {
        Text("\(count)")
            .font(. caption)
            .foregroundColor(.white)
            .frame(width: 20, height: 20)
            .background(
                Circle()
                    .fill(. red)
            )
    }
}

/// Card with custom corners
struct CustomCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(. white)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            )
    }
}

// MARK: - Complete Example View

struct ShapesShowcase: View {
    @State private var progress: Double = 0.7
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Basic shapes
                HStack(spacing: 20) {
                    Circle()
                        .fill(.blue)
                        .frame(width: 60, height: 60)
                    
                    Rectangle()
                        .fill(.green)
                        .frame(width: 60, height: 60)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.orange)
                        .frame(width: 60, height: 60)
                    
                    Capsule()
                        .fill(.purple)
                        .frame(width: 60, height:  40)
                }
                
                // Custom shapes
                HStack(spacing: 20) {
                    Triangle()
                        .fill(.red)
                        .frame(width: 60, height: 60)
                    
                    Star(corners: 5, smoothness: 0.45)
                        .fill(.yellow)
                        .frame(width: 60, height: 60)
                    
                    Polygon(sides: 6)
                        .fill(.cyan)
                        .frame(width: 60, height: 60)
                }
                
                // Progress ring
                ProgressRing(progress: progress, lineWidth: 15, color: .blue)
                    .frame(width: 120, height: 120)
                    .overlay(
                        Text("\(Int(progress * 100))%")
                            .font(. title2)
                            .bold()
                    )
                
                // Custom button
                CustomShapeButton(title: "Get Started") {
                    print("Button tapped")
                }
                
                // Card example
                CustomCard {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Notifications")
                                .font(.headline)
                            Spacer()
                            Badge(count: 3)
                        }
                        Text("You have new messages")
                            .font(. subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                . padding(. horizontal)
            }
            . padding(. vertical, 40)
        }
    }
}

// MARK:  - Preview
#Preview {
    ShapesShowcase()
}