//
//  UINavgationExtension.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/15.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit
private var key: Void?
///https://github.com/ltebean/LTNavigationBar/blob/master/LTNavigationBar/UINavigationBar%2BAwesome.m
extension UINavigationBar {
    var overlay: UIView? {
        get {
            return objc_getAssociatedObject(self, &key) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var lt_backgroundColor: UIColor? {
        get {
            if self.overlay == nil {
                self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
                self.overlay = UIView(frame: CGRect(x: 0, y: -20, width: UIScreen.mainScreen().bounds.size.width, height: CGRectGetHeight(self.bounds) + 20))
                self.overlay?.userInteractionEnabled = false
                self.overlay?.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
                self.insertSubview(self.overlay!, atIndex: 0)
            }
            return self.overlay?.backgroundColor
        }
        set {
            if self.overlay == nil {
                self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
                self.overlay = UIView(frame: CGRect(x: 0, y: -20, width: UIScreen.mainScreen().bounds.size.width, height: CGRectGetHeight(self.bounds) + 20))
                self.overlay?.userInteractionEnabled = false
                self.overlay?.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
                self.insertSubview(self.overlay!, atIndex: 0)
            }
            self.overlay?.backgroundColor = newValue
        }
    }
    
}
