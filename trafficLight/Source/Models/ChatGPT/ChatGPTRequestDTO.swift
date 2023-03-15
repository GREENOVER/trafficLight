//
//  ChatGPTRequestDTO.swift
//  Models
//
//  Created by GREEN on 2023/03/15.
//

public struct ChatGPTRequestDTO: Encodable {
  let prompt: String
  let temperature: String
  let maxTokens: String
  let stop: String
  
  public init(
    prompt: String,
    temperature: String,
    maxTokens: String,
    stop: String
  ) {
    self.prompt = prompt
    self.temperature = temperature
    self.maxTokens = maxTokens
    self.stop = stop
  }
  
  public enum CodingKeys: String, CodingKey {
    case prompt
    case temperature
    case maxTokens = "max_tokens"
    case stop
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(prompt, forKey: .prompt)
    try container.encode(temperature, forKey: .temperature)
    try container.encode(maxTokens, forKey: .maxTokens)
    try container.encode(stop, forKey: .stop)
  }
}
