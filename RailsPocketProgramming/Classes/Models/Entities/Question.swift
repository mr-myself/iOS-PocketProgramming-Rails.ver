import Foundation
import SwiftyJSON

class Question {
    var question_id: Int?
    var day: Int?
    var question: [String : JSON] = [:]
    var choices: [JSON]?
    var answer: Int?
    var explanation: String?
    var next_id: Int?
   
    init(json: JSON) {
        question_id  = json["question_id"].intValue
        day          = json["day"].intValue
        question     = json["question"].dictionaryValue
        choices      = json["choices"].arrayValue
        answer       = json["answer"].intValue
        explanation  = json["explanation"].stringValue
        next_id      = json["next_id"].intValue
    }
}