//
//  ServiceProcesses.swift
//  AlamofireUser
//
//  Created by Praveer on 27/06/20.
//  Copyright © 2020 Praveer. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ODataSwift

class ServiceProcess{
    
    static var instance = ServiceProcess()
    
    func getHeader(userid: String, password: String)->[String: String]{
            gUserid = userid
            gPassword = password
            let credentialData = "\(userid):\(password)".data(using: String.Encoding.utf8)!
            let masterCredentail = credentialData.base64EncodedString()
            let headers = [
                      "Authorization": "Basic \(masterCredentail)",
                      "Content-Type": "application/json; charset=utf-8",
                      "X-CSRF-Token": "Fetch",
                      "Accept": "application/json"]
        return headers
    }
    
    func fetchUserDetail(userid: String, password: String, complition: @escaping ComplitionHandler){
        iUsers = []
        iDisplay = []
        let iHeaders = self.getHeader(userid: userid, password: password)
        Alamofire.request(C_MAIN_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: iHeaders).responseJSON { (response) in
            if response.result.error == nil{
                guard let oData = response.data else { return complition(false) }
                do {
                    let jsondata = try? JSON(data: oData)
                    let iRecords = jsondata?["d"]["results"]
                    for index in 0...(iRecords?.count ?? 1 - 1){
                        let id : String = iRecords![index][C_USERID].string ?? ""
                        if id != "" {
                                let userFName: String = iRecords![index][C_FNAME].string ?? ""
                                let userMName: String = iRecords![index][C_MNAME].string ?? ""
                                let userLName: String = iRecords![index][C_LNAME].string ?? ""
                                let mail: String = iRecords![index][C_MAIL].string ?? ""
                                let mobile: String = iRecords![index][C_MOBILE].string ?? ""
                                let exten: String = iRecords![index][C_EXTEN].string ?? ""
                            
                                let wUser = userDetail(id: id, fname: userFName, mname: userMName, lname: userLName, mail: mail, exten: exten, mobile: mobile, status: .B)
                                iUserDetails.append(wUser)
                            
                                let wDisplay = displayStruct(id: id , name: "\(userFName) \(userMName) \(userLName)", mail: mail, mobile: "\(exten) - \(mobile)")
                                iDisplay.append(wDisplay)
                        }
                    }
                    complition(true)
                } catch{
                    complition(false)
                }
            } else {
                print("Error")
                complition(false)
            }
        }
    }
    
    func addNewUser(userId: String, password: String, FirstName fname: String, middleName mname: String, lastName lName: String, mail: String, extension exten: String, mobile: String, complition :@escaping ComplitionHandler){
        
        let iHeaders = self.getHeader(userid: userId, password: password)
        let id = self.getUserId()
        let body: [String: Any] = [
            C_USERID:id,
            C_FNAME:fname,
            C_MNAME:mname,
            C_LNAME:lName,
            C_MAIL:mail,
            C_EXTEN:exten,
            C_MOBILE:mobile
        ]
        
        Alamofire.request(C_MAIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: iHeaders).responseString { (response) in
            if response.result.error == nil {
                let wUser = userDetail(id: id, fname: fname, mname: mname, lname: lName, mail: mail, exten: exten, mobile: mobile, status: .B)
                iUserDetails.append(wUser)
                
                let wDisplay = displayStruct(id: id , name: "\(fname) \(mname) \(lName)", mail: mail, mobile: "\(exten) - \(mobile)")
                iDisplay.append(wDisplay)
                complition(true)
            } else {
                complition(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getUserId() -> String {
        if isConnectionAvailable == true {
            if iUserDetails.count == 0 {
                return "1"
            } else {
                let id = iUserDetails[iUserDetails.count - 1].id
                var newid: String = String( Int(id)! + 1 )
                return newid
            }
        } else {
            return C_NEW_RECS
        }
    }
    
    func deleteuser(userid id: String, complition: @escaping ComplitionHandler){
        
        let delUrl = "\(C_MAIN_URL)\(C_SEL_USER)\(id)')"
        let iheader = getHeader(userid: gUserid, password: gPassword)
        Alamofire.request(delUrl, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: iheader).responseString { (response) in
            if response.result.error == nil {
                for index in 0...iDisplay.count - 1{
                    if iDisplay[index].id == id{
                        iDisplay.remove(at: index)
                        iUserDetails.remove(at: index)
                    }
                }
                complition(true)
            } else {
                complition(false)
                print(response.result)
            }
        }
    }
    
    func initUpdateUser(index: Int){
        let updateUser = userDetail(id: iUserDetails[index].id,
                             fname: iUserDetails[index].fname,
                             mname: iUserDetails[index].mname,
                             lname: iUserDetails[index].lname,
                             mail: iUserDetails[index].mail,
                             exten: iUserDetails[index].exten,
                             mobile: iUserDetails[index].mobile,
                             status: .B)
        updateDetails.append(updateUser)
    }
    
    func updateUser(id: String, FirstName fname: String, middleName mname: String, lastName lName: String, mail: String, extension exten: String, mobile: String, complition :@escaping ComplitionHandler) {
        let iHeaders = self.getHeader(userid: gUserid, password: gPassword)
        let updateUrl = "\(C_MAIN_URL)\(C_SEL_USER)\(id)')"
        let body: [String: Any] = [
            C_FNAME:fname,
            C_MNAME:mname,
            C_LNAME:lName,
            C_MAIL:mail,
            C_EXTEN:exten,
            C_MOBILE:mobile
        ]
        Alamofire.request(updateUrl, method: .put, parameters: body, encoding: JSONEncoding.default, headers: iHeaders).responseJSON { (response) in
            if response.result.error == nil{
                for index in 0...iDisplay.count - 1{
                    if iDisplay[index].id == id{
                        let wDisplay = displayStruct(id: id , name: "\(fname) \(mname) \(lName)", mail: mail, mobile: "\(exten) - \(mobile)")
                        iDisplay[index] = wDisplay
                        
                        let wUser = userDetail(id: id, fname: fname, mname: mname, lname: lName, mail: mail, exten: exten, mobile: mobile, status: .B)
                        iUserDetails[index] = wUser
                    }
                }
                complition(true)
            } else {
                complition(false)
                print("Error")
            }
        }
        
    }
    
}
