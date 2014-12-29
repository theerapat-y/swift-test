//
//  DetailViewController.swift
//  test1
//
//  Created by Theerapat Yimsirikul on 29-12-14.
//  Copyright (c) 2014 ABC Startsiden AS. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, JSONLibProtocol {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var newsList: NewsList?
    var newsArticle: NewsArticle?
    var jsonLib: JSONLib?
    
    let imageCellIdentifier = "Header Image"
    let titleCellIdentifier = "Title Text"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let imageCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(imageCellIdentifier) as UITableViewCell
        
        println(newsArticle?.title)
        
        return imageCell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        
        jsonLib = JSONLib(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        if let newsListJa = newsList {
            jsonLib!.fetchArticle(newsListJa.id)
        }
    }
    
    func didReceiveJSONResults(results: NSDictionary) {
        dispatch_async(dispatch_get_main_queue(), {
            self.newsArticle = NewsArticle.NewsArticleWithJSON(results)
            self.detailTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
}
