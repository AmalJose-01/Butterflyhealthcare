//
//  UtilReach.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 29/12/2023.


import Foundation
import SystemConfiguration


public class UtilReach {
    func connectionStatus() -> Bool {
        var connectionStatus = false
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:do {
            print("Not connected")
            connectionStatus = false
        }
        case .online(.wwan):do {
            print("Connected via WWAN")
            connectionStatus = true
        }
        case .online(.wiFi):do {
            print("Connected via WiFi")
            connectionStatus = true
        }
       }
        return connectionStatus
    }
}

