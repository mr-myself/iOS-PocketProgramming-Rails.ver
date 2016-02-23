import UIKit
import SwiftyJSON

class ReviewViewModel {
    
    let parentVC: ReviewViewController!
    var weekViewHeight: Int!
    var jsonReview: JSON!
    
    init(parentVC: ReviewViewController) {
        self.parentVC = parentVC
    }
    
    func setup(json: JSON) {
        self.jsonReview = json
        self.weekViewHeight = setEachWeekViewHeight()
        
        buildFourWeeksReviewView()
        defineScrollViewSize()
    }
   
    private func buildFourWeeksReviewView() {
        for var i=1; i<=4; i++ {
            let weekScores: [Dictionary<String, JSON>?] = extractOneWeekScores(i)
            
            let frame = CGRectMake(0, (i==1 ? 0 : CGFloat((i-1)*weekViewHeight)), self.parentVC.view.bounds.width, CGFloat(weekViewHeight))
            let weekReviewView = WeekReviewView(frame: frame, parentVM: self, week: i, data: weekScores)
            self.parentVC.scrollView.addSubview(weekReviewView)
        }
    }
    
    private func defineScrollViewSize() {
        self.parentVC.scrollView.contentSize = CGSizeMake(self.parentVC.view.bounds.width, CGFloat(weekViewHeight!*4))
    }
    
    private func extractOneWeekScores(week: Int) -> [Dictionary<String, JSON>?] {
        var weekScores: [Dictionary<String, JSON>?] = []
        let weekDays = (((week-1)*7+1)...(week*7))
        
        for day in weekDays {
            if day <= jsonReview.count {
                weekScores.append(jsonReview[day-1].dictionaryValue)
            } else {
               weekScores.append(nil)
            }
        }
        return weekScores
    }
    
    private func setEachWeekViewHeight() -> Int {
        if 1.0 < UIScreen.mainScreen().scale {
            let size = UIScreen.mainScreen().bounds.size
            let scale = UIScreen.mainScreen().scale
            let result = CGSizeMake(size.width * scale, size.height * scale)
            switch result.height {
            case 960:  // 4,4s
                return 600
            case 1136: // 5,5s,5c
                return 600
            case 1334: // 6,6s
                return 680
            case 2208: // 6plus, 6splus
                return 712
            default:
                return 712
            }
        } else {
            return 600
        }
    }
}