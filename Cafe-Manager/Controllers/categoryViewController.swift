//
//  categoryViewController.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-18.
//

import UIKit
import Firebase


class categoryViewController: UIViewController {

    @IBOutlet weak var categoryname: UITextField!
    
    
    @IBOutlet weak var tableview: UITableView!
    var category : [category] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getcategory ()
       
        
    }
    
    
    func getcategory (){
        
        category.removeAll()
      
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
            
            self.tableview.reloadData()


        }
        
    }
    
    
    
    @IBAction func addcategory(_ sender: Any) {
        
        let validationclass = Cafe_Manager.validations()
        
        if validationclass.categoryName(name: categoryname.text!)!
        {
        
        
        
        let ref2 =  db.collection("category").document()
        
        ref2.setData(["id":ref2.documentID,"name":categoryname.text!]) { (err) in
            if err != nil{
                
            }
            else
            {
                let alert = UIAlertController(title: "Succesfully", message: "Data has been saved succesfully", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                     })
                     alert.addAction(ok)
                self.present(alert, animated: true)
                
                self.categoryname.text = ""
                self.getcategory()
            
            }
        }
        }
        else
        {
            let alert = UIAlertController(title: "Failure", message: "Required field empty", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 })
                 alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
        
        
    }
    
    

    

}


extension categoryViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(category.count)
        return category.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = category[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            print(self.category[indexPath.row].id)
            
            self.db.collection("category").document(self.category[indexPath.row].id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            
            self.getcategory()
        }
        delete.backgroundColor = .red
        
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        
        return swipe
    }
    
    
}
