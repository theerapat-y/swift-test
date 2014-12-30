//
//  DetailViewController.swift
//  test1
//
//  Created by Theerapat Yimsirikul on 29-12-14.
//  Copyright (c) 2014 ABC Startsiden AS. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate, JSONLibProtocol {

    @IBOutlet var refView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var articleTextView: UITextView!
    
    
    var newsList: NewsList?
    var newsArticle: NewsArticle?
    var jsonLib: JSONLib?
    var imgCache = [String: UIImage]()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        var leftConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.refView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        var rightContraint: NSLayoutConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.refView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
        
        self.refView.addConstraint(leftConstraint)
        self.refView.addConstraint(rightContraint)
        
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
            
            println(self.newsArticle!.id)
            println(self.newsArticle!.title)
            println(self.newsArticle!.imageUrl)
            println(self.newsArticle!.ingress)
            
            self.titleTextView.text = self.newsArticle!.title
            self.articleTextView.text = self.newsArticle!.ingress
            
            var image = self.imgCache[self.newsArticle!.imageUrl]
            
            if image == nil {
                var imgUrlString = self.newsList?.imageUrl
                if self.newsArticle!.imageUrl != "" {
                    imgUrlString = "http://www.abcnyheter.no" + self.newsArticle!.imageUrl
                }
                let imgUrl: NSURL? = NSURL(string: imgUrlString!)
                
                let request: NSURLRequest = NSURLRequest(URL: imgUrl!)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    if error == nil {
                        image = UIImage(data: data)
                        
                        self.imgCache[self.newsArticle!.imageUrl] = image
                        dispatch_async(dispatch_get_main_queue(), {
                            self.headerImageView.image = image
                        })
                        
                    } else {
                        println("Error: \(error.localizedDescription)")
                    }
                })
                
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.headerImageView.image = image
                })
            }
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
}
