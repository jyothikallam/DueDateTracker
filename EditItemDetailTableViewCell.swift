//
//  EditItemDetailTableViewCell.swift
//  DueDateTracker
//
//  Created by Chanikya on 12/03/2016.
//  Copyright © 2016 jyothi.demo. All rights reserved.
//

import UIKit

class EditItemDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
