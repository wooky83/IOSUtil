import UIKit

extension String {
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

    /// Returns digits.
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
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
}
