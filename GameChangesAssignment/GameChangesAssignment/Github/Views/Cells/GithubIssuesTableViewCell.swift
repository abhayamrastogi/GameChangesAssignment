//
//  GithubIssuesTableViewCell.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import UIKit

class GithubIssuesTableViewCell: UITableViewCell {
   
    @IBOutlet weak var lIssueTitleLabel: UILabel!
    @IBOutlet weak var lIssueUpdatedLabel: UILabel!
    
    // MARK: - Life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func registerTableView(_ tableView: UITableView) {
        tableView.registerNib(GithubIssuesTableViewCell.nameOfClass)
    }
    
    func configureCell(withItemViewModel itemViewModel: GithubIssueItemViewModel) {
        lIssueTitleLabel?.text = itemViewModel.titleLabelText
        lIssueUpdatedLabel?.text = itemViewModel.updatedAtLabelText
        accessoryType = itemViewModel.showDisclosueIndicator ? .disclosureIndicator : .none
       
    }
}
