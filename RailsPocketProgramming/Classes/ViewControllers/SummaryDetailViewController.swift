import UIKit
import BubbleTransition
import SwiftyJSON

class SummaryDetailViewController: BaseViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var analysisTextView: UITextView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var weekAgainBtn: UIButton!
    @IBAction func weekAgainBtn(sender: AnyObject) {
        backToBeginningOfThisWeek()
    }
    @IBOutlet weak var firstUrl: UIButton!
    @IBAction func firstUrl(sender: AnyObject) {
        let url = NSURL(string: self.analysis["url"]![0].stringValue)
        UIApplication.sharedApplication().openURL(url!)
    }
    @IBOutlet weak var firstUrlBtn: UIImageView!
    @IBOutlet weak var secondUrl: UIButton!
    @IBAction func secondUrl(sender: AnyObject) {
        let url = NSURL(string: self.analysis["url"]![1].stringValue)
        UIApplication.sharedApplication().openURL(url!)
    }
    @IBOutlet weak var secondUrlBtn: UIImageView!
    @IBOutlet weak var thirdUrl: UIButton!
    @IBAction func thirdUrl(sender: AnyObject) {
        let url = NSURL(string: self.analysis["url"]![2].stringValue)
        UIApplication.sharedApplication().openURL(url!)
    }
    @IBOutlet weak var thirdUrlBtn: UIImageView!
    
    var analysis: Dictionary<String, JSON>!
    var summaryDetailViewModel: SummaryDetailViewModel!
    var week: Int!
    let transition = BubbleTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        summaryDetailViewModel = SummaryDetailViewModel(parentVC: self)
        summaryDetailViewModel.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        analysisTextView.flashScrollIndicators()
    }
    
    override func viewWillAppear(animated: Bool) {
//        analysisTextView.contentOffset.y = -1000
    }
    
    private func backToBeginningOfThisWeek() {
        let questionViewController = storyboard!.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
        questionViewController.day = self.week*7-6
        questionViewController.transitioningDelegate = self
        questionViewController.modalPresentationStyle = .Custom
        presentViewController(questionViewController, animated: true, completion: nil)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = self.view.center
        transition.bubbleColor = UIColor.whiteColor()
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = self.view.center
        transition.bubbleColor = UIColor.whiteColor()
        return transition
    }
}