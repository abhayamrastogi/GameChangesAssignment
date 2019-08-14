//
//  AppCoordinator.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK:- Properties
    struct CoordinatorKeys {
        static let github = "github"
    }
    
    var navigationController: UINavigationController?
    
    private var coordinators = [String: Coordinator]()
    
    //MARK:- Coordinator protocol method
    func start() {
        showGithubIssues()
    }
    
    // MARK:- Initializer
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

extension AppCoordinator {
    
    func showGithubIssues() {
        let githubIssuesCoordinator = GithubIssuesCoordinator(navigationController: navigationController, coordinatorDelegate: self)
        githubIssuesCoordinator.start()
        coordinators[CoordinatorKeys.github] = githubIssuesCoordinator
    }
}


// MARK: - GithubIssuesCoordinatorDelegate
extension AppCoordinator: GithubIssuesCoordinatorDelegate {
    
    func githubIssuesCoordinatorDidFinish(coordinator: GithubIssuesCoordinator) {
        coordinators[CoordinatorKeys.github] = nil
    }
}
