import Foundation
import Alamofire

class UserIdData {

    class func create() {
        let uuid: NSString = NSUUID().UUIDString

        Alamofire.request(.POST, EnvironmentConstants.HOST_URL, parameters: ["uuid": uuid])
            .response { request, response, data, error in
            print(error)
        }

        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(uuid, forKey: "UUID")
        userDefault.synchronize()
    }

    class func get() -> String? {
        let userDefault = NSUserDefaults.standardUserDefaults()
        return userDefault.objectForKey("UUID") as? String
    }
}
