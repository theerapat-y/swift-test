//
//  NewsArticle.swift
//  test1
//
//  Created by Theerapat Yimsirikul on 29-12-14.
//  Copyright (c) 2014 ABC Startsiden AS. All rights reserved.
//

import Foundation

class NewsArticle {
    var id: Int
    var time: String
    var date: String
    var author: String
    
    var url: String
    var ingress: String
    var title: String
    
    var imageUrl: String
    
    init(id: Int, time: String, date: String, author: String, url: String, ingress: String, title: String, imageurl: String) {
        self.id = id
        self.time = time
        self.date = date
        self.author = author
        self.url = url
        self.ingress = ingress
        self.title = title
        self.imageUrl = imageurl
    }
    
    class func NewsArticleWithJSON(results: NSDictionary) -> NewsArticle {
        let id = (results["id"] as AnyObject? as? Int) ?? 0
        let author = (results["author"] as AnyObject? as? String) ?? ""
        
        let time = (results["time"] as AnyObject? as? String) ?? ""
        let date = (results["date"] as AnyObject? as? String) ?? ""
        let url = (results["url"] as AnyObject? as? String) ?? ""
        let title = (results["title"] as AnyObject? as? String) ?? ""
        let ingress = (results["ingress"] as AnyObject? as? String) ?? ""
        let imgUrl = (results["imageurl"] as AnyObject? as? String) ?? ""
        
        var item = NewsArticle(id: id, time: time, date: date, author: author, url: url, ingress: ingress, title: title, imageurl: imgUrl)
        
        
        return item
    }
}
