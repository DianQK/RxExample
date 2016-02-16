//
//  CircleCollectionViewCell.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/13.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit
import SnapKit

class CircleCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView
    let titleLabel: UILabel
    private let _maskView = UIImageView(image: UIImage(named: "Home_Image_Mask_Plus"))
    
    override init(frame: CGRect) {
        imageView = UIImageView(frame: frame)
        imageView.contentMode = .Bottom
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel = UILabel()
        titleLabel.textColor = Config.Color.white
        titleLabel.numberOfLines = 0
        titleLabel.preferredMaxLayoutWidth = frame.width - 30
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        _maskView.clipsToBounds = true
        _maskView.contentMode = .Bottom
        _maskView.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(_maskView)
        addSubview(titleLabel)

        imageView.snp_makeConstraints { [unowned self] make in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        titleLabel.snp_makeConstraints { [unowned self] make in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self).offset(-20)
        }
        
        _maskView.snp_makeConstraints { [unowned self] make in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}