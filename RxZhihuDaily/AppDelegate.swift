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
import SWRevealViewController

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
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let mainViewController = UIStoryboard(name: .Main).instantiateViewControllerWithClass(MainTableViewController)
        let sideViewController = UIStoryboard(name: .Side).instantiateViewControllerWithClass(SideViewController)
        let navgationController = UINavigationController(rootViewController: mainViewController)
        
        let revealController = SWRevealViewController(rearViewController: sideViewController, frontViewController: navgationController)
        revealController.toggleAnimationType = .EaseOut
        revealController.frontViewShadowOffset = CGSizeZero
        revealController.frontViewShadowOpacity = 0
        revealController.frontViewShadowRadius = 0
        revealController.rearViewRevealWidth = 225
        window?.rootViewController = revealController
        window?.makeKeyAndVisible()
        
        let navigationBarAppearance = UINavigationBar.appearance()
        let textAttributes = [NSForegroundColorAttributeName: Config.Color.white]
        navigationBarAppearance.barTintColor = Config.Color.white
        navigationBarAppearance.tintColor = Config.Color.white
        navigationBarAppearance.titleTextAttributes = textAttributes
        
        return true
    }

}

