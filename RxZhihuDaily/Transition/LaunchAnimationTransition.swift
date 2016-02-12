//
//  LaunchAnimationTransition.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/12.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import TransitionTreasury

public class LaunchTransitionAnimation: NSObject, TRViewControllerAnimatedTransitioning {
    
    public var transitionStatus: TransitionStatus
    
    public var transitionContext: UIViewControllerContextTransitioning?
    
    public var percentTransition: UIPercentDrivenInteractiveTransition?
    
    public let zoomView: UIView
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.6
    }
    
    public init(zoomView view: UIView, status: TransitionStatus = .Present) {
        zoomView = view
        transitionStatus = status
        super.init()
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containView = transitionContext.containerView()
        
        if transitionStatus == .Present {
            containView?.addSubview(toVC!.view)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            return
        }
        
        containView?.addSubview(toVC!.view)
        containView?.addSubview(fromVC!.view)
        
        let endTransform = CATransform3DScale(CATransform3DIdentity, 1.15, 1.15, 1)
        zoomView.layer.transform = endTransform
        
        let zoomAnimation = CABasicAnimation(keyPath: "transform")
        zoomAnimation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        zoomAnimation.toValue = NSValue(CATransform3D: endTransform)
        zoomAnimation.duration = transitionDuration(transitionContext)
        zoomAnimation.delegate = self
        
        zoomView.layer.addAnimation(zoomAnimation, forKey: "Zoom")

    }
    
    public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        UIView.animateWithDuration(0.3, animations: { [unowned self] in
            let fromVC = self.transitionContext!.viewControllerForKey(UITransitionContextFromViewControllerKey)
            fromVC?.view.alpha = 0
            }) { [unowned self] in
                if $0 {
                    self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
                }
        }
    }
    
}
