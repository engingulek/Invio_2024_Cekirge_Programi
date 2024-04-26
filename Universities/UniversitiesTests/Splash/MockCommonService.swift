import Foundation
@testable import Universities

enum MockError : Error {
    case resultNotFound
    
}

class MockCommonService : CommonServiceProtocol {
    var mockFetchDataList : Result<DataResult,Error>?
    func fetchDataList(page: Int) async throws -> DataResult {
        guard let result = mockFetchDataList else {
            throw MockError.resultNotFound
        }
        switch result {
        case .success(let success):
            return success
        case .failure(let failure):
            throw failure
        }
    }
}
