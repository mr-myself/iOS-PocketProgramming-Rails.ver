import Foundation
import Alamofire
import SwiftyJSON

class SummaryData {

    var daySummary: DaySummary!
    var weekSummary: WeekSummary!
    var day: Int!
    var week: Int!

    init(day: Int) {
        self.day = day
    }

    init(week: Int) {
        self.week = week
    }

    func fetchTheDay(callback: DaySummary -> ()) {

        Alamofire.request(.GET, EnvironmentConstants.HOST_URL, parameters: ["uuid": UserIdData.get()!, "lang": EnvironmentConstants.lang()])
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    self.daySummary = DaySummary(json: JSON(data))
                    callback(self.daySummary)

                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
    }

    func fetchTheWeek(callback: WeekSummary -> ()) {

        Alamofire.request(.GET, EnvironmentConstants.HOST_URL, parameters: ["uuid": UserIdData.get()!, "lang": EnvironmentConstants.lang()])
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    self.weekSummary = WeekSummary(json: JSON(data))
                    callback(self.weekSummary)

                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
    }
}
