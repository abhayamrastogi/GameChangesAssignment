//
//  GithubIssuesCoordinator.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

final class GithubIssuesCoordinator: Coordinator {
    
    private struct CoordinatorKeys {
        static let githubComment = "githubComment"
    }
    
    // MARK:- Properties
    fileprivate var navigationController: UINavigationController?
    fileprivate var githubIssuesViewController: GithubIssuesViewController?
    
    weak var coordinatorDelegate: GithubIssuesCoordinatorDelegate?

    private var coordinators = [String: Coordinator]()
    
    // MARK:- Initializer
    init(navigationController: UINavigationController?, coordinatorDelegate: GithubIssuesCoordinatorDelegate?){
        self.navigationController = navigationController
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func start() {
        
        guard let githubIssuesViewController: GithubIssuesViewController = GithubIssuesViewController.viewController() else {
            return
        }
        
        let githubIssuesViewModel =  GithubIssuesViewModel(params:  GithubIssuesInitParams(), viewModelCoordinatorDelegate: self)
        githubIssuesViewController.viewModel = githubIssuesViewModel
        navigationController?.setViewControllers([githubIssuesViewController], animated: false)
        
    }
}

// MARK:- GithubIssuesViewModelCoordinatorDelegate
extension GithubIssuesCoordinator:  GithubIssuesViewModelCoordinatorDelegate {
    
    func githubIssuesViewModel(viewModel: GithubIssuesViewModel, presentGithubIssuesCommentWithParams params: GithubIssuesCommentInitParams) {
        
        let githubIssuesCommentCoordinator = GithubIssuesCommentCoordinator(navigationController: navigationController, coordinatorDelegate: self, params: params)
        githubIssuesCommentCoordinator.start()
        coordinators[CoordinatorKeys.githubComment] = githubIssuesCommentCoordinator
    }
    
    
}


// MARK:- GithubIssuesCommentCoordinatorDelegate
extension GithubIssuesCoordinator:  GithubIssuesCommentCoordinatorDelegate {
    
    func githubIssuesCommentCoordinatorDidFinish(coordinator: GithubIssuesCommentCoordinator) {
        coordinators[CoordinatorKeys.githubComment] = nil
    }
    
}
