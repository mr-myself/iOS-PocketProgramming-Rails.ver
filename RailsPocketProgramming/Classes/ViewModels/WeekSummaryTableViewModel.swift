import UIKit

class WeekSummaryTableViewModel {
    let parentVC: WeekSummaryTableViewController
    var weekSummary: WeekSummary!
    
    init(parentVC: WeekSummaryTableViewController) {
        self.parentVC = parentVC
    }
    
    func setup(weekSummary: WeekSummary) {
        self.weekSummary = weekSummary
        self.parentVC.navigationItem.title = "WEEK" + self.parentVC.week.description
        self.parentVC.nextWeekBtn.setTitle(String(format: NSLocalizedString("startNextWeek", comment: ""), (self.parentVC.week+1).description), forState: UIControlState.Normal)
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