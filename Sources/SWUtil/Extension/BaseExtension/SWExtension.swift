import Foundation

extension Array: SWCompatible { }

public extension SW where Base: RangeReplaceableCollection {
    subscript(safe index: Int) -> Base.Element? {
        let index = base.index(base.startIndex, offsetBy: index)
        return base.indices.contains(index) ? base[index] : nil
    }
}

extension String: SWCompatible { }

public extension SW where Base == String {
    func trim() -> String {
        base.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
