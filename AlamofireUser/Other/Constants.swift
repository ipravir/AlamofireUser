//
//  Constants.swift
//  AlamofireUser
//
//  Created by Praveer on 27/06/20.
//  Copyright © 2020 Praveer. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let C_USERDETAIL: String = "userDetailsVC"
let C_USERDETAILCELL: String = "userDetailsCell"
let C_MAIN_URL: String = "https://hdbprvp901189trial.hanatrial.ondemand.com/users/users.xsodata/users"
let C_SEL_USER: String = "('"
let C_NEW_RECS: String = "$$$"

let C_USERID = "ID"
let C_FNAME = "FNAME"
let C_MNAME = "MNAME"
let C_LNAME = "LNAME"
let C_MAIL = "MAIL"
let C_EXTEN = "EXTEN"
let C_MOBILE = "MOBILE"
let C_DELETE = "DELETE"
let C_UPDATE = "Update"

typealias ComplitionHandler = (_ Success: Bool) ->()

let appDelegate = UIApplication.shared.delegate as? AppDelegate

enum status: String {
    case B = ""
    case U = "U"
    case D = "D"
    case N = "N"
}

struct userDetail {
    var id: String
    var fname: String
    var mname: String
    var lname:String
    var mail:String
    var exten:String
    var mobile:String
    var status:status
}

var iUserDetails: [userDetail] = []


var iUsers: [Users] = []

struct displayStruct {
    var id: String
    var name: String
    var mail: String
    var mobile: String
}

var iDisplay: [displayStruct] = []

let userDefault = UserDefaults.standard

let C_PASSWORD_KEY: String = "PWD"
let C_USERID_KEY: String = "UID"

var gUserid: String{
    get{
        return userDefault.string(forKey: C_USERID_KEY)!
    }
    set{
        userDefault.set(newValue, forKey: C_USERID_KEY)
    }
}

var gPassword: String{
    get{
        return userDefault.string(forKey: C_PASSWORD_KEY)!
    }
    set{
        userDefault.set(newValue, forKey: C_PASSWORD_KEY)
    }
}

var isConnectionAvailable: Bool = true

var updateDetails: [userDetail] = []
