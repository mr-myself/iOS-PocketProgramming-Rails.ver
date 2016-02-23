import UIKit
import SwiftyJSON

class QuestionViewModel {
    let parentVC: QuestionViewController
    var question: Question!

    init(parentVC: QuestionViewController) {
        self.parentVC = parentVC
    }

    func setup(question: Question) {
        self.question = question

        setText()
        makeBtnsEnable()
        setProgressBar()
    }

    private func setText() {
        let nthDay = (self.question.day!%7 == 0 ? 7 : self.question.day!%7)
        self.parentVC.dayAndQuestionCount.text = String(format: NSLocalizedString("nthDayAndQuestion", comment: ""), nthDay.description, self.parentVC.questionCount.description)
        self.parentVC.questionTextView.text = question.question["sentence"]?.stringValue
        self.parentVC.questionTextView.selectable = false
        self.parentVC.questionTextView.layoutIfNeeded()
        self.parentVC.questionTextView.scrollEnabled = true
        self.parentVC.questionTextView.flashScrollIndicators()
        setBtnTitle()
    }

    private func setBtnTitle() {
        self.parentVC.choice1Btn.setTitle(question.choices![0]["title"].stringValue, forState: UIControlState.Normal)
        self.parentVC.choice2Btn.setTitle(question.choices![1]["title"].stringValue, forState: UIControlState.Normal)
        self.parentVC.choice3Btn.setTitle(question.choices![2]["title"].stringValue, forState: UIControlState.Normal)
    }

    private func setProgressBar() {
        self.parentVC.questionProgressBar.image = UIImage(named: "progress_bar\(self.parentVC.questionCount)a.png")
    }

    private func makeBtnsEnable() {
        self.parentVC.choice1Btn.enabled = true
        self.parentVC.choice2Btn.enabled = true
        self.parentVC.choice3Btn.enabled = true
        self.parentVC.showAnswerBtn.enabled = true
    }
}