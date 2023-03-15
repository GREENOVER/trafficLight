//
//  CustomChatGPTAPI.swift
//  Services
//
//  Created by GREEN on 2023/03/15.
//

import Alamofire
import Foundation

public enum CustomChatGPTAPI {
  case postChatReqeust(
    prompt: String,
    temperature: String = "0.7",
    maxTokens: String = "100",
    stop: String = "\n"
  )
}

extension CustomChatGPTAPI: Router {
  public var baseURL: URL {
    return URL(string: "https://api.openai.com")!
  }
  
  public var path: String {
    switch self {
    case .postChatReqeust:
      return "/v1/engine/chat"
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .postChatReqeust:
      return .post
    }
  }
  
  public var task: ReqeustTask {
    switch self {
    case let .postChatReqeust(
      prompt,
      temperature,
      maxTokens,
      stop
    ):
      let requestBody = ChatGPTRequestDTO(
        prompt: prompt,
        temperature: temperature,
        maxTokens: maxTokens,
        stop: stop
      )
      return .requestJSONEncodable(requestBody)
    }
  }

  public var headers: [String: String]? {
    return [
      "Content-type": "application/json",
      "Authorization": "Bearer PERSONAL_API_KEY"
    ]
  }
}
