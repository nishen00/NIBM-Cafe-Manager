//
//  orderdtlViewController.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-20.
//

import UIKit
import Firebase
import GeoFire

class orderdtlViewController: UIViewController {
    
    @IBOutlet weak var customername: UILabel!
    @IBOutlet weak var statusbtn: UIButton!
    
    @IBOutlet weak var callbtn: UIButton!
    
    @IBOutlet weak var orderdtlsview: UIView!
    

    var isarrive : Int = 0
    var name : String = ""
    var btnstatus : Int = 0
    var docid : String = ""
    var orderid : String = ""
    var Phone : String = ""
    var Userid : String = ""
    let db = Firestore.firestore()
    var geoFireRef: DatabaseReference?
        var geoFire: GeoFire?
        var myQuery: GFQuery?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        geoFireRef = Database.database().reference().child("Geolocs")
                
        geoFire = GeoFire(firebaseRef: geoFireRef!)
        
        customername.text = name + "(" + orderid + ")"
        var status : String = ""
        if(btnstatus == 2)
        {
            status = "Accepted"
        }
        
        if(btnstatus == 3)
        {
            status = "Prepararing"
        }
        
        if (btnstatus == 4)
        {
            status = "Ready"
            
            if isarrive == 1
            {
                let location:CLLocation = CLLocation(latitude: 37.785834, longitude: -122.406417)
               
                
                myQuery = geoFire?.query(at: location, withRadius: 100)
                
                myQuery?.observe(.keyEntered, with: {(key,location) in
                
                
                    if key == self.Userid
                    {
                        self.statusbtn.setTitle("Arrving", for: .normal)
                        self.statusbtn.backgroundColor = .yellow
                        self.statusbtn.setTitleColor(.black, for: .normal)
                        
                    }
                
                
                
                })
            }
        }
        
        if (btnstatus == 1)
        {
            status = "Waiting"
        }
        
        if btnstatus == 5
        {
            status = "Rejected"
            self.statusbtn.backgroundColor = .red
           
        }
        
        if btnstatus == 6
        {
            status = "Done"
            self.statusbtn.backgroundColor = .green
            self.statusbtn.setTitleColor(.black, for: .normal)
        }
        
        statusbtn.setTitle(status, for: .normal)
        statusbtn.layer.cornerRadius = 0.1 * statusbtn.bounds.size.width
        
        
        orderdtlsview.layer.borderWidth = 1.0
        orderdtlsview.layer.borderColor = UIColor.darkGray.cgColor
        orderdtlsview.backgroundColor = .white
        orderdtlsview.layer.shadowColor = UIColor.gray.cgColor
        orderdtlsview.layer.shadowOpacity = 0.4
        orderdtlsview.layer.shadowOffset = CGSize.zero
        orderdtlsview.layer.shadowRadius = 6
        
        
        

      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        for subview in self.orderdtlsview.subviews {
            
               subview.removeFromSuperview()
            
        }
        
        var cons : CGFloat = 50
            let docRef = db.collection("order").document(docid)
        
        docRef.getDocument { (document, error) in
            if let document = document,document.exists{
                
                let dd = document.data()
                let totalfind = dd!["totalAmount"] as! Float
                
               
                let ts =  dd!["dateTime"]  as! Timestamp
                let aDate = ts.dateValue()
                let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss aa"
                    let formattedTimeZoneStr = formatter.string(from: aDate)
                
                let date = UILabel()
                
                date.textAlignment = .center
                date.text = formattedTimeZoneStr
                date.textColor = UIColor.black
                self.orderdtlsview.addSubview(date)
                date.translatesAutoresizingMaskIntoConstraints = false
                date.leftAnchor.constraint(equalTo: self.orderdtlsview.leftAnchor, constant: 10).isActive = true
                date.topAnchor.constraint(equalTo: self.orderdtlsview.topAnchor, constant: 5).isActive = true
                
                
                let docorderdtl = self.db.collection("orderdtl")
                
                docorderdtl.whereField("orderid", isEqualTo: self.docid).getDocuments { (snap, error) in
                    
                    if error != nil
                    {
                        print("error")
                    }
                    else
                    {
                        
                        for element in (snap?.documents)! {
                            let data = element.data()
                            
                            let item = UILabel()
                            
                            item.textAlignment = .center
                            item.text = data["Name"] as? String
                            item.textColor = UIColor.black
                            self.orderdtlsview.addSubview(item)
                            item.translatesAutoresizingMaskIntoConstraints = false
                            item.leftAnchor.constraint(equalTo: self.orderdtlsview.leftAnchor, constant: 30).isActive = true
                            item.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons).isActive = true
                            
                            
                            let qty = data["qty"] as? Int
                            let singleprice = data["singleprice"] as? Int
                            
                            let convertstrinprice = String(singleprice!)
                            let convertstrinqty = String(qty!)
                            
                            let final = convertstrinqty + " X " + "Rs." + convertstrinprice
                            
                            let price = UILabel()
                            
                            price.textAlignment = .center
                            price.text = final
                            price.textColor = UIColor.black
                            self.orderdtlsview.addSubview(price)
                            price.translatesAutoresizingMaskIntoConstraints = false
                            price.rightAnchor.constraint(equalTo: self.orderdtlsview.rightAnchor, constant: -30).isActive = true
                            price.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons).isActive = true
                            
                            cons = cons + 50
                        }
                        
                        
                        
                        let total = UILabel()
                        let totget = String("TOTAL: Rs." + String(totalfind))
                        total.textAlignment = .center
                        total.text = totget
                        total.textColor = UIColor.black
                        self.orderdtlsview.addSubview(total)
                        total.translatesAutoresizingMaskIntoConstraints = false
                        total.rightAnchor.constraint(equalTo: self.orderdtlsview.rightAnchor, constant: -30).isActive = true
                        total.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons + 5).isActive = true
                        
                        
                        
                        
                        
                    
                        
                        
                        
                        
                    }
                }
                
                
                
                
               
            }
        }
    }
    
    
    @IBAction func call(_ sender: Any) {
        
        guard let url = URL(string: "telprompt://\(Phone)"),
                UIApplication.shared.canOpenURL(url) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    
    
    

}
