import UIKit
import SwiftyJSON
import UIColor_Hex_Swift

class CompleteDayCustomCell: UITableViewCell {
    
    @IBOutlet weak var correctOrWrongText: UILabel!
    @IBOutlet weak var nthQuestionText: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var toExplanationBtn: UIButton!
    @IBAction func toExplanationBtn(sender: AnyObject) {
    }
    
    func build(nth: Int, question: [String: JSON]) {
        nthQuestionText.text = String(format: NSLocalizedString("nthQuestion", comment: ""), (nth+1).description)
        if question["result"]?.boolValue == true {
            correctOrWrongText.text = NSLocalizedString("correct", comment: "")
            correctOrWrongText.backgroundColor = UIColor(rgba: "#009F93")
        } else {
            correctOrWrongText.text = NSLocalizedString("wrong", comment: "")
            correctOrWrongText.backgroundColor = UIColor(rgba: "#AF353D")
        }
        questionText.text = question["text"]?.stringValue
        questionText.sizeToFit()
        toExplanationBtn.tag = nth
        
        setLayout()
    }
    
    private func setLayout() {
        correctOrWrongText.layer.cornerRadius = 4
        correctOrWrongText.clipsToBounds = true
    }
}