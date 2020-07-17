//
//  NewUserVC.swift
//  AlamofireUser
//
//  Created by Praveer on 27/06/20.
//  Copyright © 2020 Praveer. All rights reserved.
//

import UIKit

class NewUserVC: UIViewController {
    
    
    @IBOutlet weak var bttnAddUpdateUser: UIButton!
    @IBOutlet weak var txtFName: txtField!
    @IBOutlet weak var lblInformation: UILabel!
    @IBOutlet weak var txtMobile: txtField!
    @IBOutlet weak var txtExtension: txtField!
    @IBOutlet weak var txtMailid: txtField!
    @IBOutlet weak var txtLName: txtField!
    @IBOutlet weak var txtMName: txtField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtExtension.addTarget(self, action: #selector(checkExtension), for: .editingChanged)
        txtMobile.addTarget(self, action: #selector(checkMobile), for: .editingChanged)
        if updateDetails.count == 1{
            txtFName.text = updateDetails[0].fname
            txtLName.text   =   updateDetails[0].lname
            txtMName.text   =   updateDetails[0].mname
            txtMailid.text  =   updateDetails[0].mail
            txtExtension.text   =   updateDetails[0].exten
            txtMobile.text  =   updateDetails[0].mobile
            bttnAddUpdateUser.setTitle("Update", for: .normal)
        }
    }


    @IBAction func ActionAddUser(_ sender: Any) {
        let fname: String = txtFName.text!
        if fname == "" {
            Alert.instance.checkMandatValue(textField: txtFName, displayLable: lblInformation, displayMessage: "Invalid user first name")
            lblInformation.isHidden = false
            return
        } else {
            lblInformation.isHidden = true
            let mname: String = txtMName.text!
            let lname: String = txtLName.text!
            let mail: String = txtMailid.text!
            let exten: String = txtExtension.text!
            let mobile: String = txtMobile.text!
            
            if updateDetails.count == 1{
                ServiceProcess.instance.updateUser(id: updateDetails[0].id, FirstName: fname, middleName: mname, lastName: lname, mail: mail, extension: exten, mobile: mobile) { (response) in
                    if response == true{
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                updateDetails = []
            } else {
                ServiceProcess.instance.addNewUser(userId: gUserid, password: gPassword, FirstName: fname, middleName: mname, lastName: lname, mail: mail, extension: exten, mobile: mobile) { (response) in
                    if response == true{
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        
                    }
                }
            }
        }
    }
    
    @IBAction func ActionClose(_ sender: Any) {
        updateDetails = []
        dismiss(animated: true, completion: nil)
    }
    
    @objc func checkExtension(){
        if let text = txtExtension.text, text.count > 4{
            lblInformation.text = "Invalid Extension"
            lblInformation.isHidden = false
        } else {
            lblInformation.isHidden = true
        }
    }
    @objc func checkMobile(){
        if let text = txtMobile.text, text.count > 10{
            lblInformation.text = "Invalid Mobile Number"
            lblInformation.isHidden = false
        } else {
            lblInformation.isHidden = true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
