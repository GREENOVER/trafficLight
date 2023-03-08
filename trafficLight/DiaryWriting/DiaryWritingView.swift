//
//  DiaryWritingView.swift
//  DiaryWriting
//
//  Created by GREEN on 2023/03/08.
//

import SwiftUI

struct DiaryWritingView: View {
  @Environment(\.presentationMode) var presentationMode
  @StateObject var diaryWritingCore: DiaryWritingCore
  
  var body: some View {
    VStack(spacing: 10) {
      // 네비게이션 바
      TrafficLightNavigationBar(
        isDisplayBackButton: true,
        backButtonAction: {
          presentationMode.wrappedValue.dismiss()
        }
      )
      
      // 헤더 뷰
      HeaderView(diaryWritingCore: diaryWritingCore)
      
      // 입력 요청 뷰
      RequestInputView(diaryWritingCore: diaryWritingCore)
      
      // AI 일기 작성 뷰
      AIResponseView(diaryWritingCore: diaryWritingCore)
      
      Spacer()
      
      // 일기 저장 버튼
      SaveDiaryButton(diaryWritingCore: diaryWritingCore)
    }
    .navigationBarHidden(true)
    .alert(isPresented: $diaryWritingCore.isDisplaySaveCompletedAlert) {
      Alert(
        title: Text("저장 완료!"),
        message: Text("또 다른 일기를 작성해보세요."),
        dismissButton: .default(Text("확인"))
      )
    }
  }
}

// MARK: - 헤더 뷰
private struct HeaderView: View {
  @ObservedObject var diaryWritingCore: DiaryWritingCore
  
  var body: some View {
    HStack {
      TextField("일기 작성을 요청해보세요.", text: $diaryWritingCore.title)
      
      Button(
        action: {
          diaryWritingCore.getDiaryFromChatGPT()
        },
        label: {
          Text("요청")
        }
      )
      .disabled(diaryWritingCore.isDisabledRequestButton)
    }
    .padding(.horizontal, 16)
  }
}

// MARK: - 입력 요청 뷰
private struct RequestInputView: View {
  @ObservedObject var diaryWritingCore: DiaryWritingCore
  
  var body: some View {
    Text("입력한 요청: \(diaryWritingCore.title)")
  }
}

// MARK: - AI 일기 작성 뷰
private struct AIResponseView: View {
  @ObservedObject var diaryWritingCore: DiaryWritingCore
  
  var body: some View {
    ZStack {
      if diaryWritingCore.isDisplayProgressView {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle())
          .scaleEffect(5.0)
      }
      
      ScrollView {
        VStack(alignment: .leading) {
          Text(diaryWritingCore.post)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(nil)
        }
      }
      .padding(.horizontal, 16)
    }
  }
}

// MARK: - 일기 저장 버튼
private struct SaveDiaryButton: View {
  @ObservedObject var diaryWritingCore: DiaryWritingCore
  
  var body: some View {
    if diaryWritingCore.isFinishedRequest {
      Button(
        action: {
          diaryWritingCore.saveDiary()
        },
        label: {
          Text("저장하기")
            .bold()
            .font(.title)
            .foregroundColor(.green)
        }
      )
    }
  }
}
