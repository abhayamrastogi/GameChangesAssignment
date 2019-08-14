//
//  API.swift
//  GameSDKCore
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

protocol APIFetcher {
    @discardableResult
    static func fetch<R: APIRequest>(request: R, completion: @escaping ((_ result: APIResponse<R.APIResourceType>) -> Void?))
}

public final class API: APIFetcher {
    
    static func fetch<R>(request: R, completion: @escaping ((APIResponse<R.APIResourceType>) -> Void?)) where R : APIRequest {
        
        do {
            let request = try request.asURLRequest()
            
            let delegate: URLSessionDelegate? = nil
            let configuration = URLSessionConfiguration.ephemeral
            configuration.timeoutIntervalForRequest = 30
            
            let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
            
            let task = session.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    completion(.error(.error(error)))
                    return
                }
                
                guard let data = data else {
                    completion(.error(.noData))
                    return
                }
                
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                completion(.resource(R.APIResourceType(jsonObject!)))
            }
            
            task.resume()
            
        }catch {
            completion(.error(.error(error)))
        }
        
    }
    
    
}
