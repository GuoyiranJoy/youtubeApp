//
//  CahceManager.swift
//  youtubeApp
//
//  Created by ByteDance on 2022/5/16.
//

import Foundation

class CacheManager{
    static var cache=[String:Data]()
    static func setVideoCache(_ url:String,_ data:Data?){
        //store the data and use the url as the key
        cache[url]=data
    }
    static func getVideoCache(_ url:String)->Data?{
        //try to get the data for the specified url
        return cache[url]
    }
}
