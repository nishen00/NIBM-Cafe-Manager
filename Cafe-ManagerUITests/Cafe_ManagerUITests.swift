//
//  Cafe_ManagerUITests.swift
//  Cafe-ManagerUITests
//
//  Created by Bhanuka Nishen on 2021-04-17.
//

import XCTest

class Cafe_ManagerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    
    
    
    func testloginsucces(){
        
        
        let app = XCUIApplication()
        app.activate()
       
        let emailfeild =  app/*@START_MENU_TOKEN@*/.textFields["EmailAddress"]/*[[".textFields[\"Email Address\"]",".textFields[\"EmailAddress\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(emailfeild.exists)
        
        
        
        emailfeild.tap()
        emailfeild.typeText("admin@gmail.com")
        
        UIPasteboard.general.string = "admin123"
        
        let passwordSecureTextField = app.secureTextFields["Password"]
                XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.press(forDuration: 1.1)
        app.menuItems["Paste"].tap()
       
        
      
        app.buttons["loginsetsection"].tap()
        app.activate()
        
        
    
       let ordersecId =  app/*@START_MENU_TOKEN@*/.staticTexts["orderfindsection"]/*[[".staticTexts[\"Find Orders\"]",".staticTexts[\"orderfindsection\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/

        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: ordersecId, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
       
        XCTAssertTrue(ordersecId.exists)
        
        
    }
    
    func testloginfalse(){
        
        
        
        
        let app = XCUIApplication()
        app.activate()
        let emailtext = app/*@START_MENU_TOKEN@*/.textFields["EmailAddress"]/*[[".textFields[\"Email Address\"]",".textFields[\"EmailAddress\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(emailtext.exists)
        emailtext.tap()
        emailtext.typeText("Invalid@gmail.com")
        
        UIPasteboard.general.string = "Invalid@!23"
        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.press(forDuration: 1.1)
        app.menuItems["Paste"].tap()
       
        app.buttons["loginsetsection"].tap()
        let alert =  app.alerts["loginalertview"].scrollViews.otherElements.buttons["okloginfalse"]
        
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
       
        XCTAssertTrue(alert.exists)
        
        
        
        
    }
    
    func testregistration (){
        
        
        
        
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.staticTexts["Register?"]/*[[".buttons[\"Register?\"].staticTexts[\"Register?\"]",".staticTexts[\"Register?\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let email = app.textFields["Email Address"]
        email.tap()
        email.typeText("Admin123@gmail.com")
      
        UIPasteboard.general.string = "0757648283"
        let phoneNumberTextField = app.textFields["phonenumberfind"]
        phoneNumberTextField.press(forDuration: 1.1)
        app.menuItems["Paste"].tap()
        
        UIPasteboard.general.string = "Admin@123g"
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.press(forDuration: 1.1)
        app.menuItems["Paste"].tap()
        
       
        app.buttons["REGISTER"].tap()
      
       
        let ordersecid = app/*@START_MENU_TOKEN@*/.staticTexts["orderfindsection"]/*[[".staticTexts[\"Find Orders\"]",".staticTexts[\"orderfindsection\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(ordersecid.exists)
        
        
        
    }
    
    
}
