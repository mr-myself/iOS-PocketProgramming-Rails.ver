import Foundation
import Alamofire
import SwiftyJSON

class LevelData {

    class func get() -> Dictionary<String, String> {
        let userDefault = NSUserDefaults.standardUserDefaults()
        let rubyLevel =  userDefault.objectForKey("RubyLevel") as? String
        let railsLevel =  userDefault.objectForKey("RailsLevel")as? String

        return ["ruby": (rubyLevel ?? "e"), "rails": (railsLevel ?? "e")]
    }

    class func fetch(callback: Level -> ()) {
        Alamofire.request(.GET, EnvironmentConstants.HOST_URL, parameters: ["uuid": UserIdData.get()!])
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    let level = Level(json: JSON(data))
                    callback(level)

                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
    }

    class func saveLevel(newLevel: Level) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(newLevel.rubyLevel, forKey: "RubyLevel")
        userDefault.setObject(newLevel.railsLevel, forKey: "RailsLevel")
        userDefault.synchronize()
    }
}
