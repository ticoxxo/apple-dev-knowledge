// SwiftUI Data Flow: Observable Pattern
// Source:  https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app

import SwiftUI
import Observation

// MARK: - Observable Object (Modern Approach - iOS 17+)
@Observable
class AppState {
    var username: String = ""
    var isLoggedIn: Bool = false
    var items: [String] = []
    
    func login(username: String) {
        self.username = username
        self. isLoggedIn = true
    }
    
    func logout() {
        self.username = ""
        self.isLoggedIn = false
    }
}

// MARK: - Using Observable in Views
struct AppView: View {
    @State private var appState = AppState()
    
    var body: some View {
        VStack {
            if appState.isLoggedIn {
                Text("Welcome, \(appState.username)!")
                Button("Logout") {
                    appState.logout()
                }
            } else {
                LoginView()
            }
        }
        .environment(appState)
    }
}

struct LoginView: View {
    @Environment(AppState.self) private var appState
    @State private var username = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Login") {
                appState.login(username: username)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

// MARK: - Legacy ObservableObject (iOS 13+)
class LegacyViewModel: ObservableObject {
    @Published var text:  String = ""
    @Published var count: Int = 0
    
    func increment() {
        count += 1
    }
}

struct LegacyView: View {
    @StateObject private var viewModel = LegacyViewModel()
    
    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            Button("Increment") {
                viewModel.increment()
            }
        }
    }
}