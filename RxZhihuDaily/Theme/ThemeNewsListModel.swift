//
//  ThemeNewsList.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/16.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import ObjectMapper

struct ThemeNewsListModel {
    var background: String!
    var color: Int!
    var description: String!
    var editors: [EditorModel]!
    var image: String!
    var image_source: String!
    var name: String!
    var stories: [NewsModel]!
}

struct EditorModel {
    var avatar: String!
    var bio: String!
    var id: Int!
    var name: String!
    var url: String!
}

extension ThemeNewsListModel: Mappable {
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        background <- map["background"]
        color <- map["color"]
        description <- map["description"]
        editors <- map["editors"]
        image <- map["image"]
        image_source <- map["image_source"]
        name <- map["name"]
        stories <- map["stories"]
    }
}

extension ThemeNewsListModel: Hashable {
    var hashValue: Int {
        return name.hashValue
    }
}

func ==(lhs: ThemeNewsListModel, rhs: ThemeNewsListModel) -> Bool {
    return lhs.name == rhs.name
}

extension EditorModel: Mappable {
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        avatar <- map["avatar"]
        bio <- map["bio"]
        id <- map["id"]
        name <- map["name"]
        url <- map["url"]
    }
}

extension EditorModel: Hashable {
    var hashValue: Int {
        return id.hashValue
    }
}

func ==(lhs: EditorModel, rhs: EditorModel) -> Bool {
    return lhs.id == rhs.id
}