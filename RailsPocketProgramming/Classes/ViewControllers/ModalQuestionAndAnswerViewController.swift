import UIKit
import SwiftyJSON

class ModalQuestionAndAnswerViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBAction func closeModalBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    var questions: [JSON]!
    var index: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBar.setColor(self)

        self.tableView.estimatedRowHeight = 400
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self

        let indexPath = NSIndexPath(forRow: self.index, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("modalQuestionAndAnswerCell") as! ModalQuestionAndAnswerTableViewCell
        cell.build(questions[indexPath.row].dictionaryValue, index: indexPath.row)
        cell.layoutIfNeeded()
        return cell
    }
}