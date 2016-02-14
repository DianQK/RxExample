//
//  MainTableViewController.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/11.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import Kingfisher
import TransitionTreasury

typealias TableSectionModel = AnimatableSectionModel<NSDate, NewsModel>

class MainTableViewController: UITableViewController, ModalTransitionDelegate {
    
    var disposeBag = DisposeBag()
    
    var tr_presentTransition: TRViewControllerTransitionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        tableView.delegate = nil
        /// 启动动画
        let launchVC = UIStoryboard(name: .Launch).instantiateViewControllerWithClass(LaunchViewController)
        launchVC.tr_delegate = self
        launchVC.view.subviews
        tr_presentViewController(launchVC, method: ZhihuTransition.Launch(zoom: launchVC.launchImageView))
        let viewModel = NewsViewModel()
        /// 请求最新的 News
        func requestLatestNews() {
            viewModel.requestLatestNews()
                .subscribe(onNext: { [unowned self] in
                    requestListNews() /// 这里再加载一下前几天的 News
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
        /// 请求前几天的 News
        func requestListNews(number: Int = Config.loadMoreNumber) {
            viewModel.beforeDate.asObservable().take(number)
                .subscribeNext { _ in
                    requestBeforeNews()
                }.addDisposableTo(disposeBag)
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
            .subscribeNext { requestListNews() }
            .addDisposableTo(disposeBag)
        /// 设置 delegate ，这里是为了设置 viewForHeaderInSection
        tableView.rx_setDelegate(viewModel)
        /// 添加轮播视图
        tableView.tableHeaderView = viewModel.circleViewfor(tableView, disposeBag: disposeBag)
        /// 轮播的点击事件
        (tableView.tableHeaderView as! CircleView).collectionView.rx_itemSelected
            .subscribeNext {
            log.info("\($0)")
        }.addDisposableTo(disposeBag)
    }
}