//
//  SaveDiaryValue.swift
//  Model
//
//  Created by GREEN on 2023/03/14.
//

import Combine

final class SaveDiaryValue: ObservableObject {
  static let shared = SaveDiaryValue()
  
  @Published var isSave: Bool = false
}
