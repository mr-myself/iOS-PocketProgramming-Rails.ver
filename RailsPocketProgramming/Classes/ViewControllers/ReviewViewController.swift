import UIKit

class ReviewViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var reviewViewModel: ReviewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBar.setColor(self)
    
        reviewViewModel = ReviewViewModel(parentVC: self)
        ReviewData.fetch(reviewViewModel.setup)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}