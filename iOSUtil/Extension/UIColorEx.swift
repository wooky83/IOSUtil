//
//  UIColorEx.swift
//  iOSUtil
//
//  Created by wooky83 on 28/02/2019.
//  Copyright © 2019 wooky. All rights reserved.
//

import UIKit

extension UIColor {
    @nonobjc
    public class func color(hexString: String) -> UIColor {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b, a: UInt32
        
        switch hex.count {
        case 6: // RGB
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 0xFF)
            
        case 8: // RGBA
            (r, g, b, a) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF, int >> 24)
            
        default:
            return UIColor.black
        }
        
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    var hexString: String {
        get {
            var r:CGFloat = 0
            var g:CGFloat = 0
            var b:CGFloat = 0
            var a:CGFloat = 0
            
            getRed(&r, green: &g, blue: &b, alpha: &a)
            
            let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
            return String(format: "#%06x", rgb)
        }
    }
    
    // colorNames : http://www.w3schools.com/colors/colors_names.asp 참조
    public class func color(colorName: String) -> UIColor {
        
        let colorNames = ["ALICEBLUE" : "#F0F8FF",
                          "ANTIQUEWHITE" : "#FAEBD7",
                          "AQUA" : "#00FFFF",
                          "AQUAMARINE" : "#7FFFD4",
                          "AZURE" : "#F0FFFF",
                          "BEIGE" : "#F5F5DC",
                          "BISQUE" : "#FFE4C4",
                          "BLACK" : "#000000",
                          "BLANCHEDALMOND" : "#FFEBCD",
                          "BLUE" : "#0000FF",
                          "BLUEVIOLET" : "#8A2BE2",
                          "BROWN" : "#A52A2A",
                          "BURLYWOOD" : "#DEB887",
                          "CADETBLUE" : "#5F9EA0",
                          "CHARTREUSE" : "#7FFF00",
                          "CHOCOLATE" : "#D2691E",
                          "CORAL" : "#FF7F50",
                          "CORNFLOWERBLUE" : "#6495ED",
                          "CORNSILK" : "#FFF8DC",
                          "CRIMSON" : "#DC143C",
                          "CYAN" : "#00FFFF",
                          "DARKBLUE" : "#00008B",
                          "DARKCYAN" : "#008B8B",
                          "DARKGOLDENROD" : "#B8860B",
                          "DARKGRAY" : "#A9A9A9",
                          "DARKGREY" : "#A9A9A9",
                          "DARKGREEN" : "#006400",
                          "DARKKHAKI" : "#BDB76B",
                          "DARKMAGENTA" : "#8B008B",
                          "DARKOLIVEGREEN" : "#556B2F",
                          "DARKORANGE" : "#FF8C00",
                          "DARKORCHID" : "#9932CC",
                          "DARKRED" : "#8B0000",
                          "DARKSALMON" : "#E9967A",
                          "DARKSEAGREEN" : "#8FBC8F",
                          "DARKSLATEBLUE" : "#483D8B",
                          "DARKSLATEGRAY" : "#2F4F4F",
                          "DARKSLATEGREY" : "#2F4F4F",
                          "DARKTURQUOISE" : "#00CED1",
                          "DARKVIOLET" : "#9400D3",
                          "DEEPPINK" : "#FF1493",
                          "DEEPSKYBLUE" : "#00BFFF",
                          "DIMGRAY" : "#696969",
                          "DIMGREY" : "#696969",
                          "DODGERBLUE" : "#1E90FF",
                          "FIREBRICK" : "#B22222",
                          "FLORALWHITE" : "#FFFAF0",
                          "FORESTGREEN" : "#228B22",
                          "FUCHSIA" : "#FF00FF",
                          "GAINSBORO" : "#DCDCDC",
                          "GHOSTWHITE" : "#F8F8FF",
                          "GOLD" : "#FFD700",
                          "GOLDENROD" : "#DAA520",
                          "GRAY" : "#808080",
                          "GREY" : "#808080",
                          "GREEN" : "#008000",
                          "GREENYELLOW" : "#ADFF2F",
                          "HONEYDEW" : "#F0FFF0",
                          "HOTPINK" : "#FF69B4",
                          "INDIANRED " : "#CD5C5C",
                          "INDIGO " : "#4B0082",
                          "IVORY" : "#FFFFF0",
                          "KHAKI" : "#F0E68C",
                          "LAVENDER" : "#E6E6FA",
                          "LAVENDERBLUSH" : "#FFF0F5",
                          "LAWNGREEN" : "#7CFC00",
                          "LEMONCHIFFON" : "#FFFACD",
                          "LIGHTBLUE" : "#ADD8E6",
                          "LIGHTCORAL" : "#F08080",
                          "LIGHTCYAN" : "#E0FFFF",
                          "LIGHTGOLDENRODYELLOW" : "#FAFAD2",
                          "LIGHTGRAY" : "#D3D3D3",
                          "LIGHTGREY" : "#D3D3D3",
                          "LIGHTGREEN" : "#90EE90",
                          "LIGHTPINK" : "#FFB6C1",
                          "LIGHTSALMON" : "#FFA07A",
                          "LIGHTSEAGREEN" : "#20B2AA",
                          "LIGHTSKYBLUE" : "#87CEFA",
                          "LIGHTSLATEGRAY" : "#778899",
                          "LIGHTSLATEGREY" : "#778899",
                          "LIGHTSTEELBLUE" : "#B0C4DE",
                          "LIGHTYELLOW" : "#FFFFE0",
                          "LIME" : "#00FF00",
                          "LIMEGREEN" : "#32CD32",
                          "LINEN" : "#FAF0E6",
                          "MAGENTA" : "#FF00FF",
                          "MAROON" : "#800000",
                          "MEDIUMAQUAMARINE" : "#66CDAA",
                          "MEDIUMBLUE" : "#0000CD",
                          "MEDIUMORCHID" : "#BA55D3",
                          "MEDIUMPURPLE" : "#9370DB",
                          "MEDIUMSEAGREEN" : "#3CB371",
                          "MEDIUMSLATEBLUE" : "#7B68EE",
                          "MEDIUMSPRINGGREEN" : "#00FA9A",
                          "MEDIUMTURQUOISE" : "#48D1CC",
                          "MEDIUMVIOLETRED" : "#C71585",
                          "MIDNIGHTBLUE" : "#191970",
                          "MINTCREAM" : "#F5FFFA",
                          "MISTYROSE" : "#FFE4E1",
                          "MOCCASIN" : "#FFE4B5",
                          "NAVAJOWHITE" : "#FFDEAD",
                          "NAVY" : "#000080",
                          "OLDLACE" : "#FDF5E6",
                          "OLIVE" : "#808000",
                          "OLIVEDRAB" : "#6B8E23",
                          "ORANGE" : "#FFA500",
                          "ORANGERED" : "#FF4500",
                          "ORCHID" : "#DA70D6",
                          "PALEGOLDENROD" : "#EEE8AA",
                          "PALEGREEN" : "#98FB98",
                          "PALETURQUOISE" : "#AFEEEE",
                          "PALEVIOLETRED" : "#DB7093",
                          "PAPAYAWHIP" : "#FFEFD5",
                          "PEACHPUFF" : "#FFDAB9",
                          "PERU" : "#CD853F",
                          "PINK" : "#FFC0CB",
                          "PLUM" : "#DDA0DD",
                          "POWDERBLUE" : "#B0E0E6",
                          "PURPLE" : "#800080",
                          "REBECCAPURPLE" : "#663399",
                          "RED" : "#FF0000",
                          "ROSYBROWN" : "#BC8F8F",
                          "ROYALBLUE" : "#4169E1",
                          "SADDLEBROWN" : "#8B4513",
                          "SALMON" : "#FA8072",
                          "SANDYBROWN" : "#F4A460",
                          "SEAGREEN" : "#2E8B57",
                          "SEASHELL" : "#FFF5EE",
                          "SIENNA" : "#A0522D",
                          "SILVER" : "#C0C0C0",
                          "SKYBLUE" : "#87CEEB",
                          "SLATEBLUE" : "#6A5ACD",
                          "SLATEGRAY" : "#708090",
                          "SLATEGREY" : "#708090",
                          "SNOW" : "#FFFAFA",
                          "SPRINGGREEN" : "#00FF7F",
                          "STEELBLUE" : "#4682B4",
                          "TAN" : "#D2B48C",
                          "TEAL" : "#008080",
                          "THISTLE" : "#D8BFD8",
                          "TOMATO" : "#FF6347",
                          "TURQUOISE" : "#40E0D0",
                          "VIOLET" : "#EE82EE",
                          "WHEAT" : "#F5DEB3",
                          "WHITE" : "#FFFFFF",
                          "WHITESMOKE" : "#F5F5F5",
                          "YELLOW" : "#FFFF00",
                          "YELLOWGREEN" : "#9ACD32"]
        
        guard let hexString = colorNames[colorName.uppercased()] else {
            return UIColor.black
        }
        
        return UIColor.color(hexString: hexString)
    }
}
