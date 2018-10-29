
import Foundation
import CoreLocation
import UIKit

class Setup{
    
    var ArtisanservicesArr = [String]()
    var MovingHomeArr = [String]()
    var filteredArr : [String] = []
    var imageExtension : String = ".jpg"
    var imagePath : String = "http://ps.ayumba.com/service_images/"
    var selectedService : String!
    let defaults = UserDefaults.standard
    
    init() {
        
    }
    
    
    
     func GetArtisan() -> [String]{
        
        return self.ArtisanservicesArr
    }
    
     func GetMovingHome() -> [String]{
        return self.MovingHomeArr
    }
    
    func GetImageExtension() -> String {
        return self.imageExtension
    }
    
    
    func SetFilteredArr(Arr : [String] ) {
        self.filteredArr = Arr
    }
    
    func GetFilteredArr() -> [String]{
        return self.filteredArr
    
    }
    
    func SetSelectedRow(Row : String){
        
        self.selectedService = Row
    }
    func GetSelectedRow() -> String {
        return self.selectedService
    }
    
    func base64Convert(strbase64: String?) -> UIImage{
        if (strbase64?.isEmpty)! {
            return #imageLiteral(resourceName: "no_image_found")
        }else {
            // !!! Separation part is optional, depends on your Base64String !!!
            let dataDecoded:NSData = NSData(base64Encoded: strbase64!, options: NSData.Base64DecodingOptions(rawValue: 0))!
            let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
            return decodedimage
        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    
}
