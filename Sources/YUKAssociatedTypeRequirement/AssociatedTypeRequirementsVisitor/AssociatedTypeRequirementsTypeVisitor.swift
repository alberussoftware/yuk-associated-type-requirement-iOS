//
//  AssociatedTypeRequirementsTypeVisitor.swift
//  YUKAssociatedTypeRequirement
//
//  Created by Ruslan Lutfullin on 2/9/21.
//

import CContext

// MARK: -
public protocol AssociatedTypeRequirementsTypeVisitor {
  associatedtype Visitor
  associatedtype Input
  associatedtype Output
}

extension AssociatedTypeRequirementsTypeVisitor {
  public func callAsFunction(_ type: Any.Type) -> Output? {
    guard let visitorWitnessTable = ProtocolConformanceRecord(implementationType: Self.self, protocolType: Visitor.self),
          let conformanceRecord = ProtocolConformanceRecord(implementationType: type, protocolType: Input.self)
    else {
      return nil
    }
    
    let functionPointer = visitorWitnessTable
      .witnessTable!
      .assumingMemoryBound(to: UnsafeRawPointer.self)
      .advanced(by: 2)
      .pointee
    let function = unsafeBitCast(functionPointer, to: (@convention(thin) (UnsafeRawPointer, ProtocolConformanceRecord, UnsafeRawPointer) -> Output).self)
    return withUnsafePointer(to: self) { (selfPointer) in
      let typePointer = unsafeBitCast(type, to: UnsafeRawPointer.self)
      set_self_pointer(UnsafeMutableRawPointer(mutating: UnsafeRawPointer(selfPointer)))
      return function(typePointer, conformanceRecord, conformanceRecord.witnessTable!)
    }
  }
}
