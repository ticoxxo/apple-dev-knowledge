// SwiftData: Model Definition and Basic Operations
// Source: https://developer.apple.com/documentation/swiftdata

import SwiftData
import Foundation

// MARK: - Basic Model
@Model
final class Item {
    var name: String
    var timestamp: Date
    var isCompleted: Bool
    
    init(name: String, timestamp: Date = Date(), isCompleted: Bool = false) {
        self.name = name
        self.timestamp = timestamp
        self.isCompleted = isCompleted
    }
}

// MARK: - Model with Relationships
@Model
final class Category {
    var name: String
    var color: String
    
    @Relationship(deleteRule: .cascade, inverse: \Task.category)
    var tasks: [Task] = []
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
}

@Model
final class Task {
    var title: String
    var details: String
    var dueDate: Date
    var isCompleted: Bool
    
    var category: Category?
    
    init(
        title: String,
        details: String = "",
        dueDate: Date,
        isCompleted: Bool = false,
        category: Category?  = nil
    ) {
        self.title = title
        self.details = details
        self. dueDate = dueDate
        self.isCompleted = isCompleted
        self.category = category
    }
}

// MARK: - Model with Unique Constraint
@Model
final class User {
    @Attribute(.unique) var email: String
    var name: String
    var createdAt: Date
    
    init(email: String, name: String, createdAt: Date = Date()) {
        self.email = email
        self.name = name
        self.createdAt = createdAt
    }
}

// MARK: - Query Examples in SwiftUI
import SwiftUI

struct ItemListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.timestamp, order: .reverse) private var items: [Item]
    
    var body: some View {
        List {
            ForEach(items) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    if item.isCompleted {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            Button("Add Item") {
                addItem()
            }
        }
    }
    
    private func addItem() {
        let newItem = Item(name: "New Item")
        modelContext. insert(newItem)
    }
    
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(items[index])
        }
    }
}

// MARK: - Filtered Query
struct CompletedTasksView: View {
    @Query(filter: #Predicate<Task> { task in
        task. isCompleted == true
    }, sort: \Task.dueDate) private var completedTasks:  [Task]
    
    var body: some View {
        List(completedTasks) { task in
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                Text(task. dueDate, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}