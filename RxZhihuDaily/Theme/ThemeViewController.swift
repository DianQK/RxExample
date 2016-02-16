//
//  ThemeViewController.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/16.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SWRevealViewController
import Kingfisher

class ThemeViewController: UITableViewController {
    
    var id: Int!
    
    let disposeBag = DisposeBag()
    
    let sections = Variable([NewsModel]())
    
    let imageURL = Variable(NSURL())

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        tableView.delegate = nil
        let revealController = self.revealViewController()
        view.addGestureRecognizer(revealController.tapGestureRecognizer())
        view.addGestureRecognizer(revealController.panGestureRecognizer())
        
        navigationController?.navigationBar.lt_backgroundColor = UIColor.clearColor()
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let navImageView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, 64))
        navImageView.contentMode = UIViewContentMode.ScaleAspectFill
        navImageView.clipsToBounds = true
        
        let headerView = ParallaxHeaderView.parallaxThemeHeaderViewWithSubView(navImageView, size: CGSizeMake(self.view.frame.width, 64), image: navImageView.image)
        tableView.tableHeaderView = headerView
        
        ZhihuDailyProvider.request(.Theme(id: id))
            .mapObject(ThemeNewsListModel)
            .subscribeNext { [unowned self] in
                self.sections.value = $0.stories
                self.imageURL.value = NSURL(string: $0.image)!
            }.addDisposableTo(disposeBag)
        
        sections.asObservable().bindTo(tableView.rx_itemsWithCellIdentifier("\(ThemeNewCell.self)", cellType: ThemeNewCell.self)) { (row, element, cell) in
            cell.nameLabel.text = element.title
            if let imageStr = element.images?.first {
                cell.contentImageView.kf_setImageWithURL(NSURL(string: imageStr)!)
                cell.trailingLayoutConstraint.priority = 700
            } else {
                cell.trailingLayoutConstraint.priority = 900
            }
            }.addDisposableTo(disposeBag)
        
        // TODO: UPDATE CODE
        imageURL.asObservable().subscribeNext {
            navImageView.kf_setImageWithURL($0, placeholderImage: nil, optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                headerView.blurViewImage = image
                headerView.refreshBlurViewForNewsImage()
            })
        }.addDisposableTo(disposeBag)
        
        tableView.rx_contentOffset.subscribeNext { [unowned self] in
            headerView.layoutThemeHeaderViewForScrollViewOffset($0)
            if self.tableView.contentOffset.y < -80 {
                self.tableView.contentOffset.y = -80
            }
        }.addDisposableTo(disposeBag)
        
    }

    //设置StatusBar为白色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
