//
//  ViewController.swift
//  AlamofireUser
//
//  Created by Praveer on 26/06/20.
//  Copyright © 2020 Praveer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtUserID: txtField!
    @IBOutlet weak var txtPassword: txtField!
    @IBOutlet weak var lblInformation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        CheckConnectivity.instance.isOnline()
        
        lblInformation.text = ""
        lblInformation.isHidden = false
        txtUserID.text = gUserid
        txtPassword.text = gPassword
        txtUserID.addTarget(self, action: #selector(txtUseridMandatory(txtField:)), for: .editingChanged)
    }
    
    @IBAction func ActionLogin(_ sender: Any) {
        if isConnectionAvailable == false{
//If online then no process
                let oAlert: UIAlertController    = Alert.instance.displayMessage(MessageTitle: "Not Online", MessageText: "Information to display")
                self.present(oAlert, animated: true, completion: nil)
            } else {
                if Alert.instance.checkMandatValue(textField: txtUserID, displayLable: lblInformation, displayMessage: "Invalid User Id") == true{
                    if Alert.instance.checkMandatValue(textField: txtPassword, displayLable: lblInformation, displayMessage: "Invalid User Password") == true {
                        ServiceProcess.instance.fetchUserDetail(userid: txtUserID.text!, password: txtPassword.text!) { (complition) in
                            if complition == true{
                                guard let oDetailView = self.storyboard?.instantiateViewController(identifier: C_USERDETAIL) else {return}
                                oDetailView.modalPresentationStyle = .fullScreen
                                self.present(oDetailView, animated: true, completion: nil)
                            } else {
                                let msg = Alert.instance.displayMessage(MessageTitle: "Information", MessageText: "Invalid user id or Password")
                                self.present(msg, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
    }
    
    @IBAction func ActionCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    }
    
    
    @objc func txtUseridMandatory(txtField: UITextField){
        if txtField.text == ""{
            lblInformation.text = "Invalid User id"
        } else {
            lblInformation.text = ""
        }
    }
}

