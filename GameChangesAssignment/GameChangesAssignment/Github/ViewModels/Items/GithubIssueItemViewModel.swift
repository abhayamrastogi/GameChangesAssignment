//
//  GithubIssueItemViewModel.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import PersistenceStore

class GithubIssueItemViewModel {
    
    //MARK: - Properties
    var issue: CDGitIssue!
    
    //MARK: - Computed Properties
    var titleLabelText : String {
        return issue.title ?? ""
    }
    
    var updatedAtLabelText: String {
        return issue.updatedAt ?? ""
    }
    
    var isCommentsAvailable: Bool {
        if issue.comments > 0 {
            return true
        }
        return false
    }
    
    var showDisclosueIndicator: Bool {
        return isCommentsAvailable
    }
    
    //MARK: - Initialization methods
    init(issue: CDGitIssue) {
        self.issue = issue
    }
}
