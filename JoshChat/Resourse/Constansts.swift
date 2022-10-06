//
//  Constansts.swift
//  JoshChat
//
//  Created by Josh on 03/10/22.
//

import Foundation

struct Constant {
    
    static let appName = "⚡️JoshChat"
    static let registerSegue = "RegisterToMessanger"
    static let loginSegue = "LoginToMessanger"
    
    
    struct FirbaseLibrary {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
    struct AppColor {
        static let appBlueColor =  "BlueAppColor"
        static let appPurpleColor = "PurpleColor"
        static let appLightBlueColor = "LightBlueApp"
        static let appLightPurpleColor = "LightPurpleApp"
    }
}
