//
//  MesssageTableViewCell.swift
//  JoshChat
//
//  Created by Josh on 03/10/22.
//

import UIKit

class MesssageTableViewCell: UITableViewCell {

    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var meImageview: UIImageView!
    @IBOutlet weak var youImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageView.layer.cornerRadius = messageView.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
