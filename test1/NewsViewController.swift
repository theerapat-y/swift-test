//
//  ViewController.swift
//  test1
//
//  Created by Theerapat Yimsirikul on 24-12-14.
//  Copyright (c) 2014 ABC Startsiden AS. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, JSONLibProtocol {

    @IBOutlet weak var firstTableView: UITableView!
    let kCellIndentifier = "NewsCell"
    
    var newsList = [NewsList]()
    var jsonLib: JSONLib?
    var imageCache = [String: UIImage]()
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIndentifier) as UITableViewCell
        let news = self.newsList[indexPath.row]
        
        if news.thumbnailUrl != "" {
            var image = self.imageCache[news.thumbnailUrl]
            
            if image == nil {
                let imgUrl: NSURL? = NSURL(string: (news.thumbnailUrl))
                
                let request: NSURLRequest = NSURLRequest(URL: imgUrl!)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    if error == nil {
                        image = UIImage(data: data)
                        
                        self.imageCache[news.thumbnailUrl] = image
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell? {
                                var imgSize = CGSizeMake(93, 70)
                                UIGraphicsBeginImageContext(imgSize)
                                var imgRect = CGRectMake(0, 0, imgSize.width, imgSize.height)
                                image?.drawInRect(imgRect)
                                cellToUpdate.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
                                UIGraphicsEndImageContext()
                                cell.setNeedsLayout()
                            }
                        })
                        
                    } else {
                        println("Error: \(error.localizedDescription)")
                    }
                })

            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                        var imgSize = CGSizeMake(93, 70)
                        UIGraphicsBeginImageContext(imgSize)
                        var imgRect = CGRectMake(0, 0, imgSize.width, imgSize.height)
                        image?.drawInRect(imgRect)
                        cellToUpdate.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        cell.setNeedsLayout()
                    }
                })
            }
        }
        
        cell.textLabel?.text = news.title
        cell.detailTextLabel?.text = news.ingress
        
        return cell
    }
    
    func didReceiveJSONResults(results: NSDictionary) {
        var resultsArray = results["results"] as NSArray
        
        dispatch_async(dispatch_get_main_queue(), {
            self.newsList = NewsList.NewsListWithJSON(resultsArray)
            self.firstTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var detailViewController: DetailViewController = segue.destinationViewController as DetailViewController
        var newsIndex = firstTableView!.indexPathForSelectedRow()!.row
        
        detailViewController.newsList = self.newsList[newsIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News from ABC Nyheter"
        
        // Do any additional setup after loading the view, typically from a nib.
        
        jsonLib = JSONLib(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        jsonLib!.fetchNews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

