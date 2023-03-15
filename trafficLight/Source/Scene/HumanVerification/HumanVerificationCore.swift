//
//  HumanVerificationCore.swift
//  HumanVerification
//
//  Created by GREEN on 2023/03/09.
//

import Combine

final class HumanVerificationCore: ObservableObject {
  @Published var imageInfos: [ImageInfo]
  @Published var selectedImageInfo: ImageInfo?
  @Published var isDisplayNeedSelectedAlert: Bool
  @Published var isDisplayHumanVerificationView: Bool
  @Published var saveDiaryValue: SaveDiaryValue = .shared
  var isAvailableSubmitButton: Bool {
    return selectedImageInfo != nil
  }
  
  init(
    imageInfos: [ImageInfo] = [
      .init(imageName: "greeting", isCollect: false, isSelect: false),
      .init(imageName: "love", isCollect: false, isSelect: false),
      .init(imageName: "sing", isCollect: true, isSelect: false),
      .init(imageName: "sleep", isCollect: false, isSelect: false),
    ],
    selectedImageInfo: ImageInfo? = nil,
    isDisplayNeedSelectedAlert: Bool = false,
    isDisplayHumanVerificationView: Bool = false
  ) {
    self.imageInfos = imageInfos
    self.selectedImageInfo = selectedImageInfo
    self.isDisplayNeedSelectedAlert = isDisplayNeedSelectedAlert
    self.isDisplayHumanVerificationView = isDisplayHumanVerificationView
  }
}

extension HumanVerificationCore {
  // MARK: - 액션
  // 제출
  @MainActor
  func submitResult() {
    if let selectedImageInfo = selectedImageInfo {
      if checkIsCorrect(answer: selectedImageInfo) {
        setIsDisplayHumanVerificationView(false)
        saveDiaryValue.isSave = true
        setSelectedImageInfo(nil)
      } else {
        setIsDisplayNeedSelectedAlert(true)
      }
    }
  }
  
  // 정답 판단
  @MainActor
  func checkIsCorrect(answer: ImageInfo) -> Bool {
    return answer.isCollect
  }
  
  // MARK: - 프로퍼티 셋업
  @MainActor
  func setSelectedImageInfo(imageInfo: ImageInfo) {
    if selectedImageInfo?.imageName == imageInfo.imageName {
      selectedImageInfo = nil
    } else {
      selectedImageInfo = imageInfo
      selectedImageInfo?.isSelect = true
    }
  }
  
  @MainActor
  func setIsDisplayNeedSelectedAlert(_ isDisplay: Bool) {
    isDisplayNeedSelectedAlert = isDisplay
  }
  
  @MainActor
  func setIsDisplayHumanVerificationView(_ isDisplay: Bool) {
    isDisplayHumanVerificationView = isDisplay
  }
  
  @MainActor
  func setSelectedImageInfo(_ imageInfo: ImageInfo?) {
    selectedImageInfo = imageInfo
  }
}
