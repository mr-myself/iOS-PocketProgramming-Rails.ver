import Foundation
import SwiftyJSON

class WeekSummary {
    var ok: [JSON]?
    var no: [JSON]?
   
    init(json: JSON) {
        ok = json["ok"].arrayValue
        no = json["no"].arrayValue
    }
}