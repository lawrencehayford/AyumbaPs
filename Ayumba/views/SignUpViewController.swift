//
//  SigninViewController.swift
//  Ayumba
//
//  Created by Admin on 10/27/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    var dict : [String : AnyObject]!
    var userName : String!
    var userProfession: String!
    var userLogo : String!
    var userContact : String!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var dob: UIDatePicker!
    
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
    }
    
    @IBAction func signUp(_ sender: UIButton) {
    }
    //function is fetching the user data
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
