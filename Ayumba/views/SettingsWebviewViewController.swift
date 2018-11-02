//
//  SettingsWebviewViewController.swift
//  Ayumba
//
//  Created by Admin on 11/2/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit
import WebKit

class SettingsWebviewViewController: UIViewController {
    var indexSelected : String!
    var url : URL!
   
    @IBOutlet weak var wkwebview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch indexSelected {
        case "0":
            
           self.url = URL(string: "http:/ps.ayumba.com/about")
            break
        case "1":
            
           self.url = URL(string: "http:/ps.ayumba.com/privacy")
            break
        case "2":
            
           self.url = URL(string: "http:/ps.ayumba.com/terms")
            break
        case "3":
            
           self.url = URL(string: "http:/ps.ayumba.com/disclaimer")
            break
        default:
            break
            
        }
       
        let request = URLRequest(url : self.url!)
        wkwebview.load(request)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: Any) {
        performSegue(withIdentifier: "fromSettingsToMainSeque", sender: self)
    }
    //fromSettingsToMainSeque
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
