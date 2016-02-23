import UIKit

class SummaryViewController: BaseViewController {

    @IBOutlet weak var week1Btn: UIButton!
    @IBOutlet weak var week2Btn: UIButton!
    @IBOutlet weak var week3Btn: UIButton!
    @IBOutlet weak var week4Btn: UIButton!
    
    var summaryViewModel: SummaryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#90161E")
        
        summaryViewModel = SummaryViewModel(parentVC: self)
        DayData.fetchStartDay(summaryViewModel.setup)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let summaryTableViewController = segue.destinationViewController as! SummaryTableViewController
        switch segue.identifier! {
        case "week1Btn":
            summaryTableViewController.week = 1
            break
        case "week2Btn":
            summaryTableViewController.week = 2
            break
        case "week3Btn":
            summaryTableViewController.week = 3
            break
        case "week4Btn":
            summaryTableViewController.week = 4
            break
        default:
            break
        }
    }
}