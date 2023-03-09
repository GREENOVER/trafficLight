//
//  Diary.swift
//  Model
//
//  Created by GREEN on 2023/03/07.
//

import Combine

final class Diary: ObservableObject, Hashable {
  static func == (lhs: Diary, rhs: Diary) -> Bool {
    return lhs.title == rhs.title && lhs.content == rhs.content
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(title)
    hasher.combine(content)
  }
  
  @Published var title: String
  @Published var content: String
  
  init(
    title: String,
    content: String
  ) {
    self.title = title
    self.content = content
  }
}

extension Diary {
  static let stubs: [Diary] = [
    stub1,
    stub2,
    stub3,
    stub4,
    stub5,
  ]
  
  static let stub1: Diary = .init(title: "퇴사하고싶다", content: "일이 너무 많아서 퇴사하고 싶은데 할까?")
  static let stub2: Diary = .init(title: "야채먹기싫다", content: "야채는 맛없는데 왜 먹어야하지?")
  static let stub3: Diary = .init(title: "여행가고싶다", content: "여행가고 싶은데 돈이 없어서 못간다")
  static let stub4: Diary = .init(title: "놀고먹고싶다", content: "어떻게 하면 로또 당첨이 될 수 있을까?")
  static let stub5: Diary = .init(title: "개발개노잼", content: "다른 직업 가지고 싶다")
}
