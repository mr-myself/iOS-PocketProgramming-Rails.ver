import Foundation
import Alamofire

class DeviceTokenData {

    class func create(deviceToken: String) {

        Alamofire.request(.POST, EnvironmentConstants.HOST_URL, parameters: ["device_token": deviceToken, "uuid": UserIdData.get()!, "lang": EnvironmentConstants.lang()])
            .response { request, response, data, error in
            print(error)
        }
    }
}
