//
//  TrafficPopUp.swift
//  DesignSystem
//
//  Created by GREEN on 2023/03/10.
//

import SwiftUI

public struct TrafficPopUp<Content: View>: View {
  
  @Binding var isPresented: Bool
  private let content: () -> Content
  private var opacity: Double
  
  public init(
    isPresented: Binding<Bool>,
    opacity: Double,
    content: @escaping () -> Content
  ) {
    self._isPresented = isPresented
    self.opacity = opacity
    self.content = content
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack {
        if isPresented {
          Color.black.opacity(opacity)
            .onTapGesture {
              self.isPresented.toggle()
            }
            .transition(.opacity)
          
          content()
        }
      }
    }
    .ignoresSafeArea()
  }
}

extension View {
  public func trafficPopUp<Content: View>(
    isPresented: Binding<Bool>,
    opacity: Double,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    modifier(
      TrafficPopUpModifier(
        content: {
          TrafficPopUp(
            isPresented: isPresented,
            opacity: opacity,
            content: content
          )
        }
      )
    )
  }
}

fileprivate struct TrafficPopUpModifier<PopUpContent>: ViewModifier where PopUpContent: View {
  var content: () -> TrafficPopUp<PopUpContent>
  
  func body(content: Content) -> some View {
    ZStack {
      content
      self.content()
    }
  }
}
