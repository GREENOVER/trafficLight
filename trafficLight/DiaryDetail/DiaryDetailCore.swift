//
//  DiaryDetailCore.swift
//  DiaryDetail
//
//  Created by GREEN on 2023/03/07.
//

import Combine

final class DiaryDetailCore: ObservableObject {
  @Published var diary: Diary
  
  init(diary: Diary) {
    self.diary = diary
  }
}
