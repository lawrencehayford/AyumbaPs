
import UIKit

class ServicesTableView: UITableViewCell {

    @IBOutlet weak var ServiceImage: UIImageView!
    
    @IBOutlet weak var ServiceName: UILabel!
    
    @IBOutlet weak var serviceDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
