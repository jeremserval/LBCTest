//
//  LBCHomeHeaderView.swift
//  LBCTest
//
//  Created by Jeremie Serval on 26/02/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import UIKit

class LBCHomeHeaderView: UIView {
    
    private var titleLabel: LBCTitleLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .LBCColor
        translatesAutoresizingMaskIntoConstraints = false
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        initTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func initTitleLabel() {
        titleLabel = LBCTitleLabel()
        titleLabel.text = "leboncoin test"
        addSubview(titleLabel)
        let xConstraint = NSLayoutConstraint(item: titleLabel!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)

        let yConstraint = NSLayoutConstraint(item: titleLabel!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 10)

        NSLayoutConstraint.activate([xConstraint, yConstraint])
    }
}
