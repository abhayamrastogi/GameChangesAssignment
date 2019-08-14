//
//  GithubIssuesViewController.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

class GithubIssuesViewController: UIViewController, ViewFromNib {

    // MARK:- IBOutlets
    @IBOutlet var tvTableView:UITableView!

    // MARK:- Properties
    var viewModel: GithubIssuesViewModel! {
        didSet {
            self.viewModel.delegate = self
        }
    }
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        configureViews()
        fetchIssues()
    }

    //MARK: Private methods
    private func setupNavBar() {
        title = viewModel.navBarTitle
    }
    
    private func configureViews() {
        configureTableView()
    }
    
    private func configureTableView() {
        tvTableView.delegate = self
        tvTableView.dataSource = self
        tvTableView.estimatedRowHeight = 44
        tvTableView.rowHeight = UITableView.automaticDimension
        GithubIssuesTableViewCell.registerTableView(tvTableView)
    }
    
    private func fetchIssues() {
        viewModel.fetchIssues()
    }

}

// MARK: - GithubIssuesViewModelDelegate
extension GithubIssuesViewController: GithubIssuesViewModelDelegate {
    
    func githubIssuesViewModel(viewModel: GithubIssuesViewModel, failedToFetchIssuesWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func githubIssuesViewModel(viewModel: GithubIssuesViewModel, fetchedIssues issues: [GithubIssueItemViewModel]) {
        viewModel.saveContext()
        viewModel.populateIssuesItemViewModels()
        DispatchQueue.main.async {
            self.tvTableView.reloadData()
        }
    }
}
