import Foundation

extension Array: SWCompatible { }

public extension SW where Base: RangeReplaceableCollection {
    subscript(safe index: Int) -> Base.Element? {
        let index = base.index(base.startIndex, offsetBy: index)
        return base.indices.contains(index) ? base[index] : nil
    }
}

public extension SW where Base: Collection {
    subscript(circular index: Int) -> Base.Element {
        index >= 0 ?
            base[base.index(base.startIndex, offsetBy:(index % base.count))] :
            base[base.index(base.startIndex, offsetBy:(base.count - abs(index) % base.count))]
    }
}

public extension SW where Base: RangeReplaceableCollection, Base.Element: Hashable {
    var arrayDeduplicated: Base {
        var dict: [Base.Element: Bool] = [:]
        return base.filter { dict.updateValue(true, forKey: $0) == nil }
    }
}
