
import Foundation
import UIKit
import SnapKit
protocol FavoritiesViewControllerProtocol :
    AnyObject,
    NavConUIAble,
    ViewControllerAble,
    NavigationControllerAble {
    func prepareTableView()
    func reloadTableView()
    func emptyMessage(message:String,isHidden:Bool)
}


class FavoritiesViewController : UIViewController {
    private lazy var realManager: RealmManagerProtocol = RealmManager()
    private lazy var viewModel : FavoritiesViewModelProtocol = FavoritiesViewModel(
        view: self,
        realManager: realManager)
    private lazy var universitiesTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(
            UniversityTableViewCell.self,
            forCellReuseIdentifier: UniversityTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var messageLabel : UILabel = {
       let label = UILabel()
        label.font = LabelFont.titleLabel.font
        label.isHidden = true
        label.textColor = UIColor(hex: ColorTheme.primaryLabelColor.rawValue)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.addSubview(universitiesTableView)
        universitiesTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        view.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

extension FavoritiesViewController : FavoritiesViewControllerProtocol {
    func prepareTableView() {
        universitiesTableView.delegate = self
        universitiesTableView.dataSource = self
    }
    
    func reloadTableView() {
        universitiesTableView.reloadData()
    }
    
    func emptyMessage(message: String,isHidden:Bool) {
        messageLabel.text = message
        messageLabel.isHidden = isHidden
    }
}


extension FavoritiesViewController :  UITableViewDelegate,UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(at: indexPath)
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = universitiesTableView.dequeueReusableCell(
            withIdentifier: UniversityTableViewCell.identifier,
            for: indexPath) as? UniversityTableViewCell else {return UITableViewCell()}
        let item = viewModel.cellForRowAt(indexPath: indexPath)
        cell.configureData(cellForRowAtReturn: item)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath: indexPath)
    }
}


extension FavoritiesViewController : UniversityTableViewCellDelegate {
    
    func favIconButtonOnTapped(university: University) {
        viewModel.favIconButtonOnTapped(university: university)
    }
    
    func webSiteOnTapped(webSite: String, navTitle: String) {
        viewModel.toWebSitePage(webSite: webSite, navTitle: navTitle)
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
