//
//  LaunchImageModel.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/12.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import ObjectMapper

struct LaunchImageModel: Mappable {
    var text: String!
    var img: String!
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        text <- map["text"]
        img <- map["img"]
    }
}

extension LaunchImageModel: Hashable {
    var hashValue: Int {
        return self.img.hashValue
    }
}

func ==(lhs: LaunchImageModel, rhs: LaunchImageModel) -> Bool {
    return lhs.img == rhs.img
}
