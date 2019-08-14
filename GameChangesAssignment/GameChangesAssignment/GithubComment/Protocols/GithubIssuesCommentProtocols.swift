//
//  GithubIssuesCommentProtocols.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

protocol GithubIssuesCommentViewModelDelegate: class {
    func githubIssuesCommentViewModel(viewModel: GithubIssuesCommentViewModel, fetchedIssueComments comments: [GithubIssueCommentItemViewModel])
    func githubIssuesCommentViewModel(viewModel: GithubIssuesCommentViewModel, failedToFetchIssueCommentsWithError error: Error)

}

protocol GithubIssuesCommentViewModelCoordinatorDelegate: class {
    
}

protocol GithubIssuesCommentCoordinatorDelegate: class {
    func githubIssuesCommentCoordinatorDidFinish(coordinator: GithubIssuesCommentCoordinator)
}

protocol GithubIssuesCommentProtocol {
}
