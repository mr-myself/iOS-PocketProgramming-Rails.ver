import UIKit

class SummaryViewModel {
    let parentVC: SummaryViewController
    var startDay: Int!
    
    init(parentVC: SummaryViewController) {
        self.parentVC = parentVC
    }
    
    func setup(startDay: Int) {
        self.startDay = startDay
       
        setImages()
        setImageRatio()
    }

    private func setImageRatio() {
        let btnList = [self.parentVC.week1Btn, self.parentVC.week2Btn, self.parentVC.week3Btn, self.parentVC.week4Btn]
        for btn in btnList {
            btn.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
            btn.layer.cornerRadius = 5
            btn.layer.shadowOpacity = 0.1
            btn.layer.shadowOffset = CGSizeMake(1, 1)
        }
    }
    
    private func setImages() {
        let finishedWeek = self.startDay / 7
        switch finishedWeek {
        case 0:
            finishedNoWeeks()
            break
        case 1:
            finished1Week()
            break
        case 2:
            finished2Weeks()
            break
        case 3:
            finished3Weeks()
            break
        case 4:
            finishedAllWeeks()
            break
        default:
            finishedNoWeeks()
            break
        }
    }
   
    private func finishedNoWeeks() {
        self.parentVC.week1Btn.userInteractionEnabled = false
        self.parentVC.week2Btn.userInteractionEnabled = false
        self.parentVC.week3Btn.userInteractionEnabled = false
        self.parentVC.week4Btn.userInteractionEnabled = false
        
        self.parentVC.week1Btn.setImage(UIImage(named: "prize_week1_inactive"), forState: .Normal)
        self.parentVC.week2Btn.setImage(UIImage(named: "prize_week2_inactive"), forState: .Normal)
        self.parentVC.week3Btn.setImage(UIImage(named: "prize_week3_inactive"), forState: .Normal)
        self.parentVC.week4Btn.setImage(UIImage(named: "prize_week4_inactive"), forState: .Normal)
    }
    
    private func finished1Week() {
        self.parentVC.week2Btn.userInteractionEnabled = false
        self.parentVC.week3Btn.userInteractionEnabled = false
        self.parentVC.week4Btn.userInteractionEnabled = false
        
        self.parentVC.week1Btn.setImage(UIImage(named: "prize_week1_active"), forState: .Normal)
        self.parentVC.week2Btn.setImage(UIImage(named: "prize_week2_inactive"), forState: .Normal)
        self.parentVC.week3Btn.setImage(UIImage(named: "prize_week2_inactive"), forState: .Normal)
        self.parentVC.week4Btn.setImage(UIImage(named: "prize_week2_inactive"), forState: .Normal)
    }
    
    private func finished2Weeks() {
        self.parentVC.week3Btn.userInteractionEnabled = false
        self.parentVC.week4Btn.userInteractionEnabled = false
        
        self.parentVC.week1Btn.setImage(UIImage(named: "prize_week1_active"), forState: .Normal)
        self.parentVC.week2Btn.setImage(UIImage(named: "prize_week2_active"), forState: .Normal)
        self.parentVC.week3Btn.setImage(UIImage(named: "prize_week3_inactive"), forState: .Normal)
        self.parentVC.week4Btn.setImage(UIImage(named: "prize_week4_inactive"), forState: .Normal)
    }
    
    private func finished3Weeks() {
        self.parentVC.week4Btn.userInteractionEnabled = false
        
        self.parentVC.week1Btn.setImage(UIImage(named: "prize_week1_active"), forState: .Normal)
        self.parentVC.week2Btn.setImage(UIImage(named: "prize_week2_active"), forState: .Normal)
        self.parentVC.week3Btn.setImage(UIImage(named: "prize_week3_active"), forState: .Normal)
        self.parentVC.week4Btn.setImage(UIImage(named: "prize_week4_inactive"), forState: .Normal)
    }
    
    private func finishedAllWeeks() {
        self.parentVC.week1Btn.setImage(UIImage(named: "prize_week1_active"), forState: .Normal)
        self.parentVC.week2Btn.setImage(UIImage(named: "prize_week2_active"), forState: .Normal)
        self.parentVC.week3Btn.setImage(UIImage(named: "prize_week3_active"), forState: .Normal)
        self.parentVC.week4Btn.setImage(UIImage(named: "prize_week4_active"), forState: .Normal)
    }
}