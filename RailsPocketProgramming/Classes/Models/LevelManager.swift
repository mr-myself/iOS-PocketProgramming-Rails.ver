import Foundation

class LevelManager {

    var targetViewController: UIViewController?
    
    init(uiViewController: UIViewController) {
        self.targetViewController = uiViewController
    }
    
    func update() {
        LevelData.fetch(manageLevelUpAndSave)
    }
    
    func manageLevelUpAndSave(newLevel: Level) {
        if isLevelUp("ruby", newLevel: newLevel.rubyLevel!) {
            showLevelUpPopup("ruby", oldLevel: LevelData.get()["ruby"]!, newLevel: newLevel.rubyLevel!)
        }
        
        if isLevelUp("rails", newLevel: newLevel.railsLevel!) {
            showLevelUpPopup("rails", oldLevel: LevelData.get()["rails"]!, newLevel: newLevel.railsLevel!)
        }
        LevelData.saveLevel(newLevel)
    }

    private func isLevelUp(target: String, newLevel: String) -> Bool {
        switch (LevelData.get()[target]!) {
           case "e":
               return (newLevel == "e" ? false : true)
           case "d":
               return ((newLevel == "e" || newLevel == "d") ? false : true)
           case "c":
               return ((newLevel == "e" || newLevel == "d" || newLevel == "c") ? false : true)
           case "b":
               return ((newLevel == "e" || newLevel == "d" || newLevel == "c" || newLevel == "b") ? false : true)
           case "a":
               return false
           default:
               return false
       }
    }
    
    private func showLevelUpPopup(target: String, oldLevel: String, newLevel: String) {
        let levelUpPopupView = LevelUpPopupViewController(nibName: "LevelUpPopupView", bundle: nil)
        levelUpPopupView.target = target
        levelUpPopupView.oldLevel = oldLevel
        levelUpPopupView.newLevel = newLevel
        
        self.targetViewController!.presentPopupViewController(levelUpPopupView, animationType: MJPopupViewAnimationSlideBottomBottom)
    }
}
