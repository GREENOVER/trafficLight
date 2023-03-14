//
//  HumanVerificationView.swift
//  HumanVerification
//
//  Created by GREEN on 2023/03/09.
//

import SwiftUI

struct HumanVerificationView: View {
  @StateObject var humanVerificationCore: HumanVerificationCore
  
  var body: some View {
    VStack(spacing: 20) {
      // 헤더 뷰
      HeaderView(humanVerificationCore: humanVerificationCore)
      
      // 그림 선택 그리드 뷰
      SelectImageGridView(humanVerificationCore: humanVerificationCore)
      
      // 제출 버튼
      if humanVerificationCore.selectedImageInfo != nil {
        SubmitButtonView(humanVerificationCore: humanVerificationCore)
      }
    }
    .border(Color.gray, width: 2)
    .cornerRadius(16)
    .padding(.horizontal, 30)
    .alert(isPresented: $humanVerificationCore.isDisplayNeedSelectedAlert) {
      Alert(
        title: Text("실패!"),
        message: Text("너 인간 아니지?"),
        dismissButton: .default(Text("재도전"))
      )
    }
  }
}

// MARK: - 헤더 뷰
private struct HeaderView: View {
  @ObservedObject var humanVerificationCore: HumanVerificationCore
  
  var body: some View {
    HStack {
      Text("노래하는 원숭이를 찾아보세요.")
        .font(.title)
        .foregroundColor(.red)
      
      Spacer()
      
      Button(
        action: {
          humanVerificationCore.setIsDisplayHumanVerificationView(false)
        },
        label: {
          Image("closeIcon")
            .resizable()
            .frame(width: 40, height: 40)
        }
      )
    }
  }
}

// MARK: - 그림 그리드 뷰
private struct SelectImageGridView: View {
  @ObservedObject var humanVerificationCore: HumanVerificationCore
  
  let columns: [GridItem] = [
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]
  
  var body: some View {
    LazyVGrid(columns: columns) {
      ForEach(humanVerificationCore.imageInfos, id: \.self) { imageInfo in
        EachImageView(
          humanVerificationCore: humanVerificationCore,
          imageInfo: imageInfo
        )
      }
    }
  }
}

// MARK: - 개별 그림 뷰
private struct EachImageView: View {
  @ObservedObject var humanVerificationCore: HumanVerificationCore
  var imageInfo: ImageInfo
  
  var body: some View {
    ZStack {
      Image(imageInfo.imageName)
        .resizable()
        .frame(width: 100, height: 100)
        .opacity(imageInfo.imageName == humanVerificationCore.selectedImageInfo?.imageName ? 0.3 : 1)
      
      if imageInfo.imageName == humanVerificationCore.selectedImageInfo?.imageName {
        Image("selectIcon")
          .resizable()
          .frame(width: 50, height: 50)
      }
    }
    .onTapGesture {
      humanVerificationCore.setSelectedImageInfo(imageInfo: imageInfo)
    }
  }
}

// MARK: - 제출 버튼 뷰
private struct SubmitButtonView: View {
  @ObservedObject var humanVerificationCore: HumanVerificationCore
  
  var body: some View {
    Button(
      action: {
        humanVerificationCore.submitResult()
      },
      label: {
        Text("제출 해버릴까보다")
          .font(.title)
          .foregroundColor(.green)
          .padding(.horizontal, 20)
          .padding(.vertical, 10)
      }
    )
  }
}
