import UIKit

class NoNetworkViewController: UIViewController, UITabBarDelegate {

    @IBOutlet weak var tabBar: UITabBar?

    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBar.setColor(self)
        self.tabBar?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        switch item.tag {
        case 1:
            checkAndSegue(segueToMain)
            break;
        case 2:
            checkAndSegue(segueToReview)
            break;
        case 3:
            checkAndSegue(segueToSummary)
            break;
        default:
            break;
        }
    }

    private func segueToMain() {
        let topTabBarController = storyboard!.instantiateViewControllerWithIdentifier("topTabBarController")
        presentViewController(topTabBarController, animated: false, completion: nil)
    }

    private func segueToReview() {
        let topTabBarController = storyboard!.instantiateViewControllerWithIdentifier("topTabBarController") as! UITabBarController
        topTabBarController.selectedIndex = 1
        presentViewController(topTabBarController, animated: false, completion: nil)
    }

    private func segueToSummary() {
        let topTabBarController = storyboard!.instantiateViewControllerWithIdentifier("topTabBarController") as! UITabBarController
        topTabBarController.selectedIndex = 2
        presentViewController(topTabBarController, animated: false, completion: nil)
    }

    private func checkAndSegue(callback: () -> ()) {
        let reachability: AMReachability
        do {
            reachability = try AMReachability.reachabilityForInternetConnection()
            if reachability.isReachable() {
                callback()
            }
        } catch {
            print("Unable to create Reachability")
        }
    }
}