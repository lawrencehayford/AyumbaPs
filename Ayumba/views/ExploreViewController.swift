
import UIKit

class ExploreViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    let services =  Setup()
    
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
         services.SetFilteredArr(Arr: services.GetArtisan())
        // Do any additional setup after loading the view.
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        services.SetSelectedRow(Row: services.GetFilteredArr()[indexPath.row])
        performSegue(withIdentifier: "MainServiceSeque", sender: self)
    }
    
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
    
}
