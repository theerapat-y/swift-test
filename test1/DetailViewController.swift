//
//  DetailViewController.swift
//  test1
//
//  Created by Theerapat Yimsirikul on 29-12-14.
//  Copyright (c) 2014 ABC Startsiden AS. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var newsList: NewsList?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
    }
}