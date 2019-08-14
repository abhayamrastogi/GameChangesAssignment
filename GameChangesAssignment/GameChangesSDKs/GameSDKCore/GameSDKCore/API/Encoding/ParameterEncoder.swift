//
//  ParameterEncoder.swift
//  GameSDKCore
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

public protocol ParameterEncoder {
    func encode(urlRequest: URLRequestConvertible, with parameters: RequestParams) throws -> URLRequest
}
