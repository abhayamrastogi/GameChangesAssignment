//
//  GithubIssuesRequest.swift
//  GameChangesSDKGithubAPI
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import GameSDKCore

public struct GithubIssuesRequest: APIRequest {

    public typealias APIResourceType = GithubIssuesResource
    
    public var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    public var path: String {
        return "issues"
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var header: RequestHeaders? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    public var parameters: RequestParams {
        return [:]
    }
    
    public init() {} 
}

public class GithubIssuesResource: APIResource {

    public var issues: [[String: Any]]? {
        return self.array
    }
}
