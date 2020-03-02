//
//  LBCEmptyView.swift
//  LBCTest
//
//  Created by Jeremie Serval on 27/02/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import UIKit

class LBCEmptyView: UIView {
    private var titleLabel: LBCEmptyLabel!
    private var refreshButton: UIButton!
    
    var refreshCompletion: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
        initTitleLabel()
        initRefreshButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    fileprivate func initTitleLabel() {
         titleLabel = LBCEmptyLabel()
         titleLabel.text = NSLocalizedString("LBC.EMPTYLIST.MESSAGE", comment: "")
         addSubview(titleLabel)
         let xConstraint = NSLayoutConstraint(item: titleLabel!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: titleLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 24)

         let yConstraint = NSLayoutConstraint(item: titleLabel!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)

         NSLayoutConstraint.activate([height, xConstraint, yConstraint])
     }
    
    fileprivate func initRefreshButton() {
        refreshButton = UIButton(type: .system)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.setTitle(NSLocalizedString("LBC.EMPTYLIST.REFRESH", comment: ""), for: .normal)
        refreshButton.setTitleColor(.white, for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshAction), for: .touchDown)
        addSubview(refreshButton)

        let width = NSLayoutConstraint(item: refreshButton!, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0)
        let yConstraint = NSLayoutConstraint(item: refreshButton!, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 16)
        let height = NSLayoutConstraint(item: refreshButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 24)
        NSLayoutConstraint.activate([yConstraint, width, height])

    }
    
    @objc private func refreshAction() {
        if let completion = refreshCompletion {
            completion()
        }
    }
    
}
