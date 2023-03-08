//
//  DiaryListCore.swift
//  DiaryList
//
//  Created by GREEN on 2023/03/07.
//

import Combine
import UIKit

final class DiaryListCore: ObservableObject {
  @Published var isMoveToDiaryWritingMode: Bool = false
  
  let service: ChatGPTService
  
  init(service: ChatGPTService) {
    self.service = service
  }
}

extension DiaryListCore {
  // MARK: - 액션
  // 광고 사이트 이동
  @MainActor
  func openADURL(_ url: String) async {
    if let url = URL(string: url) {
      await UIApplication.shared.open(url)
    }
  }
  
  // MARK: - 프로퍼티 셋업
  func setIsMoveToDiaryWritingMode(_ isMove: Bool) {
    isMoveToDiaryWritingMode = isMove
  }
}
