//
//  Cafe_ManagerTests.swift
//  Cafe-ManagerTests
//
//  Created by Bhanuka Nishen on 2021-04-17.
//

import XCTest

@testable import Cafe_Manager

class Cafe_ManagerTests: XCTestCase {

    func testvalidetionEmailPasswordempty()  {
        
        let validetion = validations()
        let result = validetion.validationEmailPassword(email: "gg@gmail.com", password: "DDcafeManager123")
        
        XCTAssertEqual(result, true)
        
        
    }
    
    func testvalidateemailpasswordphoneEmpty () {
        
        let validetion = validations()
        let result = validetion.validationEmailPasswordphone(email: "nishen@gmail.com", password: "nishenDf11", phone: "0757648283")
        
        XCTAssertEqual(result, true)
    }
    
    
    
    func testcategory () {
        
        let validetion = validations()
        let result = validetion.categoryName(name: "Rice")
        
        XCTAssertEqual(result, true)
    }
    
    func testRegXEmail () {
        
        let validetion = validations()
        let result = validetion.RegXEmail(email: "nishen@gmail.com")
        
        XCTAssertEqual(result, true)
        
    }
    
    
    func testRegXpassword() {
        
        let validetion = validations()
        let result = validetion.RegXpassword(password: "ddqwrsggsj123")
        
        XCTAssertEqual(result, true)
    }
    
    func testRegXphone() {
        
        let validetion = validations()
        let result = validetion.RegXphone(phone: "0757648283")
        
        XCTAssertEqual(result, true)
        
    }
    
    
    
    
    
}
