import Foundation
import Alamofire
import SwiftyJSON

class QuestionData {

    var question: Question!
    var day: Int
    var questionId: Int

    init(day: Int?, questionId: Int?) {
        self.day = (day ?? 0)
        self.questionId = (questionId ?? 0)
    }

    func fetch(callback: Question -> ()) {

        Alamofire.request(.GET, EnvironmentConstants.HOST_URL, parameters: ["lang": EnvironmentConstants.lang()])
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    self.question = Question(json: JSON(data))
                    callback(self.question)

                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
    }
}
