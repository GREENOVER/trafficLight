//
//  ErrorFactory.swift
//  Common
//
//  Created by GREEN on 2023/03/15.
//

import Foundation

public protocol TrafficError: CustomNSError {
  var code: Code { get }
  var userInfo: [String: Any]? { get }
  var underlying: Error? { get }
  
  associatedtype Code: RawRepresentable where Code.RawValue == Int
}

extension TrafficError {
  var errorDomain: String { "\(Self.self)" }
  public var errorCode: Int { self.code.rawValue }
  var errorUserInfo: [String: Any]? {
    
    var userInfo: [String: Any] = self.userInfo ?? [:]
    
    userInfo["identifier"] = String(reflecting: code)
    userInfo[NSUnderlyingErrorKey] = underlying
    
    return userInfo
  }
}
