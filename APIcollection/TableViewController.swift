//
//  TableViewController.swift
//  APIcollection
//
//  Created by Field Employee on 4/6/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class TableViewController: UITableViewController {
  
  var tableModelView: ModelView = ModelView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initiateTableModelView()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableModelView.imageData.images[section].count
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
 
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "The albumID is \(section)"
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return tableModelView.imageData.images.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")!


    if let label = cell.viewWithTag(1000) as? UILabel {
      if (tableModelView.imageData.images.count == 0) {
        label.text = "loading..."
      } else {
        label.text = String(tableModelView.imageData.images[indexPath.section][indexPath.row].title)
      }
    }
    
    let iconImage = tableModelView.getAPIImage(urlString: tableModelView.imageData.images[indexPath.section][indexPath.row].thumbnailUrl)
    
    if let thumbnail = cell.viewWithTag(1001) as? UIImageView {
      if (tableModelView.imageData.images.count == 0) {
        thumbnail.image = UIImage(named: "placeholder.png")
      } else {
        thumbnail.image = iconImage
      }
    }
    
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "fromTableToImage") {
      
      let cellSender = sender as! UITableViewCell
      let cellSenderPath: IndexPath = tableView.indexPath(for: cellSender)!
      //cellSender.superview as! UITableView
      let displayImage = tableModelView.getAPIImage(urlString: tableModelView.imageData.images[cellSenderPath.section][cellSenderPath.row].url)
      let dest = segue.destination as! ViewController
      dest.imageToDisplay = displayImage
    }
  }
  
  func initiateTableModelView() {
    let url = URL(string: "https://jsonplaceholder.typicode.com/photos")

    let semaphore = DispatchSemaphore(value: 0)
    //Do an API call, get the JSON
    let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
      let rawData = JSON(data)
      self.tableModelView.parseData(rawData, numImages: rawData.count)
      semaphore.signal()
    })
    task.resume()
    _ = semaphore.wait(wallTimeout: .distantFuture)
    tableView.reloadData()
  }
  
}
