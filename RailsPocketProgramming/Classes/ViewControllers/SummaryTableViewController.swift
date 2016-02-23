import UIKit

class SummaryTableViewController: UITableViewController {

    var summaryData: SummaryData!
    var summaryTableViewModel: SummaryTableViewModel!
    var week: Int!
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        summaryTableViewModel = SummaryTableViewModel(parentVC: self)
        summaryData = SummaryData(week: self.week)
        summaryData.fetchTheWeek(self.setupView)
    }
    
    private func setupView(weekSummary: WeekSummary) {
        summaryTableViewModel.setup(weekSummary)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

        self.tableView.reloadData()

        // Google Analytics
        let name = NSStringFromClass(self.classForCoder).componentsSeparatedByString(".").last!
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)

        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summaryData.weekSummary != nil ? (summaryData.weekSummary.ok!.count + summaryData.weekSummary.no!.count) : 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("summaryTableViewCell", forIndexPath: indexPath) as! SummaryTableViewCell
        return summaryTableViewModel.buildCell(cell, index: indexPath.row)
    }

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
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
}