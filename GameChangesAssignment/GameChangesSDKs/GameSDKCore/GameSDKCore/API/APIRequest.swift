//
//  APIRequest.swift
//  GameSDKCore
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

public typealias RequestParams = [String: Any]
public typealias RequestBody = [String: Any]
public typealias RequestHeaders = [String: String]

public protocol APIRequest {
    
    associatedtype APIResourceType: APIResource
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    
    var parameters: RequestParams { get }
    var header: RequestHeaders? { get }
    
    func asURLRequest() throws -> URLRequest
    
    var encoding: ParameterEncoder { get }
    
    func execute(completion: @escaping ((APIResponse<APIResourceType>) -> Void))
    
}

public extension APIRequest {
    
    var encoding: ParameterEncoder {
        return URLEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = try URLRequest(url: url, method: method, headers: header)
        urlRequest = try encoding.encode(urlRequest: urlRequest, with: parameters)
        return urlRequest
    }
    
    public func execute(completion: @escaping ((APIResponse<APIResourceType>) -> Void)) {
        API.fetch(request: self, completion: completion)
    }
}
