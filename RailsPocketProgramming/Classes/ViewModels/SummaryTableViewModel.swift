import UIKit

class SummaryTableViewModel {
    let parentVC: SummaryTableViewController
    var weekSummary: WeekSummary!
    
    init(parentVC: SummaryTableViewController) {
        self.parentVC = parentVC
    }
    
    func setup(weekSummary: WeekSummary) {
        self.weekSummary = weekSummary
        self.parentVC.navigationItem.title = "WEEK" + self.parentVC.week.description
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.parentVC.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
    }

    func buildCell(cell: SummaryTableViewCell, index: Int) -> SummaryTableViewCell {
        let okCount = self.parentVC.summaryData.weekSummary.ok!.count
        if (okCount-1) >= index {
            cell.build(true, title: self.parentVC.summaryData.weekSummary.ok![index].stringValue)
            cell.userInteractionEnabled = false
            cell.accessoryType = UITableViewCellAccessoryType.None
        } else {
            cell.build(false, title: self.parentVC.summaryData.weekSummary.no![index-okCount]["title"].stringValue)
        }
        return cell
    }
}