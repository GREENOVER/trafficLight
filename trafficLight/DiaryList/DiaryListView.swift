//
//  DiaryListView.swift
//  DiaryList
//
//  Created by GREEN on 2023/03/07.
//

import SwiftUI

struct DiaryListView: View {
  @EnvironmentObject var diariesModel: DiariesModel
  @StateObject var diaryListCore: DiaryListCore
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading, spacing: 10) {
        TitleView()
        
        ScrollView {
          VStack (alignment: .leading) {
            ForEach(diariesModel.diaries, id: \.self) { diary in
              NavigationLink(
                destination: DiaryDetailView(diaryDetailCore: .init(diary: diary))
              ) {
                DiaryView(
                  title: diary.title,
                  content: diary.content
                )
              }
              .padding(.bottom, 10)
            }
          }
        }
        
        Spacer()
        
        ADBannerView(diaryListCore: diaryListCore)
      }
      .padding(.all, 20)
    }
  }
}

// 목록 타이틀
private struct TitleView: View {
  var body: some View {
    HStack {
      Spacer()
      
      Text("신호등")
        .font(.headline)
        .foregroundColor(.green)
      
      Spacer()
    }
  }
}

// 일기 셀 뷰
private struct DiaryView: View {
  var title: String
  var content: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text(title)
        .lineLimit(1)
        .font(.title)
        .foregroundColor(.red)
      
      Text(content)
        .lineLimit(3)
        .font(.body)
        .foregroundColor(.yellow)
      
      DividerHorizontal(height: ._1)
    }
  }
}

// 광고 배너 뷰
private struct ADBannerView: View {
  @ObservedObject var diaryListCore: DiaryListCore
  
  var body: some View {
    Button(
      action: {
        Task {
          await diaryListCore.openADURL("https://green1229.tistory.com")
        }
      },
      label: {
        Image("adBanner")
          .resizable()
          .scaledToFit()
          .clipped()
      }
    )
  }
}
