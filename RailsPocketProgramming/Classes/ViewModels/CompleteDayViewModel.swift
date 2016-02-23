import UIKit

class CompleteDayViewModel {

    let parentVC: CompleteDayViewController
    var daySummary: DaySummary!

    init(parentVC: CompleteDayViewController) {
        self.parentVC = parentVC
    }

    func setup(daySummary: DaySummary) {
        self.daySummary = daySummary
       
        setScoreImage()
        setNextDayText()
        makeBtnsEnable()
        setLayout()
    }

    private func setScoreImage() {
        self.parentVC.scoreImage.image = UIImage(named: "score_" + self.daySummary.score!.description)
        
        if self.daySummary.score >= 80 {
            AVAudioPlayerUtil.setValue("good")
            AVAudioPlayerUtil.play();
        } else if self.daySummary.score <= 30 {
            AVAudioPlayerUtil.setValue("shock")
            AVAudioPlayerUtil.play();
        } else {
            AVAudioPlayerUtil.setValue("normal")
            AVAudioPlayerUtil.play();
        }
    }
    
    private func setLayout() {
        self.parentVC.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0) // for showing TabBar
        self.parentVC.tableView.separatorColor = UIColor.whiteColor() // hidden tableView separator
        self.parentVC.tableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0) // remove the blank between title and tableView
    }

    private func setNextDayText() {
        checkNext()
        let day = self.parentVC.day%7
        self.parentVC.completedDay.text = String(format: NSLocalizedString("completedDay", comment: ""), day.description)
        self.parentVC.whatYouLearned.text = String(format: NSLocalizedString("whatYouLearned", comment: ""), day.description)
    }
    
    private func checkNext() {
        if self.daySummary.nextDay! == 0 || (self.daySummary.nextDay!-1)%7 == 0 {
            self.parentVC.nextDayBtnTop.setTitle(String(format: NSLocalizedString("toThisWeekSummary", comment: "")), forState: UIControlState.Normal)
            self.parentVC.nextDayBtnBottom.setTitle(String(format: NSLocalizedString("toThisWeekSummary", comment: "")), forState: UIControlState.Normal)
            self.parentVC.nextDayBtnTop.setBackgroundImage(UIImage(named: "button_next_star_large.png"), forState: UIControlState.Normal)
            self.parentVC.nextDayBtnBottom.setBackgroundImage(UIImage(named: "button_next_star_large.png"), forState: UIControlState.Normal)
        } else {
            let weekStartDay = (self.daySummary.nextDay!%7 == 0 ? 7 : self.daySummary.nextDay!%7)
            self.parentVC.nextDayBtnTop.setTitle(String(format: NSLocalizedString("challengeNthDay", comment: ""), weekStartDay), forState: UIControlState.Normal)
            self.parentVC.nextDayBtnBottom.setTitle(String(format: NSLocalizedString("challengeNthDay", comment: ""), weekStartDay), forState: UIControlState.Normal)
        }
    }

    private func makeBtnsEnable() {
        self.parentVC.nextDayBtnTop.enabled = true
        self.parentVC.nextDayBtnBottom.enabled = true
    }
}