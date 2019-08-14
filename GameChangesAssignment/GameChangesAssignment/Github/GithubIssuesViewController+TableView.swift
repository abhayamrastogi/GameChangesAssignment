//
//  GithubIssuesViewController+UITableView.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

extension GithubIssuesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelect(atIndexPath: indexPath)
    }
    
}

//MARK: - UITableViewDataSource
extension GithubIssuesViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(atSection: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell: GithubIssuesTableViewCell = tableView.dequeueCell(withIdentifier: GithubIssuesTableViewCell.nameOfClass, for: indexPath)
        let itemViewModel = viewModel.githubIssueItemViewModel(atIndexPath: indexPath)
        cell.configureCell(withItemViewModel: itemViewModel)
        return cell
        
    }
    
}
