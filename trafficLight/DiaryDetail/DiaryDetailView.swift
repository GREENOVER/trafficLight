//
//  DiaryDetailView.swift
//  DiaryDetail
//
//  Created by GREEN on 2023/03/07.
//

import SwiftUI

struct DiaryDetailView: View {
  @StateObject var diaryDetailCore: DiaryDetailCore
  
  var body: some View {
    Text(diaryDetailCore.diary.title)
      .navigationBarHidden(true)
  }
}
