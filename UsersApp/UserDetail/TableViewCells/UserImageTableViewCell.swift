//
//  UserDetailsTableViewCell.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/30/23.
//

import UIKit

class UserImageTableViewCell: UITableViewCell {


    @IBOutlet weak var userImageVw: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
