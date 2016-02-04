//
//  RootTableViewController.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/2.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

private let reuseIdentifier = "Cell"
/// 这里建立 Section 的 Model
typealias TableSectionModel = AnimatableSectionModel<String, TableViewCellModel>

class ExampleTableViewController: UITableViewController {
    
    var disposeBag = DisposeBag()
    /// 保存所有的 Section
    var sections = Variable([TableSectionModel]())
    
    static let initialValue: [TableViewCellModel] = [
        TableViewCellModel(tool: "file", cost: "12"),
        TableViewCellModel(tool: "miter", cost: "22"),
        TableViewCellModel(tool: "nail", cost: "2"),
        TableViewCellModel(tool: "brad", cost: "5"),
        TableViewCellModel(tool: "ruler", cost: "14")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        /**
        使用 Rx 必须将其 dataSource 和 delegate 设置为 nil
        */
        tableView.dataSource = nil
        tableView.delegate = nil
        /**
        添加数据
        */
        sections.value.append(TableSectionModel(model: "", items: ExampleTableViewController.initialValue))
        
        /// 生成一个可以用给 tableView 用的数据
        let tvAnimatedDataSource = RxTableViewSectionedAnimatedDataSource<TableSectionModel>()
        skinTableViewDataSource(tvAnimatedDataSource)
        /**
        数据绑定到 tableView
        */
        sections.asObservable()
            .bindTo(tableView.rx_itemsAnimatedWithDataSource(tvAnimatedDataSource))
            .addDisposableTo(disposeBag)
        
        tableView.rx_itemSelected
            .subscribeNext { [weak self] i in
                print("You clicked \(i).")
                self?.tableView.deselectRowAtIndexPath(i, animated: true)
            }
            .addDisposableTo(disposeBag)
    }
    
    /**
     处理 dataSource
     */
    func skinTableViewDataSource(dataSource: RxTableViewSectionedDataSource<TableSectionModel>) {
        dataSource.configureCell = { (tv, ip, i) in
            let cell = tv.dequeueReusableCellWithIdentifier("Cell") as! ExampleTableViewCell
            
            cell.toolLabelOutlet.text = i.value.tool
            cell.costLabelOutlet.text = i.value.cost
            
            return cell
        }
        
//        dataSource.titleForHeaderInSection = { [unowned dataSource] (section: Int) -> String in
//            return dataSource.sectionAtIndex(section).model
//        }
    }
}
