//
//  ThemeModel.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/15.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import ObjectMapper

struct ThemesListModel {
    var limit: Int!
    var others: [ThemeModel]!
    var subscribed: [String]!
}

extension ThemesListModel: Mappable {
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        limit <- map["limit"]
        others <- map["others"]
        subscribed <- map["subscribed"]
    }
}

extension ThemesListModel: Hashable {
    var hashValue: Int {
        return self.limit.hashValue
    }
}

func ==(lhs: ThemesListModel, rhs: ThemesListModel) -> Bool {
    return lhs.limit == rhs.limit
}


struct ThemeModel {
    var color: Int!
    var description: String!
    var id: Int!
    var name: String!
    var thumbnail: String!
}

extension ThemeModel: Mappable {
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        color <- map["color"]
        description <- map["description"]
        id <- map["id"]
        name <- map["name"]
        thumbnail <- map["thumbnail"]
    }
}

extension ThemeModel: Hashable {
    var hashValue: Int {
        return self.id.hashValue
    }
}

func ==(lhs: ThemeModel, rhs: ThemeModel) -> Bool {
    return lhs.id == rhs.id
}