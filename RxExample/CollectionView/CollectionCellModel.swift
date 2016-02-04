//
//  CellModel.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/4.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import Foundation

struct CollectionCellModel {
    let name: String
    let age: Int
}

// MARK: - For RxDataSources
extension CollectionCellModel: Hashable {
    var hashValue: Int {
        return self.name.hashValue
    }
}

func ==(lhs: CollectionCellModel, rhs: CollectionCellModel) -> Bool {
    return lhs.name == rhs.name
}