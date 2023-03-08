//
//  DiaryDetailView.swift
//  DiaryDetail
//
//  Created by GREEN on 2023/03/07.
//

import SwiftUI

struct DiaryDetailView: View {
  @Environment(\.presentationMode) var presentationMode
  @StateObject var diaryDetailCore: DiaryDetailCore
  
  var body: some View {
    VStack(alignment: .center, spacing: 10) {
      TrafficLightNavigationBar(
        isDisplayBackButton: true,
        backButtonAction: {
          presentationMode.wrappedValue.dismiss()
        }
      )
      
      // 제목
      Text(diaryDetailCore.diary.title)
        .font(.title)
        .foregroundColor(.red)
        .lineLimit(nil)
        .padding(.horizontal, 16)
      
      // 본문
      ScrollView {
        Text(diaryDetailCore.diary.content)
          .font(.body)
          .foregroundColor(.yellow)
          .lineLimit(nil)
      }
      .padding(.horizontal, 16)
      
      Spacer()
    }
    .navigationBarHidden(true)
  }
}
