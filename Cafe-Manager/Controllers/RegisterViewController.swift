//
//  RegisterViewController.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-21.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    
    
    
    
    @IBAction func registerbtn(_ sender: Any) {
        
        let phonev = phone.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailv = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let validationclass = Cafe_Manager.validations()
        
        if validationclass.validationEmailPasswordphone(email: emailv, password: pass, phone: phonev)!
        {
            
            
            if validationclass.RegXEmail(email: emailv)! && (validationclass.RegXpassword(password: pass)!) && (validationclass.RegXphone(phone: phonev)!)
            {
            
            Auth.auth().createUser(withEmail: emailv, password: pass) { (result, err) in
                if err != nil {
//                    self.showToast(message:"Registrasion fail", font: .systemFont(ofSize: 12.0))
                    let alert = UIAlertController(title: "Registration failure", message: "User already Exist", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                         })
                         alert.addAction(ok)
                    self.present(alert, animated: true)
                }
                else
                {
                    let db = Firestore.firestore()
                  
                    let ref =  db.collection("User")
                    
                    let imagename : String? = (result?.user.uid)! + ".png"
                    
                    
                    ref.addDocument(data: ["phone" :phonev,"UID" : result!.user.uid , "image":imagename!,"email": result!.user.email!]) { (erro) in
                        if erro != nil
                        {
//                            self.showToast(message:"Registration error ", font: .systemFont(ofSize: 12.0))
                            
                        }
                        else
                        {
                            UserDefaults.standard.set(result?.user.uid, forKey: "userId")
                          
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "homeSet") as! UITabBarController

                                self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                    }
                }
            }
            }
            else
            {
                
                if validationclass.RegXEmail(email: emailv)!
                {
                    
                }
                else
                {
                let alert = UIAlertController(title: "Registration failure", message: "Invalid Email", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.email.layer.borderWidth = 1.0
                    self.email.layer.borderColor = UIColor.red.cgColor
                     })
                     alert.addAction(ok)
                self.present(alert, animated: true)
                }
                
                if validationclass.RegXpassword(password: pass)!
                {
                    
                }
                else
                {
                    let alert = UIAlertController(title: "Registration failure", message: "Password must be Minimum 8 characters at least 1 Alphabet and 1 Number", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.password.layer.borderWidth = 1.0
                        self.password.layer.borderColor = UIColor.red.cgColor
                         })
                         alert.addAction(ok)
                    self.present(alert, animated: true)
                }
                
                if validationclass.RegXphone(phone: phonev)!
                {
                    
                }
                else
                {
                    let alert = UIAlertController(title: "Registration failure", message: "Invalid Phone number", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.phone.layer.borderWidth = 1.0
                        self.phone.layer.borderColor = UIColor.red.cgColor
                         })
                         alert.addAction(ok)
                    self.present(alert, animated: true)
                }
            }
        }
        else
        {
            let alert = UIAlertController(title: "Registration failure", message: "Required field empty", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 })
                 alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
    
    

    

}

