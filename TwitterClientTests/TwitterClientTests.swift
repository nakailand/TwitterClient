//
//  TwitterClientTests.swift
//  TwitterClientTests
//
//  Created by nakazy on 2015/10/24.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import XCTest
@testable import TwitterClient

class TwitterClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFollowerModel() {
        let follower = Follower(name: "test", iconUrl: "testUrl")
        XCTAssertEqual(follower.name, "test")
        XCTAssertEqual(follower.iconUrl, "testUrl")
    }
    
    func testMessageModel() {
        let message = Message(text: "test", type: .Me)
        XCTAssertEqual(message.text, "test")
        XCTAssertEqual(message.type, Message.User.Me)
    }
}
