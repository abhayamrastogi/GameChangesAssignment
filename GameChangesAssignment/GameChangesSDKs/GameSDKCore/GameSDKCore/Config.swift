//
//  Config.swift
//  GameSDKCore
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

open class Config {
    
    public enum Environment {
        case development, stage, production
    }
    
    public static var env: Environment = .development
    
    static var bundle: Bundle {
        return Bundle.init(identifier: "change.games.GameChangesSDKCore")!
    }
}
