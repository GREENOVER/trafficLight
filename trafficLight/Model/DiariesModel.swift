//
//  DiariesModel.swift
//  Model
//
//  Created by GREEN on 2023/03/07.
//

import Combine

final class DiariesModel: ObservableObject {
  @Published var diaries: [Diary]
  
  init(diaries: [Diary]) {
    self.diaries = diaries
  }
}

extension DiariesModel {
  static let stub: DiariesModel = .init(diaries: Diary.stubs)
}
