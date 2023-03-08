//
//  trafficLightApp.swift
//  trafficLight
//
//  Created by GREEN on 2023/03/07.
//

import SwiftUI

@main
struct trafficLightApp: App {
  @StateObject var diariesModel = DiariesModel.shared
  
  var body: some Scene {
    WindowGroup {
      DiaryListView(diaryListCore: .init(service: ChatGPTService()))
        .environmentObject(diariesModel)
    }
  }
}
