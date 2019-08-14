//
//  Config.swift
//  GameChangesSDKGithubAPI
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import GameSDKCore

class Config: GameSDKCore.Config {
    
    static var baseURL: String {
        switch env {
        case .development:
            return "https://api.github.com/repos/firebase/firebase-ios-sdk"
        case .stage:
            return "https://api.github.com/repos/firebase/firebase-ios-sdk"
        case .production:
            return "https://api.github.com/repos/firebase/firebase-ios-sdk"
        }
    }
}
