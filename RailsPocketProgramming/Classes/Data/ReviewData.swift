import Foundation
import Alamofire
import SwiftyJSON

class ReviewData {

    class func fetch(callback: JSON -> ()) {
        Alamofire.request(.GET, EnvironmentConstants.HOST_URL, parameters: ["uuid": UserIdData.get()!, "lang": EnvironmentConstants.lang()])
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    callback(JSON(data))

                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
    }
}
