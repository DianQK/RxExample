//
//  NewModel.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/11.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import ObjectMapper

struct NewsListModel: Mappable {
    var date: String!
    var stories: [NewsModel]!
    var top_stories: [NewsModel]!
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        date <- map["date"]
        stories <- map["stories"]
    }
}

extension NewsListModel: Hashable {
    var hashValue: Int {
        return self.date.hashValue
    }
}

func ==(lhs: NewsListModel, rhs: NewsListModel) -> Bool {
    return lhs.date == rhs.date
}

struct NewsModel: Mappable {
    var ga_prefix: String!
    var id: Int!
    var images: [String]!
    var title: String!
    var type: Int!
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        ga_prefix <- map["ga_prefix"]
        id <- map["id"]
        images <- map["images"]
        title <- map["title"]
        type <- map["type"]
    }
}

extension NewsModel: Hashable {
    var hashValue: Int {
        return self.id.hashValue
    }
}

func ==(lhs: NewsModel, rhs: NewsModel) -> Bool {
    return lhs.id == rhs.id
}