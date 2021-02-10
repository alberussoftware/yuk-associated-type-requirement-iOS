//
//  ProtocolType.swift
//  YUKAssociatedTypeRequirement
//
//  Created by Ruslan Lutfullin on 2/9/21.
//

// MARK: -
fileprivate func mangledName(moduleName: ModuleName, protocolName: ProtocolName) -> String {
  "\(moduleName.rawValue.count)\(moduleName.rawValue)\(protocolName.rawValue.count)\(protocolName.rawValue)_p"
}

// MARK: -
public struct ProtocolType {
  public let type: Any.Type
  
  public init?(moduleName: ModuleName, protocolName: ProtocolName) {
    let name = mangledName(moduleName: moduleName, protocolName: protocolName)
    guard let type = _typeByName(name) else { return nil }
    self.type = type
  }
}
