//
//  NewsList.swift
//  test1
//
//  Created by Theerapat Yimsirikul on 26-12-14.
//  Copyright (c) 2014 ABC Startsiden AS. All rights reserved.
//

import Foundation


class NewsList {
    var id: String
    var time: String
    var date: String
    
    var url: String
    var ingress: String
    var title: String
    
    var imageUrl: String
    var thumbnailUrl: String
    
    var videoIcon: Bool
    
    init(id: String, time: String, date: String, url: String, ingress: String, title: String, imageurl: String, thumbnailurl: String, videoicon: Bool) {
        self.id = id
        self.time = time
        self.date = date
        self.url = url
        self.ingress = ingress
        self.title = title
        self.imageUrl = imageurl
        self.thumbnailUrl = thumbnailurl
        self.videoIcon = videoicon
    }
    
    class func NewsListWithJSON(results: NSArray) -> [NewsList] {
        var newsList = [NewsList]()
        
        if results.count > 0 {
            for newsItem in results {
                let id = (newsItem["id"] as AnyObject? as? String) ?? ""
                
                let time = (newsItem["time"] as AnyObject? as? String) ?? ""
                let date = (newsItem["date"] as AnyObject? as? String) ?? ""
                let url = (newsItem["url"] as AnyObject? as? String) ?? ""
                let title = (newsItem["title"] as AnyObject? as? String) ?? ""
                let ingress = (newsItem["ingress"] as AnyObject? as? String) ?? ""
                let imgUrl = (newsItem["imageurl"] as AnyObject? as? String) ?? ""
                let thumbnailUrl = (newsItem["thumbnailurl"] as AnyObject? as? String) ?? ""
                
                let videoIconInt = (newsItem["video_icon"] as AnyObject? as? Int) ?? 0
                let videoIcon: Bool = videoIconInt == 1 ? true : false
            
                var item = NewsList(id: id, time: time, date: date, url: url, ingress: ingress, title: title, imageurl: imgUrl, thumbnailurl: thumbnailUrl, videoicon: videoIcon)
                
                newsList.append(item)
                
            }
        }
        
        return newsList
    }
}
