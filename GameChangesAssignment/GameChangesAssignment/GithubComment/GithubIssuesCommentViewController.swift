//
//  GithubIssuesCommentViewController.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

class GithubIssuesCommentViewController: UIViewController, ViewFromNib {

    // MARK:- IBOutlets
    @IBOutlet var tvTableView: UITableView!

    // MARK:- Properties
    var viewModel: GithubIssuesCommentViewModel! {
        didSet {
            self.viewModel.delegate = self
        }
    }
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        configureViews()
        fetchComments()
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
        GithubIssueCommentTableViewCell.registerTableView(tvTableView)
    }
    
    private func fetchComments() {
        viewModel.fetchComments()
    }
    
}

extension GithubIssuesCommentViewController: GithubIssuesCommentViewModelDelegate {
    
    func githubIssuesCommentViewModel(viewModel: GithubIssuesCommentViewModel, fetchedIssueComments comments: [GithubIssueCommentItemViewModel]) {
        DispatchQueue.main.async {
            self.tvTableView.reloadData()
        }
    }
    
    func githubIssuesCommentViewModel(viewModel: GithubIssuesCommentViewModel, failedToFetchIssueCommentsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
}
