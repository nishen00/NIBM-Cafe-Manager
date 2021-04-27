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
        var status : String = ""
        var status2 : String = ""
        
        
        if(order.status == 2)
        {
            status = "Accepted"
        }
        
        if(order.status == 3)
        {
            status = "Prepararing"
        }
        
        if (order.status == 4)
        {
            status = "Ready"
        }
        
        if (order.status == 1)
        {
            
            status = "Waiting"
        }
        
        statusbtn.setTitle(status, for: .normal)
        statusbtn.layer.cornerRadius = 0.1 * statusbtn.bounds.size.width
      
       
    }
    
}
