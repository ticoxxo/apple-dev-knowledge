// SwiftUI Canvas Drawing Reference
// Source: https://developer.apple.com/documentation/swiftui/canvas

import SwiftUI

// MARK: - Basic Canvas Usage

/// Simple Canvas with basic shapes
struct BasicCanvasExample: View {
    var body: some View {
        Canvas { context, size in
            // Draw a circle
            context.fill(
                Path(ellipseIn: CGRect(x: 50, y: 50, width: 100, height: 100)),
                with: .color(.blue)
            )
            
            // Draw a rectangle
            context. stroke(
                Path(CGRect(x: 200, y: 50, width:  100, height: 100)),
                with: .color(.red),
                lineWidth: 3
            )
            
            // Draw a line
            var path = Path()
            path.move(to: CGPoint(x: 0, y: size.height / 2))
            path.addLine(to: CGPoint(x: size.width, y: size.height / 2))
            context.stroke(path, with: .color(. green), lineWidth: 2)
        }
        .frame(height: 300)
        .border(Color.gray)
    }
}

// MARK: - Drawing with Paths

struct PathDrawingExample: View {
    var body: some View {
        Canvas { context, size in
            let centerX = size.width / 2
            let centerY = size. height / 2
            
            // Draw a triangle
            var trianglePath = Path()
            trianglePath.move(to: CGPoint(x: centerX, y: 50))
            trianglePath.addLine(to: CGPoint(x: centerX - 50, y: 150))
            trianglePath. addLine(to: CGPoint(x: centerX + 50, y: 150))
            trianglePath.closeSubpath()
            
            context.fill(trianglePath, with: . color(.purple))
            
            // Draw a curved path
            var curvePath = Path()
            curvePath.move(to: CGPoint(x: 50, y: 200))
            curvePath.addQuadCurve(
                to: CGPoint(x:  size.width - 50, y: 200),
                control: CGPoint(x: centerX, y: 100)
            )
            
            context.stroke(curvePath, with: . color(.orange), lineWidth: 4)
        }
        .frame(height: 300)
    }
}

// MARK:  - Gradients in Canvas

struct CanvasGradientsExample: View {
    var body: some View {
        Canvas { context, size in
            // Linear gradient
            let linearGradient = Gradient(colors: [. blue, .purple])
            let linearShading = GraphicsContext. Shading. linearGradient(
                linearGradient,
                startPoint: .zero,
                endPoint: CGPoint(x: size.width, y: 0)
            )
            
            context.fill(
                Path(CGRect(x: 20, y: 20, width:  size.width - 40, height: 80)),
                with: linearShading
            )
            
            // Radial gradient
            let radialGradient = Gradient(colors: [.yellow, .orange, .red])
            let radialShading = GraphicsContext. Shading.radialGradient(
                radialGradient,
                center: CGPoint(x: size.width / 2, y: 200),
                startRadius: 10,
                endRadius: 80
            )
            
            context.fill(
                Path(ellipseIn: CGRect(x: size.width / 2 - 80, y: 120, width: 160, height:  160)),
                with: radialShading
            )
        }
        .frame(height: 300)
    }
}

// MARK: - Text Rendering in Canvas

struct CanvasTextExample: View {
    var body: some View {
        Canvas { context, size in
            // Simple text
            let text = Text("Hello, Canvas!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(. blue)
            
            context.draw(text, at: CGPoint(x: size.width / 2, y: 50))
            
            // Text with custom position
            let customText = Text("Custom Position")
                .font(.title2)
                .foregroundColor(. purple)
            
            context.draw(
                customText,
                at:  CGPoint(x: 100, y: 150),
                anchor: .leading
            )
            
            // Rotated text
            var rotatedContext = context
            rotatedContext.rotate(by: .degrees(45))
            let rotatedText = Text("Rotated!")
                .font(.headline)
                .foregroundColor(. red)
            rotatedContext. draw(rotatedText, at:  CGPoint(x: size.width / 2, y: 200))
        }
        .frame(height: 300)
    }
}

// MARK:  - Drawing Symbols and Images

struct CanvasSymbolsExample: View {
    var body: some View {
        Canvas { context, size in
            // SF Symbol
            if let symbol = context.resolveSymbol(id: "star") {
                context.draw(symbol, at: CGPoint(x: 100, y: 100))
            }
            
            // Multiple symbols in a grid
            let columns = 5
            let rows = 3
            let spacing:  CGFloat = 60
            
            for row in 0..<rows {
                for col in 0..<columns {
                    if let symbol = context.resolveSymbol(id: "heart") {
                        let x = CGFloat(col) * spacing + 50
                        let y = CGFloat(row) * spacing + 150
                        context.draw(symbol, at: CGPoint(x:  x, y: y))
                    }
                }
            }
        } symbols: {
            Image(systemName: "star. fill")
                .font(.system(size: 40))
                .foregroundColor(.yellow)
                .tag("star")
            
            Image(systemName: "heart.fill")
                .font(.system(size: 30))
                .foregroundColor(. red)
                .tag("heart")
        }
        .frame(height: 350)
    }
}

// MARK: - Transforms and Transformations

struct CanvasTransformsExample: View {
    var body: some View {
        Canvas { context, size in
            let rect = CGRect(x: 0, y: 0, width:  50, height: 50)
            
            // Original
            context.fill(Path(rect), with: .color(.blue))
            
            // Translated
            var translatedContext = context
            translatedContext. translateBy(x: 100, y: 0)
            translatedContext.fill(Path(rect), with: .color(.green))
            
            // Rotated
            var rotatedContext = context
            rotatedContext.translateBy(x: 250, y: 25)
            rotatedContext.rotate(by: .degrees(45))
            rotatedContext.fill(Path(rect), with: .color(.orange))
            
            // Scaled
            var scaledContext = context
            scaledContext. translateBy(x: 400, y: 0)
            scaledContext.scaleBy(x: 1.5, y: 1.5)
            scaledContext. fill(Path(rect), with: .color(.purple))
        }
        .frame(height: 200)
    }
}

// MARK: - Opacity and Blending

struct CanvasBlendingExample: View {
    var body: some View {
        Canvas { context, size in
            // First circle
            context.opacity = 0.8
            context.fill(
                Path(ellipseIn: CGRect(x: 50, y: 50, width: 100, height: 100)),
                with: .color(.red)
            )
            
            // Second circle with blending
            context.opacity = 0.6
            context.blendMode = .multiply
            context.fill(
                Path(ellipseIn: CGRect(x: 100, y: 50, width: 100, height:  100)),
                with: . color(.blue)
            )
            
            // Third circle
            context.opacity = 0.7
            context.fill(
                Path(ellipseIn: CGRect(x: 75, y: 100, width: 100, height: 100)),
                with: .color(.green)
            )
        }
        . frame(height: 250)
    }
}

// MARK: - Clipping and Masking

struct CanvasClippingExample: View {
    var body: some View {
        Canvas { context, size in
            // Create a circular clip
            let clipPath = Path(ellipseIn: CGRect(x: 50, y: 50, width:  200, height: 200))
            context.clip(to: clipPath)
            
            // Draw a gradient that will be clipped
            let gradient = Gradient(colors: [.blue, .purple, .pink])
            let shading = GraphicsContext.Shading.linearGradient(
                gradient,
                startPoint:  .zero,
                endPoint: CGPoint(x: size.width, y: size.height)
            )
            
            context.fill(
                Path(CGRect(origin: .zero, size: size)),
                with: shading
            )
        }
        .frame(height: 300)
    }
}

// MARK:  - Animated Canvas

struct AnimatedCanvasExample: View {
    @State private var rotation: Double = 0
    @State private var scale: Double = 1.0
    
    var body: some View {
        VStack {
            Canvas { context, size in
                let center = CGPoint(x: size. width / 2, y: size.height / 2)
                
                // Animated rotating shape
                var rotatedContext = context
                rotatedContext.translateBy(x: center.x, y: center.y)
                rotatedContext.rotate(by: . degrees(rotation))
                rotatedContext.scaleBy(x: scale, y: scale)
                rotatedContext.translateBy(x: -25, y: -25)
                
                rotatedContext.fill(
                    Path(CGRect(x: 0, y: 0, width: 50, height: 50)),
                    with: .color(.blue)
                )
            }
            .frame(height: 200)
            .onAppear {
                withAnimation(. linear(duration: 2).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    scale = 1.5
                }
            }
            
            Text("Rotating & Scaling")
                .font(.caption)
                .foregroundColor(. secondary)
        }
    }
}

// MARK:  - Drawing with TimelineView for Animation

struct AnimatedParticlesCanvas: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let time = timeline.date.timeIntervalSinceReferenceDate
                
                // Draw animated particles
                for i in 0..<20 {
                    let angle = (time + Double(i)) * 0.5
                    let x = size.width / 2 + cos(angle) * 80
                    let y = size. height / 2 + sin(angle) * 80
                    let radius = 5 + sin(time * 2 + Double(i)) * 3
                    
                    context. fill(
                        Path(ellipseIn: CGRect(
                            x: x - radius,
                            y: y - radius,
                            width: radius * 2,
                            height:  radius * 2
                        )),
                        with: .color(.blue. opacity(0.7))
                    )
                }
            }
            .frame(height: 250)
        }
    }
}

// MARK: - Stroke Styles

struct CanvasStrokeStylesExample: View {
    var body:  some View {
        Canvas { context, size in
            let y:  CGFloat = 50
            let spacing: CGFloat = 40
            
            // Solid line
            var path1 = Path()
            path1.move(to: CGPoint(x: 20, y: y))
            path1.addLine(to: CGPoint(x: size.width - 20, y: y))
            context.stroke(path1, with: .color(.blue), lineWidth: 3)
            
            // Dashed line
            var path2 = Path()
            path2.move(to: CGPoint(x: 20, y: y + spacing))
            path2.addLine(to: CGPoint(x: size.width - 20, y: y + spacing))
            context.stroke(
                path2,
                with:  .color(.red),
                style: StrokeStyle(lineWidth: 3, dash: [10, 5])
            )
            
            // Dotted line
            var path3 = Path()
            path3.move(to: CGPoint(x: 20, y: y + spacing * 2))
            path3.addLine(to: CGPoint(x: size.width - 20, y: y + spacing * 2))
            context.stroke(
                path3,
                with:  .color(.green),
                style: StrokeStyle(lineWidth: 3, dash: [2, 4])
            )
            
            // Round caps
            var path4 = Path()
            path4.move(to: CGPoint(x:  20, y: y + spacing * 3))
            path4.addLine(to: CGPoint(x: size.width - 20, y: y + spacing * 3))
            context.stroke(
                path4,
                with: .color(.purple),
                style: StrokeStyle(lineWidth: 8, lineCap: .round, dash: [20, 10])
            )
            
            // Square caps
            var path5 = Path()
            path5.move(to: CGPoint(x:  20, y: y + spacing * 4))
            path5.addLine(to: CGPoint(x: size.width - 20, y: y + spacing * 4))
            context.stroke(
                path5,
                with: .color(.orange),
                style: StrokeStyle(lineWidth: 8, lineCap: .square, dash: [20, 10])
            )
        }
        .frame(height: 250)
    }
}

// MARK: - Complex Shapes and Patterns

struct CanvasPatternExample: View {
    var body: some View {
        Canvas { context, size in
            let rows = 8
            let cols = 8
            let cellWidth = size.width / CGFloat(cols)
            let cellHeight = size.height / CGFloat(rows)
            
            for row in 0..<rows {
                for col in 0..<cols {
                    let x = CGFloat(col) * cellWidth
                    let y = CGFloat(row) * cellHeight
                    
                    // Checkerboard pattern
                    if (row + col) % 2 == 0 {
                        context.fill(
                            Path(CGRect(x: x, y:  y, width: cellWidth, height: cellHeight)),
                            with: .color(.blue. opacity(0.3))
                        )
                    }
                    
                    // Draw circle in center of each cell
                    let centerX = x + cellWidth / 2
                    let centerY = y + cellHeight / 2
                    let radius = min(cellWidth, cellHeight) / 4
                    
                    context. fill(
                        Path(ellipseIn: CGRect(
                            x: centerX - radius,
                            y: centerY - radius,
                            width:  radius * 2,
                            height: radius * 2
                        )),
                        with:  .color(.purple. opacity(0.5))
                    )
                }
            }
        }
        .frame(height: 300)
        .border(Color.gray)
    }
}

// MARK: - Drawing Charts/Graphs

struct CanvasBarChartExample: View {
    let data:  [Double] = [0.3, 0.7, 0.5, 0.9, 0.4, 0.8, 0.6]
    
    var body: some View {
        Canvas { context, size in
            let barWidth = size.width / CGFloat(data.count * 2)
            let maxHeight = size.height - 40
            
            for (index, value) in data.enumerated() {
                let barHeight = maxHeight * value
                let x = CGFloat(index) * barWidth * 2 + barWidth / 2
                let y = size.height - barHeight - 20
                
                // Draw bar
                let rect = CGRect(x: x, y: y, width: barWidth, height: barHeight)
                context.fill(
                    Path(roundedRect: rect, cornerRadius: 4),
                    with: .color(.blue)
                )
                
                // Draw value label
                let valueText = Text("\(Int(value * 100))%")
                    .font(.caption)
                    .foregroundColor(.white)
                context.draw(valueText, at: CGPoint(x: x + barWidth / 2, y: y + 15))
            }
            
            // Draw baseline
            var baseline = Path()
            baseline.move(to: CGPoint(x: 0, y: size.height - 20))
            baseline.addLine(to: CGPoint(x:  size.width, y: size.height - 20))
            context. stroke(baseline, with: .color(.gray), lineWidth: 1)
        }
        .frame(height: 250)
    }
}

// MARK: - Drawing Line Chart

struct CanvasLineChartExample: View {
    let dataPoints: [CGPoint] = [
        CGPoint(x: 0, y: 0.5),
        CGPoint(x: 1, y: 0.7),
        CGPoint(x: 2, y: 0.4),
        CGPoint(x:  3, y: 0.8),
        CGPoint(x: 4, y: 0.6),
        CGPoint(x: 5, y: 0.9),
        CGPoint(x: 6, y:  0.7)
    ]
    
    var body: some View {
        Canvas { context, size in
            let padding:  CGFloat = 40
            let chartWidth = size.width - padding * 2
            let chartHeight = size.height - padding * 2
            let maxX = dataPoints.map { $0.x }.max() ?? 1
            let scaleX = chartWidth / maxX
            let scaleY = chartHeight
            
            // Draw line
            var path = Path()
            for (index, point) in dataPoints.enumerated() {
                let x = padding + point.x * scaleX
                let y = size.height - padding - (point. y * scaleY)
                
                if index == 0 {
                    path.move(to: CGPoint(x: x, y:  y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            
            context.stroke(path, with: .color(.blue), lineWidth: 3)
            
            // Draw points
            for point in dataPoints {
                let x = padding + point.x * scaleX
                let y = size.height - padding - (point. y * scaleY)
                
                context.fill(
                    Path(ellipseIn: CGRect(x: x - 4, y: y - 4, width: 8, height: 8)),
                    with: . color(.red)
                )
            }
            
            // Draw axes
            var xAxis = Path()
            xAxis.move(to: CGPoint(x: padding, y: size. height - padding))
            xAxis.addLine(to: CGPoint(x: size.width - padding, y: size.height - padding))
            context.stroke(xAxis, with: .color(.gray), lineWidth: 1)
            
            var yAxis = Path()
            yAxis.move(to: CGPoint(x: padding, y: padding))
            yAxis.addLine(to: CGPoint(x:  padding, y: size.height - padding))
            context.stroke(yAxis, with: .color(. gray), lineWidth: 1)
        }
        .frame(height: 250)
        .border(Color.gray. opacity(0.3))
    }
}

// MARK:  - Practical Example: Progress Circle

struct CanvasProgressCircle: View {
    let progress:  Double // 0.0 to 1.0
    let lineWidth: CGFloat = 20
    
    var body: some View {
        Canvas { context, size in
            let center = CGPoint(x: size. width / 2, y: size.height / 2)
            let radius = min(size.width, size.height) / 2 - lineWidth / 2
            
            // Background circle
            let backgroundPath = Path { path in
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: . degrees(0),
                    endAngle: .degrees(360),
                    clockwise: false
                )
            }
            context.stroke(
                backgroundPath,
                with:  .color(.gray.opacity(0.2)),
                lineWidth: lineWidth
            )
            
            // Progress arc
            let endAngle = 360 * progress
            let progressPath = Path { path in
                path.addArc(
                    center:  center,
                    radius: radius,
                    startAngle:  .degrees(-90),
                    endAngle: .degrees(-90 + endAngle),
                    clockwise: false
                )
            }
            
            let gradient = Gradient(colors: [. blue, .purple])
            let angularGradient = GraphicsContext.Shading.conicGradient(
                gradient,
                center: center,
                angle: .degrees(-90)
            )
            
            context.stroke(
                progressPath,
                with: angularGradient,
                style: StrokeStyle(lineWidth: lineWidth, lineCap:  .round)
            )
            
            // Center text
            let percentText = Text("\(Int(progress * 100))%")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.primary)
            context.draw(percentText, at: center)
        }
        .aspectRatio(1, contentMode:  .fit)
    }
}

// MARK:  - Practical Example: Custom Gauge

struct CanvasGauge: View {
    let value: Double // 0.0 to 1.0
    let minValue: Double = 0
    let maxValue: Double = 100
    
    var body: some View {
        Canvas { context, size in
            let center = CGPoint(x: size.width / 2, y: size.height * 0.75)
            let radius = min(size.width, size.height) * 0.6
            let startAngle:  Double = 180 + 45
            let endAngle: Double = 360 - 45
            let totalAngle = endAngle - startAngle
            
            // Background arc
            let backgroundPath = Path { path in
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: . degrees(startAngle),
                    endAngle: .degrees(endAngle),
                    clockwise: false
                )
            }
            context.stroke(backgroundPath, with: .color(.gray.opacity(0.2)), lineWidth: 15)
            
            // Value arc
            let valueAngle = startAngle + (totalAngle * value)
            let valuePath = Path { path in
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: .degrees(startAngle),
                    endAngle: .degrees(valueAngle),
                    clockwise: false
                )
            }
            context.stroke(valuePath, with: .color(.green), lineWidth: 15)
            
            // Needle
            let needleAngle = Angle. degrees(valueAngle)
            let needleEnd = CGPoint(
                x: center.x + cos(needleAngle. radians) * (radius - 20),
                y: center.y + sin(needleAngle. radians) * (radius - 20)
            )
            
            var needlePath = Path()
            needlePath.move(to: center)
            needlePath.addLine(to: needleEnd)
            context.stroke(needlePath, with: .color(.red), lineWidth: 3)
            
            // Center dot
            context.fill(
                Path(ellipseIn:  CGRect(x: center.x - 5, y: center. y - 5, width: 10, height: 10)),
                with: .color(.red)
            )
            
            // Value text
            let displayValue = minValue + (maxValue - minValue) * value
            let valueText = Text("\(Int(displayValue))")
                .font(.system(size: 36, weight: .bold))
            context.draw(valueText, at: CGPoint(x: center.x, y: center.y - 30))
        }
        .aspectRatio(2, contentMode: .fit)
    }
}

// MARK: - Complete Showcase

struct CanvasShowcase: View {
    @State private var progress:  Double = 0.65
    @State private var gaugeValue: Double = 0.7
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Group {
                    Text("Basic Shapes")
                        .font(. headline)
                    BasicCanvasExample()
                    
                    Text("Path Drawing")
                        .font(.headline)
                    PathDrawingExample()
                    
                    Text("Gradients")
                        .font(. headline)
                    CanvasGradientsExample()
                    
                    Text("Symbols")
                        .font(.headline)
                    CanvasSymbolsExample()
                }
                
                Group {
                    Text("Stroke Styles")
                        .font(.headline)
                    CanvasStrokeStylesExample()
                    
                    Text("Pattern")
                        .font(.headline)
                    CanvasPatternExample()
                    
                    Text("Bar Chart")
                        .font(. headline)
                    CanvasBarChartExample()
                    
                    Text("Line Chart")
                        .font(.headline)
                    CanvasLineChartExample()
                }
                
                Group {
                    Text("Animated Particles")
                        .font(.headline)
                    AnimatedParticlesCanvas()
                    
                    Text("Progress Circle")
                        . font(.headline)
                    CanvasProgressCircle(progress: progress)
                        .frame(width: 200, height: 200)
                        .padding()
                    
                    Slider(value: $progress, in: 0... 1)
                        .padding(. horizontal)
                    
                    Text("Custom Gauge")
                        .font(.headline)
                    CanvasGauge(value: gaugeValue)
                        .frame(height: 200)
                        .padding()
                    
                    Slider(value: $gaugeValue, in: 0...1)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle("Canvas Examples")
    }
}

// MARK:  - Preview
#Preview {
    NavigationStack {
        CanvasShowcase()
    }
}