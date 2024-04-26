import Foundation
import UIKit

protocol ViewControllerAble {
    func setBackroundColor(color:String)
}

extension ViewControllerAble where Self : UIViewController {
    func setBackroundColor(color:String) {
        view.backgroundColor = UIColor(hex:color)
    }
}


protocol NavConUIAble {
    func setNavigationTitle(title:String)
   
}

extension NavConUIAble where Self : UIViewController  {
    func setNavigationTitle(title:String) {
        navigationItem.title = title
    }
}

protocol NavigationControllerAble {
    func pushViewControllerAble(view:UIViewController)
    func presentAble(view:UIViewController)
}

extension NavigationControllerAble where Self : UIViewController {
    func pushViewControllerAble(view:UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
    
    func presentAble(view:UIViewController) {
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
   
}

public protocol AlertMessageAble {
    func createAlertMesssage(title:String,message:String,actionTitle:String)
   
}

extension AlertMessageAble  where Self : UIViewController {
    public  func createAlertMesssage(title:String,message:String,actionTitle:String){
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .default))
        self.present(alert, animated: true)
        
    }
}

