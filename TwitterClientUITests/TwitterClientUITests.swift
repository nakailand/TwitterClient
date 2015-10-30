//
//  TwitterClientUITests.swift
//  TwitterClientUITests
//
//  Created by nakazy on 2015/10/24.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import XCTest

class TwitterClientUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        if #available(iOS 9.0, *) {
            XCUIApplication().launch()
        } else {
            // Fallback on earlier versions
        }

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /// 自分のTwitterアカウントでのテストのためコメントアウトをしておく(本来ならテスト用のアカウントを作成するべき)
    func testTransition() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //let app = XCUIApplication()
        //app.buttons["authorization"].tap()
        //app.sheets["Twitter"].collectionViews.buttons["Shachikusky"].tap()
        //app.tables.staticTexts["@takfmk"].tap()
        //app.otherElements.containingType(.NavigationBar, identifier:"takfmk").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.TextView).element.tap()
        //app.tables["Empty list"].tap()
        //app.navigationBars["takfmk"].buttons["Twitter DM"].tap()

        //XCTAssertTrue(app.tables.cells.count == 20)

    }

    /// 自分のTwitterアカウントでのテストのためコメントアウトをしておく(本来ならテスト用のアカウントを作成するべき)
    func testSendDM() {
        
        //let app = XCUIApplication()
        //app.buttons["authorization"].tap()
        //app.sheets["Twitter"].collectionViews.buttons["Shachikusky"].tap()
        //app.tables.staticTexts["@yukiyukimama"].tap()
        //
        //let textView = app.otherElements.containingType(.NavigationBar, identifier:"yukiyukimama").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.TextView).element
        //textView.tap()
        //textView.typeText("Hello")
        //XCTAssertEqual(textView.value as? String, "Hello")
        //app.buttons["Post"].tap()
        //app.navigationBars["yukiyukimama"].buttons["Twitter DM"].tap()

    }
}
