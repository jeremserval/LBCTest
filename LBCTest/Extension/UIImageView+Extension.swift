//
//  UIImageView+Extension.swift
//  LBCTest
//
//  Created by Jeremie Serval on 26/02/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    func load(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

