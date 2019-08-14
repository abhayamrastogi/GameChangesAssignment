//
//  GithubIssuesViewModel+Request.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 14/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import GameChangesSDKGithubAPI
import PersistenceStore

extension GithubIssuesViewModel {
    
    func fetchIssues() {
        
        guard !is24HoursPassed else {
            
            fetchIssuesFromDB()
            self.delegate?.githubIssuesViewModel(viewModel: self, fetchedIssues: self.githubIssueItemViewModels)
            return
            
        }
        
        let request = GithubIssuesRequest()
        
        request.execute { [weak self] (response) -> Void in
            
            guard let _WeakSelf = self else { return  }
            
            switch response {
            case .resource(let resource):
                
                if let issuesJSON = resource.array {
                    
                    _WeakSelf.deleteAllIssues()
                    
                    for issueJSON in issuesJSON {
                        let _ = CDGitIssue.instanceForData(withJSON: issueJSON, context: _WeakSelf.cdContext)
                    }
                }
                
                UserDefaultsUtil.setDate(Date(), key: .date)
                _WeakSelf.fetchIssuesFromDB()
                _WeakSelf.delegate?.githubIssuesViewModel(viewModel: _WeakSelf, fetchedIssues: _WeakSelf.githubIssueItemViewModels)

                break
                
            case .error(let error):
                _WeakSelf.delegate?.githubIssuesViewModel(viewModel: _WeakSelf, failedToFetchIssuesWithError: error)
                break
            }
        }
    }
    
     func deleteAllIssues() {
        CDGitIssue.deleteAll(context: cdContext)
    }
    
    func fetchIssuesFromDB() {
        let sort = NSSortDescriptor(key: "updatedAt", ascending: false)

        if let gitIssues = CDGitIssue.all(orderedBy: [sort], in: cdContext) as? [CDGitIssue] {
            self.gitIssues = gitIssues
        }
        
    }

}
