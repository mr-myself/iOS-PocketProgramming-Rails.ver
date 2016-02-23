import UIKit

class BaseViewController: UIViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

        let name = NSStringFromClass(self.classForCoder).componentsSeparatedByString(".").last!
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)

        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
}