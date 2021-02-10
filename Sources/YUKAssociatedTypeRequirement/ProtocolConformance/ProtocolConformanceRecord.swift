//
//  ProtocolConformanceRecord.swift
//  YUKAssociatedTypeRequirement
//
//  Created by Ruslan Lutfullin on 2/9/21.
//

// MARK: -
fileprivate struct ProtocolDescriptor { }

// MARK: -
fileprivate struct ProtocolMetadata {
  let kind: Int
  let layoutFlags: UInt32
  let numberOfProtocols: UInt32
  let protocolDescriptorVector: UnsafeMutablePointer<ProtocolDescriptor>
  
  init(type: Any.Type) {
    self = unsafeBitCast(type, to: UnsafeMutablePointer<Self>.self).pointee
  }
}

// MARK: -
@_silgen_name("swift_conformsToProtocol")
fileprivate func _conformsToProtocol(_ type: Any.Type, _ protocolDescriptor: UnsafeMutablePointer<ProtocolDescriptor>) -> UnsafeRawPointer?

// MARK: -
public struct ProtocolConformanceRecord {
  public let type: Any.Type
  public let witnessTable: UnsafeRawPointer?
}

extension ProtocolConformanceRecord {
  public init?(implementationType: Any.Type, protocolType: Any.Type) {
    guard let witnessTable = _conformsToProtocol(implementationType, ProtocolMetadata(type: protocolType).protocolDescriptorVector) else {
      return nil
    }
    self.init(type: implementationType, witnessTable: witnessTable)
  }
}

extension ProtocolConformanceRecord {
  public init?(implementationType: Any.Type, protocolType: ProtocolType) {
    self.init(implementationType: implementationType, protocolType: protocolType.type)
  }
}

// MARK: -
public func does(_ implementationType: Any.Type, conformTo protocolType: Any.Type) -> Bool {
  _conformsToProtocol(implementationType, ProtocolMetadata(type: protocolType).protocolDescriptorVector) != nil
}

public func does(_ implementationType: Any.Type, conformTo protocolType: ProtocolType) -> Bool {
  does(implementationType, conformTo: protocolType.type)
}
