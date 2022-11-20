//
//  DetailTableViewCell.swift
//  SimilarInstagram
//
//  Created by Tai on 2022/11/16.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPostImageView: UIImageView!
    @IBOutlet weak var postNiceLabel: UILabel!
    @IBOutlet weak var detailUserNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
