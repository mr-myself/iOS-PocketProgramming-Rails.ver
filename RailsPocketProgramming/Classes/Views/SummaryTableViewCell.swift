import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var genreTitle: UILabel!
    @IBOutlet weak var trueOrFalseImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func build(result: Bool, title: String ) {
        self.genreTitle.text = title
        if result == true {
             trueOrFalseImage.image = UIImage(named: "icon_right")
        } else {
             trueOrFalseImage.image = UIImage(named: "icon_wrong")
        }
    }
}
