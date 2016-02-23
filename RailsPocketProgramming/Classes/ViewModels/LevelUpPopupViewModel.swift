import UIKit

class LevelUpPopupViewModel {
    let parentVC: LevelUpPopupViewController!

    init(parentVC: LevelUpPopupViewController) {
        self.parentVC = parentVC
    }

    func setup() {
        self.parentVC.oldLevelImage.image = UIImage(named: "rank_" + self.parentVC.oldLevel)
        self.parentVC.newLevelImage.image = UIImage(named: "rank_" + self.parentVC.newLevel)

        self.parentVC.levelUpText.text = String(format: NSLocalizedString("levelUp", comment: ""),  self.parentVC.target.capitalizedString)
        
        AVAudioPlayerUtil.setValue("up")
        AVAudioPlayerUtil.play();
    }
}