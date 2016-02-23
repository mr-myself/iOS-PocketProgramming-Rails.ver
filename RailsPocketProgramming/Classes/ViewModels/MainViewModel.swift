import UIKit

class MainViewModel {
    let parentVC: MainViewController
    var startDay: Int!
    
    init(parentVC: MainViewController) {
        self.parentVC = parentVC
    }
    
    func setup(startDay: Int) {
        self.startDay = startDay

        self.parentVC.dayStartBtn.enabled = true
        setStartDayText()
        setLevels()
        setProgress()
        //RatingAlertManager.showOrNot(self.parentVC, startDay: startDay)
    }
    
    private func setStartDayText() {
        let weekStartDay = (self.startDay%7 == 0 ? 7 : self.startDay%7)
        self.parentVC.dayStartBtn.setTitle(String(format: NSLocalizedString("challengeNthDay", comment: ""), weekStartDay), forState: UIControlState.Normal)
    }
 
    private func setLevels() {
        let levelData = LevelData.get()
        self.parentVC.rubyLevel.image = UIImage(named: "rank_" + levelData["ruby"]!)
        self.parentVC.railsLevel.image = UIImage(named: "rank_" + levelData["rails"]!)
    }
    
    private func setProgress() {
        if finishedEveryday() {
            setCompleteAll()
        } else {
            setProgcessingWeek()
            setProgcessingDay()
        }
    }
    
    private func setProgcessingWeek() {
        let week = (self.startDay > 28 ? 4 : (self.startDay-1)/7+1)
        self.parentVC.processingWeek.image = UIImage(named: "element_birds1_" + week.description)
    }
    
    private func setProgcessingDay() {
        let weekStartDay = (self.startDay%7 == 0 ? 7 : self.startDay%7)
        self.parentVC.processingDay.image = UIImage(named: "icon_eggs1_" + weekStartDay.description)
        
        // Add the aspect ratio constraint
        self.parentVC.view.addConstraint(NSLayoutConstraint(
            item: self.parentVC.processingDay,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.parentVC.processingDay,
            attribute: NSLayoutAttribute.Height,
            multiplier: setProgressingDayRatio(),
            constant: 0))
    }
    
    private func setCompleteAll() {
        self.parentVC.dayStartBtn.enabled = false
        self.parentVC.dayText.text = ""
        self.parentVC.dayStartBtn.setTitle(String(format: NSLocalizedString("completedAllDays", comment: "")), forState: UIControlState.Normal) 
        self.parentVC.processingWeek.image = UIImage(named: "element_birds1_5")
        if EnvironmentConstants.lang() == "ja" {
            self.parentVC.processingDay.image = UIImage(named: "icon_all_finished")
        } else {
            self.parentVC.processingDay.image = UIImage(named: "icon_all_finished_en")
        }
        
        // Add the vertical constraint
        self.parentVC.view.addConstraint(NSLayoutConstraint(
            item: self.parentVC.processingDay,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.parentVC.processingWeek,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1,
            constant: -60))
    }

    private func finishedEveryday() -> Bool {
        return self.startDay == 29
    }
    
    private func setProgressingDayRatio() -> CGFloat {
        if 1.0 < UIScreen.mainScreen().scale {
            let size = UIScreen.mainScreen().bounds.size
            let scale = UIScreen.mainScreen().scale
            let result = CGSizeMake(size.width * scale, size.height * scale)
            switch result.height {
            case 1136: // 5,5s,5c
                return 81/25
            case 1334: // 6,6s
                return 81/20
            case 2208: // 6plus, 6splus
                return 81/16
            default:
                return 81/25
            }
        } else {
            return 81/25
        }
    }
}