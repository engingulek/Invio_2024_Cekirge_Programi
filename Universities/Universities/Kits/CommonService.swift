import Foundation

protocol CommonServiceProtocol {
    func fetchDataList(page:Int) async throws -> DataResult
}


class CommonService  :CommonServiceProtocol {
    private let networkManager : NetworkManagerProtocol = NetworkManager()
    
    // MARK: - FetchDataList
    /// Description : Returns the first page of the university list
    /// - Paramter :  page = value of first page
    /// - Returns: [DataResult]
    func fetchDataList(page: Int) async throws -> DataResult  {
        do{
            let result = try await  networkManager.fetch(
                target: .dataList(page),
                responseClass: DataResult.self)
            
            return result
        }catch{
            throw error
        }
    }
}
