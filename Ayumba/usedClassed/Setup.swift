
import Foundation
class Setup{
    
    var ArtisanservicesArr = [String]()
    var MovingHomeArr = [String]()
    var imageExtension : String = "jpg"
    
    init() {
        self.ArtisanservicesArr = ["capentery","cleaning","plumbing","massage","makeup","painting","trainer"]
        self.MovingHomeArr = ["capentery","cleaning"]
        
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
    
    
    
    
    
}
