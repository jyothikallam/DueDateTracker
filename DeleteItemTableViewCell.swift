//
//  DeleteItemTableViewCell.swift
//  DueDateTracker
//
//  Created by Chanikya on 12/03/2016.
//  Copyright © 2016 jyothi.demo. All rights reserved.
//

import UIKit

class DeleteItemTableViewCell: UITableViewCell {
    
    var delegate:ItemDetailViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "deleteItem")
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func deleteItem() {
        delegate.deleteItem()
    }

}
