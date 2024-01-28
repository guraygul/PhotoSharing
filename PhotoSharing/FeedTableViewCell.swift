//
//  FeedTableViewCell.swift
//  PhotoSharing
//
//  Created by Güray Gül on 27.01.2024.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
