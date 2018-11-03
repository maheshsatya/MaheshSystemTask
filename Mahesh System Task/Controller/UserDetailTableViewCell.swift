//
//  UserDetailTableViewCell.swift
//  Mahesh System Task
//
//  Created by Apple on 29/10/18.
//  Copyright © 2018 Mahesh. All rights reserved.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var Owner_LogInLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var userDataObject: UserDataModel? {
        didSet {
            fullNameLabel.text = "Full Name: " + (userDataObject?.full_name ?? "")
            Owner_LogInLabel.text = "Login: " + (userDataObject?.owner?.login ?? "")
            descriptionLabel.text = "Description: " + (userDataObject?.description ?? "")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
