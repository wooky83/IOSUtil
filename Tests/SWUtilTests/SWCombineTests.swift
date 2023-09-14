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

    func testFlatMapLatest() throws {
        var cancellables = Set<AnyCancellable>()
        let subject = PassthroughSubject<Int, Never>()
        var result = [Int]()
        waitUntil(timeout: .seconds(5)) { done in
            subject
                .flatMapLatest { value in
                    Just(value)
                        .delay(for: .seconds(1), scheduler: DispatchQueue.global())
                        .eraseToAnyPublisher()
                }
                .sink {
                    expect($0).toEventually(equal(5))
                    result.append($0)
                    done()
                }
                .store(in: &cancellables)
            subject.send(1)
            subject.send(2)
            subject.send(3)
            subject.send(4)
            subject.send(5)
            subject.send(completion: .finished)
        }
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

    func testNwise() throws {
        var cancellables = Set<AnyCancellable>()
        let subject = PassthroughSubject<Int, Never>()
        var result = [[Int]]()
        subject
            .nwise(3)
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
        expect(result).toEventually(equal([[1, 2, 3], [2, 3, 4], [3, 4, 5]]))
    }

    func testPairwise() throws {
        var cancellables = Set<AnyCancellable>()
        let subject = PassthroughSubject<Int, Never>()
        var result = [[Int]]()
        subject
            .pairwise()
            .sink {
                result.append([$0.0, $0.1])
            }
            .store(in: &cancellables)
        subject.send(1)
        subject.send(2)
        subject.send(3)
        subject.send(4)
        subject.send(5)
        subject.send(completion: .finished)
        expect(result).toEventually(equal([[1, 2], [2, 3], [3, 4], [4, 5]]))
    }

}
