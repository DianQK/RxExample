//
//  ZhihuDailyAPI.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/11.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import Moya
import SwiftDate

// MARK: - Provider setup

private let requestClosure = { (endpoint: Endpoint<ZhihuDailyAPI>, done: NSURLRequest -> Void) in
    let request = endpoint.urlRequest
    
    // Modify the request however you like.
    
    done(request)
}

let ZhihuDailyProvider = RxMoyaProvider<ZhihuDailyAPI>(endpointClosure: MoyaProvider.DefaultEndpointMapping,
    requestClosure: requestClosure,
    stubClosure: MoyaProvider.NeverStub,
    manager: MoyaProvider<ZhihuDailyAPI>.DefaultAlamofireManager(),
    plugins: [NetworkLoggerPlugin()])

public typealias ZhihuDate = Int

public enum ZhihuDailyAPI {
    case NewsLatest
    case NewsBefore(date: NSDate) //改
    case News(id: String)
    case ThemesList
    case Theme(id: String)
    case StartImage
}

extension ZhihuDailyAPI: TargetType {
    public var baseURL: NSURL { return NSURL(string: Config.host)! }
    public var path: String {
        switch self {
        case .NewsLatest:
            return "/api/4/news/latest"
        case .NewsBefore(let date):
            return "/api/4/news/before/" + date.toString(DateFormat.Custom("yyyyMMdd"))!
        case .News(let id):
            return "/api/4/news/" + id
        case .ThemesList:
            return "/api/4/themes"
        case .Theme(let id):
            return "/api/4/theme/" + id
        case .StartImage:
            return "/api/4/start-image/1080*1776"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .NewsLatest:
            return .GET
        case .NewsBefore(_):
            return .GET
        case .News(_):
            return .GET
        case .ThemesList:
            return .GET
        case .Theme(_):
            return .GET
        case .StartImage:
            return .GET
        }
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        case .NewsLatest:
            return nil
        case .NewsBefore(_):
            return nil
        case .News(_):
            return nil
        case .ThemesList:
            return nil
        case .Theme(_):
            return nil
        case .StartImage:
            return nil
        }
    }
    
    public var sampleData: NSData { // 改
        switch self {
        case .NewsLatest:
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
        case .NewsBefore(_):
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
        case .News(_):
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
        case .ThemesList:
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
        case .Theme(_):
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
        case .StartImage:
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}