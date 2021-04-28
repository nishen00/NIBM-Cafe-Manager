//
//  AccountViewController.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-21.
//

import UIKit
import Firebase
import FirebaseAuth


class AccountViewController: UIViewController {

    @IBOutlet weak var printhistory: UIButton!
    
    
    @IBOutlet weak var fromdate: UITextField!
    
    
    
    @IBOutlet weak var detailview: UIView!
    
    @IBOutlet weak var todate: UITextField!
    
    var datepicker : UIDatePicker?
    var todatepicker : UIDatePicker?
    
    let db = Firestore.firestore()
    
    var itemonecereport : [orderReportdtl] = []
    var tag :Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        datepicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        datepicker?.datePickerMode = .date
        
        
        todatepicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        todatepicker?.datePickerMode = .date
        
        datepicker?.addTarget(self, action: #selector(AccountViewController.fromdateset(datepicker:)), for: .valueChanged)
        
        todatepicker?.addTarget(self, action: #selector(AccountViewController.todateset(todatepicker:)), for: .valueChanged)
        
        fromdate.inputView = datepicker
        todate.inputView = todatepicker
        
        
        let date = Date()
        let Yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date)
        let tommoro = Calendar.current.date(byAdding: .day, value: 1, to: date)
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        fromdate.text = formatter.string(from: Yesterday!)
        todate.text = formatter.string(from: tommoro!)
        getdetails()
        
       
       
        
        
       
    }
    
    @objc func fromdateset(datepicker : UIDatePicker)
    {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        
        fromdate.text = dateformat.string(from: datepicker.date)
        view.endEditing(true)
    }
    
    @objc func todateset(todatepicker : UIDatePicker)
    {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        
        todate.text = dateformat.string(from: todatepicker.date)
        
        
        getdetails()
        view.endEditing(true)
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let frm = dateFormatter.date(from: fromdate.text!)
        let toget = dateFormatter.date(from: todate.text!)
        
        let from =  frm
        let To = toget
        var cons : CGFloat = 10
        var Date : String = ""
        self.tag = 1
        
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
                
                if (snap?.documents.count)! > 0
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
                                
                                let viewcontent = UIView()
                          
                                self.detailview.addSubview(viewcontent)
                                viewcontent.translatesAutoresizingMaskIntoConstraints = false
                                viewcontent.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 0).isActive = true
                                viewcontent.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons).isActive = true
                                viewcontent.rightAnchor.constraint(equalTo: self.detailview.rightAnchor, constant: 0).isActive = true
                                viewcontent.heightAnchor.constraint(equalToConstant: 90).isActive = true
                                viewcontent.tag = self.tag + 10
                                
                                
                                
                                
                                for element in (snap?.documents)! {
                                    
                                    
                                    
                                    let data = element.data()
                                    
                                    
                                    
                                    
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
                                    viewcontent.addSubview(price)
                                    price.translatesAutoresizingMaskIntoConstraints = false
                                    price.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 200).isActive = true
                                    price.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons).isActive = true
                                    
                                    
                                    
                                    let details = Cafe_Manager.orderReportdtl(Foodname: (data["Name"] as? String)!, Price: final,date: Date)
                                    
                                    self.itemonecereport.append(details)
                                    
                                    
                                    cons = cons + 50
                                    
                                   
                                }
                                
                           
                                
                                let printbtn = UIButton()
                                printbtn.setTitle("Print(" + Date + ")", for: .normal)
                             
                                self.detailview.addSubview(printbtn)
                                printbtn.translatesAutoresizingMaskIntoConstraints = false
                                printbtn.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 30).isActive = true
                                printbtn.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons + 5).isActive = true
                                printbtn.tag = self.tag
                                printbtn.backgroundColor = .darkGray
                                printbtn.addTarget(self, action: #selector(self.processButtonClickEvent), for: UIControl.Event.touchDown)
                                
                                
                                let total = UILabel()
                                total.textColor = UIColor(red: 188/255.0, green: 0, blue: 0, alpha: 1)
                                let totget = String("TOTAL: Rs." + String(totalfind))
                                total.textAlignment = .center
                                total.text = totget
                                total.textColor = UIColor.black
                                self.detailview.addSubview(total)
                                total.translatesAutoresizingMaskIntoConstraints = false
                                total.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 200).isActive = true
                                total.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons + 7).isActive = true
                                
                                
                                
                                let date22 = UILabel()
                                
                                date22.tag = self.tag + 100
                                date22.isHidden = true
                                date22.textAlignment = .center
                                date22.text = Date
                                date22.textColor = UIColor.black
                                self.detailview.addSubview(date22)
                                date22.translatesAutoresizingMaskIntoConstraints = false
                                date22.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 250).isActive = true
                                date22.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons + 5).isActive = true
                                
                                
                                
                                
                                let viewcontentlst = UIView()
                                viewcontentlst.backgroundColor = .darkGray
                                self.detailview.addSubview(viewcontentlst)
                                viewcontentlst.translatesAutoresizingMaskIntoConstraints = false
                                viewcontentlst.leftAnchor.constraint(equalTo: self.detailview.leftAnchor, constant: 0).isActive = true
                                viewcontentlst.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons).isActive = true
                                viewcontentlst.rightAnchor.constraint(equalTo: self.detailview.rightAnchor, constant: 0).isActive = true
                                viewcontentlst.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons + 100).isActive = true
                                viewcontentlst.heightAnchor.constraint(equalToConstant: 5).isActive = true
                                
                                
                                
                                cons = cons + 100
                                
                                self.tag = self.tag + self.tag
                               
                                
                                
                                
                                
                                
                                
                            
                                
                                
                                
                                
                            }
                        }
                        
                        
                        
                        
                    }
                    
                }
                
                else
                {
                    let alert = UIAlertController(title: "Failure", message: "No Data found", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                         })
                         alert.addAction(ok)
                    self.present(alert, animated: true)
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
    vc.printingItem = detailview.toImage()
    vc.present(from: self.view.frame, in: self.view, animated: true, completionHandler: nil)
  
        
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
    
    @objc func processButtonClickEvent(srcObj : UIButton) -> Void{
        
        let tag : String = String(srcObj.tag)
        
        var tagset = Int(tag)

        let viewtoprint = detailview.viewWithTag(tagset! + 10) as! UIView
        
        let info = UIPrintInfo(dictionary: nil)
    info.outputType = UIPrintInfo.OutputType.general
    info.jobName = "Print"
    
    let vc = UIPrintInteractionController.shared
    vc.printInfo = info
    vc.printingItem = viewtoprint.toImage()
    vc.present(from: self.view.frame, in: self.view, animated: true, completionHandler: nil)
    
        
        
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
