import Foundation

extension Collection {
    subscript(safe index: Int) -> Element? {
        let index = self.index(startIndex, offsetBy: index)
        return indices.contains(index) ? self[index] : nil
    }

    subscript(circular index: Int) -> Element {
        index >= 0 ?
            self[self.index(startIndex, offsetBy:(index % count))] :
            self[self.index(startIndex, offsetBy:(count - abs(index) % count))]
    }

}

extension Collection where Element: Hashable {
    var arrayDuduplicated: [Self.Element] {
        var dict: [Element: Bool] = [:]
        return filter { dict.updateValue(true, forKey: $0) == nil }
    }
}
