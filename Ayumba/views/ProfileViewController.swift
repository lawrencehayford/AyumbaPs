//
//  ProfileViewController.swift
//  Ayumba
//
//  Created by Admin on 9/26/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var profession: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var signbtn: UIButton!
    @IBOutlet weak var editbtn: UIButton!
    @IBOutlet weak var profileName: UILabel!
    var setup = Setup()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if(setup.isKeyPresentInUserDefaults(key: "email")){
            
        let strbase64 = String(describing: UserDefaults.standard.value(forKey:"avatar")!)
       profession.text! = String(describing: UserDefaults.standard.value(forKey:"profession")!)
       email.text! = String(describing: UserDefaults.standard.value(forKey:"email")!)
       contact.text! = String(describing: UserDefaults.standard.value(forKey:"contact")!)
      profileName.text! = String(describing: UserDefaults.standard.value(forKey:"fullname")!)
          
       avatar.image = setup.base64Convert(strbase64: strbase64)
            
        }else{
            signbtn.isEnabled = false
            editbtn.isEnabled = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
