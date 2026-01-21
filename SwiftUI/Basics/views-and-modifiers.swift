// SwiftUI Views and Modifiers Reference
// Source: https://developer.apple.com/documentation/swiftui/view

import SwiftUI

// MARK: - Basic View Structure
struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .font(.title)
            .foregroundColor(. blue)
            .padding()
    }
}

// MARK: - Common Modifiers
extension View {
    /// Example of commonly used modifiers in order of precedence
    func styledCard() -> some View {
        self
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

// MARK: - State Management
struct CounterView: View {
    @State private var count = 0
    
    var body: some View {
        VStack {
            Text("Count: \(count)")
                .font(.largeTitle)
            
            Button("Increment") {
                count += 1
            }
            .buttonStyle(. borderedProminent)
        }
    }
}

// MARK: - Lists
struct FruitListView: View {
    let fruits = ["Apple", "Banana", "Orange", "Mango"]
    
    var body: some View {
        List(fruits, id: \.self) { fruit in
            Text(fruit)
        }
    }
}

// MARK:  - Navigation
struct NavigationExample: View {
    var body: some View {
        NavigationStack {
            List(1..<20) { index in
                NavigationLink("Row \(index)", value: index)
            }
            .navigationDestination(for: Int.self) { value in
                DetailView(number: value)
            }
            .navigationTitle("Items")
        }
    }
}

struct DetailView: View {
    let number: Int
    
    var body: some View {
        Text("Detail for item \(number)")
            .navigationTitle("Item \(number)")
    }
}