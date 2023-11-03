#if os(iOS) || os(tvOS)
import UIKit
#endif
import Foundation

extension String: SWCompatible { }

public extension SW where Base == String {
    /// Returns digits.
    var digits: String {
        base.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

    var urlEncoded: String {
        base.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? base
    }

    func trim() -> String {
        base.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var prettyString: String {
        guard let object = json,
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else {
            return base
        }
        return prettyPrintedString
    }

    var json: [String: Any]? {
        guard let data = base.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }

        return json
    }
    
    var phoneNumberFormatString: String? {
        let regex = "([0-9]{3})([0-9]{4})([0-9]{4})$"
        
        if let regex = try? NSRegularExpression(pattern: regex) {
            let modString = regex.stringByReplacingMatches(
                in: base,
                range: NSRange(base.startIndex..., in: base),
                withTemplate: "$1-$2-$3"
            )
            return modString
        } else {
            return nil
        }
    }

    var base64Encoded: String {
        base.data(using: .utf8)?.base64EncodedString() ?? base
    }

    var base64Decoded: String {
        guard let data = Data(base64Encoded: base) else { return base }
        return String(data: data, encoding: .utf8) ?? base
    }

#if os(iOS) || os(tvOS)
    //아주 많이 느릴때가 있음...
    //https://stackoverflow.com/questions/31852655/very-slow-html-rendering-in-nsattributedstring
    //https://stackoverflow.com/questions/21166752/why-does-the-initial-call-to-nsattributedstring-with-an-html-string-take-over-10
    //http://www.robpeck.com/2015/04/nshtmltextdocumenttype-is-slow/#.XIDdcVMzZTY
    func attributedStringFromHtml(familyName: String = "Apple SD Gothic Neo", fontColor: String = "#ffffff", fontSize: CGFloat) -> NSAttributedString {
        let html = "<font face=\"\(familyName)\" color=\"\(fontColor)\"><span style= \"font-size:\(Int(fontSize))\">\(self)</span></font>"
        guard let data = html.data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch{
            return NSAttributedString()
        }
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = base.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = base.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
#endif


}
