//
//  Extensions.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 21.12.2023.
//

import Foundation
import UIKit

extension UIView{
    var width : CGFloat{
        return frame.size.width
    }
    
    var height : CGFloat{
        return frame.size.height
    }
    
    var left : CGFloat{
        return frame.origin.x
    }
    
    var right : CGFloat{
        return left + width
    }
    
    var top : CGFloat{
        return frame.origin.y
    }
    
    var bottom : CGFloat{
        return top + height
    }
}

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
       let date = DateFormatter()
        date.dateFormat = "YYYY-MM-dd"
        return date
    }()
    
    static let displayDateFormatter: DateFormatter = {
       let date = DateFormatter()
        date.dateStyle = .medium
        return date
    }()
}

extension String {
    static func formattedDate(string: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: string) else {
            return string
        }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}
