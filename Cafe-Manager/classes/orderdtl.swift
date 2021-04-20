//
//  orderdtl.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-19.
//

import Foundation

class orderdtl {
    var cusname : String
    var docid : String
    var userid : String
    var status : Int
    var section : String
    var orderno : String
    var cusphone : String
   
    
    init(cusname : String,docid : String,userid:String,status:Int,section:String,orderno:String,cusphone:String) {
        
        
        self.cusname = cusname
        self.docid = docid
        self.userid = userid
        self.status = status
        self.section = section
        self.orderno = orderno
        self.cusphone = cusphone
        
        
    }
}
