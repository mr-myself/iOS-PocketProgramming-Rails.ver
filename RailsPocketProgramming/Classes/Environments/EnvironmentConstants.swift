import Foundation

class EnvironmentConstants {

    static let HOST_URL = "HOST_URL"
    static let APP_STORE_URL = "https://itunes.apple.com/app/id1069270469?mt=8"

    static func lang() -> String {
        let regex = try? NSRegularExpression(pattern: "ja", options: NSRegularExpressionOptions())
        let localLang = NSLocale.preferredLanguages().first! as NSString
        if ((regex?.firstMatchInString(localLang as String, options: NSMatchingOptions(), range: NSMakeRange(0, localLang.length))) != nil) {
            return "ja"
        } else {
            return "en"
        }
    }
}
