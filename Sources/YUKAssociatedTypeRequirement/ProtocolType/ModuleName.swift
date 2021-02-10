//
//  ModuleName.swift
//  YUKAssociatedTypeRequirement
//
//  Created by Ruslan Lutfullin on 2/9/21.
//

// MARK: -
public struct ModuleName: RawRepresentable, Equatable {
  public let rawValue: String
  
  public init(rawValue: String) {
    self.rawValue = rawValue
  }
}

extension ModuleName: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(rawValue: value)
  }
}
