//
//  NewModel.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/11.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import ObjectMapper

struct NewsListModel {
    var date: String!
    var stories: [NewsModel]!
    var top_stories: [TopNewsModel]!
}

struct NewsModel {
    var ga_prefix: String!
    var id: Int!
    var images: [String]!
    var title: String!
    var type: Int!
}

struct TopNewsModel {
    var ga_prefix: String!
    var id: Int!
    var image: String!
    var title: String!
    var type: Int!
}

// MARK: - NewsListModel Mappable

extension NewsListModel: Mappable {
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        date <- map["date"]
        stories <- map["stories"]
        top_stories <- map["top_stories"]
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

// MARK: - NewsModel Mappable

extension NewsModel: Mappable {
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

// MARK: - TopNewsModel Mappable

extension TopNewsModel: Mappable {
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        ga_prefix <- map["ga_prefix"]
        id <- map["id"]
        image <- map["image"]
        title <- map["title"]
        type <- map["type"]
    }
}

extension TopNewsModel: Hashable {
    var hashValue: Int {
        return self.id.hashValue
    }
}

func ==(lhs: TopNewsModel, rhs: TopNewsModel) -> Bool {
    return lhs.id == rhs.id
}