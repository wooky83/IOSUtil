import Foundation

public protocol EnumCodable: RawRepresentable, Codable {
    static var errorCase: Self { get }
}

public extension EnumCodable where Self.RawValue: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(RawValue.self)
        self = Self.init(rawValue: rawValue) ?? Self.errorCase
    }
}
