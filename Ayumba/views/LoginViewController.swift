//
//  LoginViewController.swift
//  Ayumba
//
//  Created by Admin on 10/27/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func Login(_ sender: Any) {
        
        if((email.text?.isEmpty)! && (password.text?.isEmpty)!){
            alertMessage(message: "Input required", messageTitle: "Please fill in all input")
            return
        }
        
        do {
            loginBtn.isEnabled = false
            loader.isHidden = false
            loader.startAnimating()
            
            try Load()
            
        } catch  {
            
            alertMessage(message: "Error", messageTitle: "An Error has occured. \(error)")
        }
    }
    
    func Load() throws {
        print("sending request..")
        let parameters = [
            "email": String(describing: email.text!),
            "password": String(describing: password.text!)
            
        ]
        //print (parameters)
        let request = SendHttpRequest("get-user-details","POST", parameters,[:])
        request.send() { responseObject, error in
            // response from request sent
            let result = responseObject! as String
            let dic = request.parseJsonString(input: result)
            
            for data in dic {
                if(data["success"] as Any as! String == "Y"){
                    //success
                    
                    UserDefaults.standard.set( data["base64"] as Any as! String, forKey: "avatar")
                    UserDefaults.standard.set( data["fullname"] as Any as! String, forKey: "fullname")
                    UserDefaults.standard.set( String(describing: self.email.text!), forKey: "email")
                    UserDefaults.standard.set( String(data["profession"] as Any as! String), forKey: "profession")
                    UserDefaults.standard.set( String(data["contact"] as Any as! String), forKey: "contact")
                    
                    self.performSegue(withIdentifier: "fromLoginToExploreSeque", sender: self)
                    
                }else{
                    //failed
                    
                    self.alertMessage(message: data["message"]! as! String, messageTitle: String(describing: "Login Failed"))
                }
            }
            
            
        }
        
    }
    
    func alertMessage(message : String, messageTitle :String){
        loginBtn.isEnabled = true
        loader.isHidden = true
        loader.stopAnimating()
        
        let alert = UIAlertController(title: messageTitle, message: String(describing: message ), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }

}
