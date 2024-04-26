import UIKit
import SnapKit

protocol SplashViewContollerProtocol : AnyObject,
                                       ViewControllerAble,
                                       AlertMessageAble,
                                       NavigationControllerAble {
    func startAnimatingLogo()
   
}

class SplashViewController: UIViewController {
    
    private lazy var service : CommonServiceProtocol = CommonService()
    private lazy var viewModel : SplashViewModelProtocol = SplashViewModel(view: self,service: service)
    
    private lazy var iconImage : UIImageView = {
        let image = UIImage(named: ImageTheme.appLogo.rawValue)
        let imageView = UIImageView()
        imageView.image = image
        return imageView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        viewModel.viewDidLoad()
    }
   
    private func  configureConstraints() {
        view.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(view.frame.height * 0.25)
            make.width.equalTo(view.frame.width * 0.50)
        }
    }
    
    private func anitmatedLogo(){
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.iconImage.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.iconImage.alpha = 0.0
        }, completion: { finished in
            self.iconImage.removeFromSuperview()
            self.viewModel.toMainViewController()
        })
    }
}

//MARK: SplashViewContollerProtocol
extension SplashViewController : SplashViewContollerProtocol {
    func startAnimatingLogo() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.anitmatedLogo()
        })
    }
}


