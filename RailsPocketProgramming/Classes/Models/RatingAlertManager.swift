import Foundation

class RatingAlertManager {
   
    static var startDay: Int!
    static var targetViewController: UIViewController!
    
    class func showOrNot(targetViewController: UIViewController, startDay: Int) {
        self.startDay = startDay
        self.targetViewController = targetViewController
        
        if isShowFirstAlert() {
            showRatingAlert("first")
        } else if isShowSecondAlert() {
            showRatingAlert("second")
        }
    }
    
    private class func isShowFirstAlert() -> Bool {
        return (15 <= self.startDay && self.startDay <= 20) && RatingData.get("first") == true
    }
    
    private class func isShowSecondAlert() -> Bool {
        return self.startDay == 29 && RatingData.get("second") == true
    }
    
    private class func showRatingAlert(timing: String) {
        let alertController = alertControllerInstance()
        alertController.addAction(reviewAction())
        alertController.addAction(notNowAction())
        RatingData.create(timing)
        
        self.targetViewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private class func alertControllerInstance() -> UIAlertController {
        return UIAlertController(
          title: NSLocalizedString("ratingAlertTitle", comment: ""),
          message: NSLocalizedString("ratingAlertDescription", comment: ""),
          preferredStyle: .Alert
        )
    }

    private class func reviewAction() -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("ratingAlertAccceptTitle", comment: ""), style: .Cancel) {
          action in
            UIApplication.sharedApplication().openURL(NSURL(string: EnvironmentConstants.APP_STORE_URL)!)
        }
    }
    
    private class func notNowAction() -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("ratingAlertNotNowTitle", comment: ""), style: .Default) { action in }
    }
}