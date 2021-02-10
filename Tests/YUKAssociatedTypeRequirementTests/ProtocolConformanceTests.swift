//
//  ProtocolConformanceTests.swift
//  YUKAssociatedTypeRequirementTests
//
//  Created by Ruslan Lutfullin on 2/9/21.
//

import XCTest
@testable import YUKAssociatedTypeRequirement

// MARK: -
protocol ProtocolConformanceTests_Protocol: Hashable {
  associatedtype Output
}

// MARK: -
final class ProtocolConformanceTests: XCTestCase {

  func testDoes() {
    struct SomeStruct: ProtocolConformanceTests_Protocol {
      typealias Output = Int
    }
    let any: Any = SomeStruct()
    XCTAssertTrue(does(type(of: any), conformTo: ProtocolType(moduleName: "YUKAssociatedTypeRequirementTests", protocolName: "ProtocolConformanceTests_Protocol")!))
    XCTAssertTrue(does(type(of: any), conformTo: ProtocolType(moduleName: "Swift", protocolName: "Hashable")!))
    XCTAssertFalse(does(type(of: any), conformTo: ProtocolType(moduleName: "Swift", protocolName: "Collection")!))
  }
  
  static var allTests = [("testDoes", testDoes)]
}
