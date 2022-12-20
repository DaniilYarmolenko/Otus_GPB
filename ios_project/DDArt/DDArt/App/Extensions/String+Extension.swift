//
//  String+Extension.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 02.12.2022.
//

import UIKit

extension String {
    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    func textWithLineSpace(lineSpacing: CGFloat = 5) -> NSAttributedString? {
        let attrString = NSMutableAttributedString(string: self)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: self.count))
        return attrString
    }
}

extension String {
    public var validPhoneNumber: Bool {
        let phoneRegex = #"\+7 \(?([0-9]{3})\) \(?[0-9]{3}\)?[-.]?\(?[0-9]{2}\)?[-.]?\(?[0-9]{2}\)?"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: self)
    }
    
    public var validFullName: Bool {
        let nameRegex =  #"^[a-zA-Z0-9]*$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return predicate.evaluate(with: self)
    }
    
    public var validEmail: Bool {
        let emailRegex =  #"^.+@{1}[a-zA-Z]{2,}[.]{1}[a-zA-Z]{2,4}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
    
    public var validAdress: Bool {
        return !self.isEmpty
    }
}
extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter.date(from: self) ?? Date()
    }
}
extension Date {
   
        func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
            return calendar.dateComponents(Set(components), from: self)
        }

        func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
            return calendar.component(component, from: self)
        }
    func convertToTimeZone(initTimeZone: TimeZone?) -> Date {
        let delta = TimeInterval(TimeZone.current.secondsFromGMT(for: self) - (initTimeZone?.secondsFromGMT(for: self) ?? 0))
             return addingTimeInterval(delta)
        }
    
}
