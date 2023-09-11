import XCTest
import Combine
import Nimble
@testable import SWUtil

final class SWCombineTests: XCTestCase {

    func testSkipNil() throws {
        var cancellables = Set<AnyCancellable>()
        let subject = PassthroughSubject<Int?, Never>()
        var result = [Int]()
        subject
            .skipNil()
            .sink {
                result.append($0)
            }
            .store(in: &cancellables)
        subject.send(1)
        subject.send(nil)
        subject.send(2)
        XCTAssertEqual(result, [1, 2])
    }

    func testCombineIgnoreFailure() throws {
        var cancellables = Set<AnyCancellable>()
        let subject = PassthroughSubject<Int, Error>()
        var result = [Int]()
        subject
            .ignoreFailure()
            .sink {
                result.append($0)
            }
            .store(in: &cancellables)
        subject.send(1)
        subject.send(completion: .failure(NSError(domain: "", code: 0, userInfo: nil)))
        subject.send(2)
        XCTAssertEqual(result, [1])
    }

    func testCombineMainThread() throws {
        func asyncFunction() -> AnyPublisher<Data, Never> {
            Deferred { () -> PassthroughSubject<Data, Never> in
                let subject = PassthroughSubject<Data, Never>()
                URLSession.shared.dataTask(with: URL(string: "https://www.google.com")!) { data, _, _ in
                    subject.send(data ?? Data())
                }.resume()
                return subject
            }.eraseToAnyPublisher()
        }

        var cancellables = Set<AnyCancellable>()
        waitUntil(timeout: .seconds(5)) { done in
            asyncFunction()
                .mainThread()
                .sink(receiveValue: { _ in
                    expect(Thread.isMainThread).to(beTrue())
                    done()
                })
                .store(in: &cancellables)
        }
    }

    func testCombineFlatMapLatest() async throws {
        var cancellables = Set<AnyCancellable>()
        let subject = PassthroughSubject<Int, Never>()
        var result = [Int]()
        subject
            .flatMapLatest { value in
                Just(value)
                    .delay(for: .seconds(1), scheduler: DispatchQueue.global())
                    .eraseToAnyPublisher()
            }
            .sink {
                result.append($0)
            }
            .store(in: &cancellables)
        subject.send(1)
        subject.send(2)
        subject.send(3)
        subject.send(4)
        subject.send(5)
        subject.send(completion: .finished)
        try await Task.sleep(nanoseconds: 2_000_000_000)
        await expect(result).toEventually(equal([5]))
    }

    func testCombineAsyncMap() async throws {
        func asyncFunction(value: Int) async -> Int {
            await withCheckedContinuation { promise in
                promise.resume(returning: value)
            }
        }
        var cancellables = Set<AnyCancellable>()
        let subject = PassthroughSubject<Int, Never>()
        var result = [Int]()
        subject
            .asyncMap { value in
                await asyncFunction(value: value)
            }
            .sink(receiveValue: { value in
                result.append(value)
            })
            .store(in: &cancellables)
        subject.send(3)
        subject.send(3)
        subject.send(3)
        subject.send(completion: .finished)
        await expect(result).toEventually(equal([3, 3, 3]))
    }

}
