import UIKit
import SwiftyJSON
import BubbleTransition
import Social

class CompleteDayViewController: BaseViewController, UIViewControllerTransitioningDelegate, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    @IBOutlet weak var completedDay: UILabel!
    @IBOutlet weak var whatYouLearned: UILabel!
    @IBOutlet weak var scoreImage: UIImageView!
    @IBOutlet weak var nextDayBtnTop: UIButton!
    @IBOutlet weak var nextDayBtnBottom: UIButton!
    @IBAction func nextDayBtn(sender: AnyObject) {
        if summaryData.daySummary.nextDay! == 0 || (summaryData.daySummary.nextDay!-1)%7 == 0 {
            performSegueWithIdentifier("toSummary", sender: nil)
        } else {
            segueToNextDay()
        }
    }
    @IBAction func retryDayBtn(sender: AnyObject) {
        performSegueWithIdentifier("retryDay", sender: nil)
    }
    @IBAction func twitterShareBtn(sender: AnyObject) {
        let weekNthDay = (self.day%7 == 0 ? 7 : self.day%7)
        let week = (self.day > 28 ? 4 : (self.day-1)/7+1)
        let tweetText = String(format: NSLocalizedString("tweetDayComplete", comment: ""), week.description, weekNthDay.description, self.summaryData.daySummary.score!.description)
        let composeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
        composeViewController.setInitialText(tweetText)
        composeViewController.addURL(NSURL(string: EnvironmentConstants.HOST_URL))

        self.presentViewController(composeViewController, animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var scrollView: UIScrollView!

    var day: Int!
    var completeDayViewModel: CompleteDayViewModel!
    var summaryData: SummaryData!
    let transition = BubbleTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBar.setColor(self)

        self.tableView.estimatedRowHeight = 125
        self.tableView.rowHeight = UITableViewAutomaticDimension

        completeDayViewModel = CompleteDayViewModel(parentVC: self)
        summaryData = SummaryData(day: self.day)
        summaryData.fetchTheDay(self.setupView)

        let levelManager = LevelManager(uiViewController: self)
        levelManager.update()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tabBar.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        tableViewHeightConstraint.constant = self.tableView.contentSize.height
        self.view.layoutIfNeeded()
    }

    func setupView(daySummary: DaySummary) {
        completeDayViewModel.setup(daySummary)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summaryData.daySummary != nil ? summaryData.daySummary.questions!.count : 0
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        //cell deque
        let cell = self.tableView.dequeueReusableCellWithIdentifier("completeDayCustomCell") as! CompleteDayCustomCell
        if summaryData.daySummary != nil {
            cell.build(indexPath.row, question: summaryData.daySummary.questions![indexPath.row].dictionaryValue)
        }

        cell.layoutIfNeeded()
        return cell
    }

    func showPopUp() {
        let LevelUpPopupView = LevelUpPopupViewController(nibName:"LevelUpPopupView", bundle:nil)
        presentPopupViewController(LevelUpPopupView, animationType: MJPopupViewAnimationSlideBottomBottom)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        switch segue.identifier! {
        case "retryDay":
            let questionViewController = segue.destinationViewController as! QuestionViewController
            questionViewController.day = self.day
            questionViewController.questionId = 0
            questionViewController.transitioningDelegate = self
            questionViewController.modalPresentationStyle = .Custom
            break

        case "toExplanation":
            let modalQuestionAndAnswerViewController = segue.destinationViewController as! ModalQuestionAndAnswerViewController
            modalQuestionAndAnswerViewController.questions = self.summaryData.daySummary.questions
            modalQuestionAndAnswerViewController.index = sender.tag
            break

        case "toSummary":
            let nav = segue.destinationViewController as! UINavigationController
            let weekSummaryTableViewController = nav.topViewController as! WeekSummaryTableViewController
            weekSummaryTableViewController.week = summaryData.daySummary.day! / 7
            break

        default:
            break
        }
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = self.view.center
        transition.bubbleColor = UIColor.whiteColor()
        return transition
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.bubbleColor = UIColor.whiteColor()
        return transition
    }

    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        switch item.tag {
        case 1:
            segueToMain()
            break
        case 2:
            segueToReview()
            break
        case 3:
            segueToSummary()
            break
        default:
            break
        }
    }

    private func segueToMain() {
        let topTabBarController = storyboard!.instantiateViewControllerWithIdentifier("topTabBarController")
        presentViewController(topTabBarController, animated: false, completion: nil)
    }

    private func segueToReview() {
        let topTabBarController = storyboard!.instantiateViewControllerWithIdentifier("topTabBarController") as! UITabBarController
        topTabBarController.selectedIndex = 1
        presentViewController(topTabBarController, animated: false, completion: nil)
    }

    private func segueToSummary() {
        let topTabBarController = storyboard!.instantiateViewControllerWithIdentifier("topTabBarController") as! UITabBarController
        topTabBarController.selectedIndex = 2
        presentViewController(topTabBarController, animated: false, completion: nil)
    }

    private func segueToNextDay() {
        let questionViewController = storyboard!.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
        questionViewController.day = self.summaryData.daySummary.nextDay!
        questionViewController.questionId = 0
        questionViewController.transitioningDelegate = self
        questionViewController.modalPresentationStyle = .Custom
        presentViewController(questionViewController, animated: true, completion: nil)
    }
}