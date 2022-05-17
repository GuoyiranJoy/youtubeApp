//
//  Video.swift
//  youtubeApp
//
//  Created by ByteDance on 2022/5/12.
//

import Foundation
struct Video:Decodable{
    var videoId=""
    var title=""
    var description=""
    var thumbnail=""
    var pushlished=Date()
    
    enum CodingKeys:String,CodingKey{
        case pushlished="publishedAt"
        case title
        case description
        case thumbnail="url"
        case videoId
        //nested JSON
        case snippet
        case thumbnails
        case high
        case resourceId
    }
    
    init (from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        self.title=try snippetContainer.decode(String.self, forKey: .title)
        self.description=try snippetContainer.decode(String.self, forKey: .description)
        self.pushlished=try snippetContainer.decode(Date.self, forKey: .pushlished)
        let tnContainer=try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let highContainer=try tnContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.thumbnail=try highContainer.decode(String.self, forKey: .thumbnail)
        let resourceIdContainer=try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        self.videoId=try resourceIdContainer.decode(String.self, forKey: .videoId)
    }
}
