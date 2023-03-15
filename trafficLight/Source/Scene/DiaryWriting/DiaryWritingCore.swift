//
//  DiaryWritingCore.swift
//  DiaryWriting
//
//  Created by GREEN on 2023/03/08.
//

import Combine

final class DiaryWritingCore: ObservableObject {
  @Published var title: String = ""
  @Published var post: String = ""
  @Published var isDisabledRequestButton: Bool = false
  @Published var isFinishedRequest: Bool = false
  @Published var isDisplayProgressView: Bool = false
  @Published var isDisplaySaveCompletedAlert: Bool = false
  @Published var diariesModel: DiariesModel
  @Published var humanVerificationView: HumanVerificationView
  @Published var saveDiaryValue: SaveDiaryValue = .shared
  
  let service: ChatGPTService
  
  // 커스텀 네트워킹 구축
  let customService: CustomChatGPTService = .live
  private var cancellables = Set<AnyCancellable>()
  
  init(
    diariesModel: DiariesModel,
    service: ChatGPTService,
    humanVerificationView: HumanVerificationView
  ) {
    self.diariesModel = diariesModel
    self.service = service
    self.humanVerificationView = humanVerificationView
  }
}

extension DiaryWritingCore {
  // MARK: - 액션
  // AI 일기 작성
  @MainActor
  func getDiaryFromChatGPT() {
    Task {
      do {
        setIsDisplayProgressView(true)
        setIsDisabledRequestButton(true)
        setIsFinishedRequest(false)
        let stream = try await service.api.sendMessageStream(text: title)
        for try await line in stream {
          if isDisplayProgressView {
            setIsDisplayProgressView(false)
          }
          post += line
        }
      } catch {
        print(error.localizedDescription)
      }
      setIsDisabledRequestButton(false)
      setIsFinishedRequest(true)
      setIsDisplayCompletedAlert(false)
    }
  }
  
  // 일기 저장
  @MainActor
  func saveDiary() {
    let components = post.split(separator: ".")
    var result = ""
    
    if components.count > 2 {
      result = components[2...].joined(separator: ".")
    } else {
      result = post
    }
    
    diariesModel.diaries.append(
      .init(
        title: title,
        content: result
      )
    )
    
    setTitle("")
    setPost("")
    setIsFinishedRequest(false)
    setIsDisplayCompletedAlert(true)
    
    saveDiaryValue.isSave = false
  }
  
  // MARK: - 프로퍼티 셋업
  @MainActor
  func setTitle(_ input: String) {
    title = input
  }
  
  @MainActor
  func setPost(_ input: String) {
    post = input
  }
  
  @MainActor
  func setIsDisabledRequestButton(_ isDisabled: Bool) {
    isDisabledRequestButton = isDisabled
  }
  
  @MainActor
  func setIsFinishedRequest(_ isFinished: Bool) {
    isFinishedRequest = isFinished
  }
  
  @MainActor
  func setIsDisplayProgressView(_ isDisplay: Bool) {
    isDisplayProgressView = isDisplay
  }
  
  @MainActor
  func setIsDisplayCompletedAlert(_ isDisplay: Bool) {
    isDisplaySaveCompletedAlert = isDisplay
  }
  
  // MARK: - 커스텀 ChatGPT 네트워킹
  @MainActor
  func requestCustomChatGPT(
    prompt: String,
    temperature: String = "0.7",
    maxTokens: String = "100",
    stop: String = "\n"
  ) {
    customService.postChatRequest(prompt, temperature, maxTokens, stop)
      .sink(receiveCompletion: { result in
        switch result {
        case .failure(let error):
          // 에러 처리
          dump(error.localizedDescription)
          
        case .finished:
          break
        }
      }, receiveValue: { [weak self] response in
        // 응답 값 주입
        self?.post = response.completions.first?.text ?? ""
      })
      .store(in: &cancellables)
  }
}
