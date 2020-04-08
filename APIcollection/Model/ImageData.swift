//
//  ImageData.swift
//  APIcollection
//
//  Created by Field Employee on 4/4/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import Foundation

class ImageData {
  var images: [[SingleImageData]]
  
  init() {
    images = []
  }
}

struct SingleImageData {
  var albumID: Int
  var id: Int
  var title: String
  var url: String
  var thumbnailUrl: String
}
