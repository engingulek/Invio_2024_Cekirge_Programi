import Foundation


import SnapKit
import UIKit

protocol SectionViewDelegate {
    func sectionOnTapped(sectionData:Int)
}


class SectionView : UIView {
    var delegate : SectionViewDelegate?
    
    private lazy var iconImage : UIImageView = {
       let imageView = UIImageView()
        let image = UIImage(systemName: ImageTheme.minus.rawValue)
        imageView.image = image
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var label : UILabel = {
        let label =  UILabel()
        label.font = LabelFont.titleLabel.font
        label.textColor = UIColor(hex: ColorTheme.primaryLabelColor.rawValue)
        return label
    }()
    
    
    
    private var section : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
               self.label.isUserInteractionEnabled = true
               self.label.addGestureRecognizer(labelTap)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(title:String,sectionData:Int,iconButtonState:Bool,iconImageTitle:String) {
        label.text = title
        section = sectionData

        if iconButtonState {
            iconImage.isHidden = false
            let image = UIImage(systemName: iconImageTitle)
            iconImage.image = image
        }
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        delegate?.sectionOnTapped(sectionData: section)
        }
    
    
    private func configureUI() {
        addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
        }
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImage.snp.trailing).offset(10)
          
        }
    }
}

