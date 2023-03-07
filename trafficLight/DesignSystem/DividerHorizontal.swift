//
//  DividerHorizontal.swift
//  DesignSystem
//
//  Created by GREEN on 2023/03/07.
//

import SwiftUI

public struct DividerHorizontal: View {
  let color: BackgroundColor
  let height: Height
  
  public init(
    color: BackgroundColor = .blue,
    height: Height
  ) {
    self.color = color
    self.height = height
  }
  
  public var body: some View {
    Rectangle()
      .foregroundColor(color.usage)
      .frame(maxWidth: .infinity)
      .frame(height: height.value)
  }
}

extension DividerHorizontal {
  public enum BackgroundColor {
    case blue
    case gray
    
    var usage: Color {
      switch self {
      case .blue:
        return .blue
      case .gray:
        return .gray
      }
    }
  }
  
  public enum Height {
    case _1
    case _2
    case _4
    case _8
    case _12
    case _16
    case _20
    case _24
    
    var value: CGFloat {
      switch self {
      case ._1: return 1
      case ._2: return 2
      case ._4: return 4
      case ._8: return 8
      case ._12: return 12
      case ._16: return 16
      case ._20: return 20
      case ._24: return 24
      }
    }
  }
}

