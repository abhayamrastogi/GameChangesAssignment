//
//  GithubIssuesCommentViewController+TableView.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

extension GithubIssuesCommentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - UITableViewDataSource
extension GithubIssuesCommentViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(atSection: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GithubIssueCommentTableViewCell = tableView.dequeueCell(withIdentifier: GithubIssueCommentTableViewCell.nameOfClass, for: indexPath)
        let itemViewModel = viewModel.githubIssueCommentItemViewModel(atIndexPath: indexPath)
        cell.configureCell(withItemViewModel: itemViewModel)
        return cell
        
    }
    
}
