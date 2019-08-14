//
//  APIResponse.swift
//  GameSDKCore
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

public enum APIResponse<T: APIResource> {
    case resource(T)
    case error(APIError)
}

