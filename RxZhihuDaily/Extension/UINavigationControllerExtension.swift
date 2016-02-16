//
//  UINavigationControllerExtension.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/15.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit

//拓展NavigationController以设置StatusBar
extension UINavigationController {
    public override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.topViewController
    }
    public override func childViewControllerForStatusBarHidden() -> UIViewController? {
        return self.topViewController
    }
}