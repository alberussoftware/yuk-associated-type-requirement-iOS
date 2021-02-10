import XCTest
@testable import YUKAssociatedTypeRequirement

// MARK: -
struct ValuePointersTests_Struct {
  let first: Int
  func someFunc() { }
  let second: String
}

// MARK: -
final class ValuePointersTests: XCTestCase {
  func testWithUnsafeValuePointer() {
    let value: Any = ValuePointersTests_Struct(first: 1, second: "A")
    let secondOffset = MemoryLayout<ValuePointersTests_Struct>.offset(of: \ValuePointersTests_Struct.second)!
    let secondString = withUnsafeValuePointer(to: value) {
      $0.advanced(by: secondOffset)
        .assumingMemoryBound(to: String.self)
        .pointee
    }
    XCTAssert(secondString == "A")
  }
  func testWithUnsafeValueBytes() {
    let value: Any = ValuePointersTests_Struct(first: 1, second: "A")
    let secondOffset = MemoryLayout<ValuePointersTests_Struct>.offset(of: \ValuePointersTests_Struct.second)!
    let secondString = withUnsafeValueBytes(of: value) {
      $0.load(fromByteOffset: secondOffset, as: String.self)
    }
    XCTAssert(secondString == "A")
  }
  
  static var allTests = [("testWithUnsafeValuePointer", testWithUnsafeValuePointer),
                         ("testWithUnsafeValueBytes", testWithUnsafeValueBytes)]
}
