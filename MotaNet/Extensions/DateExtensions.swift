//
//  DateExtensions.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//

import Foundation


import Foundation

extension Date {
    func formattedAsDayDateMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM"  // e.g., "Tue, 3 May"
        
        // Optionally, add ordinal suffixes if needed:
        let day = Calendar.current.component(.day, from: self)
        let dayFormatter = NumberFormatter()
        dayFormatter.numberStyle = .ordinal
        
        //let dayString = dayFormatter.string(from: NSNumber(value: day)) ?? "\(day)"
        return "\(formatter.string(from: self))"
    }
}
