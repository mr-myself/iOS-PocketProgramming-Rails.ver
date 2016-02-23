import UIKit
import WYInteractiveTransitions

class AnswerViewController: BaseViewController {
   
    @IBOutlet weak var choice1Btn: UIButton!
    @IBOutlet weak var choice2Btn: UIButton!
    @IBOutlet weak var choice3Btn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var dayAndQuestionCount: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var answerProgressBar: UIImageView!
    @IBAction func nextBtn(sender: AnyObject) {
        if isLastQuestion() {
            DayData.createCompletedDay(question.day!)
            segueToCompleteDay()
        } else {
            segueToQuestion()
        }
    }
    @IBAction func backToMainBtn(sender: AnyObject) {
        let transition: CATransition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom
        
        self.view.window?.layer.addAnimation(transition,forKey: kCATransition)
    }
    
    var questionCount: Int!
    var question: Question!
    var nextQuestion: Question?
    var answerViewModel: AnswerViewModel!
    let transitionMgr = WYInteractiveTransitions()

    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBar.setColor(self)
        
        answerViewModel = AnswerViewModel(parentVC: self)
        answerViewModel.setup(self.question)
    }
    
    override func viewDidAppear(animated: Bool) {
        answerTextView.flashScrollIndicators()
    }
    
    override func viewWillAppear(animated: Bool) {
        answerTextView.contentOffset.y = -100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    private func isLastQuestion() -> Bool {
        return question.next_id == 0
    }
    
    private func segueToCompleteDay() {
        let completeDayViewController = storyboard!.instantiateViewControllerWithIdentifier("CompleteDayViewController") as! CompleteDayViewController
        completeDayViewController.day = question.day
        presentViewController(completeDayViewController, animated: true, completion: nil)
    }
    
    private func segueToQuestion() {
        let questionViewController = storyboard!.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
        questionViewController.nextQuestion = self.nextQuestion
        questionViewController.day = question.day
        questionViewController.questionId = question.next_id
        questionViewController.questionCount = questionCount + 1
        transitionMgr.configureTransition(0.5, toViewController: questionViewController, handGestureEnable: true, transitionType: WYTransitoinType.Push)
        presentViewController(questionViewController, animated: true, completion: nil)
    }
}