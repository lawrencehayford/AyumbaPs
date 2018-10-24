
import Foundation
class Setup{
    
    var ArtisanservicesArr = [String]()
    var MovingHomeArr = [String]()
    var filteredArr : [String]!
    var imageExtension : String = ".jpg"
    var imagePath : String = "http://ps.ayumba.com/service_images/"
    var selectedService : String!
    
    init() {
        
        let request = SendHttpRequest("get-services","POST",[:],[:])
            request.send() { responseObject, error in
            // response from request sent
            let result = responseObject! as String
            let dic = request.parseJsonString(input: result)
            for data in dic {
                
                //check if we need to show it
                if(data["show"] as Any as! String == "N"){
                    continue
                }
                //checking if type is normal service or moving to home
                if(data["type"] as Any as! String == "1"){
                    self.ArtisanservicesArr.append(data["service-name"] as Any as! String)
                }else{
                      self.MovingHomeArr.append(data["service-name"] as Any as! String)
                }
                
                
            }
            return
        }
       
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
