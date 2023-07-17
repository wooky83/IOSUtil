import Combine

public extension Publisher {
    func ignoreFailure(completeImmediately: Bool = false) -> AnyPublisher<Output, Never> {
        self.catch { _ in
            Empty(completeImmediately: completeImmediately)
        }.eraseToAnyPublisher()
    }

}


