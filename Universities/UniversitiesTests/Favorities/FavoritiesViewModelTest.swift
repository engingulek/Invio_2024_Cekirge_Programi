import XCTest
@testable import Universities

class FavoritiesViewModelTest :  XCTestCase {
    private var viewModel : FavoritiesViewModel!
    private var view : MockFavoritiesViewController!
    
    private var realmManager : MockRealManager!
    
    
    override func setUp() {
        super.setUp()
        view = .init()
        realmManager = .init()
        viewModel = .init(view: view,realManager: realmManager)
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        viewModel = nil
        realmManager = nil
    }
    
    func test_viewDidLoad_InvokesRequireMethods(){
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertFalse(view.invokedReloadTableView)
        viewModel.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareTableView)
        XCTAssertTrue(view.invokedReloadTableView)
        
        XCTAssertEqual(view.invokedPrepareTableViewCount,1)
        XCTAssertEqual(view.invokedReloadTableViewCount,1)
        
    }
    
    func test_setBackgroundColor_viewDidLoad_returnprimaryBackColor() {
        XCTAssertFalse(view.invokedSetBackroundColor)
        viewModel.viewDidLoad()
        
        XCTAssertTrue(view.invokedSetBackroundColor)
        XCTAssertEqual(view.invokedSetBackroundColorCount,1)
        XCTAssertEqual(view.invokedSetBackroundColorList.map(\.color),[ColorTheme.primaryBackColor.rawValue])
    }
    
    func test_setNavigaitonTitle_viewDidLoad_ReturnUniverities() {
        XCTAssertFalse(view.invokedSetNavigationTitle)
        viewModel.viewDidLoad()
        
        XCTAssertTrue(view.invokedSetNavigationTitle)
        XCTAssertEqual(view.invokedSetNavigationTitleCount,1)
        XCTAssertEqual(view.invokedSetNavigationTitleList.map(\.title),[NavTitle.favorities.rawValue])
    }
    
    
    func test_emptyMessage_ifFavoritiesIsEmpty(){
        XCTAssertFalse(view.invokedEmptyMessage)
        realmManager.favoriteList = []
        viewModel.viewDidLoad()
        XCTAssertTrue(view.invokedEmptyMessage)
        XCTAssertEqual(view.invokedEmptyMessageList.map(\.message),[AlertMessageTheme.emptyListMessage.rawValue])
        
        XCTAssertEqual(view.invokedEmptyMessageList.map(\.isHidden),[false])
       
        
    }
    
    func test_emptyMessage_ifFavoritiesIsNotEmpty(){
        XCTAssertFalse(view.invokedEmptyMessage)
        realmManager.favoriteList = [Favorities.favoritiesOne]
        viewModel.viewDidLoad()
        XCTAssertTrue(view.invokedEmptyMessage)
        XCTAssertEqual(view.invokedEmptyMessageList.map(\.message),[AlertMessageTheme.defaultMessage.rawValue])
        
        XCTAssertEqual(view.invokedEmptyMessageList.map(\.isHidden),[true])
    }
    
    
   
    
    func test_didSelectRowAt_IfuniversityWithInfo_OpenInfo(){
        realmManager.favoriteList = [Favorities.favoritiesOne]
        viewModel.viewDidLoad()
        let indexPath : IndexPath = [0,0]
        
        viewModel.didSelectRowAt(indexPath: indexPath)
        let cellForRowAtReturn = viewModel.cellForRowAt(indexPath: indexPath)
        
        XCTAssertEqual(cellForRowAtReturn.collapseIconIsHidden,false)
        XCTAssertEqual(cellForRowAtReturn.uniStackViewIsHidden,false)
        XCTAssertEqual(cellForRowAtReturn.iconImage,ImageTheme.minus.rawValue)
        
    }
    
    func test_didSelectRowAt_IfuniversityWithInfo_CloseInfo(){
        realmManager.favoriteList = [Favorities.favoritiesOne]
        viewModel.viewDidLoad()
        let indexPath : IndexPath = [0,0]
        // open
        viewModel.didSelectRowAt(indexPath: indexPath)
        // close
        viewModel.didSelectRowAt(indexPath: indexPath)
        let cellForRowAtReturn = viewModel.cellForRowAt(indexPath: indexPath)
        
        XCTAssertEqual(cellForRowAtReturn.collapseIconIsHidden,false)
        XCTAssertEqual(cellForRowAtReturn.uniStackViewIsHidden,true)
        XCTAssertEqual(cellForRowAtReturn.iconImage,ImageTheme.plus.rawValue)
        
    }
    
    func test_didSelectRowAt_IfuniversityWithoutInfo_DontOpenInfo(){
        realmManager.favoriteList = [Favorities.favoritiesTwo]
        viewModel.viewDidLoad()
        let indexPath : IndexPath = [0,0]
        
        viewModel.didSelectRowAt(indexPath: indexPath)
        let cellForRowAtReturn = viewModel.cellForRowAt(indexPath: indexPath)
        
        XCTAssertEqual(cellForRowAtReturn.collapseIconIsHidden,true)
        XCTAssertEqual(cellForRowAtReturn.uniStackViewIsHidden,true)
    }
}
