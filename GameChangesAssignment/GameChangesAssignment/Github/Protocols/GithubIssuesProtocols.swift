//
//  GithubIssuesProtocols.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

protocol GithubIssuesViewModelDelegate: class {
    
    func githubIssuesViewModel(viewModel: GithubIssuesViewModel, fetchedIssues issues: [GithubIssueItemViewModel])
    func githubIssuesViewModel(viewModel: GithubIssuesViewModel, failedToFetchIssuesWithError error: Error)

}

protocol GithubIssuesViewModelCoordinatorDelegate: class {
    
    func githubIssuesViewModel(viewModel: GithubIssuesViewModel, presentGithubIssuesCommentWithParams params: GithubIssuesCommentInitParams)
}

protocol GithubIssuesCoordinatorDelegate: class {
    func githubIssuesCoordinatorDidFinish(coordinator: GithubIssuesCoordinator)
}

protocol GithubIssuesProtocol {
}
