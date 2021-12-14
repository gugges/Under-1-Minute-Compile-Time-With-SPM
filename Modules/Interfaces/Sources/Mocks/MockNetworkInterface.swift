
import Foundation

public class MockNetworkInterface: NetworkInterface {
    
    private lazy var queue: DispatchQueue = .init(label: "com.okcupid.\(String(describing: self))",
                                                  qos: .userInteractive)
    public var nextError: Error?
    public var nextResult: Decodable?

    enum MockError: Error {
        case noValue
        case typeMismatch
    }

    // MARK: - Init

    public init() {}

    // MARK: - NetworkInterface

    @discardableResult
    public func task<T: Decodable>(endpoint: Endpoint, type: T.Type, completion: @escaping (Result<T, Error>, URLResponse?) -> Void) -> URLSessionTask? {
        let nextError = nextError
        let nextResult = nextResult
        self.nextError = nil
        self.nextResult = nil

        queue.async {
            if let nextResult = nextResult as? T {
                completion(.success(nextResult), nil)
                
            } else if let nextError = nextError {
                completion(.failure(nextError), nil)
                
            } else {
                completion(.failure(MockError.noValue), nil)
            }
        }

        return nil
    }
    
}
