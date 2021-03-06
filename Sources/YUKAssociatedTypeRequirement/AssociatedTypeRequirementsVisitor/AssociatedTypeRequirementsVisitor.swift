//
//  AssociatedTypeRequirementsVisitor.swift
//  YUKAssociatedTypeRequirement
//
//  Created by Ruslan Lutfullin on 2/9/21.
//

import CContext

// MARK: -
public protocol AssociatedTypeRequirementsVisitor {
  associatedtype Visitor
  associatedtype Input
  associatedtype Output
}

extension AssociatedTypeRequirementsVisitor {
  public func callAsFunction(_ value: Any) -> Output? {
    guard let visitorWitnessTable = ProtocolConformanceRecord(implementationType: Self.self, protocolType: Visitor.self) else {
      return nil
    }
    return withCasted(value, as: Input.self) { (casted) in
      let functionPointer = visitorWitnessTable
        .witnessTable!
        .assumingMemoryBound(to: UnsafeRawPointer.self)
        .advanced(by: 2)
        .pointee
      let function = unsafeBitCast(functionPointer, to: (@convention(thin) (CastedProtocolValue) -> Output).self)
      return withUnsafePointer(to: self) { (selfPointer) in
        set_self_pointer(UnsafeMutableRawPointer(mutating: UnsafeRawPointer(selfPointer)))
        return function(casted)
      }
    }
  }
}
