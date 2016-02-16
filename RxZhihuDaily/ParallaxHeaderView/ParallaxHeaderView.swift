//
//  ParallaxHeaderView.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/16.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ParallaxHeaderView: UIView {
    
    var headerTitleLabel: UILabel!
    
    var blurViewImage: UIImage!
    
    var imageScrollView: UIScrollView!
    
    var subView: UIView!
    
    var bluredImageView: UIImageView!
    
    static func parallaxThemeHeaderViewWithSubView(subView: UIView, size: CGSize, image: UIImage?) -> ParallaxHeaderView {
        let headerView = ParallaxHeaderView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        headerView.initialThemeSetupForCustomSubView(subView, image: image)
        
        return headerView
    }
    
    func layoutThemeHeaderViewForScrollViewOffset(offset: CGPoint) {
        var imageScrollViewFrame = imageScrollView.frame
        if offset.y > 0 {
            imageScrollViewFrame.origin.y = offset.y
            imageScrollView.frame = imageScrollViewFrame
        } else {
            var rect = CGRect(origin: CGPointZero, size: frame.size)
            let delta = offset.y
            rect.origin.y += delta
            rect.size.height -= delta
            
            bluredImageView.alpha = (95 + offset.y) / 95
            imageScrollView.frame = rect
            clipsToBounds = false
        }
    }
    
    func initialThemeSetupForCustomSubView(view: UIView, image: UIImage?) {
        imageScrollView = UIScrollView(frame: bounds)
        imageScrollView.backgroundColor = UIColor.whiteColor()
        addSubview(imageScrollView)
        
        view.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleHeight, .FlexibleWidth]
        subView = view
        imageScrollView.addSubview(subView)
        
        bluredImageView = UIImageView(frame: subView.frame)
        bluredImageView.autoresizingMask = subView.autoresizingMask
        bluredImageView.alpha = 1
        bluredImageView.contentMode = .ScaleAspectFill
        
        imageScrollView.addSubview(bluredImageView)
        
        addSubview(imageScrollView)
        
        blurViewImage = image
        refreshBlurViewForNewsImage()
    }
    
    func refreshBlurViewForNewsImage() {
        if blurViewImage != nil {
            let screenShot = blurViewImage.applyBlurWithRadius(5, tintColor: nil, saturationDeltaFactor: 1.0)
            bluredImageView.image = screenShot
        }
    }
    
    

}
