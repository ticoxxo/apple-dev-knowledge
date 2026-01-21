// XCTest: Testing Patterns and Best Practices
// Source: https://developer.apple.com/documentation/xctest

import XCTest

// MARK: - Basic Test Structure
final class MyAppTests: XCTestCase {
    
    // Called before each test method
    override func setUp() {
        super.setUp()
        // Set up test fixtures
    }
    
    // Called after each test method
    override func tearDown() {
        // Clean up after tests
        super.tearDown()
    }
    
    // MARK: - Basic Assertions
    func testBasicAssertions() {
        let value = 42
        
        XCTAssertEqual(value, 42, "Value should be 42")
        XCTAssertNotEqual(value, 0)
        XCTAssertTrue(value > 0)
        XCTAssertFalse(value < 0)
        XCTAssertNil(Optional<Int>.none)
        XCTAssertNotNil(Optional(value))
    }
    
    // MARK: - Testing Async Code
    func testAsyncFunction() async throws {
        let result = try await fetchData()
        XCTAssertEqual(result. count, 10)
    }
    
    // MARK: - Testing Errors
    func testThrowingFunction() {
        XCTAssertThrowsError(try riskyOperation()) { error in
            XCTAssertEqual(error as? MyError, MyError.invalidInput)
        }
        
        XCTAssertNoThrow(try safeOperation())
    }
    
    // MARK: - Performance Testing
    func testPerformance() {
        measure {
            // Code to measure performance
            _ = (0..<1000).map { $0 * 2 }
        }
    }
    
    // MARK: - Testing with Expectations
    func testAsyncWithExpectation() {
        let expectation = expectation(description: "Async operation completes")
        
        performAsyncOperation { result in
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}

// MARK: - Mock Objects
class MockNetworkService: NetworkServiceProtocol {
    var shouldFail = false
    var mockData: Data?
    
    func fetchData() async throws -> Data {
        if shouldFail {
            throw NetworkError.connectionFailed
        }
        return mockData ??  Data()
    }
}

// MARK: - Testing with Mocks
final class NetworkTests: XCTestCase {
    var mockService: MockNetworkService! 
    var sut: DataManager!  // System Under Test
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        sut = DataManager(networkService: mockService)
    }
    
    func testSuccessfulDataFetch() async throws {
        // Given
        mockService.mockData = "Test Data". data(using: .utf8)
        
        // When
        let result = try await sut.loadData()
        
        // Then
        XCTAssertEqual(result, "Test Data")
    }
    
    func testFailedDataFetch() async {
        // Given
        mockService.shouldFail = true
        
        // When/Then
        do {
            _ = try await sut.loadData()
            XCTFail("Should have thrown an error")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}

// MARK: - Supporting Types
protocol NetworkServiceProtocol {
    func fetchData() async throws -> Data
}

class DataManager {
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func loadData() async throws -> String {
        let data = try await networkService.fetchData()
        return String(data: data, encoding: . utf8) ?? ""
    }
}

enum MyError: Error {
    case invalidInput
}

enum NetworkError: Error {
    case connectionFailed
}

func fetchData() async throws -> [Int] {
    Array(0..<10)
}

func riskyOperation() throws {
    throw MyError.invalidInput
}

func safeOperation() throws {
    // Does nothing
}

func performAsyncOperation(completion: @escaping (String?) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        completion("Success")
    }
}