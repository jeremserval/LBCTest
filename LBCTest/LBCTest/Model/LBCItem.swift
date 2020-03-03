//
//  Item.swift
//  LBCTest
//
//  Created by Jeremie Serval on 26/02/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import Foundation

struct LBCItem: Codable {
    var id: Int
    var category_id: Int
    var title: String
    var description: String
    var price: Int
    var images_url: [String: String]
    var creation_date: String
    var is_urgent: Bool
    var siret: String?
    var is_seen: Bool? = false
    
    func priceString() -> String{
        return "\(price) €"
    }
    
    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFinalFormatter = DateFormatter()
        dateFinalFormatter.dateFormat = "dd MMMM yyyy HH:mm"
        if let date = dateFormatter.date(from: creation_date) {
            return dateFinalFormatter.string(from: date)
        } else { return "" }
         
    }
}
