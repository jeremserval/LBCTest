//
//  LBCError.swift
//  LBCTest
//
//  Created by Jeremie Serval on 26/02/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import Foundation
import UIKit

struct LBCErrorManager {
    
    static func presentError(title: String, message: String, completion : @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(.init(title: NSLocalizedString("LBC.OK", comment: ""), style: .cancel, handler: nil))
        AppDelegate.shared.window?.rootViewController?.navigationController?.show(alert, sender: nil)
    }
}
