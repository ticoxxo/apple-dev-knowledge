# Swift 6 Modern Features

Source: https://developer.apple.com/documentation/swift

## Data Race Safety

Swift 6 introduces complete data race safety at compile time. 

### Sendable Protocol
```swift
// Types that are safe to send across concurrency domains
struct User: Sendable {
    let id: String
    let name: String
}

// Classes must be final and have immutable properties
final class Configuration: Sendable {
    let apiKey: String
    let timeout: TimeInterval
    
    init(apiKey: String, timeout:  TimeInterval) {
        self.apiKey = apiKey
        self.timeout = timeout
    }
}
```

### Isolated Parameters
```swift
@MainActor
class ViewModel {
    var data: [String] = []
    
    func update(with newData: [String]) {
        self.data = newData
    }
}

// Function that takes an isolated parameter
func processData(viewModel: isolated ViewModel, items: [String]) {
    viewModel.update(with: items)
}
```

## Typed Throws (SE-0413)

```swift
enum ValidationError: Error {
    case tooShort
    case tooLong
    case invalidCharacters
}

// Function that throws a specific error type
func validate(input: String) throws(ValidationError) {
    if input.count < 3 {
        throw . tooShort
    }
    if input.count > 20 {
        throw .tooLong
    }
}

// Caller knows exact error type
func handleInput(_ input: String) {
    do {
        try validate(input:  input)
    } catch {
        // error is known to be ValidationError
        switch error {
        case .tooShort:
            print("Input too short")
        case .tooLong:
            print("Input too long")
        case .invalidCharacters:
            print("Invalid characters")
        }
    }
}
```

## Pack Iteration

```swift
// Iterate over parameter packs
func process<each T>(_ value: repeat each T) {
    repeat print(each value)
}

process(1, "hello", true) // Prints: 1, hello, true
```

## Noncopyable Types

```swift
struct FileHandle: ~Copyable {
    private let descriptor: Int32
    
    init(path: String) throws {
        // Open file
        self.descriptor = 0 // placeholder
    }
    
    deinit {
        // Close file automatically
        // close(descriptor)
    }
    
    consuming func close() {
        // Explicit close consumes self
    }
}

// Must use 'consuming' or 'borrowing'
func useFile(_ file: consuming FileHandle) {
    // file is consumed
}
```