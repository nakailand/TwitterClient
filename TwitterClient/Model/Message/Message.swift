//
//  Message.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/25.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import Foundation

/// DMの内容を格納
struct Message {
    enum User {
        case Me, Friend
    }
    let text: String
    let type: User
}