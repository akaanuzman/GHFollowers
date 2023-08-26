//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 27/8/23.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
