//
//  Constants.swift
//  Chatme
//
//  Created by Mikail on 08/01/2022.
//

import Foundation

struct Constants{
    
    static let loginSegue = "loginToChatScreen"
    static let signUpSegue = "signInToChatScreen"
    static let appName = "Chat me"
    static let cellIdentifier = "chatCell"
    static let cellNibName = "MessageCell"
    
    
    struct FireStore{
        static let ColectionName = "messages"
        static let sender = "Sender"
        static let body = "body"
    }
}
