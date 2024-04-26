import Foundation

protocol WebViewModelProtocol  {
    var view : WebViewControllerProtocol? {get}
    func viewDidLoad(title:String,url: String)
}


class WebViewModel : WebViewModelProtocol {
    var view: WebViewControllerProtocol?
    
    init(view: WebViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad(title:String,url: String) {
        view?.setBackroundColor(color: ColorTheme.primaryBackColor.rawValue)
        view?.setNavigationTitle(title:title )
        checkWebSiteAvailable(url: url)
    }
    
    
    private func checkWebSiteAvailable(url:String) {
        view?.startAnimation()
        guard let url = URL(string: url) else {
         
            view?.stopAnimation()
            self.view?.errorMessageShow(
                message: AlertMessageTheme.errorMessageTwo.rawValue)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { _, response, error in
           
            if error != nil {
                self.view?.stopAnimation()
                self.view?.errorMessageShow(
                    message: AlertMessageTheme.errorMessageTwo.rawValue)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
               
                self.view?.stopAnimation()
                self.view?.errorMessageShow(
                    message: AlertMessageTheme.errorMessageTwo.rawValue)
                return
            }
          
            let statusCode = httpResponse.statusCode
           
            if (200...299).contains(statusCode) {
            let request = URLRequest(url: url)
            self.view?.webViewLoad(request: request)
                self.view?.stopAnimation()
            } else {
                self.view?.stopAnimation()
                self.view?.errorMessageShow(
                    message: AlertMessageTheme.errorMessageTwo.rawValue)
            }
          
        }
        task.resume()
    }
}








