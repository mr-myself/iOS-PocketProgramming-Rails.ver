import UIKit
import Social

class LevelUpPopupViewController: BaseViewController {

    @IBOutlet weak var newLevelImage: UIImageView!
    @IBOutlet weak var oldLevelImage: UIImageView!
    @IBOutlet weak var levelUpText: UILabel!

    @IBAction func twitterShareBtn(sender: AnyObject) {
        let tweetText = String(format: NSLocalizedString("tweetLevelUp", comment: ""), self.target.capitalizedString, self.oldLevel.capitalizedString, self.newLevel.capitalizedString)
        let composeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
        composeViewController.setInitialText(tweetText)
        composeViewController.addURL(NSURL(string: EnvironmentConstants.HOST_URL + "/" + EnvironmentConstants.lang()))
        
        self.presentViewController(composeViewController, animated: true, completion: nil)
    }

    var target: String! // ruby or rails
    var oldLevel: String!
    var newLevel: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let levelUpPopupViewModel = LevelUpPopupViewModel(parentVC: self)
        levelUpPopupViewModel.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}