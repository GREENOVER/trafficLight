//
//  CustomChatGPTService.swift
//  Services
//
//  Created by GREEN on 2023/03/15.
//

import Alamofire
import Combine
import Foundation

public struct CustomChatGPTService {
  public let postChatRequest: (
    _ prompt: String,
    _ temperature: String,
    _ maxTokens: String,
    _ stop: String
  ) -> AnyPublisher<ChatGPTResponseDTO, Error>
  
  private init(
    postChatRequest: @escaping (
      _: String,
      _: String,
      _: String,
      _: String
    ) -> AnyPublisher<ChatGPTResponseDTO, Error>
  ) {
    self.postChatRequest = postChatRequest
  }
}

extension CustomChatGPTService {
  public static let live = Self(
    postChatRequest: { prompt, temperature, maxTokens, stop in
      return RouterManager<CustomChatGPTAPI>
        .init()
        .request(
        router: .postChatReqeust(
          prompt: prompt,
          temperature: temperature,
          maxTokens: maxTokens,
          stop: stop
        )
      ).tryMap({ data -> BasicResponseDTO.ExistData<ChatGPTResponseDTO> in
        do {
          return try JSONDecoder().decode(BasicResponseDTO.ExistData<ChatGPTResponseDTO>.self, from: data)
        } catch {
          throw CustomChatGPTServiceError(code: .decodeFailed, userInfo: ["data": data], underlying: error)
        }
      })
      .map { $0.data }
      .eraseToAnyPublisher()
    }
  )
}

public struct CustomChatGPTServiceError: TrafficError {
  public var code: Code
  public var userInfo: [String: Any]?
  public var underlying: Error?
  
  public enum Code: Int {
    case decodeFailed = 0
  }
  
  public init(
    code: CustomChatGPTServiceError.Code,
    userInfo: [String: Any]? = nil,
    underlying: Error? = nil
  ) {
    self.code = code
    self.userInfo = userInfo
    self.underlying = underlying
  }
}

