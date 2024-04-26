import Foundation
import UIKit
enum ImageTheme : String {
    case appLogo = "appLogo"
    case minus = "minus"
    case plus = "plus"
    case collapseIcon = "collapseIcon"
    /// is heart.fill
    case favIconTrue = "heart.fill"
    /// is heart
    case favIconFalse = "heart"
    
}



enum SizeTheme : CGFloat {
    /// is 30
    case small = 30
}

enum ColorTheme : String {
    // is #000000
    case primaryLabelColor = "#000000"
    // is ##FFFFFF
    case primaryBackColor = "#FFFFFF"
    // is #FF5BAE
    case favIconColor = "#FF5BAE"
}


enum NavTitle : String {
    case univerities = "Üniversiteler"
    case favorities = "Favoriler"
}


enum SpacingTheme : Double {
    // is 10
    case small = 10
}

enum LabelFont {
    case headerLabel
    case titleLabel
    case infoLabel

    var font: UIFont {
        switch self {
        case .headerLabel:
            return UIFont.systemFont(ofSize: 22, weight: .semibold)
        case .titleLabel:
            return UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .infoLabel:
            return UIFont.systemFont(ofSize: 18, weight: .regular)
        }
    }
}


enum AlertMessageTheme : String {
    case actionTitlePrimary = "Tamam"
    case errorMessageOne = "Beklenmedik bir hata oluştu"
    case titleOne = "Hata"
    case errorMessageTwo = "Sayfaya ulaşılamadı"
    case emptyListMessage = "Henüz bir üniversite eklemedin!"
    case defaultMessage = ""
}


enum RowHeightTheme:CGFloat {
    /// is 200
    case open = 220
    /// is 50
    case close = 50
}



