//
//  trafficLightApp.swift
//  trafficLight
//
//  Created by GREEN on 2023/03/07.
//

import SwiftUI

@main
struct trafficLightApp: App {
  var diariesModel = DiariesModel.stub
  
  var body: some Scene {
    WindowGroup {
      DiaryListView(diaryListCore: .init())
        .environmentObject(diariesModel)
    }
  }
}
