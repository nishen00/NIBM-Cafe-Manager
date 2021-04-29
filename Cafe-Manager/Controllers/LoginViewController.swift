//
//  LoginViewController.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-17.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
//        let userID = Auth.auth().currentUser?.uid
//
//        if userID != ""
//        {
//            UserDefaults.standard.set(userID, forKey: "userId")
//
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "homeSet") as! UITabBarController
//
//                self.navigationController?.pushViewController(nextViewController, animated: true)
//        }
//        else
//        {
//
//        }
    }
    
    
    
    
    @IBAction func login(_ sender: Any) {
        
        let validationclass = Cafe_Manager.validations()
        
        
        
        if validationclass.validationEmailPassword(email: email.text!, password: password.text!)!
        {
            
            let emailget = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordget = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
           
            
            Auth.auth().signIn(withEmail: emailget, password: passwordget) { (Result, Error) in
                if Error != nil
                {
                    let alert = UIAlertController(title: "Invalid Authentication", message: "Invalid UserName Password", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                         })
                    alert.view.accessibilityIdentifier = "loginalertview"
                    ok.accessibilityIdentifier = "okloginfalse"
                         alert.addAction(ok)
                    self.present(alert, animated: true)
                }
                else
                {
                    UserDefaults.standard.set(Result?.user.uid, forKey: "userId")
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "homeSet") as! UITabBarController

                        self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
            
            
            
        }
        else
        {
            let alert = UIAlertController(title: "Authetication Failure", message: "Required field empty", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 })
                 alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
    }
    
    
    

}
