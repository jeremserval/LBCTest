//
//  LBCViewController.swift
//  LBCTest
//
//  Created by Jeremie Serval on 02/03/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import UIKit

class LBCViewController: UIViewController {

    var headerView: LBCHomeHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initHeaderView()
    }
    
    func initHeaderView() {
        headerView = LBCHomeHeaderView()
        view.addSubview(headerView)
        var allConstraints: [NSLayoutConstraint] = []

        let iconVerticalConstraints = NSLayoutConstraint.constraints(
          withVisualFormat: "V:|[headerView(64)]",
          metrics: nil,
          views:["headerView" : headerView!])
        allConstraints += iconVerticalConstraints

        let iconHorizontalConstraints = NSLayoutConstraint.constraints(
          withVisualFormat: "H:|[headerView]|",
          metrics: nil,
          views:["headerView" : headerView!])
        allConstraints += iconHorizontalConstraints
        
        view.addConstraints(allConstraints)
    }

}
