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
    
    @IBOutlet weak var foodtableview: UITableView!
    
    var food : [fooddtl] = []
    var category : [category] = []
    var foodonce : [foodonce] = []
    var foodcatename : [String] = []
    let db = Firestore.firestore()


    override func viewDidLoad() {
        super.viewDidLoad()
       
     
        foodtableview.delegate = self
        foodtableview.dataSource = self
       
        
        
     
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        first()
        
        
    }
    
   
    
    
    func first() {

        category.removeAll()
        foodonce.removeAll()
        let docRef = db.collection("category")

        docRef.getDocuments { (snapshot, error) in
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
            
            self.foodtableview.reloadData()


        }
        
        
        let docRef2 = db.collection("Food")
     
        docRef2.getDocuments { (snapshot, error) in
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
                    let categoryname = dd["category"] as! String
                    let active = dd["active"] as! Bool
                     
                   
                     
                     
                     
                     let foodget = Cafe_Manager.foodonce(Name:name,discription: discrip,price: price,discount: discount,id: foodId,documentId: docid,category: categoryname,active: active)
                     
                     self.foodonce.append(foodget)
                    
                    
                    
   
                }
                self.foodtableview.reloadData()
                
                
                
            }
            
            
        }
        
        
        
        
    }
    
    
    
    
    

    

}

extension PreviewViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked")
    }
    
    
}

extension PreviewViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(category.count)
        return category.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var filterdarray : [foodonce] = []
        filterdarray = foodonce.filter{($0.category.contains(category[section].name))}
        return filterdarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = foodtableview.dequeueReusableCell(withIdentifier: "cell") as! tablecellTableViewCell
        
        var filterdarray : [foodonce] = []
        
        filterdarray = foodonce.filter{($0.category.contains(category[indexPath.section].name))}
        
        let foo = filterdarray[indexPath.row]
        cell.setfood(food: foo)
       
        
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return category[section].name
    }
    
    
    
    
    
    
    
    
    
}


