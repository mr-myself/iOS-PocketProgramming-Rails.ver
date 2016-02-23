import UIKit
import SwiftyJSON

class AnswerViewModel {
    let parentVC: AnswerViewController
    var question: Question!

    init(parentVC: AnswerViewController) {
        self.parentVC = parentVC
    }
    
    func setup(question: Question) {
        self.question = question
        
        changeBtnBackgroundImages()
        setText()
        makeBtnsEnable()
        setProgressBar()
    }
  
    private func changeBtnBackgroundImages() {
        if self.question.choices![0]["id"].intValue == question.answer {
            self.parentVC.choice1Btn.setBackgroundImage(UIImage(named: "element_card_a_right.png"), forState: UIControlState.Normal)
        } else {
            self.parentVC.choice1Btn.setBackgroundImage(UIImage(named: "element_card_a_wrong.png"), forState: UIControlState.Normal)
        }
        
        if self.question.choices![1]["id"].intValue == question.answer {
            self.parentVC.choice2Btn.setBackgroundImage(UIImage(named: "element_card_b_right.png"), forState: UIControlState.Normal)
        } else {
            self.parentVC.choice2Btn.setBackgroundImage(UIImage(named: "element_card_b_wrong.png"), forState: UIControlState.Normal)
        }
        
        if self.question.choices![2]["id"].intValue == question.answer {
            self.parentVC.choice3Btn.setBackgroundImage(UIImage(named: "element_card_c_right.png"), forState: UIControlState.Normal)
        } else {
            self.parentVC.choice3Btn.setBackgroundImage(UIImage(named: "element_card_c_wrong.png"), forState: UIControlState.Normal)
        }
        
        self.parentVC.nextBtn.setBackgroundImage(UIImage(named: "element_card_d_next.png"), forState: UIControlState.Normal)
    }
    
    private func setText() {
        let nthDay = (self.question.day!%7 == 0 ? 7 : self.question.day!%7)
        self.parentVC.dayAndQuestionCount.text = String(format: NSLocalizedString("nthDayAndQuestion", comment: ""), nthDay.description, self.parentVC.questionCount.description)
        self.parentVC.answerTextView.text = question.explanation
        self.parentVC.answerTextView.selectable = false
        self.parentVC.answerTextView.layoutIfNeeded()
        self.parentVC.answerTextView.scrollEnabled = true
        self.parentVC.answerTextView.flashScrollIndicators()
        setBtnTitle()
    }
    
    private func setBtnTitle() {
        self.parentVC.choice1Btn.setTitle(question.choices![0]["title"].stringValue, forState: UIControlState.Normal)
        self.parentVC.choice2Btn.setTitle(question.choices![1]["title"].stringValue, forState: UIControlState.Normal)
        self.parentVC.choice3Btn.setTitle(question.choices![2]["title"].stringValue, forState: UIControlState.Normal)
    }

    private func setProgressBar() {
        self.parentVC.answerProgressBar.image = UIImage(named: "progress_bar\(self.parentVC.questionCount)b.png")
    }

    private func makeBtnsEnable() {
        self.parentVC.nextBtn.enabled = true
    }
}