import UIKit
import SwiftyJSON

class ModalQuestionAndAnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var nthQuestionText: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var explanationText: UILabel!

    var question: [String: JSON]!
    var index: Int!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func build(question: [String: JSON], index: Int) {
        self.question = question
        self.index = index
        setText()
        setLayout()
    }

    private func setText() {
        questionText.text = self.question["text"]?.stringValue
        answerText.text = self.question["answer"]?.stringValue
        explanationText.text = self.question["explanation"]?.stringValue
        nthQuestionText.text = String(format: NSLocalizedString("nthQuestion", comment: ""), (self.index+1).description)
    }
    
    private func setLayout() {
        nthQuestionText.layer.cornerRadius = 4
        nthQuestionText.clipsToBounds = true
    }
}