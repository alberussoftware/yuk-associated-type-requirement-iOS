//
//  WithCasted.swift
//  YUKAssociatedTypeRequirement
//
//  Created by Ruslan Lutfullin on 2/9/21.
//

// MARK: -
public func withCasted<Result>(_ value: Any, as moduleName: ModuleName, _ protocolName: ProtocolName, body: (CastedProtocolValue) throws -> Result) rethrows -> Result? {
  guard let protocolType = ProtocolType(moduleName: moduleName, protocolName: protocolName) else {
    return nil
  }
  return try withCasted(value, as: protocolType, body: body)
}

public func withCasted<Result>(_ value: Any, as protocolType: ProtocolType, body: (CastedProtocolValue) throws -> Result) rethrows -> Result? {
  try withCasted(value, as: protocolType.type, body: body)
}

public func withCasted<Result>(_ value: Any, as protocolType: Any.Type, body: (CastedProtocolValue) throws -> Result) rethrows -> Result? {
  let implementationType = type(of: value)
  guard let conformanceRecord = ProtocolConformanceRecord(implementationType: implementationType, protocolType: protocolType) else {
    return nil
  }
  return try withUnsafeValuePointer(to: value) { try body(CastedProtocolValue(value: $0, conformanceRecord: conformanceRecord)) }
}
