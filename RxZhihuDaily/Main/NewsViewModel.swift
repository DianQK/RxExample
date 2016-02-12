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

class NewsViewModel: NSObject, UIScrollViewDelegate {
    let beforeDate = Variable(NSDate.today())
    let sections = Variable([TableSectionModel]())
    /// 请求最新的 News
    func requestLatestNews() -> Observable<Void> {
        sections.value.removeAll()
        return ZhihuDailyProvider.request(.NewsLatest)
            .mapObject(NewsListModel)
            .map { ($0.date, $0.stories) }
            .map {
                self.beforeDate.value = $0.toDate(DateFormat.Custom("yyyyMMdd"))!
                self.sections.value.append(TableSectionModel(model: self.beforeDate.value, items: $1))
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
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.sectionHeaderHeight))
        label.backgroundColor = Config.Color.blue
        label.text = sections.value[section].model.zhihuDate
        label.textColor = Config.Color.white
        label.textAlignment = .Center
        return label
    }

}