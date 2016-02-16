//
//  StoryboardHelper.swift
//  PalmCivet
//
//  Created by DianQK on 16/1/30.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit

public enum StoryboardName: String {
    case Main = "Main"
    case Launch = "Launch"
    case Side = "Side"
    case Theme = "Theme"
}

public extension UIStoryboard {
    public convenience init(name: StoryboardName, bundle storyboardBundleOrNil: NSBundle? = nil) {
        self.init(name: name.rawValue, bundle: storyboardBundleOrNil)
    }
    
    public func instantiateViewControllerWithClass<T: UIViewController>(type: T.Type) -> T {
        return instantiateViewControllerWithIdentifier("\(T.self)") as! T
    }
}