//
//  AccountViewController.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-21.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    @IBOutlet weak var printhistory: UIButton!
    
    
    @IBOutlet weak var fromdate: UIDatePicker!
    
    @IBOutlet weak var detailview: UIScrollView!
    
    @IBOutlet weak var todate: UIDatePicker!
    let db = Firestore.firestore()
    
    var itemonecereport : [orderReportdtl] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fromdate.datePickerMode = .date
        todate.datePickerMode = .date
        
        
        
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemonecereport.removeAll()
        for subview in self.detailview.subviews {
           
               subview.removeFromSuperview()
            
        }
    }
    
    
    
    @IBAction func clicksearch(_ sender: Any) {
        getdetails()
    }
    
    func getdetails()
    {
        itemonecereport.removeAll()
        let docorderdtl = self.db.collection("order")
        let from = fromdate.date
        let To = todate.date
        var cons : CGFloat = 50
        var Date : String = ""
        var tag :Int = 1
        
        for subview in self.detailview.subviews {
           
               subview.removeFromSuperview()
            
        }
        
        docorderdtl.whereField("dateTime", isGreaterThanOrEqualTo:  from).whereField("dateTime",isLessThanOrEqualTo:To).getDocuments { (snap, error) in
            
            if error != nil
            {
                print("error")
            }
            else
            {
                
                
                for element in (snap?.documents)! {
                    let data = element.data()
                    
                   
                    let docid =  data["docid"]  as! String
                    let totalfind = data["totalAmount"] as! Float
                    
                    
                    
                    let date = UILabel()

                    date.textAlignment = .center
                    date.text = ""
                    date.textColor = UIColor.black
                    self.detailview.addSubview(date)
                    date.translatesAutoresizingMaskIntoConstraints = false
                    date.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 10).isActive = true
                    date.topAnchor.constraint(equalTo: self.detailview.topAnchor, constant: 5).isActive = true
                    
                    
                    
                    let docorderdtl = self.db.collection("orderdtl")
                    
                    docorderdtl.whereField("orderid", isEqualTo: docid).getDocuments { (snap, error) in
                        
                        if error != nil
                        {
                            print("error")
                        }
                        else
                        {
                            
                            for element in (snap?.documents)! {
                                
                                
                                
                                let data = element.data()
                                
                                let viewcontent = UIView()
                                viewcontent.backgroundColor = .red
                                self.detailview.addSubview(viewcontent)
                                viewcontent.translatesAutoresizingMaskIntoConstraints = false
                                viewcontent.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 0).isActive = true
                                viewcontent.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons).isActive = true
                                viewcontent.rightAnchor.constraint(equalTo: self.detailview.rightAnchor, constant: 0).isActive = true
                                viewcontent.heightAnchor.constraint(equalToConstant: 90).isActive = true
                                
                                
                                let item = UILabel()
                                
                                item.textAlignment = .center
                                item.text = data["Name"] as? String
                                item.textColor = UIColor.black
                                viewcontent.addSubview(item)
                                item.translatesAutoresizingMaskIntoConstraints = false
                                item.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 30).isActive = true
                                item.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons).isActive = true
                                
                                
                                let qty = data["qty"] as? Int
                                let singleprice = data["singleprice"] as? Int
                                let ts =  data["datetime"]  as! Timestamp
                                let aDate = ts.dateValue()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
                                Date = formatter.string(from: aDate)
                                
                                let convertstrinprice = String(singleprice!)
                                let convertstrinqty = String(qty!)
                                
                                let final = convertstrinqty + " X " + "Rs." + convertstrinprice
                                
                                let price = UILabel()
                                
                                price.textAlignment = .center
                                price.text = final
                                price.textColor = UIColor.black
                                self.detailview.addSubview(price)
                                price.translatesAutoresizingMaskIntoConstraints = false
                                price.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 200).isActive = true
                                price.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons).isActive = true
                                
                                
                                
                                let details = Cafe_Manager.orderReportdtl(Foodname: (data["Name"] as? String)!, Price: final,date: Date)
                                
                                self.itemonecereport.append(details)
                                
                                
                                cons = cons + 50
                                
                               
                            }
                            
                       
                            
                            let printbtn = UILabel()
                            printbtn.text =  Date
                         
                            self.detailview.addSubview(printbtn)
                            printbtn.translatesAutoresizingMaskIntoConstraints = false
                            printbtn.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 30).isActive = true
                            printbtn.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons + 5).isActive = true
                            printbtn.tag = tag
//                            printbtn.addTarget(self, action: #selector(self.processButtonClickEvent), for: UIControl.Event.touchDown)
                            
                            
                            let total = UILabel()
                            let totget = String("TOTAL: Rs." + String(totalfind))
                            total.textAlignment = .center
                            total.text = totget
                            total.textColor = UIColor.black
                            self.detailview.addSubview(total)
                            total.translatesAutoresizingMaskIntoConstraints = false
                            total.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 200).isActive = true
                            total.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons + 5).isActive = true
                            
                            
                            
                            let date22 = UILabel()
                            
                            date22.tag = tag + 10
                            date22.isHidden = true
                            date22.textAlignment = .center
                            date22.text = Date
                            date22.textColor = UIColor.black
                            self.detailview.addSubview(date22)
                            date22.translatesAutoresizingMaskIntoConstraints = false
                            date22.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 250).isActive = true
                            date22.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons + 5).isActive = true
                            
                            
                            cons = cons * 2
                            
                           tag = tag + tag
                           
                            
                            
                            
                            
                            
                            
                        
                            
                            
                            
                            
                        }
                    }
                    
                    
                    
                    
                }
                
                
                
                        
                
                
                
                
                
            
                
                
                
                
            }
                    
                    
        }
                
    }
    
    
    
   
    
    
    
    
    @IBAction func Printhistory(_ sender: Any) {
        
        if itemonecereport.count > 0
        {
        
        let info = UIPrintInfo(dictionary: nil)
    info.outputType = UIPrintInfo.OutputType.general
    info.jobName = "Print"
    
    let vc = UIPrintInteractionController.shared
    vc.printInfo = info
    vc.printingItem = detailview
    vc.present(from: self.view.frame, in: self.view, animated: true, completionHandler: nil)
    vc.printingItem = detailview.toImage()
        
        }
        
        else
        {
            let alert = UIAlertController(title: "Failure", message: "Please select date range and search", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 })
                 alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
    }
    
    
        
    
        
}

extension UIView {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
