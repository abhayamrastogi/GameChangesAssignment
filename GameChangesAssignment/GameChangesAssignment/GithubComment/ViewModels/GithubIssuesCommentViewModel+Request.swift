//
//  GithubIssueCommentViewModel+Request.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 15/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import GameChangesSDKGithubAPI

extension GithubIssuesCommentViewModel {
    
    func fetchComments() {
        
        let request = GithubIssueCommentsRequest(issueNo: Int(issueNo))
        
        request.execute { [weak self] (response) -> Void in
            guard let _WeakSelf = self else { return  }
            
            switch response {
            case .resource(let resource):
                
                if let commentsJSON = resource.array {
                    _WeakSelf.populateIssuesCommentItemViewModels(fromJSON: commentsJSON)
                }
                _WeakSelf.delegate?.githubIssuesCommentViewModel(viewModel: _WeakSelf, fetchedIssueComments: _WeakSelf.githubIssueCommentItemViewModels)
                break
                
            case .error(let error):
                _WeakSelf.delegate?.githubIssuesCommentViewModel(viewModel: _WeakSelf, failedToFetchIssueCommentsWithError: error)
                break
            }
        }
        
        
    }
}
