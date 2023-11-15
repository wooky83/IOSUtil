import Foundation

extension Data {
    var base64URLEncodedString: String { base64URLEncodedString() }
    func base64URLEncodedString(with option: Data.Base64EncodingOptions = []) -> String {
        self.base64EncodedString(options: option)
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}
