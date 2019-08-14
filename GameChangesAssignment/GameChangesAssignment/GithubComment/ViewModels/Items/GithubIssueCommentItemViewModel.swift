//
//  GithubIssueCommentItemViewModel.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import PersistenceStore

class GithubIssueCommentItemViewModel {
    
    //MARK: - Properties
    private var comment: CDComment!
    
    //MARK: - Computed Property
    var commentLabelText: String{
        return comment.body ?? ""
    }
    
    var authorLabelText:String {
        return (comment.user?.login ?? "").capitalized
    }
    
    //MARK: - Initialization methods
    init(comment: CDComment) {
        self.comment = comment
    }
}
