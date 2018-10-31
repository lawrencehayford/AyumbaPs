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
    @IBOutlet weak var loginBtn: UIButton!
    var setup = Setup()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if(setup.isKeyPresentInUserDefaults(key: "email")){
        loginBtn.isHidden = true
        signbtn.isHidden = false
        let base64 = String(describing: UserDefaults.standard.value(forKey:"avatar")!)
            if(base64.count > 100){
                let strbase64 = base64
                avatar.image = setup.base64Convert(strbase64: strbase64)
                
            }
       profession.text! = String(describing: UserDefaults.standard.value(forKey:"profession")!)
       email.text! = String(describing: UserDefaults.standard.value(forKey:"email")!)
       contact.text! = String(describing: UserDefaults.standard.value(forKey:"contact")!)
      profileName.text! = String(describing: UserDefaults.standard.value(forKey:"fullname")!)
            
       
            
        }else{
            signbtn.isEnabled = false
            editbtn.isEnabled = false
            loginBtn.isHidden = false;
            signbtn.isHidden = true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signOut(_ sender: Any) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "goToLoginSeque", sender: self)
        
        //goToLoginSeque
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func alertMessage(message : String, messageTitle :String){
        
        let alert = UIAlertController(title: messageTitle, message: String(describing: message ), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }

}
