import UIKit
import BubbleTransition

class WeekSummaryTableViewController: BaseViewController, UIViewControllerTransitioningDelegate, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var nextWeekBtn: UIButton!
    @IBAction func nextWeekBtn(sender: AnyObject) {
        startNextWeek()
    }
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!

    var summaryData: SummaryData!
    var weekSummaryTableViewModel: WeekSummaryTableViewModel!
    var week: Int!
    var selectedIndex: Int!
    let transition = BubbleTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBar.setColor(self)

        
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension

        weekSummaryTableViewModel = WeekSummaryTableViewModel(parentVC: self)
        summaryData = SummaryData(week: self.week)
        summaryData.fetchTheWeek(self.setupView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tabBar.delegate = self
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#90161E")
    }

    private func setupView(weekSummary: WeekSummary) {
        weekSummaryTableViewModel.setup(weekSummary)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        tableViewHeightConstraint.constant = self.tableView.contentSize.height
        self.view.layoutIfNeeded()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summaryData.weekSummary != nil ? (summaryData.weekSummary.ok!.count + summaryData.weekSummary.no!.count) : 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("summaryTableViewCell", forIndexPath: indexPath) as! SummaryTableViewCell
        return weekSummaryTableViewModel.buildCell(cell, index: indexPath.row)
    }

    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        self.selectedIndex = indexPath.row
        return indexPath
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let summaryDetailViewController = segue.destinationViewController as! SummaryDetailViewController
        let okCount = self.summaryData.weekSummary.ok!.count
        let analysis = self.summaryData.weekSummary.no![self.selectedIndex-okCount]
        summaryDetailViewController.week = self.week
        summaryDetailViewController.analysis = analysis.dictionaryValue
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

    private func startNextWeek() {
        let questionViewController = storyboard!.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
        questionViewController.day = self.week*7+1
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
        transition.bubbleColor = UIColor.whiteColor()
        return transition
    }
}