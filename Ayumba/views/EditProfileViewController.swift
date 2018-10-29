//
//  EditProfileViewController.swift
//  Ayumba
//
//  Created by Admin on 10/29/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profession: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var contact: UITextField!
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    var imagePicker = UIImagePickerController()
    var base64Image : String! = ""
    var setup = Setup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgProfile.layer.borderWidth = 1
        imgProfile.layer.masksToBounds = false
        imgProfile.layer.borderColor = UIColor.black.cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        imgProfile.clipsToBounds = true
        
        let strbase64 = String(describing: UserDefaults.standard.value(forKey:"avatar")!)
        
            profession.text = String(describing: UserDefaults.standard.value(forKey:"profession")!)
            email.text = String(describing: UserDefaults.standard.value(forKey:"email")!)
            contact.text = String(describing: UserDefaults.standard.value(forKey:"contact")!)
            
            imgProfile.image = setup.base64Convert(strbase64: strbase64)
            
     

        // Do any additional setup after loading the view.
    }
    
    func Load() throws {
        print("sending request..")
        let parameters = [
            "email": String(describing: email.text!),
            "contact": String(describing: contact.text!),
            "password": String(describing: password.text!),
            "photo": String(describing: base64Image!)
        ]
        //print (parameters)
        let request = SendHttpRequest("change-user","POST", parameters,[:])
        request.send() { responseObject, error in
            // response from request sent
            let result = responseObject! as String
            let dic = request.parseJsonString(input: result)
            print(dic)
            
            for data in dic {
                if(data["success"] as Any as! String == "0"){
                    //success
                    self.alertMessage(message: data["message"]! as! String, messageTitle: String(describing: "Update Successfull"))
                    
                    
                }else{
                    //failed
                    
                    self.alertMessage(message: data["message"]! as! String, messageTitle: String(describing: "Update Failed"))
                }
            }
            
            
        }
        
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        /*
         Get the image from the info dictionary.
         If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
         instead of `UIImagePickerControllerEditedImage`
         */
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            print(editedImage)
            self.imgProfile.image = editedImage
            
            
            let imageData:NSData = UIImagePNGRepresentation(editedImage)! as NSData
            // convert the NSData to base64 encoding
            self.base64Image = imageData.base64EncodedString()
            
        }
        
        //Dismiss the UIImagePicker after selection
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func updateInfo(_ sender: Any) {
        if((email.text?.isEmpty)! && (contact.text?.isEmpty)! && (password.text?.isEmpty)!){
            alertMessage(message: "Input required", messageTitle: "Please fill in all input")
            return
        }
        
        do {
            updateBtn.isEnabled = false
            loader.isHidden = false
            loader.startAnimating()
            
            try Load()
        } catch  {
            
            alertMessage(message: "Error", messageTitle: "An Error has occured. \(error)")
        }
        
        
    }
    
    
    func alertMessage(message : String, messageTitle :String){
        updateBtn.isEnabled = true
        loader.isHidden = true
        loader.stopAnimating()
        
        let alert = UIAlertController(title: messageTitle, message: String(describing: message ), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
