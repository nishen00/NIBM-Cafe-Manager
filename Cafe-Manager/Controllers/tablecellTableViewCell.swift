//
//  tablecellTableViewCell.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-18.
//

import UIKit
import FirebaseStorage

class tablecellTableViewCell: UITableViewCell {

    @IBOutlet weak var foodimage: UIImageView!
    
  
    
    @IBOutlet weak var discription: UILabel!
    
    @IBOutlet weak var Name: UILabel!
    
   
    @IBOutlet weak var swich: UISwitch!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var price: UILabel!
    var locations: String = ""
    
    func setfood(food:foodonce) {
        Name.text = food.Name
        discription.text = food.discription
        price.text =  "Rs."+String( food.price )
        if food.discount == 0
        {
            discount.text = String( food.discount)
            discount.isHidden = true
        }
        else
        {
        discount.text = String( food.discount) + "%OFF"
            discount.isHidden = false
        }
        
        if food.active == true{
            swich.setOn(true, animated: true) 
        }
        else{
            swich.setOn(false, animated: true)
        }
        
   
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let path = "foodimages/"+food.id+".png"
        
       
        let formattedString = path.replacingOccurrences(of: " ", with: "")
        let islandRef = storageRef.child(formattedString)
        
        islandRef.getData(maxSize: 6 * 1024 * 1024) { data, error in
            if error != nil {
           print(error)
          } else {
          
            let image = UIImage(data: data!)
            self.foodimage.image = image
            
            
          }
        }
        
        
        
        
//        idlbl.text = food.id
//        idlbl.isHidden = true
//        dicumentId.text = food.documentId
//        dicumentId.isHidden = true
        
        
        
            
        
    }
}
