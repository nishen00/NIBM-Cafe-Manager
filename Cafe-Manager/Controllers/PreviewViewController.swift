//
//  PreviewViewController.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-17.
//

import UIKit
import Firebase
import FirebaseStorage

class PreviewViewController: UIViewController {
    
    var food : [fooddtl] = []
    var category : [category] = []
    var foodonce : [foodonce] = []
    var foodcatename : [String] = []
    let db = Firestore.firestore()


    override func viewDidLoad() {
        super.viewDidLoad()
     
        
       
        
        
     
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        first()
        print(foodonce)
        print(category)
    }
    
   
    
    
    func first() {

        
        let docRef = db.collection("category")
     
        docRef.getDocuments { [self] (snapshot, error) in
            if error != nil
            {
                print("error")
            }
            else
            {
               
                for document in (snapshot?.documents)!
                {
                   
                    let dd=document.data()
                    let name = dd["name"] as! String
                    let id = dd["id"] as! String
                    
                    let category = Cafe_Manager.category(id: id, name: name)
                    
                    self.category.append(category)
                    
   
                }
                
                
                
            }
            
            
        }
        
        
        let docRef2 = db.collection("Food")
     
        docRef2.getDocuments { [self] (snapshot, error) in
            if error != nil
            {
                print("error")
            }
            else
            {
               
                for document in (snapshot?.documents)!
                {
                   
                    let dd=document.data()
                    let name = dd["Name"] as! String
                     let discrip = dd["description"] as! String
                     let price = dd["price"] as! Float
                     let discount = dd["discount"] as! Int
                     let foodId = dd["id"] as! String
                     let docid = dd["dicid"] as! String
                     
                   
                     
                     
                     
                     let foodget = Cafe_Manager.foodonce(Name:name,discription: discrip,price: price,discount: discount,id: foodId,documentId: docid)
                     
                     self.foodonce.append(foodget)
                    
                    
                    
   
                }
                
                
                
            }
            
            
        }
        
        
    }
    
    

    

}
