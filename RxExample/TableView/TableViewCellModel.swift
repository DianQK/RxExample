//
//  TableViewCellMode.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/4.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import Foundation

struct TableViewCellModel {
    let tool: String
    let cost: String
}

extension TableViewCellModel: Hashable {
    var hashValue: Int {
        return self.tool.hashValue
    }
}

func ==(lhs: TableViewCellModel, rhs: TableViewCellModel) -> Bool {
    return lhs.tool == rhs.tool
}