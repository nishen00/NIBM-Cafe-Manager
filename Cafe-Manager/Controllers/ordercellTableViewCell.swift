//
//  ordercellTableViewCell.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-19.
//

import UIKit
import GeoFire

class ordercellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var customername: UILabel!
    
    
    @IBOutlet weak var acceptbtn: UIButton!
    
    @IBOutlet weak var rejectbtn: UIButton!
    
    @IBOutlet weak var statusbtn: UIButton!
    
    @IBOutlet weak var orderid: UILabel!
    
    
    
    var tapblock : (() -> Void)? = nil
    var rejecttap : (() -> Void)? = nil
    
    var statuschange : (() -> Void)? = nil
    
    var geoFireRef: DatabaseReference?
        var geoFire: GeoFire?
        var myQuery: GFQuery?
    
    func setorder(order:orderdtl) {
        
        geoFireRef = Database.database().reference().child("Geolocs")
                
        geoFire = GeoFire(firebaseRef: geoFireRef!)
        
        
       
        
       
        
        
        customername.text = order.cusname
        
        orderid.text = "Order No : " + order.orderno
        var status : String = ""
        var status2 : String = ""
        
        
        if(order.status == 2)
        {
            status = "Accepted"
            statusbtn.isHidden = false
            acceptbtn.isHidden = true
            rejectbtn.isHidden = true
            self.statusbtn.backgroundColor = .blue
        }
        
        if(order.status == 3)
        {
            status = "Prepararing"
            statusbtn.isHidden = false
            acceptbtn.isHidden = true
            rejectbtn.isHidden = true
            self.statusbtn.backgroundColor = .blue
        }
        
        if (order.status == 4)
        {
            status = "Ready"
            statusbtn.isHidden = false
            acceptbtn.isHidden = true
            rejectbtn.isHidden = true
            
            self.statusbtn.backgroundColor = .blue
            
            
            
            let location:CLLocation = CLLocation(latitude: 37.785834, longitude: -122.406417)
//           geoFire!.setLocation(CLLocation(latitude: 37.785834, longitude: -122.406417), forKey: order.userid)
            
            myQuery = geoFire?.query(at: location, withRadius: 100)
            
            myQuery?.observe(.keyEntered, with: {(key,location) in
            
            
                if key == order.userid
                {
                    self.statusbtn.setTitle("Arrving", for: .normal)
                    self.statusbtn.backgroundColor = .yellow
                    self.statusbtn.setTitleColor(.black, for: .normal)
                    
                }
            
            
            
            })
            
            
            
            
        }
        
        if (order.status == 1)
        {
            
            status = "Waiting"
            statusbtn.isHidden = true
            acceptbtn.isHidden = false
            rejectbtn.isHidden = false
        }
        
        
        if (order.status == 5)
        {
            status = "Rejected"
            statusbtn.isHidden = false
            acceptbtn.isHidden = true
            rejectbtn.isHidden = true
            self.statusbtn.backgroundColor = .red
        }
        
        
        if (order.status == 6)
        {
            status = "Done"
            statusbtn.isHidden = false
            acceptbtn.isHidden = true
            rejectbtn.isHidden = true
            self.statusbtn.backgroundColor = .green
        }
        
        statusbtn.setTitle(status, for: .normal)
        statusbtn.layer.cornerRadius = 0.1 * statusbtn.bounds.size.width
      
       
    }
    
    
    @IBAction func acceptevent(_ sender: UIButton) {
        
        tapblock?()
    }
    
    @IBAction func rejectevent(_ sender: UIButton) {
        rejecttap?()
    }
    
    @IBAction func statuschange(_ sender: UIButton) {
        statuschange?()
    }
    
}
