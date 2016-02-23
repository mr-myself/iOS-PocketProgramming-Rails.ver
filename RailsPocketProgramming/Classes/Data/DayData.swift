import Foundation
import Alamofire
import SwiftyJSON

class DayData {

    static var startDay: Int!

    class func fetchStartDay(callback: Int -> ()) {

        Alamofire.request(.GET, EnvironmentConstants.HOST_URL, parameters: ["uuid": UserIdData.get()!, "lang": EnvironmentConstants.lang()])
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)
                    startDay = json["start_day"].intValue
                    callback(startDay)

                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
    }

    class func createCompletedDay(completedDay: Int) {

        Alamofire.request(.POST, EnvironmentConstants.HOST_URL, parameters: ["uuid": UserIdData.get()!])
            .response { request, response, data, error in
            print(error)
        }
    }
}
