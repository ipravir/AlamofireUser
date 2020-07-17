//
//  userDetailsCell.swift
//  AlamofireUser
//
//  Created by Praveer on 29/06/20.
//  Copyright © 2020 Praveer. All rights reserved.
//

import UIKit

class userDetailsCell: UITableViewCell {
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblMail: UILabel!
    @IBOutlet weak var lblFulleName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCellvalues(index: IndexPath){
        lblFulleName.text = iDisplay[index.row].name
        lblMobile.text = iDisplay[index.row].mobile
        lblMail.text = iDisplay[index.row].mail
    }
}
