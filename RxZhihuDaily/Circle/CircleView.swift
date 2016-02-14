//
//  CircleCollectionView.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/13.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CircleView: UIView {
    
    var currentPage: Int {
        get {
            return pageControl.currentPage
        }
        set {
            pageControl.currentPage = newValue
        }
    }
    
    var pageControl : UIPageControl
    
    let collectionView: UICollectionView
    
    init(frame: CGRect, disposeBag: DisposeBag) {
        let flowLayout =  UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .Horizontal
        flowLayout.itemSize = frame.size
        collectionView = UICollectionView(frame: CGRect(origin: CGPointZero, size: frame.size), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.pagingEnabled = true
        
//        let maskView = UIImageView(image: UIImage(named: "Home_Image_Mask_Plus"))
//        maskView.layer.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - maskView.frame.size.height / 2)
        
        pageControl = UIPageControl()
        pageControl.layer.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - 10)
        pageControl.currentPageIndicatorTintColor = Config.Color.white
        
        super.init(frame: frame)
        addSubview(collectionView)
//        addSubview(maskView)
        addSubview(pageControl)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
