//
//  ImageApiModel.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//

import Foundation
final class ImageApiModelElement: Codable {
  var id: String
  var url: String
  var width: Int
  var height: Int

  init(id: String, url: String, width: Int, height: Int) {
    self.id = id
    self.url = url
    self.width = width
    self.height = height
  }
}

typealias ImageApiModel = [ImageApiModelElement]
