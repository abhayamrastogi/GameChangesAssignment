//
//  GithubIssueCommentTableViewCell.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

class GithubIssueCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var lAuthorLabel: UILabel!
    @IBOutlet weak var lCommentLabel: UILabel!

    // MARK: - Life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        lCommentLabel.numberOfLines = 0
        lCommentLabel.lineBreakMode = .byWordWrapping
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func registerTableView(_ tableView: UITableView) {
        tableView.registerNib(GithubIssueCommentTableViewCell.nameOfClass)
    }
    
    func configureCell(withItemViewModel itemViewModel: GithubIssueCommentItemViewModel) {
        lCommentLabel?.text = itemViewModel.commentLabelText
        lAuthorLabel?.text = itemViewModel.authorLabelText
    }
    
}
