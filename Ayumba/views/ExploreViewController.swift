
import UIKit
import  CoreLocation



class ExploreViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    var selectedType:String?
    
    var services =  Setup()
    var locationManager = CLLocationManager()
    var latitude : String?
    var longitude : String?
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        services.SetFilteredArr(
            Arr: searchText.isEmpty ? services.GetArtisan() : services.GetArtisan().filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
            )
        
        table.reloadData()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return services.GetFilteredArr().count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ServicesTableView
        
        
            if let url = URL(string: services.imagePath + services.GetFilteredArr()[indexPath.row] + services.imageExtension) {
                downloadImage(from: url, cell: cell, service: services)
            }
            //cell.ServiceImage.image = UIImage(named: (services.imagePath + services.GetFilteredArr()[indexPath.row] + services.imageExtension))
            cell.ServiceName.text = services.GetFilteredArr()[indexPath.row].uppercased()
        
       return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loader.startAnimating()
        print("you are here")
       
       
        //********************
        
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            self.Load()
            DispatchQueue.main.async {
                // Run UI Updates or call completion block
                print("Finished all requests.")
                
            }
        }
        //********************
     

        
        
       
        
    
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
       
        do{
            
            try self.Locate()
        }catch {
            print("Error occured")
        }
        
       
        // Do any additional setup after loading the view.
    }
    
    
    func Load() {
        
        
        let request = SendHttpRequest("get-services","POST",[:],[:])
        request.send() { responseObject, error in
            // response from request sent
            let result = responseObject! as String
            let dic = request.parseJsonString(input: result)
            print(dic)
            for data in dic {
                //check if we need to show it
                if(data["show"] as Any as! String == "N"){
                    continue
                }
                //checking if type is normal service or moving to home
                if(data["type"] as Any as! String == "1"){
                
                    self.services.ArtisanservicesArr.append(data["service-name"] as Any as! String)
                }else{
                    self.services.MovingHomeArr.append(data["service-name"] as Any as! String)
                }
                
                
            }
            self.services.SetFilteredArr(Arr: self.services.GetArtisan())
            self.table.reloadData()
            print(self.services.GetArtisan())
            self.loader.stopAnimating()
            self.loader.isHidden = true
            return
        }
        
    }
    
    func Locate(){
        
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.startUpdatingLocation()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func OnSegmentSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print ("0 selected")
            services.SetFilteredArr(Arr: services.GetArtisan())
            table.reloadData()
            break
        case 1:
            print ("1 selected")
            services.SetFilteredArr(Arr: services.GetMovingHome())
            table.reloadData()
            break
        default:
            break
           
        }
    }
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        services.SetSelectedRow(Row: services.GetFilteredArr()[indexPath.row])
        performSegue(withIdentifier: "MainSeque", sender: self)
    }
 */
    
    func downloadImage(from url: URL, cell : ServicesTableView, service : Setup ) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                cell.ServiceImage.image = UIImage(data: data)
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // Print out the location to the console
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latitude = String(location.coordinate.latitude)
            longitude = String(location.coordinate.longitude)
            print(location.coordinate)
        }
    }
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedType = services.GetFilteredArr()[indexPath.row]
        performSegue(withIdentifier: "MainSeque", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "MainSeque") {
            let vc = segue.destination  as! MainServicesViewController
            vc.type = selectedType
            vc.latitude = latitude
            vc.longitude = longitude
        }    }
    
    
    
}
