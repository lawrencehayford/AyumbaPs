
import UIKit

class ExploreViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    let services = ["capentery","cleaning","plumbing","massage","makeup","painting","trainer"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.services.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ServicesTableView
        cell.ServiceImage.image = UIImage(named: (self.services[indexPath.row] + ".jpg"))
        cell.ServiceName.text = self.services[indexPath.row]
        return (cell)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
