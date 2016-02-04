//
//  ExampleButtonViewController.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/4.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExampleButtonViewController: UIViewController {
    
    var disposeBag = DisposeBag()

    @IBOutlet weak var buttonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOutlet.rx_tap.subscribeNext {
            print("You clicked button.")
        }.addDisposableTo(disposeBag)
    }

}
