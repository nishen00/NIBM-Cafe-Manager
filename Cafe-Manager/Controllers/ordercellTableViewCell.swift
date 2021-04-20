//
//  ordercellTableViewCell.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-19.
//

import UIKit

class ordercellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var customername: UILabel!
    
  
    @IBOutlet weak var statusbtn: UIButton!
    
    @IBOutlet weak var orderid: UILabel!
    
    
    
    func setorder(order:orderdtl) {
        
        
        customername.text = order.cusname
        
        orderid.text = "Order No : " + order.orderno
        
        statusbtn.setTitle(String(order.status), for: .normal)
      
       
    }
    
}
