# Swift Charts

Source: https://developer.apple.com/documentation/Charts

## Define the data source

```swift
/*
Suppose you want to know which toy shape appears the most. Start by visualizing how many of each shape you have. To display this information with a chart, create a ToyShape structure that represents the information that you want to visualize:
*/ 
struct ToyShape: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

// Then, initialize an array of ToyShape structures to hold the data from the table:
var data: [ToyShape] = [
    .init(type: "Cube", count: 5),
    .init(type: "Sphere", count: 4),
    .init(type: "Pyramid", count: 4)
]
// In a real app, you might download this data from a network connection, or load it from a file.

```
## Initialize a chart view and create marks
```swift
// Create a Chart view that serves as a container for the data series that you want to draw:
import SwiftUI
import Charts


struct BarChart: View {
    var body: some View {
        Chart {
            // Add marks here
            BarMark(
        x: .value("Shape Type", data[0].type),
        y: .value("Total Count", data[0].count)
    )
    BarMark(
         x: .value("Shape Type", data[1].type),
         y: .value("Total Count", data[1].count)
    )
    BarMark(
         x: .value("Shape Type", data[2].type),
         y: .value("Total Count", data[2].count)
    )
        }
    }
}

// The above code lists each BarMark individually. However, for regular, repetitive data, you can use a ForEach structure to represent the same chart more concisely:
Chart {
    ForEach(data) { shape in
        BarMark(
            x: .value("Shape Type", shape.type),
            y: .value("Total Count", shape.count)
        )
    }
}
```

## Explore additional data properties

```swift
/*
The above bar chart shows how much of each type of toy shape there are, but the earlier table separates each toy shape by color as well. A stacked bar chart can visualize not only the amount of each toy shape type, but also the distribution of colors among the shapes. Before you can plot this new information, you need to represent color in your data structure:
*/
struct ToyShape: Identifiable {
    var color: String
    var type: String
    var count: Double
    var id = UUID()
}

// Then update the initialized data to include the color info:
var stackedBarData: [ToyShape] = [
    .init(color: "Green", type: "Cube", count: 2),
    .init(color: "Green", type: "Sphere", count: 0),
    .init(color: "Green", type: "Pyramid", count: 1),
    .init(color: "Purple", type: "Cube", count: 1),
    .init(color: "Purple", type: "Sphere", count: 1),
    .init(color: "Purple", type: "Pyramid", count: 1),
    .init(color: "Pink", type: "Cube", count: 1),
    .init(color: "Pink", type: "Sphere", count: 2),
    .init(color: "Pink", type: "Pyramid", count: 0),
    .init(color: "Yellow", type: "Cube", count: 1),
    .init(color: "Yellow", type: "Sphere", count: 1),
    .init(color: "Yellow", type: "Pyramid", count: 2)
]

// o represent this additional dimension of information, add the foregroundStyle(by:) method to the BarMark, and indicate the data’s color property as the plottable value:

Chart {
    ForEach(stackedBarData) { shape in
        BarMark(
            x: .value("Shape Type", shape.type),
            y: .value("Total Count", shape.count)
        )
        .foregroundStyle(by: .value("Shape Color", shape.color))
    }
}
```

## Customize your chart

```Swift
// For many charts, the default configuration works well. However, in this case, the colors that the framework assigns to each mark don’t match the shape colors that they represent. You can customize the chart to override the default color scale by adding the chartForegroundStyleScale(_:) chart modifier:

Chart {
    ForEach(stackedBarData) { shape in
        BarMark(
            x: .value("Shape Type", shape.type),
            y: .value("Total Count", shape.count)
        )
        .foregroundStyle(by: .value("Shape Color", shape.color))
    }  
}
.chartForegroundStyleScale([
    "Green": .green, "Purple": .purple, "Pink": .pink, "Yellow": .yellow
])