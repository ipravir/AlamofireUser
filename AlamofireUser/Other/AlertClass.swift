//
//  AlertClass.swift
//  AlamofireUser
//
//  Created by Praveer on 27/06/20.
//  Copyright © 2020 Praveer. All rights reserved.
//

import Foundation
import UIKit
	
class Alert{
    
    static let instance = Alert()
    
    func displayMessage(MessageTitle title: String, MessageText msg: String)-> UIAlertController{
        let oAlertMsg = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        oAlertMsg.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) in
            oAlertMsg.dismiss(animated: true, completion: nil)
        }))
        return oAlertMsg
    }
    
    
    func checkMandatValue(textField txtField:UITextField, displayLable lblDisplay: UILabel, displayMessage msg:String)->Bool{
        if txtField.text == ""{
            lblDisplay.text = msg
            return false
        } else {
            lblDisplay.text = ""
            return true
        }
    }
}
