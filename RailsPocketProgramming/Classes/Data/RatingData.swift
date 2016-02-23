import Foundation

class RatingData {
   
    class func get(timing: String) -> Bool? {
        let userDefault = NSUserDefaults.standardUserDefaults()
        return userDefault.objectForKey(timing + "Rating") as? Bool
    }
    
    class func create(timing: String) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(false, forKey: timing + "Rating")
        userDefault.synchronize()
    }
}