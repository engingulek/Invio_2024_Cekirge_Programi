import Foundation

protocol SplashViewModelProtocol {
    var view : SplashViewContollerProtocol? {get}
    func viewDidLoad()
    func toMainViewController()
}


class SplashViewModel: SplashViewModelProtocol {
    var view: SplashViewContollerProtocol?
    private var service : CommonServiceProtocol
    private var list : DataResult?
    
    init(view: SplashViewContollerProtocol,service:CommonServiceProtocol) {
        self.view = view
        self.service = service
    }
    
    // MARK: FetchData
    private func fetcData() async{
        do {
            list = try await service.fetchDataList(page: 1)
            view?.startAnimatingLogo()
        }catch{
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                view?.createAlertMesssage(
                    title: AlertMessageTheme.titleOne.rawValue,
                    message: AlertMessageTheme.errorMessageOne.rawValue,
                    actionTitle: AlertMessageTheme.actionTitlePrimary.rawValue)
            }
        }
    }
    
    func viewDidLoad() {
        view?.setBackroundColor(color: ColorTheme.primaryBackColor.rawValue)
        Task{
            await fetcData()
        }
    }
    
    
    func toMainViewController() {
        let mainViewController = MainViewController()
         mainViewController.result = list
        self.view?.presentAble(view: mainViewController)
    }
}
