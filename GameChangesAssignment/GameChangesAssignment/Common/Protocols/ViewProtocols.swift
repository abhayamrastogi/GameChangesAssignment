//
//  ViewProtocols.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

protocol ViewFromNib {}

extension ViewFromNib {
    
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static func view() -> Self? {
        let objects = self.nib.instantiate(withOwner: nil, options: nil)
        return objects.first as? Self
    }
    
    static func viewController<T: UIViewController>() -> T? {
        return T(nibName: nibName, bundle: nil)
    }
}
