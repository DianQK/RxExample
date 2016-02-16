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
import SWRevealViewController

class SideViewController: UIViewController {
    
    @IBOutlet weak var sideTableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    let sections = Variable([ThemeModel]())
    
    static let mainTheme: ThemeModel = {
        var theme = ThemeModel()
        theme.color = 0
        theme.description = "今日热闻"
        theme.id = 0
        theme.name = "首页"
        theme.thumbnail = ""
        return theme
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ZhihuDailyProvider.request(.ThemesList)
            .mapObject(ThemesListModel)
            .map { $0.others }
            .subscribeNext { [unowned self] in
                log.info("\($0)")
                self.sections.value = $0
            }.addDisposableTo(disposeBag)
        
        sections.asObservable().map { [SideViewController.mainTheme] + $0 }
            .bindTo(sideTableView.rx_itemsWithCellIdentifier("\(SideTableViewCell.self)", cellType: SideTableViewCell.self)) { (row, element, cell) in
            cell.nameLabel.text = element.name
            }.addDisposableTo(disposeBag)
        
        sideTableView.rx_itemSelected
            .filter { $0.row == 0 }
            .map { _ in }
            .subscribeNext { [unowned self] in
                let revealViewController = self.revealViewController()
                revealViewController.setFrontViewPosition(.Left, animated: true)
                revealViewController.pushFrontViewController(revealViewController.frontViewController, animated: true)
        }.addDisposableTo(disposeBag)
        
        sideTableView.rx_itemSelected
            .filter { $0.row > 0 }
            .map { [unowned self] in (self.sections.value[$0.row - 1].id, self.sections.value[$0.row - 1].name) }
            .subscribeNext { [unowned self] in
                let themeVC = UIStoryboard(name: .Theme).instantiateViewControllerWithClass(ThemeViewController)
                themeVC.id = $0
                themeVC.title = $1
                let nav = UINavigationController(rootViewController: themeVC)
                let revealViewController = self.revealViewController()
                revealViewController.setFrontViewPosition(.Left, animated: true)
                revealViewController.pushFrontViewController(nav, animated: true)
        }.addDisposableTo(disposeBag)

    }
    
    //设置StatusBar为白色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
