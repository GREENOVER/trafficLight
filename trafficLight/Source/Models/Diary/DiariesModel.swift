//
//  DiariesModel.swift
//  Models
//
//  Created by GREEN on 2023/03/07.
//

import Combine

final class DiariesModel: ObservableObject {
  static let shared = DiariesModel(diaries: .init())
  
  @Published var diaries: [Diary]
  
  private init(diaries: [Diary]) {
    self.diaries = diaries
  }
}

extension DiariesModel {
  static let stub: DiariesModel = .init(diaries: Diary.stubs)
}
