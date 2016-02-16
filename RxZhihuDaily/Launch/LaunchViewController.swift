//
//  LaunchViewController.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/12.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import TransitionTreasury

class LaunchViewController: UIViewController {

    @IBOutlet weak var launchImageView: UIImageView!
    
    var tr_delegate: ModalViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let launchImageURL = NSUserDefaults.standardUserDefaults().URLForKey(Config.Launch.launchImageKey)
        launchImageView.kf_setImageWithURL(launchImageURL ?? NSURL())
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Config.Launch.launchTime * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.tr_delegate?.modalViewControllerDismiss(callbackData: nil)
        }
    }
    
    //设置StatusBar为白色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}