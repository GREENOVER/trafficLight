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
      ZStack {
        // 일기 작성 뷰 이동 링크
        WritingViewNavigationLink(diaryListCore: diaryListCore)
        
        // 네비게이션 뷰
        VStack(alignment: .leading, spacing: 10) {
          TrafficLightNavigationBar(
            isDisplayWritingButton: true,
            writingButtonAction: {
              diaryListCore.setIsMoveToDiaryWritingMode(true)
            }
          )
          
          TitleView()
          
          // 일기 리스트 스크롤 뷰
          ScrollView {
            VStack (alignment: .leading) {
              ForEach(diariesModel.diaries, id: \.self) { diary in
                NavigationLink(
                  destination: DiaryDetailView(
                    diaryDetailCore: .init(diary: diary)
                  )
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
}

// MARK: - 목록 타이틀
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

// MARK: - 일기 셀 뷰
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

// MARK: - 광고 배너 뷰
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

// MARK: - 일기 작성 뷰 이동 링크
private struct WritingViewNavigationLink: View {
  @ObservedObject var diaryListCore: DiaryListCore
  
  var body: some View {
    NavigationLink(
      "",
      isActive: $diaryListCore.isMoveToDiaryWritingMode
    ) {
      DiaryWritingView(
        diaryWritingCore: .init(
          diariesModel: .shared,
          service: diaryListCore.service
        )
      )
    }
    .frame(maxHeight: 0)
    .hidden()
  }
}
