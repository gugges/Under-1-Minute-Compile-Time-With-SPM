
import Foundation

public enum HTTPMethod: Equatable {
    
    case get([URLQueryItem])
    case post(Data?)
    case put(Data?)
    case delete

    public var name: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .delete: return "DELETE"
        }
    }
}

public protocol Endpoint {
    
    var additionalHeaders: [String: String]? { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

public protocol NetworkInterface {
    
    @discardableResult
    func task<T: Decodable>(endpoint: Endpoint,
                            type: T.Type,
                            completion: @escaping (Result<T, Error>, URLResponse?) -> Void) -> URLSessionTask?
}
