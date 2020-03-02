//
//  Category.swift
//  LBCTest
//
//  Created by Jeremie Serval on 26/02/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import UIKit

struct LBCCategory: Decodable {
    var id: Int
    var name: String
}

struct LBCCategories: Decodable {
    var items: Array<LBCCategory>
}
