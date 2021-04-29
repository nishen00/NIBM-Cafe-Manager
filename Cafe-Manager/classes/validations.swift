//
//  validations.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-29.
//

import Foundation

public class validations {
    
    func validationEmailPassword(email:String,password:String) -> Bool? {
        if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return false
        }
        else
        {
            return true
        }
        
    }
    
    
    
    func validationEmailPasswordphone(email:String,password:String,phone:String) -> Bool? {
        if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phone.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return false
        }
        else
        {
            return true
        }
        
    }
    
    
    
    
    func categoryName(name:String) -> Bool? {
        if name.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return false
        }
        else
        {
            return true
        }
        
    }
    
    
    
    
    
    func RegXEmail(email:String) -> Bool?
    {
        if email.isEmail
        {
            return true
        }
        else
        {
            return false
        }
        
        
    }
    
    
    func RegXpassword(password:String) -> Bool?
    {
        if password.ispassword
        {
            return true
        }
        else
        {
            return false
        }
        
        
    }
    
    
    func RegXphone(phone:String) -> Bool?
    {
        if phone.isphone
        {
            return true
        }
        else
        {
            return false
        }
        
        
    }
    
    
    
    
    
    
}

extension String {
    private static let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
    private static let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
    private static let __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,6}"
    private static let __passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    private static let __phonenumberRegex = "^[0-9]{10}$"
    private static let __number = "^[0-9]+$"
    public var isEmail: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", type(of:self).__emailRegex)
        return predicate.evaluate(with: self)
    }
    
    public var isnumber:Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", type(of:self).__number)
        return predicate.evaluate(with: self)
        
    }
    
    public var ispassword: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", type(of:self).__passwordRegex)
        return predicate.evaluate(with: self)
    }
    
    public var isphone: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", type(of:self).__phonenumberRegex)
        return predicate.evaluate(with: self)
    }
}

