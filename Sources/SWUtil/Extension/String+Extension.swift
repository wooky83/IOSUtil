#if canImport(UIKit)
    import UIKit
#endif
import Foundation

public extension String {
    /// Returns digits.
    var digits: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

    var urlEncoded: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }

    func trim() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var prettyString: String {
        guard let object = json,
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8)
        else {
            return self
        }
        return prettyPrintedString
    }

    var json: [String: Any]? {
        guard let data = data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else {
            return nil
        }

        return json
    }

    var phoneNumberFormatString: String? {
        let regex = "([0-9]{3})([0-9]{4})([0-9]{4})$"

        if let regex = try? NSRegularExpression(pattern: regex) {
            let modString = regex.stringByReplacingMatches(
                in: self,
                range: NSRange(startIndex..., in: self),
                withTemplate: "$1-$2-$3"
            )
            return modString
        } else {
            return nil
        }
    }

    var isValidEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        if let regex = try? NSRegularExpression(pattern: regex) {
            let matches = regex.matches(in: self, range: NSRange(startIndex..., in: self))
            return !matches.isEmpty
        } else {
            return false
        }
    }

    var base64Encoded: String {
        data(using: .utf8)?.base64EncodedString() ?? self
    }

    var base64Decoded: String {
        guard let data = Data(base64Encoded: self) else { return self }
        return String(data: data, encoding: .utf8) ?? self
    }

    subscript(_ range: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(startIndex, offsetBy: range.upperBound)
        return String(self[start ... end])
    }

    subscript(_ range: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(startIndex, offsetBy: range.upperBound)
        return String(self[start ..< end])
    }

    subscript(_ range: PartialRangeThrough<Int>) -> String {
        let end = index(startIndex, offsetBy: range.upperBound)
        return String(self[startIndex ... end])
    }

    subscript(_ range: PartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: range.lowerBound)
        return String(self[start ..< endIndex])
    }

    #if canImport(UIKit)
        // 아주 많이 느릴때가 있음...
        // https://stackoverflow.com/questions/31852655/very-slow-html-rendering-in-nsattributedstring
        // https://stackoverflow.com/questions/21166752/why-does-the-initial-call-to-nsattributedstring-with-an-html-string-take-over-10
        // http://www.robpeck.com/2015/04/nshtmltextdocumenttype-is-slow/#.XIDdcVMzZTY
        func attributedStringFromHtml(familyName: String = "Apple SD Gothic Neo", fontColor: String = "#ffffff", fontSize: CGFloat) -> NSAttributedString {
            let html = "<font face=\"\(familyName)\" color=\"\(fontColor)\"><span style= \"font-size:\(Int(fontSize))\">\(self)</span></font>"
            guard let data = html.data(using: .utf8) else { return NSAttributedString() }
            do {
                return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            } catch {
                return NSAttributedString()
            }
        }

        func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
            let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
            let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

            return ceil(boundingBox.height)
        }

        func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
            let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
            let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

            return ceil(boundingBox.width)
        }
    #endif
}
