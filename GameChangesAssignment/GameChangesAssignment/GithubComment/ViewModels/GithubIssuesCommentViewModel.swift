//
//  GithubIssuesCommentViewModel.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import PersistenceStore
import CoreData

struct GithubIssuesCommentInitParams {
    var issueNo: Int64
}

class GithubIssuesCommentViewModel {
    
    // MARK: Properties
    weak var delegate: GithubIssuesCommentViewModelDelegate?
    weak var viewModelCoordinatorDelegate: GithubIssuesCommentViewModelCoordinatorDelegate?
    
    var issueNo: Int64
    lazy var context: NSManagedObjectContext = {
        return CoreDataStack.sharedInstance.newChildManagedObjectContext(ofContext: CoreDataStack.getSharedMOC())
    }()
    
    //MARK:- Computed Properties
    var navBarTitle: String {
        return "Firebase Comments"
    }
    
    var githubIssueCommentItemViewModels = [GithubIssueCommentItemViewModel]()
    
    // MARK:- Initializer
    required init(params: GithubIssuesCommentInitParams, viewModelCoordinatorDelegate: GithubIssuesCommentViewModelCoordinatorDelegate?) {
        self.issueNo = params.issueNo
        self.viewModelCoordinatorDelegate = viewModelCoordinatorDelegate
    }
    
    func populateIssuesCommentItemViewModels(fromJSON commentsJSON: [[String: Any]]) {
        githubIssueCommentItemViewModels.removeAll()
        
        for itemJSON in commentsJSON{
            if let comment = CDComment.instanceForData(withJSON: itemJSON, context: context) {
                let itemViewModel = GithubIssueCommentItemViewModel(comment: comment)
                githubIssueCommentItemViewModels.append(itemViewModel)
            }
        }
        
    }
}

// MARK: TableView populate methods
extension GithubIssuesCommentViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows(atSection section: Int) -> Int{
        return githubIssueCommentItemViewModels.count
    }
    
    func githubIssueCommentItemViewModel(atIndexPath indexPath: IndexPath) -> GithubIssueCommentItemViewModel {
        return githubIssueCommentItemViewModels[indexPath.row]
    }
    
}
