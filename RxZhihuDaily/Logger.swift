//
//  Logger.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/11.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import XCGLogger

let log: XCGLogger = {
    let log = XCGLogger.defaultInstance()
    let logPath : NSURL = cacheDirectory.URLByAppendingPathComponent("XCGLogger.Log")
    // By using Swift build flags, different log levels can be used in debugging versus staging/production. Go to Build settings -> Swift Compiler - Custom Flags -> Other Swift Flags and add -DDEBUG to the Debug entry.
    log.setup(Config.logLevel, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil)
    log.xcodeColorsEnabled = true
    log.xcodeColors = [
        .Verbose: .lightGrey,
        .Debug: .darkGrey,
        .Info: .darkGreen,
        .Warning: .orange,
        .Error: .red,
        .Severe: .whiteOnRed
    ]
    return log
}()

private var documentsDirectory: NSURL {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls[urls.endIndex-1]
}

private var cacheDirectory: NSURL {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
    return urls[urls.endIndex-1]
}

import Moya
import XCGLogger
import Result

public struct NetworkLoggerPlugin: PluginType {
    
    public typealias NetworkLoggerClosure = (change: NetworkActivityChangeType) -> ()
    let networkLoggerClosure: NetworkLoggerClosure
    
    static let defaultLoggerClousre: NetworkLoggerClosure = { change in
        
    }
    
    public init(networkLoggerClosure: NetworkLoggerClosure = NetworkLoggerPlugin.defaultLoggerClousre) {
        self.networkLoggerClosure = networkLoggerClosure
    }
    
    // MARK: Plugin
    
    /// Called immediately before a request is sent over the network (or stubbed).
    public func willSendRequest(request: RequestType, target: TargetType) {
        log.info("\(request.request)")
        networkLoggerClosure(change: .Began)
    }
    
    // Called after a response has been received, but before the MoyaProvider has invoked its completion handler.
    public func didReceiveResponse(result: Result<Moya.Response, Moya.Error>, target: TargetType) {
        switch result {
        case .Success(let response) :
            do {
                try NetworkLog.out(response.statusCode, target: target, json: response.mapJSON())
            } catch {
                //                log.error("解析错误: \(response)")
                NetworkLog.out(response.statusCode, target: target, json: try! response.mapString())
            }
        case .Failure(let error) :
            log.error("\(error)")
        }
        networkLoggerClosure(change: .Ended)
    }
    
}

public struct NetworkLog {
    static let ESCAPE = "\u{001b}["
    
    static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    static let RESET = ESCAPE + ";"   // Clear any foreground or background color
    
    typealias StatusCode = Int
    static func out(statusCode: StatusCode, target: TargetType, json: AnyObject) {
//        Async.background { () -> Void in
            var codeColor = "fg255,0,0"
            if statusCode == 200 {
                codeColor = "fg0,255,0"
            }
            print("\(ESCAPE)\(codeColor);\(statusCode)\(RESET) \(ESCAPE)fg53,255,206;\(target.method)\(RESET) \(ESCAPE)fg69,69,69;\(target.path) \(target.parameters ?? [:])\(RESET) \n\(ESCAPE)fg29,29,29;\(json)\(RESET)")
//        }
    }
}