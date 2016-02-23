import Foundation
import Alamofire

class TrueOrFalseData {

    class func create(questionId: Int, result: Bool) {

        Alamofire.request(.POST, EnvironmentConstants.HOST_URL,
            parameters: ["uuid": UserIdData.get()!, "result": result.description, "question_id": questionId])
            .response { request, response, data, error in
            print(error)
        }
    }
}
