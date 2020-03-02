//
//  LBCAPIManager.swift
//  LBCTest
//
//  Created by Jeremie Serval on 26/02/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import Foundation

class LBCAPIManager: NSObject {
    
    var categories: LBCCategories?
    var items: Array<LBCItem>?
    
    override init() {
        super.init()
        fetchCategories()
        fetchAds(forceRefresh: true) { (items) in
        }
    }
    
    func fetchAds(forceRefresh: Bool, completion: @escaping ((Array<LBCItem>) -> Void)) {

        if (!forceRefresh) {
            if let  items = items {
                completion(items)
                return
            }
        }
        
        if let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") {
           URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
              if let data = data {
                  do {
                    let res: Array<LBCItem> = try JSONDecoder().decode(Array<LBCItem>.self, from: data)
                    self?.items = res
                    completion(res)
                  } catch let error {
                     LBCErrorManager.presentError(title: "LBC Test", message: error.localizedDescription) {
                         
                     }
                  }
               }
           }.resume()
        }
    }
    
    
    func fetchCategories() {
        
        if let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json") {
           URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
              if let data = data {
                  do {
                    let res: LBCCategories = .init(items: try JSONDecoder().decode(Array<LBCCategory>.self, from: data))
                    self?.categories = res
                  } catch let error {
                    LBCErrorManager.presentError(title: "LBC Test", message: error.localizedDescription) {
                        
                    }
                  }
               }
           }.resume()
        }
    }
}
