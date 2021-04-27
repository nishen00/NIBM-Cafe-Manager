//
//  orderViewController.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-19.
//

import UIKit
import Firebase

class orderViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    let db = Firestore.firestore()
    var orderdtl :[orderdtl] = []
    var globle : [orderdtl] = []
    var globle2 : [orderdtl] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getorder()
    }
    
    func getorder(){
        
        orderdtl.removeAll()
        globle.removeAll()
      
        let docRef = db.collection("order")

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
                    let cusname = dd["cusname"] as! String
                    let docid = dd["docid"] as! String
                    let userid = dd["userId"] as! String
                    let status = dd["status"] as! Int
                    let section = dd["section"] as! String
                    let phone = dd["cusphone"] as! String
                    let orderno = dd["orderNo"] as! String
                    

                    let order = Cafe_Manager.orderdtl(cusname: cusname, docid: docid, userid: userid, status: status,section: section,orderno: orderno,cusphone: phone)

                    self.orderdtl.append(order)


                }



            }
            
            self.tableview.reloadData()


        }
        
    }
    
    
    func approveorder(docid:String){
        
        
        let updateshowstatus = db.collection("order").document(docid)
        
        
        updateshowstatus.updateData(["section":"0","status":2]) { (error) in
            if error != nil
            {
               print(error)
            }
            else
            {
                print("updated")
            }
        }
        
        getorder()
        
    }
    
    
    func Preapareorder(docid:String){
        
        
        let updateshowstatus = db.collection("order").document(docid)
        
        
        updateshowstatus.updateData(["section":"0","status":3]) { (error) in
            if error != nil
            {
               print(error)
            }
            else
            {
                print("updated")
            }
        }
        
        getorder()
        
    }
    
    func Readyorder(docid:String){
        
        
        let updateshowstatus = db.collection("order").document(docid)
        
        
        updateshowstatus.updateData(["section":"0","status":4]) { (error) in
            if error != nil
            {
               print(error)
            }
            else
            {
                print("updated")
            }
        }
        
        getorder()
        
    }
    
    
    func rejectorder(docid:String){
        
        db.collection("order").document(docid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        getorder()
        
    }
    

   
}

extension orderViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0
        {
       
        let viewController = storyboard?.instantiateViewController(withIdentifier: "orderdtlViewController") as! orderdtlViewController
        viewController.name = globle2[indexPath.row].cusname
        viewController.btnstatus = globle2[indexPath.row].status
        viewController.docid = globle2[indexPath.row].docid
        viewController.orderid = globle2[indexPath.row].orderno
        viewController.Phone = globle2[indexPath.row].cusphone
        
        self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        else
        {
            let viewController = storyboard?.instantiateViewController(withIdentifier: "orderdtlViewController") as! orderdtlViewController
            viewController.name = globle[indexPath.row].cusname
            viewController.btnstatus = globle[indexPath.row].status
            viewController.docid = globle[indexPath.row].docid
            viewController.orderid = globle[indexPath.row].orderno
            viewController.Phone = globle[indexPath.row].cusphone
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
       
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var filterarry : [orderdtl] = []
        
        if section == 1
        {
            filterarry = orderdtl.filter{($0.section.contains("1"))}
            globle = filterarry
        }
        
        else
        {
            filterarry = orderdtl.filter{($0.section.contains("0"))}
            globle2 = filterarry
        }
        
        return filterarry.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableview.dequeueReusableCell(withIdentifier: "cell") as! ordercellTableViewCell
        
        
        var filterarry : [orderdtl] = []
        let section = String( indexPath.section)
        
        filterarry = orderdtl.filter{($0.section.contains(section))}
       
        
        let orr = filterarry[indexPath.row]
        
        cell.setorder(order: orr)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        
        
        let Reject = UIContextualAction(style: .normal, title: "Reject") { (action, view, completionHandler) in
            
            self.rejectorder(docid: self.globle[indexPath.row].docid)
            self.tableview.reloadData()
            
        }
        Reject.backgroundColor = .red
        
        let Accept = UIContextualAction(style: .normal, title: "Accept") { (action, view, completionHandler) in
            
            self.approveorder(docid: self.globle[indexPath.row].docid)
            self.tableview.reloadData()
            
        }
        Accept.backgroundColor = .green
        
        
        let Prepare = UIContextualAction(style: .normal, title: "Prepare") { (action, view, completionHandler) in
            
            self.Preapareorder(docid: self.globle2[indexPath.row].docid)
            self.tableview.reloadData()
            
        }
        
        let Ready = UIContextualAction(style: .normal, title: "Ready") { (action, view, completionHandler) in
            
            self.Readyorder(docid: self.globle2[indexPath.row].docid)
            self.tableview.reloadData()
            
        }
        
        Prepare.backgroundColor = .green
   
        
        
        if indexPath.section == 1
        {
        
        let swipe = UISwipeActionsConfiguration(actions: [Reject,Accept])
            return swipe
        }
        
        else
        {
            if(globle2[indexPath.row].status == 4)
            {
                let swipe = UISwipeActionsConfiguration(actions: [])
                    return swipe
            }
            
            if(globle2[indexPath.row].status == 3)
            {
                let swipe = UISwipeActionsConfiguration(actions: [Ready])
                    return swipe
            }
            else
            {
        let swipe = UISwipeActionsConfiguration(actions: [Prepare])
            return swipe
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "Ready (" + String(globle2.count) + ")"
        }
        else
        {
            return "New (" + String(globle.count) + ")"
        }
    }
    
    
    
    
    
}
