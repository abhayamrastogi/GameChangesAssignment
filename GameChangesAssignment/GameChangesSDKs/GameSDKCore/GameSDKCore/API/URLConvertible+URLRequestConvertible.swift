//
//  URLConvertible+URLRequestConvertible.swift
//  GameSDKCore
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

public protocol URLConvertible {
    func asURL() throws -> URL
}

extension URL: URLConvertible {
    public func asURL() throws -> URL {
        return self
    }
}

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

extension URLRequest: URLRequestConvertible {
    public func asURLRequest() throws -> URLRequest {
        return self
    }
}

extension URLRequest {
    
    init(url: URLConvertible, method: HTTPMethod, headers: RequestHeaders? = nil) throws {
        let url = try url.asURL()
        
        self.init(url: url)
        
        self.httpMethod = method.rawValue
        allHTTPHeaderFields = headers
    }
}
