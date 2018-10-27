//
//  MainServicesTableViewCell.swift
//  Ayumba
//
//  Created by Admin on 10/26/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit

class MainServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profession: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var call: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
