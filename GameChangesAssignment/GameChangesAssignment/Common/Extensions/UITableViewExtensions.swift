//
//  UITableViewExtensions.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerNib(_ identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(withIdentifier identifier: String, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
    
}
