//
//  SideViewController.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/15.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class SideViewController: UIViewController {
    
    @IBOutlet weak var sideTableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    let sections = Variable([ThemeModel]())

    override func viewDidLoad() {
        super.viewDidLoad()

        ZhihuDailyProvider.request(.ThemesList)
            .mapObject(ThemesListModel)
            .map { $0.others }
            .subscribeNext { [unowned self] in
                log.info("\($0)")
                self.sections.value = $0
            }.addDisposableTo(disposeBag)
        
        sections.asObservable()
            .bindTo(sideTableView.rx_itemsWithCellIdentifier("\(SideTableViewCell.self)", cellType: SideTableViewCell.self)) { (row, element, cell) in
            cell.nameLabel.text = element.name
            }.addDisposableTo(disposeBag)
        
        sideTableView.rx_itemSelected.subscribeNext {
            log.info("\(self.sideTableView.cellForRowAtIndexPath($0)?.selectedBackgroundView?.backgroundColor)")
        }
    }
    
    //设置StatusBar为白色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
