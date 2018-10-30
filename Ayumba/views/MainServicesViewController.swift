//
//  MainServicesViewController.swift
//  Ayumba
//
//  Created by Admin on 10/26/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit
import  Alamofire

class MainServicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    struct Person {
        let name : String
        let image : String
        let distance : String
        let profession : String
        let contact : String
    }
    var setup = Setup()
    var personInfo = [Person]()
    var PersonImage : String!
    var PersonProfession : String!
    var PersonContact : String!
    var PersonName : String!
    
    @IBOutlet weak var table: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("count is : \(self.personInfo.count)")
        return self.personInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maincell", for: indexPath) as! MainServicesTableViewCell
        print("populated table with name : \(self.personInfo[indexPath.row].name)")
        
        cell.username.text = self.personInfo[indexPath.row].name
        cell.profession.text = self.personInfo[indexPath.row].profession
        cell.distance.text = self.personInfo[indexPath.row].distance
        
       
        return cell
    }
    
    var type : String!
    var latitude : String!
    var longitude : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("latitude : \(String(describing: latitude!))")
        print("longitude : \(String(describing: longitude!))")
        print("type : \(String(describing: type!))")
        loader.isHidden = false
        loader.startAnimating()
        // Do any additional setup after loading the view.
        
        //********************
        
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            self.Load()
            DispatchQueue.main.async {
                // Run UI Updates or call completion block
                print("Finished all requests.")
                self.loader.stopAnimating()
                self.loader.isHidden = true
                self.table.reloadData()
                
            }
        }
        //********************
    }
    
    
    
    func Load() {
        
        let parameters = [
            "type": String(describing: type!),
            "latitude": "-0.2335539", //String(describing: latitude),
            "longitude": "5.5493243" //String(describing: longitude)
            
        ]
        let request = SendHttpRequest("get-service-users","POST", parameters,[:])
        request.send() { responseObject, error in
            // response from request sent
            let result = responseObject! as String
            let dic = request.parseJsonString(input: result)
            print(dic)
            for data in dic {
                //appending in a struct
                self.personInfo.append(Person(
                    name: String(describing: data["username"]! ),
                image: String(describing: data["avatar"]! ),
                distance: String(describing: data["distance"]! as! Double )
                ,
                profession: String(describing: data["gender"]!),
                contact: String(describing: data["contact"]! )
                
                ))
              
                
            }
            
            self.table.reloadData()
            print ("table reloaded");
            return
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UserDefaults.standard.set(self.personInfo[indexPath.row].image, forKey: "professionalPhoto")
         UserDefaults.standard.set(self.personInfo[indexPath.row].name, forKey: "professionalName")
         UserDefaults.standard.set(self.personInfo[indexPath.row].contact, forKey: "professionalContact")
         UserDefaults.standard.set(self.personInfo[indexPath.row].profession, forKey: "professionalProfession")
        UserDefaults.standard.set(self.personInfo[indexPath.row].distance, forKey: "professionaldistance")
        if(setup.isKeyPresentInUserDefaults(key: "email")){
            //user already logged in  so callserviceprovider
             performSegue(withIdentifier: "Callserviceprovider", sender: self)
            
        }else{
            //user hasnt signed up. send him to signup page
            performSegue(withIdentifier: "SignupSeque", sender: self)
        }
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        if(segue.identifier == "SigninSeque") {
            let vc = segue.destination  as! SigninViewController
            vc.userName = PersonName
            vc.userLogo = PersonImage
            vc.userContact = PersonContact
            vc.userProfession = PersonProfession
        }
         */
 }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
