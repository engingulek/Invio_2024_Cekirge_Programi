import Foundation

enum NetworkPath {
    case dataList(Int)
}

extension NetworkPath : TargetType {
    var baseURL: String {
        return Constants.baseUrl.rawValue
    }
    
    var path: String {
        switch self {
        case .dataList(let page):
            return "\(page).json"
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        default:
            return .GET
        }
    }
    
    var requestType: RequestType {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}

