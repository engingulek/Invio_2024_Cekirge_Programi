import Foundation


protocol HomeViewModelProtocol {
    var view : HomeViewControllerProtocol? {get}
    
    func viewDidLoad(_ result:DataResult)
    func viewWillAppears()
    func numberOfSections() -> Int
    func numberOfRowsInSection(section:Int) -> Int
    func cellForRowAt(indexPath:IndexPath) -> CellForRowAtReturn
    func viewForHeaderInSection(section:Int) -> (
        iconImage:String,
        iconButtonImageState:Bool,
        title:String)
    
    func heightForHeaderInSection() -> CGFloat
    func heightForRow(at indexPath:IndexPath) -> CGFloat
    func didSelectRowAt(indexPath:IndexPath)
    func sectionOnTapped(section:Int)
    func closeAllRow()
    func toWebSitePage(webSite: String,navTitle:String)
    func toFavoritiesPage()
    func nextPageLoad()
    func favIconButtonOnTapped(university:University)
    
}


class HomeViewModel {
    var view: HomeViewControllerProtocol?
    private var service : CommonServiceProtocol
    private var realManaser : RealmManagerProtocol
    private var currentPage : Int = 1
    private var totalPage : Int = 1
    private var datas : [City] = []
    private var favList : [Favorities] = []
    init(view: HomeViewControllerProtocol?,
         service:CommonServiceProtocol,
         realManager:RealmManagerProtocol) {
        self.view = view
        self.service = service
        self.realManaser = realManager
    }
}

//MARK: HomeViewModelProtocol
extension HomeViewModel : HomeViewModelProtocol {
    
    func viewDidLoad(_ result:DataResult) {
        datas = result.data
        currentPage = result.currentPage
        totalPage = result.totalPage
        view?.prepareTableView()
        view?.reloadTableView()
        view?.setBackroundColor(color: ColorTheme.primaryBackColor.rawValue)
        view?.setNavigationTitle(title: NavTitle.univerities.rawValue)
        allGetFavorities()
    }
    
    func viewWillAppears() {
        allGetFavorities()
        view?.reloadTableView()
    }
    
    
    func numberOfSections() -> Int {
        return datas.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if datas[section].opened == true {
            return datas[section].universities.count
        }else {
            return 0
        }
    }
    
    func cellForRowAt(indexPath: IndexPath) -> CellForRowAtReturn {
        let university = datas[indexPath.section].universities[indexPath.row]
        let universityName = university.name
        let favIconStatues = favList.contains { $0.name == universityName }
        let favIcon =  favIconStatues ?
        ImageTheme.favIconTrue.rawValue :
        ImageTheme.favIconFalse.rawValue
        
        var containsDash : Bool {
            university.phone == "-" &&
            university.fax == "-" &&
            university.website == "-" &&
            university.email == "-" &&
            university.adress == "-" &&
            university.rector == "-"
        }
        let collapseIconIsHidden = containsDash
        let iconImage = university.opened == true ?
        ImageTheme.minus.rawValue :
        ImageTheme.plus.rawValue
        let opened =  university.opened ?? false
        let uniStackViewIsHidden = !opened
        let cellForRowAtReturn = CellForRowAtReturn(
            university: university,
            favIcon: favIcon,
            collapseIconIsHidden: collapseIconIsHidden,
            iconImage: iconImage,
            uniStackViewIsHidden: uniStackViewIsHidden)
        return cellForRowAtReturn
    }
    
    func viewForHeaderInSection(section: Int) -> (
        iconImage: String,
        iconButtonImageState: Bool,
        title:String) {
            let unveritiesCount = datas[section].universities.count
            let iconImage = datas[section].opened == true ?
            ImageTheme.minus.rawValue :
            ImageTheme.plus.rawValue
            
            let iconImageState = unveritiesCount == 0 ? false : true
            let title = datas[section].province
            
            return (iconImage,iconImageState,title)
        }
    
    func heightForHeaderInSection() -> CGFloat {
        return SizeTheme.small.rawValue
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        let opened = datas[indexPath.section].universities[indexPath.row].opened ?? false
        if opened == true {
            return RowHeightTheme.open.rawValue
        }else{
            return RowHeightTheme.close.rawValue
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        let uniInfo = datas[section].universities[row]
        var containsDash : Bool {
            uniInfo.phone == "-" &&
            uniInfo.fax == "-" &&
            uniInfo.website == "-" &&
            uniInfo.email == "-" &&
            uniInfo.adress == "-" &&
            uniInfo.rector == "-"
        }
        if containsDash {
            datas[section].universities[row].opened = false
        }else {
            let opened = datas[section].universities[row].opened ?? false
            if opened {
                datas[section].universities[row].opened = false
            }else{
                datas[section].universities[row].opened = true
            }
        }
        view?.reloadTableView()
    }
    
    func nextPageLoad(){
        Task {
            await loadMoreData()
        }
    }
    
    
    private  func loadMoreData() async {
        self.currentPage += 1
        if currentPage < totalPage + 1{
            
            view?.startIndicator()
            do {
                
                let result = try await service.fetchDataList(page: currentPage)
              
                result.data.forEach { city in
                    self.datas.append(city)
                }
                
                view?.reloadTableView()
                view?.stopIndicator()
                return
                
                
            }catch{
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    view?.createAlertMesssage(
                        title: AlertMessageTheme.titleOne.rawValue,
                        message: AlertMessageTheme.errorMessageOne.rawValue,
                        actionTitle: AlertMessageTheme.actionTitlePrimary.rawValue)
                }
                view?.reloadTableView()
                view?.stopIndicator()
            }
        }
    }
    
    func sectionOnTapped(section: Int) {
        
        if datas[section].opened == true {
            datas[section].opened = false
            let universityCount = datas[section].universities.count
            if  universityCount != 0 {
                for i in 0...universityCount - 1 {
                    datas[section].universities[i].opened = false
                }
            }
            
        }else{
            datas[section].opened = true
        }
        
        view?.reloadTableView()
        
    }
    
    func closeAllRow() {
        for x in 0...datas.count - 1 {
            datas[x].opened = false
            if datas[x].universities.count != 0 {
                for y in 0...datas[x].universities.count - 1 {
                    datas[x].universities[y].opened = false
                }
            }
        }
        view?.reloadTableView()
    }
    
    func toWebSitePage(webSite: String,navTitle:String) {
        let webSiteViewController = WebViewController()
        webSiteViewController.webSite = webSite.replacingOccurrences(of: "website: ", with: "")
        webSiteViewController.navTitle = navTitle
        view?.pushViewControllerAble(view:webSiteViewController)
    }
    
    
    func toFavoritiesPage() {
        let favoritiesViewController = FavoritiesViewController()
        view?.pushViewControllerAble(view: favoritiesViewController)
    }
    
    
    
    func favIconButtonOnTapped(university:University) {
        
        let universityName = university.name
        if favList.contains(where: { $0.name == universityName }) {
            realManaser.deleteFavorities(university: university)
            favList = realManaser.allGetFavorities()
        }else{
            realManaser.addFavoritiy(university: university)
            favList = realManaser.allGetFavorities()
        }
        view?.reloadTableView()
    }
    
    func allGetFavorities() {
        favList = realManaser.allGetFavorities()
    }
}


