// Swift Concurrency: Async/Await Patterns
// Source: https://developer.apple.com/documentation/swift/concurrency

import Foundation

// MARK: - Basic Async Function
func fetchUserData(id: String) async throws -> User {
    let url = URL(string: "https://api.example.com/users/\(id)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(User.self, from: data)
}

// MARK: - Async Sequences
func fetchMultipleUsers(ids: [String]) async throws -> [User] {
    var users: [User] = []
    
    for id in ids {
        let user = try await fetchUserData(id: id)
        users.append(user)
    }
    
    return users
}

// MARK: - Parallel Execution with async let
func fetchUserWithDetails(id: String) async throws -> (User, [Post], [Comment]) {
    async let user = fetchUserData(id: id)
    async let posts = fetchUserPosts(userId: id)
    async let comments = fetchUserComments(userId: id)
    
    // All three requests execute in parallel
    return try await (user, posts, comments)
}

// MARK: - Task Groups for Dynamic Parallelism
func fetchAllUsers(ids: [String]) async throws -> [User] {
    try await withThrowingTaskGroup(of: User.self) { group in
        for id in ids {
            group.addTask {
                try await fetchUserData(id: id)
            }
        }
        
        var users: [User] = []
        for try await user in group {
            users.append(user)
        }
        return users
    }
}

// MARK: - Actors for Thread-Safe State
actor UserCache {
    private var cache: [String: User] = [:]
    
    func getUser(id: String) -> User? {
        cache[id]
    }
    
    func setUser(_ user: User, id: String) {
        cache[id] = user
    }
    
    func clear() {
        cache.removeAll()
    }
}

// MARK: - MainActor for UI Updates
@MainActor
class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var error: Error?
    
    func loadUser(id: String) async {
        isLoading = true
        error = nil
        
        do {
            user = try await fetchUserData(id: id)
        } catch {
            self. error = error
        }
        
        isLoading = false
    }
}

// MARK: - Supporting Types
struct User: Codable {
    let id: String
    let name: String
    let email: String
}

struct Post: Codable {
    let id: String
    let title: String
}

struct Comment: Codable {
    let id: String
    let text: String
}

func fetchUserPosts(userId: String) async throws -> [Post] {
    // Implementation
    []
}

func fetchUserComments(userId: String) async throws -> [Comment] {
    // Implementation
    []
}