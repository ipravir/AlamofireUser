//
//  bttnFuncs.swift
//  AlamofireUser
//
//  Created by Praveer on 26/06/20.
//  Copyright © 2020 Praveer. All rights reserved.
//

import UIKit
@IBDesignable
class bttnFuncs: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = 5.0
    }

}
