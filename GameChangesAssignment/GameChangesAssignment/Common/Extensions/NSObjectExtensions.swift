//
//  NSObjectExtensions.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

extension NSObject {
    
    public class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
}
