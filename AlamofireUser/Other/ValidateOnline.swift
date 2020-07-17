//
//  ValidateOnline.swift
//  AlamofireUser
//
//  Created by Praveer on 27/06/20.
//  Copyright © 2020 Praveer. All rights reserved.
//

import Foundation
import SystemConfiguration
import Network

class CheckConnectivity{
    
    static let instance = CheckConnectivity()
    
  let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    func isOnline() {
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                isConnectionAvailable = true
            } else {
                isConnectionAvailable = false
            }
        }
        monitor.start(queue: queue)
    }
}
