import Foundation
import UIKit
@testable import Universities


class MockFavoritiesViewController : FavoritiesViewControllerProtocol {
    
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
    
    var invokedEmptyMessage = false
    var invokedEmptyMessageCount = 0
    var invokedEmptyMessageList = [(message: String, isHidden: Bool)]()
    func emptyMessage(message: String, isHidden: Bool) {
         invokedEmptyMessage = true
         invokedEmptyMessageCount +=  1
        invokedEmptyMessageList.append((message: message, isHidden: isHidden))
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
    
    func pushViewControllerAble(view: UIViewController) {
        
    }
    
    func presentAble(view: UIViewController) {
        
    }
    
    
}
