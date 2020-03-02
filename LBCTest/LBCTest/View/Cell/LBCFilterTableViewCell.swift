//
//  LBCFilterTableViewCell.swift
//  LBCTest
//
//  Created by Jeremie Serval on 02/03/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import UIKit

class LBCFilterTableViewCell: UITableViewCell {
    
     var state: Bool = false
    
    override func prepareForReuse() {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        state = false
    }

    func updateState() {
        state = !state

        if state == true {
            backgroundColor = .LBCColor
        } else {
            backgroundColor = .white
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
