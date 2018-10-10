//
//  MainServicesViewController.swift
//  Ayumba
//
//  Created by Admin on 10/1/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit

class MainServicesViewController: UIViewController {

    @IBOutlet weak var ServiceName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = SendHttpRequest("","")
        request.send()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
