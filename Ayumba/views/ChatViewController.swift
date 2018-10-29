//
//  ChatViewController.swift
//  Ayumba
//
//  Created by Admin on 9/26/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit
import WebKit

class ChatViewController: UIViewController {
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http:/ps.ayumba.com/chat")
        let request = URLRequest(url : url!)
        webview.load(request)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        // 1
     
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
