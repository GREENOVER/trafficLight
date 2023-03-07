//
//  DiaryListCore.swift
//  DiaryList
//
//  Created by GREEN on 2023/03/07.
//

import Combine
import UIKit

final class DiaryListCore: ObservableObject {
  init() { }
}

extension DiaryListCore {
  // 광고 사이트 이동
  @MainActor
  func openADURL(_ url: String) async {
    if let url = URL(string: url) {
      await UIApplication.shared.open(url)
    }
  }
}
