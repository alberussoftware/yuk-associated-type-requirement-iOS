//
//  FakeConformance.swift
//  YUKAssociatedTypeRequirement
//
//  Created by Ruslan Lutfullin on 2/9/21.
//

// MARK -
public func fakeConformance<T>(_ type: Any.Type, as protocolType: T.Type = T.self) -> T {
  unsafeBitCast(ProtocolConformanceRecord(type: type, witnessTable: nil), to: protocolType)
}
