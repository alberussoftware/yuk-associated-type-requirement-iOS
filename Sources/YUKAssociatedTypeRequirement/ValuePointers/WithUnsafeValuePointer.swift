//
//  WithUnsafeValuePointer.swift
//  YUKAssociatedTypeRequirement
//
//  Created by Ruslan Lutfullin on 2/9/21.
//

// MARK: -
fileprivate protocol Pointable { }

extension Pointable {
  static func withUnsafeRawPointer<Result>(to value: Any, body: (UnsafeRawPointer) throws -> Result) rethrows -> Result {
    try withUnsafePointer(to: value as! Self) { try body(UnsafeRawPointer($0)) }
  }
  
  static func withUnsafeRawBytes<Result>(of value: Any, body: (UnsafeRawBufferPointer) throws -> Result) rethrows -> Result {
    try withUnsafeBytes(of: value as! Self, body)
  }
}

// MARK: -
fileprivate func pointable(for type: Any.Type) -> Pointable.Type {
  fakeConformance(type)
}

// MARK: -
public func withUnsafeValuePointer<Result>(to value: Any, body: (UnsafeRawPointer) throws -> Result) rethrows -> Result {
  try pointable(for: type(of: value)).withUnsafeRawPointer(to: value, body: body)
}

public func withUnsafeValueBytes<Result>(of value: Any, body: (UnsafeRawBufferPointer) throws -> Result) rethrows -> Result {
  try pointable(for: type(of: value)).withUnsafeRawBytes(of: value, body: body)
}
