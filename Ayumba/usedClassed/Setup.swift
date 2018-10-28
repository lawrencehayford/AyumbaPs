
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
    
    
    
    
}
