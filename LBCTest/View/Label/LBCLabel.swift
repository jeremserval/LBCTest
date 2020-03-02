//
//  LBCLabel.swift
//  LBCTest
//
//  Created by Jeremie Serval on 27/02/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import UIKit

class LBCTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        font = UIFont(name: "Raleway-Black", size: 24)
        textAlignment = .center
        textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        sizeToFit()
    }
}

class LBCEmptyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        font = UIFont(name: "Raleway-Black", size: 18)
        textAlignment = .center
        textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        sizeToFit()
    }
}
