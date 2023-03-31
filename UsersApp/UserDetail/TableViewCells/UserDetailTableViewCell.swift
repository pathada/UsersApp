//
//  UserDetailTableViewCell.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/30/23.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var detailNameLbl: UILabel!
    
    @IBOutlet weak var detailValueLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
