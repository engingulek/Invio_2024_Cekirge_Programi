import XCTest
@testable import Universities

class MainViewModelTest : XCTestCase {
    private var viewModel : HomeViewModel!
    private var view : MockHomeViewController!
    private var service : MockCommonService!
    private var realmManager : MockRealManager!
    
    
    override func setUp() {
        super.setUp()
        view = .init()
        service = .init()
        realmManager = .init()
        viewModel = .init(
            view: view,
            service: service,
            realManager: realmManager)
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        service = nil
        viewModel = nil
        realmManager = nil
    }
    
    func test_viewDidLoad_InvokesRequireMethods(){
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertFalse(view.invokedReloadTableView)
        viewModel.viewDidLoad(DataResult.defaultDataResult)
        
        XCTAssertTrue(view.invokedPrepareTableView)
        XCTAssertTrue(view.invokedReloadTableView)
        
        XCTAssertEqual(view.invokedPrepareTableViewCount,1)
        XCTAssertEqual(view.invokedReloadTableViewCount,1)
        
    }
    
    func test_setBackgroundColor_viewDidLoad_returnprimaryBackColor() {
        XCTAssertFalse(view.invokedSetBackroundColor)
        viewModel.viewDidLoad(DataResult.defaultDataResult)
        
        XCTAssertTrue(view.invokedSetBackroundColor)
        XCTAssertEqual(view.invokedSetBackroundColorCount,1)
        XCTAssertEqual(view.invokedSetBackroundColorList.map(\.color),[ColorTheme.primaryBackColor.rawValue])
    }
    
    
    func test_setNavigaitonTitle_viewDidLoad_ReturnUniverities() {
        XCTAssertFalse(view.invokedSetNavigationTitle)
        viewModel.viewDidLoad(DataResult.defaultDataResult)
        
        XCTAssertTrue(view.invokedSetNavigationTitle)
        XCTAssertEqual(view.invokedSetNavigationTitleCount,1)
        XCTAssertEqual(view.invokedSetNavigationTitleList.map(\.title),[NavTitle.univerities.rawValue])
    }
    
  
    
    func test_viewForHeaderInSection_sectiomOnTappep_ReturnIconImage(){
        viewModel.viewDidLoad(DataResult.defaultDataResult)
        
        viewModel.sectionOnTapped(section: 0)
        let tappedCity = viewModel.viewForHeaderInSection(section: 0)
        let untappedCity = viewModel.viewForHeaderInSection(section: 1)
        
        XCTAssertEqual(tappedCity.iconImage,ImageTheme.minus.rawValue)
        XCTAssertEqual(untappedCity.iconImage,ImageTheme.plus.rawValue)
      
    }
    
    func test_viewForHeaderInSection_ReturniconImageState() {
        viewModel.viewDidLoad(DataResult.defaultDataResult)
        
        viewModel.sectionOnTapped(section: 0)
        let cityWithUniversity = viewModel.viewForHeaderInSection(section: 0)
        let cityWithoutUniversity = viewModel.viewForHeaderInSection(section: 2)
        
        XCTAssertEqual(cityWithUniversity.iconButtonImageState,true)
        XCTAssertEqual(cityWithoutUniversity.iconButtonImageState,false)
    }
    
    
    func test_numberOfRowsInSection_sectionOnTapped_ReturnUniversityCount(){
        viewModel.viewDidLoad(DataResult.defaultDataResult)
        viewModel.sectionOnTapped(section: 0)
        let cityWithUniversity = viewModel.numberOfRowsInSection(section: 0)
        viewModel.sectionOnTapped(section: 2)
        let cityWithoutUniversity =  viewModel.numberOfRowsInSection(section: 2)
        
       
        XCTAssertNotEqual(cityWithUniversity,0)
        XCTAssertEqual(cityWithoutUniversity,0)
        
    }
    
    func test_cellForRowAt_ReturnCollapseIconIsHidden(){
        viewModel.viewDidLoad(DataResult.defaultDataResult)
   
        let universityWithInfo = viewModel.cellForRowAt(indexPath: [0,0])
        let noUniversityWithoutInfo = viewModel.cellForRowAt(indexPath: [0,1])
        XCTAssertEqual(universityWithInfo.collapseIconIsHidden,false)
        XCTAssertEqual(noUniversityWithoutInfo.collapseIconIsHidden,true)
        
    }
    
    func test_cellForRowAt_didSelectRowAt_ReturnUniversityInfoOpenAndClose(){
        viewModel.viewDidLoad(DataResult.defaultDataResult)
       
        let indexPath : IndexPath = [0,0]
        // Open University Info
        viewModel.didSelectRowAt(indexPath: indexPath)
        let cellForRowAtOpen = viewModel.cellForRowAt(indexPath: indexPath )
        let infoHeightOpen = viewModel.heightForRow(at: indexPath)
        XCTAssertEqual(cellForRowAtOpen.iconImage,ImageTheme.minus.rawValue)
        XCTAssertEqual(cellForRowAtOpen.uniStackViewIsHidden,false)
        
        // Close Universit Info
        viewModel.didSelectRowAt(indexPath: indexPath)
        let cellForRowAtClose = viewModel.cellForRowAt(indexPath: indexPath )
        let infoHeightClose = viewModel.heightForRow(at: indexPath)
        XCTAssertEqual(cellForRowAtClose.iconImage,ImageTheme.plus.rawValue)
        XCTAssertEqual(cellForRowAtClose.uniStackViewIsHidden,true)
      
    }
    

    
    func test_favIconButtonOnTapped_addUniversityToFav_ReturnHeartFill(){
        viewModel.viewDidLoad(DataResult.defaultDataResult)
       
        let onTappedFavIconIndexPath : IndexPath = [0,1]
        let cellRowAtHeart = viewModel.cellForRowAt(indexPath: onTappedFavIconIndexPath)
        let university = cellRowAtHeart.university
       
        viewModel.favIconButtonOnTapped(university: university)
        let cellRowAtHearFill = viewModel.cellForRowAt(indexPath: onTappedFavIconIndexPath)
        XCTAssertEqual(cellRowAtHearFill.favIcon,ImageTheme.favIconTrue.rawValue)
        
        
    }
    
}
