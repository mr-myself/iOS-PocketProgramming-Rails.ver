import UIKit
import WYInteractiveTransitions
import AVFoundation

class QuestionViewController: BaseViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var choice1Btn: UIButton!
    @IBOutlet weak var choice2Btn: UIButton!
    @IBOutlet weak var choice3Btn: UIButton!
    @IBOutlet weak var showAnswerBtn: UIButton!
    @IBOutlet weak var dayAndQuestionCount: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var questionProgressBar: UIImageView!
    @IBAction func choice1Btn(sender: AnyObject) {
        performSegueWithIdentifier("choice1Btn", sender: nil)
    }
    @IBAction func choice2Btn(sender: AnyObject) {
        performSegueWithIdentifier("choice2Btn", sender: nil)
    }
    @IBAction func choice3Btn(sender: AnyObject) {
        performSegueWithIdentifier("choice3Btn", sender: nil)
    }
    @IBAction func showAnswerBtn(sender: AnyObject) {
        performSegueWithIdentifier("showAnswerBtn", sender: nil)
    }
    @IBAction func backToMainBtn(sender: AnyObject) {
        performSegueWithIdentifier("backToMainBtn", sender: nil)

        let transition: CATransition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom

        self.view.window?.layer.addAnimation(transition,forKey: kCATransition)
    }

    var questionCount = 1
    var questionData: QuestionData!
    var questionViewModel: QuestionViewModel!
    var day: Int!
    var questionId: Int!
    let transitionMgr = WYInteractiveTransitions()

    var nextQuestion: Question?
    var targetQuestion: Question!

    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBar.setColor(self)
        questionViewModel = QuestionViewModel(parentVC: self)

        if isFirstQuestion() {
            questionData = QuestionData(day: day, questionId: questionId)
            questionData.fetch(setup)
        } else {
            targetQuestion = nextQuestion!
            nextQuestion = nil
            questionViewModel.setup(targetQuestion)
            fetchNextQuestion()
        }
    }

    private func setNextQuestion(question: Question) {
        self.nextQuestion = question
    }

    private func setup(question: Question) {
        questionViewModel.setup(question)
        self.targetQuestion = question
        fetchNextQuestion()
    }

    private func fetchNextQuestion() {
        if !isLastQuestion() {
            questionData = QuestionData(day: day, questionId: targetQuestion.next_id)
            questionData.fetch(setNextQuestion)
        }
    }

    private func isFirstQuestion() -> Bool {
        return nextQuestion == nil
    }

    private func isLastQuestion() -> Bool {
        return self.targetQuestion.next_id == 0
    }

    override func viewDidAppear(animated: Bool) {
        questionTextView.flashScrollIndicators()
    }
    
    override func viewWillAppear(animated: Bool) {
        questionTextView.contentOffset.y = -100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        switch segue.identifier! {
        case "choice1Btn":
            checkTrueOrFalse(targetQuestion.choices![0]["id"].intValue)
            segueToAnswerViewController(segue)
            break
        case "choice2Btn":
            checkTrueOrFalse(targetQuestion.choices![1]["id"].intValue)
            segueToAnswerViewController(segue)
            break
        case "choice3Btn":
            checkTrueOrFalse(targetQuestion.choices![2]["id"].intValue)
            segueToAnswerViewController(segue)
            break
        case "showAnswerBtn":
            checkTrueOrFalse(0)
            segueToAnswerViewController(segue)
            break
        default:
            break
        }
    }
    
    private func checkTrueOrFalse(choiceId: Int) {
        if choiceId == targetQuestion.answer {
            TrueOrFalseData.create(targetQuestion.question_id!, result: true)
            AVAudioPlayerUtil.setValue("correct")
            AVAudioPlayerUtil.play();
        } else {
            TrueOrFalseData.create(targetQuestion.question_id!, result: false)
            AVAudioPlayerUtil.setValue("wrong")
            AVAudioPlayerUtil.play();
        }
    }
    
    private func segueToAnswerViewController(segue: UIStoryboardSegue) {
        let answerViewController = segue.destinationViewController as! AnswerViewController
        answerViewController.question = self.targetQuestion
        answerViewController.questionCount = self.questionCount
        answerViewController.nextQuestion = self.nextQuestion
        answerViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(answerViewController, animated: true, completion: nil)
    }
}