import Combine

public extension Publisher {
    func skipNil<T>() -> Publishers.CompactMap<Self, T> where Output == T? {
        compactMap { $0 }
    }

}
