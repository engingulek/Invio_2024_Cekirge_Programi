import UIKit
import SnapKit


protocol HomeViewControllerProtocol : AnyObject,
                                      ViewControllerAble,
                                      NavConUIAble,
                                      NavigationControllerAble,
                                      AlertMessageAble {
    func prepareTableView()
    func reloadTableView()
    func startIndicator()
    func stopIndicator()
}

class MainViewController : UIViewController{
    private lazy var service : CommonServiceProtocol = CommonService()
    private lazy var realManager:RealmManagerProtocol = RealmManager()
    lazy var viewModel : HomeViewModelProtocol = HomeViewModel(
        view: self,service: service,realManager: realManager)
    var result : DataResult?
    private lazy var sectionView = SectionView()
    
    private lazy var collapseIcon : UIButton = {
        let button = UIButton()
        let image = UIImage(named: ImageTheme.collapseIcon.rawValue)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addAction(collapseOnTapped, for: .touchUpInside)
        return button
    }()
    
    private lazy var universitiesTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(
            UniversityTableViewCell.self,
            forCellReuseIdentifier: UniversityTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var loadingIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = UIColor(hex: ColorTheme.primaryLabelColor.rawValue)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var collapseOnTapped : UIAction = UIAction { _ in
        self.closeAllRow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Since the control is done in Splash, there is no need to make it optional.
        viewModel.viewDidLoad(result!)
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppears()
        
    }
    
    private func configureUI(){
        view.addSubview(universitiesTableView)
        universitiesTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        
        view.addSubview(collapseIcon)
        collapseIcon.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        view.addSubview(loadingIndicator)
        universitiesTableView.tableFooterView = loadingIndicator
        
        let favoritiesButton = UIBarButtonItem(
            image: UIImage(
                systemName: ImageTheme.favIconTrue.rawValue),
            style: .plain,
            target: self,
            action: #selector(heartOnTapped))
        favoritiesButton.tintColor =  UIColor(hex: ColorTheme.favIconColor.rawValue)
        navigationItem.rightBarButtonItem = favoritiesButton
    }
    
    @objc  func heartOnTapped() {
        viewModel.toFavoritiesPage()
    }
    
    private func closeAllRow() {
        viewModel.closeAllRow()
        
    }
    
}

//MARK: MainViewControllerProtocol
extension MainViewController : HomeViewControllerProtocol {
    func startIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            loadingIndicator.startAnimating()
        }
    }
    
    func stopIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            loadingIndicator.stopAnimating()
        }
    }
    
    func prepareTableView() {
        universitiesTableView.delegate = self
        universitiesTableView.dataSource = self
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            universitiesTableView.reloadData()
        }
    }
}
// MARK: SectionViewDelegate
extension MainViewController : SectionViewDelegate {
    func sectionOnTapped(sectionData:Int) {
        viewModel.sectionOnTapped(section: sectionData)
    }
}

//MARK: UniversityTableViewCellDelegate
extension MainViewController : UniversityTableViewCellDelegate {
    func favIconButtonOnTapped(university: University) {
        viewModel.favIconButtonOnTapped(university: university)
    }
    
    func webSiteOnTapped(webSite: String,navTitle:String) {
        viewModel.toWebSitePage(webSite: webSite,navTitle: navTitle)
    }
    
    func phoneNumberOnTapped(phoneNumber: String) {
        let cleanedPhoneNumber = phoneNumber
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
        // iOS telefon olmadığı için testi yapılamadı
        if let phoneURL = URL(string: "tel://\(cleanedPhoneNumber)") {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    }
}
