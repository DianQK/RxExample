//
//  AppDelegate.swift
//  RxZhihuDaily
//
//  Created by 宋宋 on 16/2/11.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let disposeBag = DisposeBag()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        ZhihuDailyProvider.request(.StartImage)
            .mapObject(LaunchImageModel)
            .subscribeNext {
                NSUserDefaults.standardUserDefaults().setURL(NSURL(string: $0.img), forKey: Config.Launch.launchImageKey)
            }
            .addDisposableTo(disposeBag)
        return true
    }

}

