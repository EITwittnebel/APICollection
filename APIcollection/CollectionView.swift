//
//  CollectionView.swift
//  APIcollection
//
//  Created by Field Employee on 4/4/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit
import SwiftyJSON

class CollectionView: UICollectionViewController {
  
 // var collModelView: ModelView?
  
 /* required init?(coder: NSCoder) {
    modelView = ModelView()
    super.init(coder: coder)
  }
  */
  override func viewDidLoad() {
    super.viewDidLoad()
    if (modelView.imageData.images.count == 0) {
      initiateCollModelView()
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
    for item in cell.subviews {
      item.removeFromSuperview()
    }
    
    let myImage = modelView.getAPIImage(urlString: modelView.imageData.images[indexPath.row][indexPath.row].thumbnailUrl)
    let myImageView = UIImageView(image: myImage)
        
    cell.addSubview(myImageView)
    cell.backgroundColor = .clear
    return cell
  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return modelView.imageData.images.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return modelView.imageData.images[section].count
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "fromCollToImage") {
      
      let cellSender = sender as! UICollectionViewCell
      let cellSenderPath: IndexPath = collectionView.indexPath(for: cellSender)!
      //cellSender.superview as! UITableView
      let displayImage = modelView.getAPIImage(urlString: modelView.imageData.images[cellSenderPath.row][cellSenderPath.row].url)
      let dest = segue.destination as! ViewController
      dest.imageToDisplay = displayImage
    }
  }
  
  func initiateCollModelView() {
    let url = URL(string: "https://jsonplaceholder.typicode.com/photos")

    let semaphore = DispatchSemaphore(value: 0)
    //Do an API call, get the JSON
    let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
      let rawData = JSON(data)
      modelView.parseData(rawData, numImages: rawData.count)
      semaphore.signal()
    })
    task.resume()
    _ = semaphore.wait(wallTimeout: .distantFuture)
    collectionView.reloadData()
  }

}
