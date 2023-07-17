import Combine
import Foundation

public extension Publisher {
    func mainThread() -> AnyPublisher<Output, Failure> {
        receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
