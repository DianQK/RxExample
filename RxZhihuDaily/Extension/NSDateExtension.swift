//
//  NSDateExtension.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/12.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import SwiftDate

extension NSDate {
    var weekdayChinese: String {
        switch weekday {
        case 1:
            return "星期日"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            fatalError("There is no this weekday")
        }
    }
    
    var zhihuDate: String {
        return toString(DateFormat.Custom("MM月dd日"))! + " " + weekdayChinese
    }
}
