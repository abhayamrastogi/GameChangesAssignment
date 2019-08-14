//
//  GithubIssuesViewModel.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import GameChangesSDKGithubAPI
import PersistenceStore
import CoreData

struct GithubIssuesInitParams {
}

class GithubIssuesViewModel {

    // MARK: Properties
    weak var delegate: GithubIssuesViewModelDelegate?
    weak var viewModelCoordinatorDelegate: GithubIssuesViewModelCoordinatorDelegate?
    
    lazy var cdContext: NSManagedObjectContext = {
        return CoreDataStack.sharedInstance.newChildManagedObjectContext(ofContext: CoreDataStack.getSharedMOC())
    }()
    
    var is24HoursPassed: Bool {
        guard let date = UserDefaultsUtil.getDate(.date),
        let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour,
        diff > 24 else { return false }
        return true
    }
    
    var gitIssues = [CDGitIssue]()
    
    //MARK:- Computed Properties
    var navBarTitle: String {
        return "Firebase Issues"
    }
    
    var githubIssueItemViewModels = [GithubIssueItemViewModel]()

    // MARK:- Initializer
    required init(params: GithubIssuesInitParams, viewModelCoordinatorDelegate: GithubIssuesViewModelCoordinatorDelegate?) {
        self.viewModelCoordinatorDelegate = viewModelCoordinatorDelegate
    }
    
    func populateIssuesItemViewModels() {
        githubIssueItemViewModels.removeAll()
        
        for gitIssue in gitIssues{
                let itemViewModel = GithubIssueItemViewModel(issue: gitIssue)
                githubIssueItemViewModels.append(itemViewModel)
        }
        
    }
    
    // MARK: - Actions
    func tableViewDidSelect(atIndexPath indexPath: IndexPath) {
        let itemViewModel =  githubIssueItemViewModels[indexPath.row]
        
        if itemViewModel.isCommentsAvailable {
            let issueNo = itemViewModel.issue.number
            
            let githubIssuesCommentInitParams = GithubIssuesCommentInitParams(issueNo: issueNo)
            viewModelCoordinatorDelegate?.githubIssuesViewModel(viewModel: self, presentGithubIssuesCommentWithParams: githubIssuesCommentInitParams)
        }
      
    }
    
    func saveContext(){
        CoreDataStack.saveSyncMOC(cdContext, cascadeSave: true)
    }
}

// MARK: TableView populate methods
extension GithubIssuesViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows(atSection section: Int) -> Int{
        return githubIssueItemViewModels.count
    }
    
    func githubIssueItemViewModel(atIndexPath indexPath: IndexPath) -> GithubIssueItemViewModel {
        return githubIssueItemViewModels[indexPath.row]
    }
    
}

