//
//  ProtocolTypeTests.swift
//  YUKAssociatedTypeRequirementTests
//
//  Created by Ruslan Lutfullin on 2/9/21.
//

import XCTest
@testable import YUKAssociatedTypeRequirement

// MARK: -
protocol ProtocolTypeTests_Protocol: Hashable {
  associatedtype Output
}

// MARK: -
final class ProtocolTypeTests: XCTestCase {
  func testType() {
    XCTAssertNotNil(ProtocolType(moduleName: "YUKAssociatedTypeRequirementTests", protocolName: "ProtocolTypeTests_Protocol"))
    XCTAssertNil(ProtocolType(moduleName: "YUKAssociatedTypeRequirementTests", protocolName: "_ProtocolTypeTests_Protocol"))
  }
  
  static var allTests = [("testType", testType)]
}


