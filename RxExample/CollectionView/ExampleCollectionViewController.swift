//
//  ExampleCollectionViewController.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/4.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

private let reuseIdentifier = "Cell"
/// 这里建立 Section 的 Model
typealias CollectionSectionModel = AnimatableSectionModel<String, CollectionCellModel>

class ExampleCollectionViewController: UICollectionViewController {
    
    var disposeBag = DisposeBag()
    /// 保存所有的 Section
    var sections = Variable([CollectionSectionModel]())
    
    static let initialValue: [CollectionCellModel] = [
        CollectionCellModel(name: "K111", age: 11),
        CollectionCellModel(name: "K222", age: 22),
        CollectionCellModel(name: "K333", age: 33),
        CollectionCellModel(name: "K444", age: 44),
        CollectionCellModel(name: "K555", age: 55)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
        使用 Rx 必须将其 dataSource 和 delegate 设置为 nil
        */
        collectionView?.dataSource = nil
        collectionView?.delegate = nil
        /**
        添加数据
        */
        sections.value.append(CollectionSectionModel(model: "", items: ExampleCollectionViewController.initialValue))
        
        /// 生成一个可以用给 collectionView 用的数据
        let cvAnimatedDataSource = RxCollectionViewSectionedAnimatedDataSource<CollectionSectionModel>()
        skinCollectionViewDataSource(cvAnimatedDataSource)
        /**
        数据绑定到 collectionView
        */
        sections.asObservable()
            .bindTo(collectionView!.rx_itemsAnimatedWithDataSource(cvAnimatedDataSource))
            .addDisposableTo(disposeBag)
        /**
        *  处理 cell 点击事件
        */
        collectionView?.rx_itemSelected.subscribeNext({ i in
            print("You clicked \(i).")
        }).addDisposableTo(disposeBag)
    }
    
    /**
     处理 dataSource
     */
    func skinCollectionViewDataSource(dataSource: RxCollectionViewSectionedAnimatedDataSource<CollectionSectionModel>) {
        /**
        *  这里生成 Cell，cv 是 colletionView，ip 是 indexPath，i 是之前的 Model，需要用 value 获取
        */
        dataSource.cellFactory = { (cv, ip, i) in
            let cell = cv.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: ip) as! ExampleCollectionViewCell
            cell.nameLabelOutlet.text = i.value.name
            cell.ageLabelOutlet.text = String(i.value.age)
            return cell
        }
        
//        dataSource.supplementaryViewFactory = { (cv, kind, ip) in
//            let section = cv.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Section", forIndexPath: ip)
//            return section
//        }
    }

}
