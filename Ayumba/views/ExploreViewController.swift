
import UIKit

class ExploreViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    let services =  Setup()
    var filteredData: [String]!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? services.GetArtisan() : services.GetArtisan().filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        table.reloadData()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return filteredData.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ServicesTableView
        
            cell.ServiceImage.image = UIImage(named: (self.filteredData[indexPath.row] + services.imageExtension))
            cell.ServiceName.text = self.filteredData[indexPath.row].uppercased()
        
       return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
         filteredData = services.GetArtisan()
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
            filteredData = services.GetArtisan()
            table.reloadData()
            break
        case 1:
            print ("1 selected")
            filteredData = services.GetMovingHome()
            table.reloadData()
            break
        default:
            break
           
        }
    }
    
}