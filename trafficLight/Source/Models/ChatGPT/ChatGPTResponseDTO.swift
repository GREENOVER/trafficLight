//
//  ChatGPTResponseDTO.swift
//  Models
//
//  Created by GREEN on 2023/03/15.
//

public struct ChatGPTResponseDTO: Decodable {
  let completions: [ChatGPTCompletionDTO]
}

public struct ChatGPTCompletionDTO: Decodable {
  let text: String
  let finishReason: String?
}
