//
//  GithubIssueCommentsRequest.swift
//  GameChangesSDKGithubAPI
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import GameSDKCore

public struct GithubIssueCommentsRequest: APIRequest {
    
    public typealias APIResourceType = GithubIssueCommentResource
    
    public var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    public var path: String {
        return "issues/\(issueNo)/comments"
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
    
    var issueNo: Int
    
    public init(issueNo: Int) {
        self.issueNo = issueNo
    }
}

public class GithubIssueCommentResource: APIResource {
    
    public var issues: [[String: Any]]? {
        return self.array
    }
}
