//
//  SigninViewController.swift
//  Ayumba
//
//  Created by Admin on 10/27/18.
//  Copyright © 2018 Ayumba. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    
    struct serviceStruct: Codable {
        let id : String
        let name : String
        let type : String
        let logo : String
        let description : String
        let show : String
    }
    
    var dict : [String : AnyObject]!
    var userName : String!
    var userProfession: String!
    var userLogo : String!
    var userContact : String!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var servicePicker: UIPickerView!
    let services = Setup()
    var serviceArr = [serviceStruct]()
    var imagePicker = UIImagePickerController()
    var ProfessionSelected : String! = "1"
    var ProfessionSelectedName : String! = "Plumbing"
    var base64Image : String! = ""
    
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
        loader.isHidden = true
        if let data = UserDefaults.standard.value(forKey:"Services") as? Data {
            self.serviceArr = try! PropertyListDecoder().decode(Array<serviceStruct>.self, from: data)
            print(serviceArr)
        }
        
        self.servicePicker.delegate = self
        self.servicePicker.dataSource = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return serviceArr.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return serviceArr[row].name
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

    //function is fetching the user data
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func signUp(_ sender: UIButton) {
        if((fullname.text?.isEmpty)! && (email.text?.isEmpty)! && (contact.text?.isEmpty)! && (password.text?.isEmpty)!){
            alertMessage(message: "Input required", messageTitle: "Please fill in all input")
            return
            }
        
        do {
             signupButton.isEnabled = false
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
            "fullname": String(describing: fullname.text!),
            "email": String(describing: email.text!),
            "password": String(describing: password.text!),
            "contact": String(describing: contact.text!),
            "profession": String(describing: ProfessionSelected!),
            "photo": String(describing: base64Image!),
            "longitude": String(describing: UserDefaults.standard.value(forKey:"longitude")!),
             "latitude": String(describing: UserDefaults.standard.value(forKey:"latitude")!)
            
        ]
        //print (parameters)
        let request = SendHttpRequest("add-user","POST", parameters,[:])
        request.send() { responseObject, error in
            // response from request sent
            let result = responseObject! as String
            let dic = request.parseJsonString(input: result)
            print(dic)
            
            for data in dic {
                if(data["success"] as Any as! String == "0"){
                    //success
                    self.alertMessage(message: data["message"]! as! String, messageTitle: String(describing: "Registration Successfull"))
                    
                    UserDefaults.standard.set( self.base64Image, forKey: "avatar")
                    UserDefaults.standard.set( self.fullname.text, forKey: "fullname")
                    UserDefaults.standard.set( String(describing: self.email.text!), forKey: "email")
                    UserDefaults.standard.set( String(describing: self.ProfessionSelectedName!), forKey: "profession")
                    UserDefaults.standard.set( String(describing: self.contact.text!), forKey: "contact")
                    
                    
                    self.fullname.text = ""
                    self.email.text = ""
                    self.contact.text = ""
                    self.password.text = ""
                    
                    self.performSegue(withIdentifier: "GotoCallProfessionalSeque", sender: self)
                   
                }else{
                    //failed
                    
                    self.alertMessage(message: data["message"]! as! String, messageTitle: String(describing: "Registration Failed"))
                }
            }
            
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        ProfessionSelected = serviceArr[row].id as String
        ProfessionSelectedName = serviceArr[row].name as String
        
    }
    func alertMessage(message : String, messageTitle :String){
        signupButton.isEnabled = true
        loader.isHidden = true
        loader.stopAnimating()
        
        let alert = UIAlertController(title: messageTitle, message: String(describing: message ), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
