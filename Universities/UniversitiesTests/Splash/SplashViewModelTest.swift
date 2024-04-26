import XCTest
@testable import Universities


class SplashViewModelTest :  XCTestCase {
    private var viewModel : SplashViewModel!
    private var view : MockSplashViewController!
    private var service : MockCommonService!
    
    override func setUp() {
        super.setUp()
        view = .init()
        service = .init()
        viewModel = .init(view: view,service: service)
    }
    
    
    func test_setBackgroundColor_viewDidLoad_returnprimaryBackColor() {
        XCTAssertFalse(view.invokedSetBackroundColor)
        viewModel.viewDidLoad()
        
        XCTAssertTrue(view.invokedSetBackroundColor)
        XCTAssertEqual(view.invokedSetBackroundColorCount,1)
        XCTAssertEqual(view.invokedSetBackroundColorList.map(\.color),[ColorTheme.primaryBackColor.rawValue])
    }
    
    func test_startAnimatingLogo_IfGetData() {
        XCTAssertFalse(view.invokedStartAnimatingLogo)
        
        let expectation = XCTestExpectation(description: "Completing an asynchronous operation")
        
        DispatchQueue.global().async {
            self.service.mockFetchDataList = .success(DataResult.defaultDataResult)
            self.viewModel.viewDidLoad()
            sleep(2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertTrue(view.invokedStartAnimatingLogo)
        
        XCTAssertEqual(view.invokedStartAnimatingLogoCount, 1)
        
    }
    
    
    
    func test_createAlerMessage_ReturnError() {
        XCTAssertFalse(view.invokedCreateAlertMessage)
        
        let expectation = XCTestExpectation(description: "Completing an asynchronous operation")
        
        DispatchQueue.global().async {
            self.service.mockFetchDataList = .failure(MockError.resultNotFound)
            self.viewModel.viewDidLoad()
            sleep(2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertTrue(view.invokedCreateAlertMessage)
        
        XCTAssertEqual(view.invokedCreateAlertMessageCount, 1)
        
        XCTAssertEqual(view.invokedCreateAlertMessageList.map(\.title),[AlertMessageTheme.titleOne.rawValue])
        
        XCTAssertEqual(view.invokedCreateAlertMessageList.map(\.message),[AlertMessageTheme.errorMessageOne.rawValue])
        XCTAssertEqual(view.invokedCreateAlertMessageList.map(\.actionTitle),[AlertMessageTheme.actionTitlePrimary.rawValue])
        
    }
}
