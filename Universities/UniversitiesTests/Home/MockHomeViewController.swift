import Foundation
import UIKit
@testable import Universities

class MockHomeViewController : HomeViewControllerProtocol {
    
    
    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0
    func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }
    
    var invokedReloadTableView = false
    var invokedReloadTableViewCount = 0
    func reloadTableView() {
        invokedReloadTableView = true
        invokedReloadTableViewCount += 1
    }
    
    var invokedStartIndicator = false
    var invokedStartIndicatorCount = 0
    func startIndicator() {
         invokedStartIndicator = true
         invokedStartIndicatorCount += 1
    }
    
    var invokedStopIndicator = false
    var invokedStopIndicatorCount = 0
    func stopIndicator() {
         invokedStopIndicator = true
         invokedStopIndicatorCount += 1
    }
    
    var invokedSetBackroundColor = false
    var invokedSetBackroundColorCount = 0
    var invokedSetBackroundColorList = [(color:String,Void)]()
    func setBackroundColor(color: String) {
         invokedSetBackroundColor = true
         invokedSetBackroundColorCount += 1
        invokedSetBackroundColorList.append((color:color,()))
        
    }
    
    var invokedSetNavigationTitle = false
    var invokedSetNavigationTitleCount = 0
    var invokedSetNavigationTitleList = [(title:String,Void)]()
    func setNavigationTitle(title: String) {
         invokedSetNavigationTitle = true
         invokedSetNavigationTitleCount += 1
        invokedSetNavigationTitleList.append((title:title,()))
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
