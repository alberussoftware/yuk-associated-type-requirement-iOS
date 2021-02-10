//
//  AssociatedTypeRequirementsVisitorTests.swift
//  YUKAssociatedTypeRequirementTests
//
//  Created by Ruslan Lutfullin on 2/9/21.
//

import XCTest
@testable import YUKAssociatedTypeRequirement

// MARK: -
protocol AssociatedTypeRequirementsVisitorTests_Protocol: Hashable {
  var value1: Int { get }
  static var value2: Int { get }
}

// MARK: -
protocol AssociatedTypeRequirementsVisitor_TypeVisitor: AssociatedTypeRequirementsTypeVisitor {
  associatedtype Visitor = AssociatedTypeRequirementsVisitor_TypeVisitor
  associatedtype Input = AssociatedTypeRequirementsVisitorTests_Protocol
  associatedtype Output
  
  func callAsFunction<T: AssociatedTypeRequirementsVisitorTests_Protocol>(_ type: T.Type) -> Output
}

// MARK: -
protocol AssociatedTypeRequirementsVisitor_Visitor: AssociatedTypeRequirementsVisitor {
  associatedtype Visitor = AssociatedTypeRequirementsVisitor_Visitor
  associatedtype Input = AssociatedTypeRequirementsVisitorTests_Protocol
  associatedtype Output
  
  func callAsFunction<T: AssociatedTypeRequirementsVisitorTests_Protocol>(_ value: T) -> Output
}

// MARK: -
struct AssociatedTypeRequirementsVisitorTests_Struct: AssociatedTypeRequirementsVisitorTests_Protocol {
  static var value2: Int { 21 }
  var value1: Int { 22 }
}

// MARK: -
final class AssociatedTypeRequirementsVisitorTests: XCTestCase {
  
  func testTypeVisitor() {
    struct TypeVisitor: AssociatedTypeRequirementsVisitor_TypeVisitor {
      func callAsFunction<T: AssociatedTypeRequirementsVisitorTests_Protocol>(_ type: T.Type) -> Int {
        return type.value2
      }
    }
    
    let anyType: Any.Type = type(of: AssociatedTypeRequirementsVisitorTests_Struct())
    let typeVisitor = TypeVisitor()
    XCTAssert(typeVisitor(anyType) == 21)
  }
  
  func testVisitor() {
    struct Visitor: AssociatedTypeRequirementsVisitor_Visitor {
      func callAsFunction<T: AssociatedTypeRequirementsVisitorTests_Protocol>(_ value: T) -> Int {
        value.value1
      }
    }
    
    let any: Any = AssociatedTypeRequirementsVisitorTests_Struct()
    let visitor = Visitor()
    XCTAssert(visitor(any) == 22)
  }
  
  static var allTests = [("testTypeVisitor", testTypeVisitor),
                         ("testVisitor", testVisitor)]
}
