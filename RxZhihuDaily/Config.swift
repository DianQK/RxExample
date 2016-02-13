//
//  Config.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/11.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import Foundation
import XCGLogger

class Config {
    
    #if DEBUG
    static let logLevel: XCGLogger.LogLevel = .Debug
    #else
    static let logLevel: XCGLogger.LogLevel = .Severe
    #endif
    
    static let host = "http://news-at.zhihu.com"
    
    static let loadMoreNumber = 3 /// 一次下拉刷新加载的天数
    
    struct Launch {
        static let launchTime: Double = 1
        static let launchImageKey = "LaunchImageURL"
    }
    
    struct Color {
        static let blue = UIColor(red: 24.0/255.0, green: 144.0/255.0, blue: 211.0/255.0, alpha: 1)
        static let white = UIColor.whiteColor()
    }
}