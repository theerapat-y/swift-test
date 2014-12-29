//
//  JSONLib.swift
//  test1
//
//  Created by Theerapat Yimsirikul on 25-12-14.
//  Copyright (c) 2014 ABC Startsiden AS. All rights reserved.
//

import Foundation

protocol JSONLibProtocol {
    func didReceiveJSONResults(results: NSDictionary)
}

class JSONLib{
    
    var delegate: JSONLibProtocol
    
    init(delegate: JSONLibProtocol) {
        self.delegate = delegate
    }
    
    func fetchNews(urlPath: String = "http://abcnyheter.no/api/article.json?category=frontpage") {
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            println("Task completed")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            let results: NSArray = jsonResult["results"] as NSArray
            
            self.delegate.didReceiveJSONResults(jsonResult)
        })
        
        task.resume()
    }
    
    func fetchArticle(articleId: String) {
        let urlString = "http://www.abcnyheter.no/api/article/\(articleId).json"
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            println("Task completed")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            
            self.delegate.didReceiveJSONResults(jsonResult)
        })
        
        task.resume()
    }

}