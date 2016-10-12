//
//  ViewController.swift
//  Lambda
//
//  Created by Buka Cakrawala on 10/10/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButton(_ sender: AnyObject) {
        login()
    }
    
    func login() {
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passField.text!, completion: { (user, error) in
            if error != nil {
                print(error)
            } else {
                
                let uid = FIRAuth.auth()?.currentUser?.uid
                
                let databaseRef = FIRDatabase.database().reference()
                //Checking in the database wether we have the current profile images or not.
                databaseRef.child("users").child(uid!).observe(.value, with: { (snapshot) in
                    //in this case we will grabbing the user's name and testing wether it is actually their or not.
                    if snapshot.childrenCount == 0 {
                        //Go to Picture scene to set up user's profile
                        var vc = self.storyboard?.instantiateViewController(withIdentifier: "Picture")
                        self.present(vc!, animated: true, completion: nil)

                        
                    } else {
                        
                        var vc = self.storyboard?.instantiateViewController(withIdentifier: "Profile")
                        self.present(vc!, animated: true, completion: nil)
                    }
                })
                
            }
            
        })
    }


    @IBAction func signupButton(_ sender: AnyObject) {
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passField.text!, completion: { (user, error) in
            if error != nil {
                print(error)
            } else {
                print("User is created")
                self.login()
            }
        })
    }
}

