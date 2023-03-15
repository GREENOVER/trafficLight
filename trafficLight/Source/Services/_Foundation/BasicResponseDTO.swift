//
//  BasicResponseDTO.swift
//  Services
//
//  Created by GREEN on 2023/03/15.
//

import Foundation

public enum BasicResponseDTO {
  public struct ExistData<T: Decodable>: Decodable {
    public var code: String
    public var message: String
    public var data: T
  }
  
  public struct Common: Decodable {
    public var code: String
    public var message: String
  }
}

