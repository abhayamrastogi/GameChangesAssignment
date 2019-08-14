//
//  GithubIssuesCommentCoordinator.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

final class GithubIssuesCommentCoordinator: Coordinator {
    
    // MARK:- Properties
    fileprivate var navigationController: UINavigationController?
    fileprivate var githubIssuesCommentViewController: GithubIssuesCommentViewController?
    fileprivate var githubIssuesCommentInitParams: GithubIssuesCommentInitParams
    weak var coordinatorDelegate: GithubIssuesCommentCoordinatorDelegate?
    
    // MARK:- Initializer
    init(navigationController: UINavigationController?, coordinatorDelegate: GithubIssuesCommentCoordinatorDelegate?, params: GithubIssuesCommentInitParams){
        self.navigationController = navigationController
        self.coordinatorDelegate = coordinatorDelegate
        self.githubIssuesCommentInitParams = params
    }
    
    func start() {
        
        guard let githubIssuesViewController: GithubIssuesCommentViewController = GithubIssuesCommentViewController.viewController() else {
            return
        }
        
        let githubIssuesCommentViewModel =  GithubIssuesCommentViewModel(params: githubIssuesCommentInitParams, viewModelCoordinatorDelegate: self)
        githubIssuesViewController.viewModel = githubIssuesCommentViewModel
        navigationController?.pushViewController(githubIssuesViewController, animated: true)
        
    }
}

// MARK:- GithubIssuesCommentViewModelCoordinatorDelegate
extension GithubIssuesCommentCoordinator:  GithubIssuesCommentViewModelCoordinatorDelegate {
    
}


