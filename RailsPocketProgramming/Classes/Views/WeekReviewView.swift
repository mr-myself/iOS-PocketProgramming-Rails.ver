import UIKit
import SwiftyJSON
import BubbleTransition

@IBDesignable
class WeekReviewView: UIView, UIViewControllerTransitioningDelegate {
   
    @IBOutlet weak var iconBird: UIImageView!
   
    @IBOutlet weak var day1Score: UIImageView!
    @IBOutlet weak var day2Score: UIImageView!
    @IBOutlet weak var day3Score: UIImageView!
    @IBOutlet weak var day4Score: UIImageView!
    @IBOutlet weak var day5Score: UIImageView!
    @IBOutlet weak var day6Score: UIImageView!
    @IBOutlet weak var day7Score: UIImageView!
    
    var view:UIView!
    var parentVM: ReviewViewModel!
    var week: Int!
    var data: [Dictionary<String, JSON>?]!
    let transition = BubbleTransition()
    
    init(frame: CGRect, parentVM: ReviewViewModel, week: Int, data: [Dictionary<String, JSON>?]) {
        super.init(frame: frame)
        self.parentVM = parentVM
        self.week = week
        self.data = data
        
        comminInit()
        setTouchInterection()
        setImages()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        comminInit()
    }
   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        let index = (touch.view?.tag)!
        
        if index != 0 && data[index-1] != nil {
            let nthDay = (self.week-1)*7 + (touch.view?.tag)!
            segue(nthDay)
        }
    }
    
    func segue(nthDay: Int) {
        let questionViewController = parentVM.parentVC.storyboard!.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
        questionViewController.day = nthDay
        questionViewController.questionId = 0
        questionViewController.transitioningDelegate = self
        questionViewController.modalPresentationStyle = .Custom
        parentVM.parentVC.presentViewController(questionViewController, animated: true, completion: nil)
    }
    
    // xibからカスタムViewを読み込んで準備する
    private func comminInit() {
        // MyCustomView.xib からカスタムViewをロードする
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "WeekReviewView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil).first as! UIView
        addSubview(view)
        
        // カスタムViewのサイズを自分自身と同じサイズにする
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
    }
    
    private func setImages() {
        self.iconBird.image = UIImage(named: "icon_bird" + self.week.description)
        
        var scoreList = [String]()
        for i in (0...6) {
            scoreList.append(self.data[i] == nil ? "question" : self.data[i]!["score"]!.stringValue)
        }
        self.day1Score.image = UIImage(named: "score_" + scoreList[0])
        self.day2Score.image = UIImage(named: "score_" + scoreList[1])
        self.day3Score.image = UIImage(named: "score_" + scoreList[2])
        self.day4Score.image = UIImage(named: "score_" + scoreList[3])
        self.day5Score.image = UIImage(named: "score_" + scoreList[4])
        self.day6Score.image = UIImage(named: "score_" + scoreList[5])
        self.day7Score.image = UIImage(named: "score_" + scoreList[6])
    }
   
    private func setTouchInterection() {
        if data[0] != nil {
            self.day1Score.userInteractionEnabled = true
            self.day1Score.tag = 1
        }
        if data[1] != nil {
            self.day2Score.userInteractionEnabled = true
            self.day2Score.tag = 2
        }
        if data[2] != nil {
            self.day3Score.userInteractionEnabled = true
            self.day3Score.tag = 3
        }
        if data[3] != nil {
            self.day4Score.userInteractionEnabled = true
            self.day4Score.tag = 4
        }
        if data[4] != nil {
            self.day5Score.userInteractionEnabled = true
            self.day5Score.tag = 5
        }
        if data[5] != nil {
            self.day6Score.userInteractionEnabled = true
            self.day6Score.tag = 6
        }
        if data[6] != nil {
            self.day7Score.userInteractionEnabled = true
            self.day7Score.tag = 7
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = self.center
        transition.bubbleColor = UIColor.whiteColor()
        return transition
    }
}