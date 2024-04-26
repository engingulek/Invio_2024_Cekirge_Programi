import Foundation
import UIKit
import SnapKit

struct CellForRowAtReturn {
    let university:University
    let favIcon:String
    let collapseIconIsHidden:Bool
    let iconImage:String
    let uniStackViewIsHidden:Bool
}

protocol UniversityTableViewCellDelegate  {
    func webSiteOnTapped(webSite:String,navTitle:String)
    func phoneNumberOnTapped(phoneNumber:String)
    func favIconButtonOnTapped(university:University)
}


class UniversityTableViewCell : UITableViewCell {
    static let identifier = "universityTableViewCell"
    var delegate:UniversityTableViewCellDelegate?
    private var university:University?
    
    private lazy var iconImage : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var nameLabel : UILabel = {
        var label = UILabel()
        label.font = LabelFont.titleLabel.font
        label.textColor = UIColor(hex: ColorTheme.primaryLabelColor.rawValue)
        return label
    }()
    
    private lazy var faviconButton : UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: ImageTheme.favIconFalse.rawValue)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(hex: ColorTheme.favIconColor.rawValue)
        button.addAction(favIconButtonOnTapped, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()
    
    private lazy var favIconButtonOnTapped : UIAction = UIAction { _ in
        guard let university = self.university else {return }
        self.delegate?.favIconButtonOnTapped(university: university)
    }
    
    private lazy var universtyInfoStackView : UIStackView = {
        var stacKView = UIStackView()
        stacKView.axis = .vertical
        stacKView.distribution = .equalSpacing
        return stacKView
    }()
    
    private lazy var phoneLabel = UILabel().defaultDetailLabel()
    private lazy var faxLabel = UILabel().defaultDetailLabel()
    private lazy var websiteLabel = UILabel().defaultDetailLabel()
    private lazy var emailLabel = UILabel().defaultDetailLabel()
    private lazy var addressLabel = UILabel().defaultDetailLabel()
    private lazy var rectorLabel = UILabel().defaultDetailLabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //MARK: Configure UI
    private func configureUI() {
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(contentView.frame.width / 1.2)
        }
        
        addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.leading.equalToSuperview().offset(10)
        }
        
        
        contentView.addSubview(faviconButton)
        faviconButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        configureuniverstyInfoStackViewUI()
        
    }
    
    //MARK: ConfigureuniverstyInfoStackViewUI
    func configureuniverstyInfoStackViewUI() {
        addSubview(universtyInfoStackView)
        universtyInfoStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        universtyInfoStackView.addArrangedSubview(phoneLabel)
        universtyInfoStackView.addArrangedSubview(faxLabel)
        universtyInfoStackView.addArrangedSubview(websiteLabel)
        universtyInfoStackView.addArrangedSubview(emailLabel)
        universtyInfoStackView.addArrangedSubview(addressLabel)
        universtyInfoStackView.addArrangedSubview(rectorLabel)
        
        let tabGestureWebSiteLabel = UITapGestureRecognizer(
            target: self,
            action: #selector(websiteLabelOnTapped))
        
        websiteLabel.addGestureRecognizer(tabGestureWebSiteLabel)
        websiteLabel.isUserInteractionEnabled = true
        
        let tabGesturePhoneLabel = UITapGestureRecognizer(
            target: self,
            action: #selector(phoneLabelOnTapped))
        phoneLabel.addGestureRecognizer(tabGesturePhoneLabel)
        phoneLabel.isUserInteractionEnabled = true
    }
    
    @objc func websiteLabelOnTapped() {
        
        if websiteLabel.text != "-" && websiteLabel.text != "" {
            delegate?.webSiteOnTapped(
                webSite: websiteLabel.text!,
                navTitle: nameLabel.text!)
        }
    }
    
    @objc func phoneLabelOnTapped() {
        if phoneLabel.text != "-" && phoneLabel.text != "" {
            delegate?.phoneNumberOnTapped(phoneNumber: "")
        }
    }
    
    //MARK: ConfigureData
    func configureData(cellForRowAtReturn:CellForRowAtReturn) {
        university = cellForRowAtReturn.university
        nameLabel.text = cellForRowAtReturn.university.name
        
        phoneLabel.text = "phone: \(cellForRowAtReturn.university.phone)"
        faxLabel.text = "fax: \(cellForRowAtReturn.university.fax)"
        websiteLabel.text = "website: \(cellForRowAtReturn.university.website)"
        addressLabel.text = "adress: \(cellForRowAtReturn.university.adress)"
        rectorLabel.text = "rector: \(cellForRowAtReturn.university.rector)"
        emailLabel.text = "email: \(cellForRowAtReturn.university.email)"
        
        let image = UIImage(systemName: cellForRowAtReturn.favIcon)
        faviconButton.setImage(image, for: .normal)
        
        iconImage.isHidden = cellForRowAtReturn.collapseIconIsHidden
        
        iconImage.image = UIImage(systemName: cellForRowAtReturn.iconImage)
        universtyInfoStackView.isHidden = cellForRowAtReturn.uniStackViewIsHidden
        
    }
}
