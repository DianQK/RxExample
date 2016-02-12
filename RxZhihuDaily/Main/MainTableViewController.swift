//
//  MainTableViewController.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/11.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Kingfisher

typealias TableSectionModel = AnimatableSectionModel<NSDate, NewsModel>

class MainTableViewController: UITableViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        tableView.delegate = nil
        
        let viewModel = NewsViewModel()
        /// 请求最新的 News
        func requestLatestNews() {
            viewModel.requestLatestNews()
                .subscribe(onNext: { [unowned self] in
                    self.tableView.stopPullRefresh()
                    }, onError: {
                        log.error("\($0)")
                })
                .addDisposableTo(disposeBag)
        }
        /// 请求前一天 News
        func requestBeforeNews() {
            viewModel.requestBeforeNews()
                .subscribe(onNext: { [unowned self] in
                    self.tableView.stopLoadRefresh()
                    }, onError: {
                        log.error("\($0)")
                })
                .addDisposableTo(disposeBag)
        }
        /// 数据源操作
        let dataSource = RxTableViewSectionedReloadDataSource<TableSectionModel>()
        dataSource.configureCell = { (tv, ip, i) in
            let cell = tv.dequeueReusableCellWithIdentifier("\(MainTableViewCell.self)") as! MainTableViewCell
            cell.contentLabel.text = i.value.title
            cell.contentImageView.kf_setImageWithURL(NSURL(string: i.value.images.first ?? "")!)
            return cell
        }
        /// 绑定数据源
        viewModel.sections.asObservable()
            .bindTo(tableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(disposeBag)
        /// 加载一下最新的 News
        requestLatestNews()
        /// 点击事件
        tableView.rx_itemSelected
            .subscribeNext { [weak self] in self?.tableView.deselectRowAtIndexPath($0, animated: true) }
            .addDisposableTo(disposeBag)
        /// 下拉刷新
        tableView.rx_pullRefresh
            .subscribeNext { requestLatestNews() }
            .addDisposableTo(disposeBag)
        /// 上拉加载更多
        tableView.rx_loadRefresh
            .subscribeNext { requestBeforeNews() }
            .addDisposableTo(disposeBag)
        /// 设置 delegate
        tableView.rx_setDelegate(viewModel)
    }
}