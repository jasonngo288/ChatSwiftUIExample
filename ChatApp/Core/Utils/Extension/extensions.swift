//
//  extensions.swift
//  ChatApp
//
//  Created by Jason Ngo on 20/05/2024.
//

import Foundation
import SwiftUI


enum CommonError: Error {
    case Exception(err: String)
}

extension Date {
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "MM/dd/yy"
        return formatter
    }
    
    func timeString() -> String {
        return timeFormatter.string(from: self)
    }
    
    private func dateString() -> String {
        return dayFormatter.string(from: self)
    }
    
    func timestampString() -> String {
        if Calendar.current.isDateInToday(self) {
            return timeString()
        } else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            return dateString()
        }
    }
    
    func chatTimestampString() -> String {
        if Calendar.current.isDateInToday(self) {
            return "Today"
        } else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            return dateString()
        }
    }
}

extension UIImage {

//MARK:- convenience function in UIImage extension to resize a given image
func convert(toSize size:CGSize, scale:CGFloat) ->UIImage {
    let imgRect = CGRect(origin: CGPoint(x:0.0, y:0.0), size: size)
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    self.draw(in: imgRect)
    let copied = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return copied!
    }
}


extension String {
    func styleAttributed(pattern: String, keys: [NSAttributedString.Key], values: [Any]) -> NSMutableAttributedString {
        let source = self
        let regex = try! NSRegularExpression(pattern: pattern, options: .anchorsMatchLines)
        let stringRange = NSRange(location: 0, length: source.utf16.count)
        let substitutionString = #"$1"#
        let newSource = regex.stringByReplacingMatches(in: source, range: stringRange, withTemplate: substitutionString)
        let matches = regex.matches(in: source,
                                    range: NSRange(source.startIndex..., in: source))
        let attributedString = NSMutableAttributedString(string: newSource)
        for match in matches {
            for rangeIndex in 1 ..< match.numberOfRanges {
                let item = (source as NSString).substring(with: match.range(at: rangeIndex))
                for (index, key) in keys.enumerated() {
                attributedString.addAttribute(key, value: values[index], range: attributedString.mutableString.range(of: item))
                }
            }
        }
        return attributedString
    }
    
    func styleAttributed(pattern: String, key: NSAttributedString.Key, value: Any) -> NSMutableAttributedString {
       return self.styleAttributed(pattern: pattern, keys: [key], values: [value])
    }
}

extension NSMutableAttributedString {
    func toAttributedString() -> AttributedString {
        do{
            return try AttributedString(self, including: \.uiKit)
        } catch {
            print(error.localizedDescription)
        }
        return AttributedString()
    }
    
    func appendText(_ text: String) -> NSMutableAttributedString {
        self.append(NSAttributedString(string: text))
        return self
    }
}
