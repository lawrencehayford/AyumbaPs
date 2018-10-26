//
//  MainServicesViewController.swift
//  Ayumba
//
//  Created by Admin on 10/26/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit

class MainServicesViewController: UIViewController {
    var type : String?
    var latitude : String?
    var longitude : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("latitude : \(latitude)")
        print("longitude : \(longitude)")
        print("type : \(type)")
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

}
