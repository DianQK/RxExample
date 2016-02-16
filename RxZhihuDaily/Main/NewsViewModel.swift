//
//  NewsViewModel.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/12.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftDate
import Kingfisher
import SnapKit

class NewsViewModel: NSObject, UIScrollViewDelegate {
    let beforeDate = Variable(NSDate.today())
    let sections = Variable([TableSectionModel]())
    let hotNews = Variable([TopNewsModel]())
    /// 请求最新的 News
    func requestLatestNews() -> Observable<Void> {
        sections.value.removeAll()
        hotNews.value.removeAll()
        return ZhihuDailyProvider.request(.NewsLatest)
            .mapObject(NewsListModel)
            .map {
                self.hotNews.value = $0.top_stories
                self.beforeDate.value = $0.date.toDate(DateFormat.Custom("yyyyMMdd"))!
                self.sections.value.append(TableSectionModel(model: self.beforeDate.value, items: $0.stories))
            }
    }
    /// 请求前一天的 News
    func requestBeforeNews() -> Observable<Void> {
        return ZhihuDailyProvider.request(.NewsBefore(date: beforeDate.value))
            .mapObject(NewsListModel)
            .map { ($0.date, $0.stories) }
            .map {
                self.beforeDate.value = $0.toDate(DateFormat.Custom("yyyyMMdd"))!
                self.sections.value.append(TableSectionModel(model: self.beforeDate.value, items: $1))
            }
    }
    /// Header 样式
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.sectionHeaderHeight))
        label.backgroundColor = Config.Color.blue
        label.text = sections.value[section].model.zhihuDate
        label.textColor = Config.Color.white
        label.textAlignment = .Center
        return label
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 38
    }
    /// 无限轮播，等待修改，并封装到 View 中，很乱的样子， == 头昏中
    func circleViewfor(tableView: UITableView, disposeBag: DisposeBag) -> CircleView {
        let circleView = CircleView(frame: CGRect(origin: CGPointZero, size: CGSize(width: tableView.frame.size.width, height: 200)), disposeBag: disposeBag)
        circleView.collectionView.registerClass(CircleCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        tableView.tableHeaderView = circleView
        
        /**
        * https://autolayout.club/2015/10/29/自己动手造无限循环图片轮播/
        * 当然，我们可以将这些封装到 circleView 中
        */
        circleView.collectionView.rx_contentOffset
            .subscribeNext { [unowned circleView, unowned self] in
            if $0.x == 0 {
                circleView.collectionView.contentOffset.x = circleView.collectionView.frame.size.width * CGFloat(self.hotNews.value.count)
            } else if $0.x == circleView.collectionView.frame.size.width * CGFloat(self.hotNews.value.count + 1) {
                circleView.collectionView.contentOffset.x = circleView.collectionView.frame.size.width
            }
            circleView.currentPage = Int(circleView.collectionView.contentOffset.x / circleView.collectionView.frame.size.width - 0.5)
            }.addDisposableTo(disposeBag)
        /// 获得数据后更新 number
        self.hotNews.asObservable()
            .subscribeNext {
                circleView.pageControl.numberOfPages = $0.count
                circleView.collectionView.contentOffset.x = circleView.frame.size.width * CGFloat(circleView.currentPage + 1)
            }.addDisposableTo(disposeBag)
        /// 数据绑定
        self.hotNews.asObservable() /// 这里其实可以进行一下封装
            .filter { $0.count > 0 } /// 过滤没有数据的情况
            .map { [$0.last!] + $0 + [$0.first!] } /// 添加头尾信息
            .bindTo(circleView.collectionView.rx_itemsWithCellIdentifier("Cell", cellType: CircleCollectionViewCell.self)) { (row, element, cell) in
                cell.imageView.kf_setImageWithURL(NSURL(string: element.image)!)
                cell.titleLabel.text = element.title
            }.addDisposableTo(disposeBag)
        /// 自动轮播处理
//        self.hotNews.asObservable().filter { $0.count > 0 }.take(1).subscribeNext { _ in
//            Observable<Int>.interval(4, scheduler: MainScheduler.instance)
//                .map { [unowned self] in $0 % self.hotNews.value.count }
//                .subscribeNext { /// 从 2 -> last
//                    circleView.collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: $0 + 2, inSection: 0), atScrollPosition: .None, animated: true)
//                }
//                .addDisposableTo(disposeBag)
//        }.addDisposableTo(disposeBag)
        return circleView
    }

}