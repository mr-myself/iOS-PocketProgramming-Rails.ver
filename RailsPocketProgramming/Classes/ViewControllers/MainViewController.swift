import UIKit
import BubbleTransition
import UIColor_Hex_Swift

class MainViewController: BaseViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var dayStartBtn: UIButton!
    @IBOutlet weak var rubyLevel: UIImageView!
    @IBOutlet weak var railsLevel: UIImageView!
    @IBOutlet weak var processingWeek: UIImageView!
    @IBOutlet weak var processingDay: UIImageView!
    @IBOutlet weak var dayText: UILabel!
    @IBAction func dayStartBtn(sender: AnyObject) {
        performSegueWithIdentifier("segue", sender: nil)
    }
    
    let transition = BubbleTransition()
    
    var mainViewModel: MainViewModel!
    var logoImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainViewModel = MainViewModel(parentVC: self)
        DayData.fetchStartDay(mainViewModel.setup)
        StatusBar.setColor(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segue") {
            let questionViewController = segue.destinationViewController as! QuestionViewController
            questionViewController.day = DayData.startDay
            questionViewController.questionId = 0
            questionViewController.transitioningDelegate = self
            questionViewController.modalPresentationStyle = .Custom
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = dayStartBtn.center
        transition.bubbleColor = UIColor.whiteColor()
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = dayStartBtn.center
        transition.bubbleColor = UIColor.whiteColor()
        return transition
    }
}