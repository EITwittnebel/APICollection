//
//  ModelView.swift
//  APIcollection
//
//  Created by Field Employee on 4/4/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

var modelView = ModelView()

class ModelView {
 
  var imageData: ImageData = ImageData()

  init() {
    imageData = ImageData()
  }
  
  func getAPIImage(urlString: String) -> UIImage {
    let thumbnailSemaphore = DispatchSemaphore(value: 0)

    let imageURL = URL(string: urlString)
    var retVal: UIImage? = UIImage(named: "placeholder.png")
    
    if (imageURL == nil) {
      //itemToAppend.thumbnailImage = UIImage(named: "placeholder.png")
    } else {
      let session = URLSession(configuration: .default)
      session.dataTask(with: imageURL!) { (data, response, error) in
        // The download has finished.
        if let e = error {
          print("Error downloading picture: \(e)")
        } else {
          // No errors found.
          // It would be weird if we didn't have a response, so check for that too.
          if let res = response as? HTTPURLResponse {
          //  print("Downloaded picture with response code \(res.statusCode)")
            if let imageData = data {
              let image = UIImage(data: imageData)
              retVal = image
              //print(image?.size.width)
            } else {
              print("Couldn't get image: Image is nil")
            }
          } else {
            print("Couldn't get response code for some reason")
          }
        }
        thumbnailSemaphore.signal()
      }.resume()
    }
    _ = thumbnailSemaphore.wait(wallTimeout: .distantFuture)
    return retVal!
  }
  
  func parseData(_ apiCallResults: JSON, numImages: Int) {
    for index in 0..<numImages {
      //print(index)
      parseImageData(apiCallResults[index])
    }
  }

  
  func parseImageData(_ item: JSON) {
    var itemToAppend: SingleImageData = SingleImageData(albumID: -9001, id: -9001, title: "ERROR", url: "ERROR", thumbnailUrl: "ERROR")
    
    itemToAppend.albumID = item["albumId"].intValue
    itemToAppend.id = item["id"].intValue
    itemToAppend.title = item["title"].stringValue
    itemToAppend.thumbnailUrl = item["thumbnailUrl"].stringValue
    itemToAppend.url = item["url"].stringValue
    if (itemToAppend.albumID > imageData.images.count) {
      imageData.images.append([])
    }
    imageData.images[itemToAppend.albumID - 1].append(itemToAppend)
  }
  
}
