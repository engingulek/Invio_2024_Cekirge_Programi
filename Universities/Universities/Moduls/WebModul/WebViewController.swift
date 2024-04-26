import Foundation
import UIKit
import WebKit
import SnapKit
protocol WebViewControllerProtocol :AnyObject,
                                    ViewControllerAble,
                                    NavConUIAble,AlertMessageAble {
    func webViewLoad(request:URLRequest)
    func startAnimation()
    func stopAnimation()
    func errorMessageShow(message:String)
}

class WebViewController : UIViewController, WKNavigationDelegate {
   lazy var viewModel : WebViewModelProtocol = WebViewModel(view: self)
    var webSite : String = ""
    var navTitle:String = ""
    var webView : WKWebView!
    
    private lazy var loadingIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = UIColor(hex: ColorTheme.primaryLabelColor.rawValue)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    
    private lazy var errorMessageLabel : UILabel = {
        let label = UILabel()
        label.font = LabelFont.titleLabel.font
        label.isHidden = true
                                 
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad(title: navTitle,url: webSite)
        
        webView = WKWebView(frame: view.bounds)
              webView.navigationDelegate = self
              view.addSubview(webView)
        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        view.addSubview(errorMessageLabel)
        errorMessageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
  
    }
}


extension WebViewController : WebViewControllerProtocol {
    func startAnimation() {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }
        
    }
    
    func stopAnimation() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }
    
    func webViewLoad(request: URLRequest) {
        DispatchQueue.main.async {
            self.webView.load(request)
            self.webView.allowsBackForwardNavigationGestures = true
        }
       
    }
    
    func errorMessageShow(message:String) {
        DispatchQueue.main.async {
            self.errorMessageLabel.isHidden = false
            self.errorMessageLabel.text = message
            self.webView.isHidden = true
        }
    }
}
