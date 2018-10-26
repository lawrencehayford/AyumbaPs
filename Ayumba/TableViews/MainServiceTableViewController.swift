//
//  MainServiceTableViewController.swift
//  Ayumba
//
//  Created by Admin on 10/12/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit
class MainServiceTableViewController: UITableViewController {

    var type = String!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //locationManager.requestWhenInUseAuthorization()
        
        // If location services is enabled get the users location
        
        let parameters: [String : String] = ["type": "1",
                                             "longitude":"",
                                             "latitude":""]
        let request = SendHttpRequest("get-service-users","POST",parameters,[:])
        request.send() { responseObject, error in
            // response from request sent
            
           
            print(responseObject! as String)
            
            return
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...

        return cell
    }
   
   
}
