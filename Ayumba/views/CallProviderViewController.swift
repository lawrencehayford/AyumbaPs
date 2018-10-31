//
//  CallProviderViewController.swift
//  Ayumba
//
//  Created by Admin on 10/30/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit
import MessageUI
@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
class CallProviderViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var providerTelephone: UILabel!
    @IBOutlet weak var providerEmail: UILabel!
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var distance: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        providerName.text = String(describing: UserDefaults.standard.value(forKey:"professionalName")!)
        providerTelephone.text = String(describing: UserDefaults.standard.value(forKey:"professionalContact")!)
         serviceName.text = String(describing: UserDefaults.standard.value(forKey:"professionalProfession")!)
         distance.text = String(describing: UserDefaults.standard.value(forKey:"professionaldistance")!) + "miles"
        
        
        let catPictureURL = URL(string:  String(describing: UserDefaults.standard.value(forKey:"professionalPhoto")!))!
        
        // Creating a session object with the default configuration.
        // You can read more about it here https://developer.apple.com/reference/foundation/urlsessionconfiguration
        let session = URLSession(configuration: .default)
        
        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        self.imgPhoto.image = image
                        // Do something with your image.
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        downloadPicTask.resume()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Call(_ sender: Any) {
        dialNumber(number: providerTelephone.text!)
    }
    @IBAction func Message(_ sender: Any) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Hi \(String(describing: providerName.text)), i understand you sepcialised in \(String(describing: serviceName.text)) and i need your services"
            controller.recipients = ([providerTelephone.text] as! [String])
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
    
    @IBAction func Back(_ sender: Any) {
        self.performSegue(withIdentifier: "CallToMainSeque", sender: self)
        
    }
    
}
