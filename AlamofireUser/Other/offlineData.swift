//
//  offlineData.swift
//  AlamofireUser
//
//  Created by Praveer on 28/06/20.
//  Copyright © 2020 Praveer. All rights reserved.
//

import Foundation
import UIKit

class OfflineFunc{
    
    static var instance = OfflineFunc()
    
    
    func saveOfflineData(UserDetails: userDetail){
        guard let userContext =  appDelegate?.persistentContainer.viewContext else {return}
        let user = Users(context: userContext)
        user.id     =   UserDetails.id
        user.fname  =   UserDetails.fname
        user.mname  =   UserDetails.mname
        user.lname  =   UserDetails.lname
        user.mail   =   UserDetails.mail
        user.exten  =   UserDetails.exten
        user.mobile =   UserDetails.mobile
        user.status =   UserDetails.status.rawValue
        do {
            try userContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateOfflineData(){
        
    }
    
    func deleteOfflineData(index: IndexPath){
         guard let userContext =  appDelegate?.persistentContainer.viewContext else {return}
        userContext.delete(iUsers[index.row])
        do {
            try userContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func isOfflineExist()->Bool{
        if iUsers == []{
            return false
        } else {
            return true
        }
    }
}
