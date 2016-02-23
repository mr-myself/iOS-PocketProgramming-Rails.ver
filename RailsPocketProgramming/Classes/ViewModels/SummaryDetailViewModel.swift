import UIKit
import SwiftyJSON

class SummaryDetailViewModel {
    let parentVC: SummaryDetailViewController
    var weekSummary: WeekSummary!
    
    init(parentVC: SummaryDetailViewController) {
        self.parentVC = parentVC
    }

    func setup() {
        setText()
        setReferenceUrls()
    }
 
    private func setText() {
        self.parentVC.navigationItem.title = self.parentVC.analysis["title"]?.stringValue
        self.parentVC.weekAgainBtn.setTitle(String(format: NSLocalizedString("startWeekAgain", comment: ""), self.parentVC.week.description), forState: UIControlState.Normal)
        self.parentVC.analysisTextView.font = UIFont(name: "Helvetica", size: 16)

        // set textString style
        let textStyle = NSMutableParagraphStyle()
        textStyle.lineSpacing = 5.0
        textStyle.paragraphSpacing = 10.0
        
        // set textString font style
        let textFontStyle: String = "Hiragino Kaku Gothic ProN W6"
        let textFontSize: CGFloat = 13.5
        let textFont = UIFont(name: textFontStyle, size: textFontSize)!

        // set all style attributes
        let attributes: Dictionary = [NSParagraphStyleAttributeName: textStyle, NSFontAttributeName: textFont]
        self.parentVC.analysisTextView.attributedText = NSAttributedString(string: (self.parentVC.analysis["sentence"]?.stringValue)!, attributes: attributes)

//        self.parentVC.analysisTextView.selectable = false
//        self.parentVC.analysisTextView.layoutIfNeeded()
//        self.parentVC.analysisTextView.scrollEnabled = true
//        self.parentVC.analysisTextView.flashScrollIndicators()
    }

    private func setReferenceUrls() {
        let referenceCount = self.parentVC.analysis["reference_title"]?.arrayValue.count
        switch referenceCount! {
        case 0:
            self.parentVC.firstUrl.setTitle(nil, forState: UIControlState.Normal)
            self.parentVC.firstUrlBtn.image = nil
            self.parentVC.secondUrl.setTitle(nil, forState: UIControlState.Normal)
            self.parentVC.secondUrlBtn.image = nil
            self.parentVC.thirdUrl.setTitle(nil, forState: UIControlState.Normal)
            self.parentVC.thirdUrlBtn.image = nil

            break
        case 1:
            self.parentVC.firstUrl.setTitle(self.parentVC.analysis["reference_title"]![0].stringValue, forState: UIControlState.Normal)

            self.parentVC.secondUrl.setTitle(nil, forState: UIControlState.Normal)
            self.parentVC.secondUrlBtn.image = nil
            self.parentVC.thirdUrl.setTitle(nil, forState: UIControlState.Normal)
            self.parentVC.thirdUrlBtn.image = nil

            break
        case 2:
            self.parentVC.firstUrl.setTitle(self.parentVC.analysis["reference_title"]![0].stringValue, forState: UIControlState.Normal)
            self.parentVC.secondUrl.setTitle(self.parentVC.analysis["reference_title"]![1].stringValue, forState: UIControlState.Normal)

            self.parentVC.thirdUrl.setTitle(nil, forState: UIControlState.Normal)
            self.parentVC.thirdUrlBtn.image = nil

            break
        case 3:
            self.parentVC.firstUrl.setTitle(self.parentVC.analysis["reference_title"]![0].stringValue, forState: UIControlState.Normal)
            self.parentVC.secondUrl.setTitle(self.parentVC.analysis["reference_title"]![1].stringValue, forState: UIControlState.Normal)
            self.parentVC.thirdUrl.setTitle(self.parentVC.analysis["reference_title"]![2].stringValue, forState: UIControlState.Normal)
        default:
            break
        }
    }
}