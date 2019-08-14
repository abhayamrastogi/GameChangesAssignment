//
//  URLRequest+APIRequest.swift
//  GameSDKCore
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

extension URLRequest {
    
    var method: HTTPMethod? {
        get { return httpMethod.flatMap(HTTPMethod.init) }
        set { httpMethod = newValue?.rawValue }
    }
}
