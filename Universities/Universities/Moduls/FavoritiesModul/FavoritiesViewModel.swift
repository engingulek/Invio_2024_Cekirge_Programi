import Foundation

protocol FavoritiesViewModelProtocol {
    var view : FavoritiesViewControllerProtocol? {get}
    func viewDidLoad()
    func numberOfRowsInSection(section:Int) -> Int
    func cellForRowAt(indexPath:IndexPath) -> CellForRowAtReturn
    func heightForRow(at indexPath: IndexPath) -> CGFloat
    func didSelectRowAt(indexPath: IndexPath)
    func toWebSitePage(webSite: String,navTitle:String)
    func favIconButtonOnTapped(university:University)
}


class  FavoritiesViewModel {
    var view: FavoritiesViewControllerProtocol?
    private var favList : [University] = []
    private var realManaser : RealmManagerProtocol
    init(
        view: FavoritiesViewControllerProtocol?,
        realManager:RealmManagerProtocol) {
        self.view = view
        self.realManaser = realManager
    }
    
    //MARK: AllGetFavorities
  private  func allGetFavorities(){
        favList = []
       let favListRealm = realManaser.allGetFavorities()
        favListRealm.forEach { fav in
            let university = University(
                name: fav.name,
                phone: fav.phone,
                fax: fav.fax,
                website: fav.website,
                email: fav.email,
                adress: fav.adress,
                rector: fav.rector)
            favList.append(university)
        }
        if favList.isEmpty {
            view?.emptyMessage(
                message: AlertMessageTheme.emptyListMessage.rawValue,
                isHidden: false)
        }else{
            view?.emptyMessage(
                message: AlertMessageTheme.defaultMessage.rawValue,
                isHidden: true)
        }
      
    }
    
}


extension FavoritiesViewModel : FavoritiesViewModelProtocol {
    func viewDidLoad() {
        allGetFavorities()
        view?.prepareTableView()
        view?.reloadTableView()
        view?.setBackroundColor(color: ColorTheme.primaryBackColor.rawValue)
        view?.setNavigationTitle(title: NavTitle.favorities.rawValue)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return favList.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> CellForRowAtReturn{
        let fav = favList[indexPath.row]
        var containsDash : Bool {
            fav.phone == "-" &&
            fav.fax == "-" &&
            fav.website == "-" &&
            fav.email == "-" &&
            fav.adress == "-" &&
            fav.rector == "-"
        }
        let collapseIconIsHidden = containsDash
        let iconImage = fav.opened == true ? ImageTheme.minus.rawValue : ImageTheme.plus.rawValue
        let opened =  fav.opened ?? false
        let uniStackViewIsHidden = !opened
        let cellForRowAtReturn = CellForRowAtReturn(
            university: fav,
            favIcon: ImageTheme.favIconTrue.rawValue,
            collapseIconIsHidden: collapseIconIsHidden,
            iconImage: iconImage,
            uniStackViewIsHidden: uniStackViewIsHidden)
        return cellForRowAtReturn
    }
    
    
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        let opened = favList[indexPath.row].opened ?? false
        
        if opened == true {
            return RowHeightTheme.open.rawValue
        }else{
            return RowHeightTheme.close.rawValue
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
       
        let row = indexPath.row
        let uniInfo = favList[row]
        
        var containsDash : Bool {
            uniInfo.phone == "-" &&
            uniInfo.fax == "-" &&
            uniInfo.website == "-" &&
            uniInfo.email == "-" &&
            uniInfo.adress == "-" &&
            uniInfo.rector == "-"
        }
        
        if containsDash {
            favList[row].opened = false
        }else{
            let opened = favList[row].opened ?? false
            if opened {
                favList[row].opened = false
            }else{
                favList[row].opened = true
            }
        }
        view?.reloadTableView()
    }
    
    
    func toWebSitePage(webSite: String,navTitle:String) {
        let webSiteViewController = WebViewController()
        webSiteViewController.webSite =  webSite.replacingOccurrences(of: "website: ", with: "")
        webSiteViewController.navTitle = navTitle
        view?.pushViewControllerAble(view:webSiteViewController)
    }
    
    func favIconButtonOnTapped(university:University) {
     
        let universityName = university.name
        if favList.contains(where: { $0.name == universityName }) {
        realManaser.deleteFavorities(university: university)
          
           allGetFavorities()
          view?.reloadTableView()
        }else{
            realManaser.addFavoritiy(university: university)
            allGetFavorities()
        view?.reloadTableView()
        }
    }
}
 

