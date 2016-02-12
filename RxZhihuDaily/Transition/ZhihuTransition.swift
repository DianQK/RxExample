//
//  ZhihuTransition.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/12.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import TransitionTreasury

enum ZhihuTransition: TransitionAnimationable {
    case Launch(zoom: UIView)
    
    func transitionAnimation() -> TRViewControllerAnimatedTransitioning {
        switch self {
        case .Launch(let zoom):
            return LaunchTransitionAnimation(zoomView: zoom)
        }
    }
}
