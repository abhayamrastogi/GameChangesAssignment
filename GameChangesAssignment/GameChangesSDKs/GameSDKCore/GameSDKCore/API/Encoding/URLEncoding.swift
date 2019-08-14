//
//  URLEncoding.swift
//  GameSDKCore
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

public struct URLEncoding: ParameterEncoder {
    
    public static var `default`: URLEncoding { return URLEncoding() }
    
    enum Destination {
        /// Applies encoded query string result to existing query string for `GET`, `HEAD` and `DELETE` requests and
        /// sets as the HTTP body for requests with any other HTTP method.
        case methodDependent
        /// Sets or appends encoded query string result to existing query string.
        case queryString
        /// Sets encoded query string result as the HTTP body of the URL request.
        case httpBody
        
        func encodesParametersInURL(for method: HTTPMethod) -> Bool {
            switch self {
            case .methodDependent: return [HTTPMethod.get, HTTPMethod.head, HTTPMethod.delete].contains(method)
            case .queryString:     return true
            case .httpBody:        return false
            }
        }
    }
    
    let destination: Destination = .methodDependent
    
    public func encode(urlRequest: URLRequestConvertible, with parameters: RequestParams)  throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let url = urlRequest.url else {
            throw APIError.parameterEncodingFailed(reason: .missingURL)
        }
        
        if let method = urlRequest.method, destination.encodesParametersInURL(for: method) {
            
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery ?? "") + query(parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlRequest.url = urlComponents.url
            }
        }else {
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = Data(query(parameters).utf8)
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters:.urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return urlRequest
    }
    
    private func queryComponent(fromKey key: String, value: Any) -> [(String, String)]{
        var components = [(String, String)]()
        
        if let dic = value as? [String: Any] {
            for (nestedKey, value) in dic {
                components += queryComponent(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        }else {
            components.append((key, "\(value)"))
        }
        
        return components
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        var components = [(String, String)]()
        
        for key in parameters.keys.sorted(by: <) {
            if let value = parameters[key] {
                components += queryComponent(fromKey: key, value: value)
            }
        }
        
        return components.map{ "\($0)=\($1)"}.joined(separator: "&")
    }
    
}
