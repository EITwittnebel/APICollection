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

class ViewController: UIViewController {
  @IBOutlet weak var imageOutlet: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  var imageToDisplay: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageOutlet.image = imageToDisplay
  }

  required init?(coder: NSCoder) {
    imageToDisplay = nil
    super.init(coder: coder)
  }
  
}
