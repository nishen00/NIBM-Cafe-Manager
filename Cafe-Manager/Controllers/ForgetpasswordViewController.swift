//
//  ForgetpasswordViewController.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-21.
//

import UIKit
import FirebaseAuth

class ForgetpasswordViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    
    @IBAction func sendemail(_ sender: Any) {
        
        let emailget = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if emailget.isEmail {
        
        Auth.auth().sendPasswordReset(withEmail: email.text!) { (error) in
           if error != nil
           {
              print ("error")
           }
            else
           {
            let alert = UIAlertController(title: "Reset Email", message: "Please Check your Email", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                self.email.layer.borderWidth = 1.0
                self.email.layer.borderColor = UIColor.red.cgColor
                 })
                 alert.addAction(ok)
            self.present(alert, animated: true)
           }
        }
        }
        
        else
        {
            let alert = UIAlertController(title: "Reset Email", message: "Invalid Email", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                self.email.layer.borderWidth = 1.0
                self.email.layer.borderColor = UIColor.red.cgColor
                 })
                 alert.addAction(ok)
            self.present(alert, animated: true)
        }    }
    
    

    
 

}
