import Foundation
import SwiftyJSON

class Level {
    var rubyLevel: String?
    var railsLevel: String?
   
    init(json: JSON) {
        rubyLevel  = json["ruby_level"].stringValue
        railsLevel = json["rails_level"].stringValue
    }
}
