//
//  TrafficLightNavigationBar.swift
//  DesignSystem
//
//  Created by GREEN on 2023/03/08.
//

import SwiftUI

struct TrafficLightNavigationBar: View {
  var isDisplayBackButton: Bool
  var isDisplayWritingButton: Bool
  var backButtonAction: () -> Void = {}
  var writingButtonAction: () -> Void = {}
  
  init(
    isDisplayBackButton: Bool = false,
    isDisplayWritingButton: Bool = false,
    backButtonAction: @escaping () -> Void = {},
    writingButtonAction: @escaping () -> Void = {}
  ) {
    self.isDisplayBackButton = isDisplayBackButton
    self.isDisplayWritingButton = isDisplayWritingButton
    self.backButtonAction = backButtonAction
    self.writingButtonAction = writingButtonAction
  }
  
  var body: some View {
    HStack {
      if isDisplayBackButton {
        Button(
          action: backButtonAction,
          label: {
            Image("arrowLeftIcon")
              .resizable()
              .frame(width: 40, height: 40, alignment: .center)
              .padding(16)
          }
        )
      }
      
      Spacer()
      
      if isDisplayWritingButton {
        Button(
          action: writingButtonAction,
          label: {
            Image("writingIcon")
              .resizable()
              .frame(width: 40, height: 40, alignment: .center)
              .padding(16)
          }
        )
      }
    }
    .frame(height: 48, alignment: .center)
    .background(.white)
  }
}
