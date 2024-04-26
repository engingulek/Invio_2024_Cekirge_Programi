import Foundation
import UIKit
@testable import Universities

class MockSplashViewController : SplashViewContollerProtocol {
    
    
    var invokedStartAnimatingLogo = false
    var invokedStartAnimatingLogoCount = 0
    func startAnimatingLogo() {
        invokedStartAnimatingLogo = true
        invokedStartAnimatingLogoCount += 1
    }
    
    var invokedSetBackroundColor = false
    var invokedSetBackroundColorCount = 0
    var invokedSetBackroundColorList = [(color:String,Void)]()
    func setBackroundColor(color: String) {
         invokedSetBackroundColor = true
         invokedSetBackroundColorCount += 1
        invokedSetBackroundColorList.append((color:color,()))
        
    }
    
    var invokedCreateAlertMessage = false
    var invokedCreateAlertMessageCount = 0
    var invokedCreateAlertMessageList = [(title:String,message:String,actionTitle:String)]()
    func createAlertMesssage(
        title: String,
        message: String,
        actionTitle: String) {
            invokedCreateAlertMessage = true
            invokedCreateAlertMessageCount += 1
            invokedCreateAlertMessageList.append((title,message,actionTitle))
            
    }
    
    func pushViewControllerAble(view: UIViewController) {
        
    }
    
    func presentAble(view: UIViewController) {
        
    }
    
    
}
