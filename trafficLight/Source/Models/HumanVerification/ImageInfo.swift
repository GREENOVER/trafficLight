//
//  ImageInfo.swift
//  Models
//
//  Created by GREEN on 2023/03/09.
//

import Foundation

struct ImageInfo: Hashable {
  var imageName: String
  var isCollect: Bool
  var isSelect: Bool
  
  init(
    imageName: String,
    isCollect: Bool,
    isSelect: Bool
  ) {
    self.imageName = imageName
    self.isCollect = isCollect
    self.isSelect = isSelect
  }
}
