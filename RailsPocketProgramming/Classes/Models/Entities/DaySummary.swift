import Foundation
import SwiftyJSON

class DaySummary {
    var day: Int?
    var nextDay: Int?
    var questions: [JSON]?
    var score: Int?
   
    init(json: JSON) {
        day       = json["day"].intValue
        nextDay   = json["next_day"].intValue
        questions = json["questions"].arrayValue
        score     = json["score"].intValue
    }
}
